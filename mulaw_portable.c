
// MAC test version
// mulaw_portable.c - reference μ-law (G.711) encode/decode (portable)
// To configure for final implementation, replace with ACTUAL implementation using NEON.

#include <stdint.h>
#include <stdlib.h>

#define BIAS 132   // 0x84, per G.711
#define CLIP 32635 // max magnitude before clipping

// linear PCM (16-bit) -> μ-law (8-bit)
static inline uint8_t linear2ulaw(int16_t pcm_val) {
    int16_t mask, seg;
    uint8_t uval;

    // Get sign and magnitude (common to shift a bit; keeps ranges nicer)
    pcm_val = pcm_val >> 2; // optional scale used in many refs
    if (pcm_val < 0) {
        pcm_val = -pcm_val;
        mask = 0x7F;
    } else {
        mask = 0xFF;
    }
    if (pcm_val > CLIP) pcm_val = CLIP;

    pcm_val += BIAS;

    // Find segment
    if      (pcm_val >= 4096) seg = 7;
    else if (pcm_val >= 2048) seg = 6;
    else if (pcm_val >= 1024) seg = 5;
    else if (pcm_val >= 512 ) seg = 4;
    else if (pcm_val >= 256 ) seg = 3;
    else if (pcm_val >= 128 ) seg = 2;
    else if (pcm_val >= 64  ) seg = 1;
    else                      seg = 0;

    // Quantize & assemble
    uint8_t quant = (seg < 2) ? ((pcm_val >> 1) & 0x0F) : ((pcm_val >> (seg + 2)) & 0x0F);
    uval = (~((seg << 4) | quant)) & 0x7F;
    return uval ^ mask;
}

// μ-law (8-bit) -> linear PCM (16-bit)
static inline int16_t ulaw2linear(uint8_t u_val) {
    u_val = ~u_val;
    int t = ((u_val & 0x0F) << 1) + BIAS;
    int seg = (u_val & 0x70) >> 4;
    if (seg) t = (t + 0x100) << (seg - 1);
    return (u_val & 0x80) ? (BIAS - t) : (t - BIAS);
}

// Public per-sample API
uint8_t MuLawCompress(int16_t sample)   { return linear2ulaw(sample); }
int16_t MuLawDecompress(uint8_t code)   { return ulaw2linear(code); }
