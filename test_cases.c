#include "muLaw_neon.h"
#include <stdio.h>
#include <stdlib.h>
// int8x8_t MuLawCompress(int16x8_t in);
// int16x8_t MuLawDecompress(int8x8_t sample);

int test_comp(int8_t expected[8], int16_t input[8], int test_case)
{
    int8_t actual[8];
    MuLawCompress(input, actual);

    for(int i = 0; i < 8; i++)
    {
        if(expected[i] != actual[i])
        {
            printf("Test case %d failed.\nExpected Actual\n", test_case);
            for(int j = 0; j< 8; j++)
            {
                printf("%d        %d\n", expected[j], actual[j]);
            }
            return 1;
        }
    }
    printf("Test case %d passed!\n", test_case);
    return 0;
}

int test_decomp(int16_t expected[8], int8_t input[8], int test_case)
{
    int16_t actual[8];
    MuLawDecompress(input, actual);

    for(int i = 0; i < 8; i++)
    {
        if(expected[i] != actual[i])
        {
            printf("Test case %d failed.\nExpected Actual\n", test_case);
            for(int j = 0; j< 8; j++)
            {
                printf("%d        %d\n", expected[j], actual[j]);
            }
            return 1;
        }
    }
    printf("Test case %d passed!\n", test_case);
    return 0;
}

int main()
{

    printf("Compression tests\n");

    // Test 1: values that get compressed to zero
    int16_t input[8] = 
    { 
        0,
        1,
        2,
        4,
        8,
        10,
        12,
        15
    };
    int8_t expected[8] = 
    {
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
    };
    test_comp(expected, input, 1);
    
    // Test 2: Values with a chord of zero
    int16_t i2[8] =
    {
        0x000f,
        0x0010,
        0x0020,
        0x0040,
        0x0068,
        0x0080,
        0x00A0,
        0x00FF
    };
    int8_t e2[8] = 
    {
        0x00,
        0x01,
        0x02,
        0x04,
        0x06,
        0x08,
        0x0A,
        0x0F
    };
    test_comp(e2, i2, 2);

    // Test 3: Min and max values of chord 0-3
    int16_t i3[8] = 
    {
        0x0010,
        0x00F0,
        0x0100,
        0x01F0,
        0x0200,
        0x03E0,
        0x0400,
        0x07C0
    };
    int8_t e3[8] =
    {
        0x01,
        0x0F,
        0x10,
        0x1F,
        0x20,
        0x2F,
        0x30,
        0x3F  
    };
    test_comp(e3, i3, 3);

    // Test 4: Min and max values of chords 4-7
    int16_t i4[8] = 
    {
        0x0800,
        0x0F80,
        0x1000,
        0x1F00,
        0x2000,
        0x3E00,
        0x4000,
        0x7C00
    };
    int8_t e4[8] =
    {
        0x40,
        0x4F,
        0x50,
        0x5F,
        0x60,
        0x6F,
        0x70,
        0x7F  
    };
    test_comp(e4, i4, 4);

    // Test 5: Negative values match positive values
        int16_t i5[8] = 
    {
        2048,
        -2048,
        3968,
        -3968,
        4096,
        -4096,
        7936,
        -7936,
    };
    int8_t e5[8] =
    {
        0x40,
        0xC0,
        0x4F,
        0xCF,
        0x50,
        0xD0,
        0x5F,
        0xDF,
    };
    test_comp(e5, i5, 5);

    // ------------------------------------------
    printf("Decompression tests\n");

    // Test 6: decompression for chords 0-1
    int8_t i6[8] = 
    {
        0x00,
        0x0F,
        0x80,
        0x8F,
        0x10,
        0x1F,
        0x90,
        0x9F
    };
    int16_t e6[8] =
    {
        0x0084,
        0x00FC,
        0x0084 * -1,
        0x00FC * -1,
        0x0108,
        0x01F8,
        0x0108 * -1,
        0x01F8 * -1
    };
    test_decomp(e6, i6, 6);

    // Test 7: decompression for chords 2-3
    int8_t i7[8] = 
    {
        0x20,
        0x2F,
        0xA0,
        0xAF,
        0x30,
        0x3F,
        0xB0,
        0xBF
    };
    int16_t e7[8] =
    {
        0x0210,
        0x03F0,
        0x0210 * -1,
        0x03F0 * -1,
        0x0420,
        0x07E0,
        0x0420 * -1,
        0x07E0 * -1
    };
    test_decomp(e7, i7, 7);

    // Test 8: decompression for chords 4-5
    int8_t i8[8] = 
    {
        0x40,
        0x4F,
        0xC0,
        0xCF,
        0x50,
        0x5F,
        0xD0,
        0xDF
    };
    int16_t e8[8] =
    {
        0x0840,
        0x0FC0,
        0x0840 * -1,
        0x0FC0 * -1,
        0x1080,
        0x1F80,
        0x1080 * -1,
        0x1F80 * -1
    };
    test_decomp(e8, i8, 8);

    // Test 9: decompression for chords 6-7
    int8_t i9[8] = 
    {
        0x60,
        0x6F,
        0xE0,
        0xEF,
        0x70,
        0x7F,
        0xF0,
        0xFF
    };
    int16_t e9[8] =
    {
        0x2100,
        0x3F00,
        0x2100 * -1,
        0x3F00 * -1,
        0x4200,
        0x7E00,
        0x4200 * -1,
        0
    };
    test_decomp(e9, i9, 9);
}