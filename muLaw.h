#pragma once
#include <stdint.h>

// MAC test version

// Per-sample μ-law API (portable, G.711 μ=255)
// Encode one 16-bit PCM sample to 8-bit μ-law
uint8_t  MuLawCompress(int16_t sample);

// Decode one 8-bit μ-law code back to 16-bit PCM
int16_t  MuLawDecompress(uint8_t code);
