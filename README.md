# SENG440_Audio_Compression
Semester project for implementing audio compression on an embedded system

Explanation of how to use this structure with neon implementation:

muLaw.h            # per-sample API (unchanged)
mulaw_portable.c   # portable C u law dummy implementation (used on mac)
mulaw_neon.c       # NEW: NEON implementation for the VM
main.c             # unchanged (calls per-sample API)
Makefile           # add a 'neon' target for the VM