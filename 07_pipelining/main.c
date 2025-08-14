// main.c
// MAC μ-law test harness using dummy implementation (see mulaw_portable.c)

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h> // wall clock
#include <sys/stat.h> // for stat()
#include <math.h>
#include "muLaw_neon.h"
// #include "muLaw.h"

#define WAV_HEADER_SIZE 44

#define SAMPLES_PER_CALL 16
#define REPETITIONS 500

typedef struct {
    uint32_t sampleRate;
    uint16_t channels;
    uint32_t numSamples; // per-channel
} WavMeta;

// For timing compansion
static inline double now_sec(void) {
#if defined(CLOCK_MONOTONIC)
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
#else
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (double)tv.tv_sec + (double)tv.tv_usec * 1e-6;
#endif
}

static inline int read_wav_header(FILE* f, WavMeta* meta, uint32_t* dataBytes, uint32_t* dataOffset) {
    unsigned char hdr[WAV_HEADER_SIZE];
    if (fread(hdr, 1, WAV_HEADER_SIZE, f) != WAV_HEADER_SIZE) return -1;

    if (memcmp(hdr+0, "RIFF", 4) != 0 || memcmp(hdr+8, "WAVE", 4) != 0) return -2;
    if (memcmp(hdr+12, "fmt ", 4) != 0) return -3;

    uint16_t audioFormat   = hdr[20] | (hdr[21] << 8);
    uint16_t numChannels   = hdr[22] | (hdr[23] << 8);
    uint32_t sampleRate    = hdr[24] | (hdr[25] << 8) | (hdr[26] << 16) | (hdr[27] << 24);
    uint16_t bitsPerSample = hdr[34] | (hdr[35] << 8);
    if (audioFormat != 1 || bitsPerSample != 16) return -4; // PCM16 only

    // Find "data" chunk (fmt may have extra bytes)
    uint32_t offset = 12 + 8 + (hdr[16] | (hdr[17]<<8) | (hdr[18]<<16) | (hdr[19]<<24));
    if (fseek(f, offset, SEEK_SET) != 0) return -5;
    for (;;) {
        unsigned char chunk[8];
        if (fread(chunk,1,8,f) != 8) return -6;
        uint32_t sz = chunk[4] | (chunk[5]<<8) | (chunk[6]<<16) | (chunk[7]<<24);
        if (memcmp(chunk, "data", 4) == 0) {
            *dataBytes  = sz;
            *dataOffset = ftell(f);
            break;
        }
        if (fseek(f, sz, SEEK_CUR) != 0) return -7;
    }

    meta->sampleRate = sampleRate;
    meta->channels   = numChannels;
    meta->numSamples = (*dataBytes) / (2 * numChannels); // 2 bytes per sample
    return 0;
}

static inline void write_wav_header(FILE* f, uint32_t sampleRate, uint16_t channels, uint32_t numSamples) {
    uint32_t subchunk1Size = 16;          // PCM
    uint16_t audioFormat   = 1;           // PCM
    uint16_t bitsPerSample = 16;
    uint32_t byteRate      = sampleRate * channels * (bitsPerSample/8);
    uint16_t blockAlign    = channels * (bitsPerSample/8);
    uint32_t dataSize      = numSamples * channels * (bitsPerSample/8);
    uint32_t riffSize      = 36 + dataSize;

    fwrite("RIFF",1,4,f); fwrite(&riffSize,4,1,f);
    fwrite("WAVE",1,4,f);
    fwrite("fmt ",1,4,f); fwrite(&subchunk1Size,4,1,f);
    fwrite(&audioFormat,2,1,f);
    fwrite(&channels,2,1,f);
    fwrite(&sampleRate,4,1,f);
    fwrite(&byteRate,4,1,f);
    fwrite(&blockAlign,2,1,f);
    fwrite(&bitsPerSample,2,1,f);
    fwrite("data",1,4,f); fwrite(&dataSize,4,1,f);
}

static inline int CompressToRaw(const char *wavPath, const char *rawPath, WavMeta* metaOut) {
    FILE* in = fopen(wavPath, "rb");
    if (!in) { perror("open input wav"); return -1; }

    WavMeta meta;
    uint32_t dataBytes=0, dataOffset=0;
    int rc = read_wav_header(in, &meta, &dataBytes, &dataOffset);
    if (rc != 0) { fprintf(stderr, "Unsupported/invalid WAV (rc=%d)\n", rc); fclose(in); return -2; }
    if (fseek(in, dataOffset, SEEK_SET) != 0) { perror("seek data"); fclose(in); return -3; }

    FILE* out = fopen(rawPath, "wb");
    if (!out) { perror("open raw out"); fclose(in); return -4; }

    const size_t bufSamples = 4096;
    int16_t* pcm = (int16_t*)aligned_alloc(16, bufSamples * meta.channels * sizeof(int16_t));
    int8_t* ulaw = (int8_t*)aligned_alloc(16, bufSamples * meta.channels);
    if (!pcm || !ulaw) { fprintf(stderr,"oom\n"); fclose(in); fclose(out); free(pcm); free(ulaw); return -5; }

    size_t samplesRemaining = meta.numSamples * meta.channels;
    while (samplesRemaining > 0) {
        size_t toRead = samplesRemaining < bufSamples*meta.channels ? samplesRemaining : bufSamples*meta.channels;
        size_t got = fread(pcm, sizeof(int16_t), toRead, in);
        if (got == 0) break;
        // for (size_t i=0;i<got;i++) ulaw[i] = MuLawCompress(pcm[i]); 
        for(size_t i=0; i<got; i += SAMPLES_PER_CALL) MuLawCompress(pcm + i, ulaw + i);
        fwrite(ulaw, 1, got, out);
        samplesRemaining -= got;
    }

    free(pcm); free(ulaw);
    fclose(in); fclose(out);

    if (metaOut) *metaOut = meta;
    return 0;
}

