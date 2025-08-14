#pragma once

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <arm_neon.h>

#define ZERO_THRESHOLD 0x000E
#define ZERO_CODE 0xFF

static inline void MuLawCompress(int16_t* sample, int8_t* output)
{
    // constants are pulled out of loop by the compiler, so they might as well be
    // defined all at once here
    int16x8_t const0 = vdupq_n_s16(0);
    int16x8_t const0x8000 = vdupq_n_s16(0x8000);
    int16x8_t const11 = vdupq_n_s16(11);
    int16x8_t const4 = vdupq_n_s16(4);
    int16x8_t zero = vdupq_n_s16(ZERO_THRESHOLD);
    int16x8_t const15 = vdupq_n_s16(0x000F);
    int16x8_t const8 = vdupq_n_s16(8);
    int16x8_t constN1 = vdupq_n_s16(-1);


    int16x8_t in1 = vld1q_s16(sample);
    int16x8_t in2 = vld1q_s16(sample + 8);

    int16x8_t signs1 = vandq_s16(in1, const0x8000); // save the signs, 0=positive
    int16x8_t signs2 = vandq_s16(in2, const0x8000); 
    
    in1 = vabsq_s16(in1);                         // get absolute value
    in2 = vabsq_s16(in2);
    
    int16x8_t clz1 = vclzq_s16(in1); // Get right shift amount
    int16x8_t clz2 = vclzq_s16(in2); 
    
    int16x8_t shift1 = vsubq_s16(const11, clz1); // get unclamped shift value
    int16x8_t shift2 = vsubq_s16(const11, clz2); 
    
    shift1 = vmaxq_s16(const4, shift1); // the minimum shift is 4, so we clamp the value
    shift2 = vmaxq_s16(const4, shift2);
    
    shift1 = vnegq_s16(shift1); // Negate for a right shift
    shift2 = vnegq_s16(shift2);

    clz1 = vsubq_s16(const8, clz1);
    clz2 = vsubq_s16(const8, clz2);

    int16x8_t out1 = vshlq_s16(in1, shift1);// Shift
    int16x8_t out2 = vshlq_s16(in2, shift2);

    uint16x8_t zero_mask1 = vcleq_s16(out1, zero); // make zero mask
    uint16x8_t zero_mask2 = vcleq_s16(out2, zero); 

    clz1 = vmaxq_s16(clz1, const0);
    clz2 = vmaxq_s16(clz2, const0);

    out1 = vandq_s16(out1, const15);
    out2 = vandq_s16(out2, const15);

    clz1 = vshlq_n_s16(clz1, 4);
    clz2 = vshlq_n_s16(clz2, 4);

    out1 = vbslq_s16(zero_mask1, constN1, out1); // if mask = 1, set output to 0xFFFF
    out2 = vbslq_s16(zero_mask2, constN1, out2); 

    signs1 = vshrq_n_s16(signs1, 8);
    signs2 = vshrq_n_s16(signs2, 8);

    out1 = vorrq_s16(out1, clz1);
    out2 = vorrq_s16(out2, clz2);

    out1 = vorrq_s16(out1, signs1);
    out2 = vorrq_s16(out2, signs2);

    int8x8_t out_vec1 = vmovn_s16(out1);
    int8x8_t out_vec2 = vmovn_s16(out2);
    int8x16_t full_out = vcombine_s8(out_vec1, out_vec2);
    vst1q_s8(output, full_out);

    return;
}


static inline void MuLawDecompress(int8_t* sample, int16_t* output)
{
    // constants are pulled out of loop by the compiler, so they might as well be
    // defined all at once here
    int8x8_t chord_mask = vdup_n_s8(0x70);
    int8x8_t const15 = vdup_n_s8(0x000F);
    uint8x8_t const84 = vdup_n_u8(0x84);
    int8x8_t zero_code = vdup_n_s8(ZERO_CODE);
    uint8x8_t const0 = vdup_n_u8(0);


    int8x8_t in1 = vld1_s8(sample);
    int8x8_t in2 = vld1_s8(&sample[8]);

    int8x8_t chord1 = vand_s8(in1, chord_mask);
    int8x8_t chord2 = vand_s8(in2, chord_mask);

    uint8x8_t small_out1 = vreinterpret_u8_s8(vand_s8(in1, const15));
    uint8x8_t small_out2 = vreinterpret_u8_s8(vand_s8(in2, const15));

    int8x8_t sign1 = vshr_n_s8(in1, 7); // arithmetic shift, not logical. It returns -1 if negative, 0 otherwise
    int8x8_t sign2 = vshr_n_s8(in2, 7);

    small_out1 = vshl_n_u8(small_out1, 3);
    small_out2 = vshl_n_u8(small_out2, 3);

    chord1 = vshr_n_s8(chord1, 4); // sets chord range to [0,7]
    chord2 = vshr_n_s8(chord2, 4);

    small_out1 = vorr_u8(small_out1, const84);
    small_out2 = vorr_u8(small_out2, const84);

    uint8x8_t zero_mask1 = vceq_s8(in1, zero_code);
    uint8x8_t zero_mask2 = vceq_s8(in2, zero_code);

    int16x8_t big_chord1 = vmovl_s8(chord1);
    int16x8_t big_chord2 = vmovl_s8(chord2);
    
    small_out1 = vbsl_u8(zero_mask1, const0, small_out1);
    small_out2 = vbsl_u8(zero_mask2, const0, small_out2);

    int16x8_t big_sign1 = vmovl_s8(sign1);
    int16x8_t big_sign2 = vmovl_s8(sign2);

    int16x8_t out1 = vreinterpretq_s16_u16(vmovl_u8(small_out1));
    int16x8_t out2 = vreinterpretq_s16_u16(vmovl_u8(small_out2));

    out1 = veorq_s16(out1, big_sign1); 
    out2 = veorq_s16(out2, big_sign2);

    out1 = vshlq_s16(out1, big_chord1);
    out2 = vshlq_s16(out2, big_chord2);

    out1 = vsubq_s16(out1, big_sign1);
    out2 = vsubq_s16(out2, big_sign2);

    vst1q_s16(output, out1);
    vst1q_s16(&output[8], out2);
    return;
}