#pragma once

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <arm_neon.h>

void MuLawCompress(int16_t* sample, int8_t* output);


void MuLawDecompress(int8_t* sample, int16_t* output);