static inline int DecompressFromRaw(const char *rawPath, const char *outWavPath, const WavMeta* meta) {
    FILE* in = fopen(rawPath, "rb");
    if (!in) { perror("open raw in"); return -1; }
    FILE* out = fopen(outWavPath, "wb");
    if (!out) { perror("open wav out"); fclose(in); return -2; }

    // Determine total per-channel samples based on file size
    fseek(in, 0, SEEK_END);
    long rawBytes = ftell(in);
    fseek(in, 0, SEEK_SET);
    uint32_t totalSamples = (uint32_t)(rawBytes / meta->channels);

    write_wav_header(out, meta->sampleRate, meta->channels, totalSamples);

    const size_t bufBytes = 4096 * meta->channels;
    int8_t* ulaw = (int8_t*)aligned_alloc(8, bufBytes);
    int16_t* pcm  = (int16_t*)aligned_alloc(16, bufBytes * sizeof(int16_t));
    if (!ulaw || !pcm) { fprintf(stderr,"oom\n"); fclose(in); fclose(out); free(ulaw); free(pcm); return -3; }

    size_t remaining = (size_t)rawBytes;
    while (remaining > 0) {
        size_t toRead = remaining < bufBytes ? remaining : bufBytes;
        size_t got = fread(ulaw, 1, toRead, in);
        if (got == 0) break;
        // for (size_t i=0;i<got;i++) pcm[i] = MuLawDecompress(ulaw[i]);
        for (size_t i=0; i < got; i += SAMPLES_PER_CALL) MuLawDecompress(ulaw + i, pcm + i);
        fwrite(pcm, sizeof(int16_t), got, out);
        remaining -= got;
    }

    free(ulaw); free(pcm);
    fclose(in); fclose(out);
    return 0;
}
// Helper for file information printout
static inline void print_file_info(const char *wavIn, const char *rawFile, const char *wavOut, const WavMeta *meta) {
    struct stat st;
    double duration_sec = (double)meta->numSamples / meta->sampleRate;

    // Expected raw size
    size_t expectedRaw = (size_t)meta->numSamples * meta->channels; // 1 byte per sample

    printf("\n--- File Info ---\n");
    printf("Sample Rate: %u Hz\n", meta->sampleRate);
    printf("Channels:    %u\n", meta->channels);
    printf("Audio Sample Duration:    %.3f seconds\n", duration_sec);
    printf("Expected raw size: %zu bytes\n", expectedRaw);

    // Actual file sizes
    if (stat(wavIn, &st) == 0) {
        printf("Input WAV size:    %lld bytes\n", (long long)st.st_size);
    }
    if (stat(rawFile, &st) == 0) {
        printf("Raw file size:     %lld bytes\n", (long long)st.st_size);
    }
    if (stat(wavOut, &st) == 0) {
        printf("Output WAV size:   %lld bytes\n", (long long)st.st_size);
    }
    printf("------------------\n\n");
}


int main(int argc, char** argv) {
    const char* inWav = (argc > 1) ? argv[1] : "input.wav";
    const char* outRaw = (argc > 2) ? argv[2] : "compressed.raw";
    const char* outWav = (argc > 3) ? argv[3] : "output.wav";

    WavMeta meta;

    double comp_times[REPETITIONS];
    double decomp_times[REPETITIONS];

    for(int i = 0; i < REPETITIONS; i++)
    {
        double t0 = now_sec();
        if (CompressToRaw(inWav, outRaw, &meta) != 0) return 1;
        double t1 = now_sec();
        comp_times[i] = t1 - t0;
    }
    for(int i = 0; i < REPETITIONS; i++)
    {
        double t1 = now_sec();
        if (DecompressFromRaw(outRaw, outWav, &meta) != 0) return 1;
        double t2 = now_sec();
        decomp_times[i] = t2 - t1;
    }
    double comp_mean = 0;
    double decomp_mean = 0;
    for(int i=0; i<REPETITIONS; i++)
    {
        comp_mean += comp_times[i];
        decomp_mean += decomp_times[i];
    }
    comp_mean /= REPETITIONS;
    decomp_mean /= REPETITIONS;

    double comp_sd = 0;
    double decomp_sd = 0;
    for(int i=0; i<REPETITIONS; i++)
    {
        comp_sd += pow(comp_times[i] - comp_mean, 2);
        decomp_sd += pow(decomp_times[i] - decomp_mean, 2);
    }
    comp_sd /= REPETITIONS;
    decomp_sd /= REPETITIONS;
    comp_sd = sqrt(comp_sd);
    decomp_sd = sqrt(decomp_sd);

    printf("07: Unrolled, manual instruction pipelining:\n");
    printf("compression mean time: %f ms\n", comp_mean * 1000);
    printf("compression sd: %f ms\n", comp_sd * 1000);
    printf("decompression mean time: %f ms\n", decomp_mean * 1000);
    printf("decompression sd: %f ms\n\n", decomp_sd * 1000);

    // double tC_ms = (t1 - t0) * 1000.0; // ms
    // double tD_ms = (t2 - t1) * 1000.0; // ms
    // double tT_ms = (t2 - t0) * 1000.0; // ms

    // // Print statistics
    // printf("Compression time:   %.3f ms\n", tC_ms / REPETITIONS);
    // printf("Decompression time: %.3f ms\n", tD_ms / REPETITIONS);
    // printf("Total time:         %.3f ms\n", tT_ms / REPETITIONS);

    // print_file_info(inWav, outRaw, outWav, &meta);

    return 0;
}