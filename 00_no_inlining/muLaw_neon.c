#include "muLaw_neon.h"

#define ZERO_THRESHOLD 0x000E
#define ZERO_CODE 0xFF

void MuLawCompress(int16_t* sample, int8_t* output)
{
    // constants are pulled out of loop by the compiler, so they might as well be
    // defined all at once here
    int16x8_t const0x8000 = vdupq_n_s16(0x8000);
    int16x8_t const11 = vdupq_n_s16(11);
    int16x8_t const4 = vdupq_n_s16(4);
    int16x8_t zero = vdupq_n_s16(ZERO_THRESHOLD);
    int16x8_t const15 = vdupq_n_s16(0x000F);
    int16x8_t const8 = vdupq_n_s16(8);


    int16x8_t in = vld1q_s16(sample);
    int16x8_t signs = vandq_s16(in, const0x8000); // save the signs, 0=positive
    in = vabsq_s16(in);                         // get absolute value


    int16x8_t clz = vclzq_s16(in); // Get right shift amount
    int16x8_t shift = vsubq_s16(const11, clz); // get unclamped shift value
    shift = vmaxq_s16(const4, shift); // the minimum shift is 4, so we clamp the value
    shift = vnegq_s16(shift);//negate for a right shift
    int16x8_t out = vshlq_s16(in, shift);// Shift

    

    // Any value below the zero threshold should be zero in the output
    // This makes a mask so that if a value is zero, it can be stored as 0xFF after compressing
    uint16x8_t zero_mask = vcleq_s16(out, zero); // make zero mask
    int16x8_t signed_mask = vreinterpretq_s16_u16(zero_mask); // convert zero mask to signed int

    // Add in chord
    // First, remove all but the 4 least significant bits
    out = vandq_s16(out, const15);

    out = vbslq_s16(zero_mask, signed_mask, out); // if mask = 1, set output to 0xFFFF

    // Get chord value
    clz = vsubq_s16(const8, clz);
    // clamp to 0, shift into place to add to result
    int16x8_t const0 = vdupq_n_s16(0);
    clz = vmaxq_s16(clz, const0);
    clz = vshlq_n_s16(clz, 4);
    // add in chord
    out = vorrq_s16(out, clz);


    // add back sign
    signs = vshrq_n_s16(signs, 8);
    out = vorrq_s16(out, signs);

    // Convert back into int pointer
    int8x8_t out8x8 = vmovn_s16(out);
    vst1_s8(output, out8x8);
    return;
}

void MuLawDecompress(int8_t* sample, int16_t* output)
{
    // constants are pulled out of loop by the compiler, so they might as well be
    // defined all at once here
    int8x8_t const1 = vdup_n_s8(1);
    int8x8_t chord_mask = vdup_n_s8(0x70);
    int16x8_t const15 = vdupq_n_s16(0x000F);
    int16x8_t const84 = vdupq_n_s16(0x0084);
    int8x8_t zero_code = vdup_n_s8(ZERO_CODE);
    int16x8_t const0 = vdupq_n_s16(0);

    int8x8_t in = vld1_s8(sample);

    int8x8_t chord = vand_s8(in, chord_mask);
    chord = vshr_n_s8(chord, 4); // sets chord range to [0,7]
    int8x8_t sign = vshr_n_s8(in, 7); // arithmetic shift, not logical. It returns -1 if negative, 0 otherwise
    int16x8_t out = vmovl_s8(in);

    // Remove all extra bits from the step value
    out = vandq_s16(out, const15);

    // add left 3, add bias, and shift left by clz
    out = vshlq_n_s16(out, 3);
    out = vaddq_s16(out, const84);

    // Shift left
    int16x8_t temp = vmovl_s8(chord);
    out = vshlq_s16(out, temp);

    // To add back the sign, we use our zero mask from earlier.
    // Adding 1 to it creates a vector with 0 for negative numbers, and 1 for positive numbers
    // adding this vector and the mask together returns -1 for negative numbers, +1 for positive numbers
    // multiplying the output vector by this will swap the signs of all negative numbers
    int8x8_t pos_sign = vadd_s8(sign, const1);
    int8x8_t sign_mask = vadd_s8(sign, pos_sign);
    int16x8_t large_sign = vmovl_s8(sign_mask);
    out = vmulq_s16(out, large_sign);

    // // set zero values to zero
    uint8x8_t zero_mask = vceq_s8(in, zero_code);
    uint16x8_t zero_mask_s16 = vmovl_u8(zero_mask);
    zero_mask_s16 = vmulq_n_u16(zero_mask_s16, 0x0101);  // Expand mask to full 16-bit
    out = vbslq_s16(zero_mask_s16, /*vdupq_n_s16(0)*/ const0, out);

    vst1q_s16(output, out);
    return;
}