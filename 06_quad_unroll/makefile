# Makefile - Mac-friendly defaults (portable μ-law)
# Usage: To run main.c:
#		./main  <input.wav>  [compressed.raw]  [output.wav]
# 		<input.wav> – path to source 16-bit PCM WAV file. REQUIRED
# 		[compressed.raw] – name/path for the μ-law-encoded byte stream (default: compressed.raw). OPTIONAL
# 		[output.wav] – name/path for the reconstructed PCM WAV file (default: output.wav). OPTIONAL

# DEFAULT: ./main
# Requires input.wav in current directory, produces compressed.raw and output.wav in current directory

CC ?= cc
CFLAGS ?= -Ofast -Wall -Wextra -lm
VMFLAGS ?= -mfpu=neon -mcpu=cortex-a15

all: main

main: main.c mulaw_portable.c muLaw.h
	$(CC) $(CFLAGS) main.c mulaw_portable.c -o main

neon: main.c muLaw_neon.h
	$(CC) $(CFLAGS) $(VMFLAGS) main.c -o main_06

test: test_cases.c muLaw_neon.h
	$(CC) $(CFLAGS) $(VMFLAGS) test_cases.c -o test

clean:
	rm -f *.o main test
