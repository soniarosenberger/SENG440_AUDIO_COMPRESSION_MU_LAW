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


    int16x8_t in = vld1q_s16(sample);
    int16x8_t signs = vandq_s16(in, const0x8000); // save the signs, 0=positive
    in = vabsq_s16(in);                         // get absolute value
    
    int16x8_t clz = vclzq_s16(in); // Get right shift amount
    int16x8_t shift = vsubq_s16(const11, clz); // get unclamped shift value
    shift = vmaxq_s16(const4, shift); // the minimum shift is 4, so we clamp the value
    shift = vnegq_s16(shift); // Negate for a right shift
    int16x8_t out = vshlq_s16(in, shift);// Shift

    // Any value below the zero threshold should be zero in the output
    // This makes a mask so that if a value is zero, it can be stored as 0xFF after compressing
    uint16x8_t zero_mask = vcleq_s16(out, zero); // make zero mask

    // Add in chord
    // First, remove all but the 4 least significant bits
    out = vandq_s16(out, const15);

    out = vbslq_s16(zero_mask, constN1, out); // if mask = 1, set output to 0xFFFF

    // Get chord value
    clz = vsubq_s16(const8, clz);
    // clamp to 0, shift into place to add to result
    clz = vmaxq_s16(clz, const0);
    clz = vshlq_n_s16(clz, 4);
    // add in chord
    out = vorrq_s16(out, clz);


    // add back sign
    signs = vshrq_n_s16(signs, 8);
    out = vorrq_s16(out, signs);


    // // Put two vectors together and store them in output vector
    // // slightly fewer instructions compared to storing separately
    int8x8_t out_vec = vmovn_s16(out);
    vst1_s8(output, out_vec);

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


    int8x8_t in = vld1_s8(sample);

    int8x8_t chord = vand_s8(in, chord_mask);
    chord = vshr_n_s8(chord, 4); // sets chord range to [0,7]
    int8x8_t sign = vshr_n_s8(in, 7); // arithmetic shift, not logical. It returns -1 if negative, 0 otherwise

    // Remove all extra bits from the step value
    uint8x8_t small_out = vreinterpret_u8_s8(vand_s8(in, const15));

    // shift left 3, add bias, and shift left by clz
    small_out = vshl_n_u8(small_out, 3);
    small_out = vorr_u8(small_out, const84);

    // Check if the input was the zero code, 0xFF. 
    // If it was, set those values to zero
    uint8x8_t zero_mask = vceq_s8(in, zero_code);
    small_out = vbsl_u8(zero_mask, const0, small_out);

    // At this point, the output has to be moved into a 16x8 vector
    int16x8_t out = vreinterpretq_s16_u16(vmovl_u8(small_out));

    // Shift left
    int16x8_t big_chord = vmovl_s8(chord);
    out = vshlq_s16(out, big_chord);

    // To add back the sign, we use the sign vector as a mask.
    // negative values have their sign represented as -1, or 0xFFFF. 
    // an exclusive OR with the sign will perform a bitwise negation on the target
    int16x8_t big_sign1 = vmovl_s8(sign);
    out = veorq_s16(out, big_sign1); 
    // Finally, subtracting the sign from our output value is the same as adding 1 to all the values we inverted
    // The two steps are arithmetic negation in 2's complement
    out = vsubq_s16(out, big_sign1);

    vst1q_s16(output, out);
    return;
}