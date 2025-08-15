# SENG 440
# Authors: Sonia Rosenberger and Alexander Williams

Semester project for implementing mu-law audio compression.

This project implements and optimizes a μ-law audio companding algorithm on a 32-bit ARM virtual machine environment running Fedora 29 Linux. The design began with a portable C reference implementation for testing on macOS, which was later replaced with a NEON-accelerated version for deployment on the target VM. Key optimizations included inlining critical functions to prevent register spilling, exploiting two’s complement properties for faster sign restoration, and tuning vector operations for reduced overhead. Performance testing compared the baseline software implementation to the optimized and hardware-accelerated versions, and compared perceived quality of the output audio to that of the original. Optimizations yielded acceptable latency and intelligibility in the context of a two-way audio communication use case. This implementation demonstrates that careful optimizations and factoring in the tolerance of human perception can significantly improve performance under resource constraints while maintaining functionality in embedded audio applications.

The main contributions of this project are as follows:
1) Developed a µ-law companding implementation in C for ARM deployment with 16-bit PCM sample input.
2) Designed and implemented a NEON-based µ-law encoder/decoder, achieving acceptable balance between processing latency and audio quality.
3) Applied targeted optimizations, including function inlining to avoid register spilling, improved sign restoration using bitwise operations, and removal of low-value zero-check branches.
4) Implemented built-in statistics methods and iterative modularized testing approach for accurate and straightforward latency benchmarking in the ARM environment.
5) Implemented a Python test environment for quality evaluation of optimized code, incorporating both PESQ and STOI metrics.
6) Provided a modular API structure and build system supporting both portable and NEON versions, facilitating ease of integration and high-level testing.
