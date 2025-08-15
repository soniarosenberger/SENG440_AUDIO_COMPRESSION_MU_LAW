	.arch armv7-a
	.fpu neon
	.eabi_attribute 28, 1
	.eabi_attribute 23, 1
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"output.wav\000"
	.align	2
.LC1:
	.ascii	"compressed.raw\000"
	.align	2
.LC2:
	.ascii	"input.wav\000"
	.align	2
.LC3:
	.ascii	"rb\000"
	.align	2
.LC4:
	.ascii	"open input wav\000"
	.global	__aeabi_uidiv
	.align	2
.LC5:
	.ascii	"Unsupported/invalid WAV (rc=%d)\012\000"
	.align	2
.LC6:
	.ascii	"seek data\000"
	.align	2
.LC7:
	.ascii	"wb\000"
	.align	2
.LC8:
	.ascii	"open raw out\000"
	.align	2
.LC9:
	.ascii	"oom\012\000"
	.align	2
.LC10:
	.ascii	"open raw in\000"
	.align	2
.LC11:
	.ascii	"open wav out\000"
	.global	__aeabi_idiv
	.align	2
.LC12:
	.ascii	"RIFF\000"
	.align	2
.LC13:
	.ascii	"WAVE\000"
	.align	2
.LC14:
	.ascii	"fmt \000"
	.align	2
.LC15:
	.ascii	"data\000"
	.global	__aeabi_l2d
	.align	2
.LC16:
	.ascii	"Compression time:   %.3f ms\012\000"
	.align	2
.LC17:
	.ascii	"Decompression time: %.3f ms\012\000"
	.align	2
.LC18:
	.ascii	"Total time:         %.3f ms\012\000"
	.align	2
.LC19:
	.ascii	"\012--- File Info ---\000"
	.align	2
.LC20:
	.ascii	"Sample Rate: %u Hz\012\000"
	.align	2
.LC21:
	.ascii	"Channels:    %u\012\000"
	.align	2
.LC22:
	.ascii	"Audio Sample Duration:    %.3f seconds\012\000"
	.align	2
.LC23:
	.ascii	"Expected raw size: %zu bytes\012\000"
	.align	2
.LC24:
	.ascii	"Input WAV size:    %lld bytes\012\000"
	.align	2
.LC25:
	.ascii	"Raw file size:     %lld bytes\012\000"
	.align	2
.LC26:
	.ascii	"Output WAV size:   %lld bytes\012\000"
	.align	2
.LC27:
	.ascii	"------------------\012\000"
	.section	.text.startup,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 280
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r2, r0
	ldr	r0, .L80+8
	vpush.64	{d8, d9, d10, d11}
	sub	sp, sp, #292
	ldr	r4, .L80+12
.LPIC36:
	add	r0, pc
	ldr	r3, .L80+16
	cmp	r2, #1
.LPIC9:
	add	r4, pc
	str	r4, [sp, #84]
	ldr	r3, [r0, r3]
	ldr	r3, [r3]
	str	r3, [sp, #284]
	mov	r3, #0
	ble	.L32
	mov	r3, r1
	ldr	r1, [r1, #4]
	cmp	r2, #2
	str	r1, [sp, #40]
	beq	.L33
	ldr	r1, [r3, #8]
	cmp	r2, #3
	str	r1, [sp, #32]
	beq	.L34
	ldr	r3, [r3, #12]
	str	r3, [sp, #76]
.L2:
	add	r3, sp, #120
	movs	r0, #1
	mov	r1, r3
	str	r3, [sp, #80]
	bl	__clock_gettime64(PLT)
	ldr	r3, .L80+20
	mov	r2, #500
	vldr.32	s18, [sp, #128]	@ int
	str	r2, [sp, #20]
.LPIC6:
	add	r3, pc
	ldrd	r1, [sp, #120]
	str	r3, [sp, #48]
	movw	ip, #16727
	movt	ip, 17750
	movw	r3, #18770
	movt	r3, 17990
	movw	lr, #28006
	movt	lr, 8308
	movw	fp, #24932
	movt	fp, 24948
	strd	r1, [sp, #88]
	strd	r3, ip, [sp, #56]
	str	lr, [sp, #72]
	str	fp, [sp, #64]
.L15:
	ldr	r1, [sp, #48]
	ldr	r0, [sp, #40]
	bl	fopen64(PLT)
	mov	r5, r0
	cmp	r0, #0
	beq	.L66
	mov	r3, r0
	movs	r2, #44
	movs	r1, #1
	add	r0, sp, #240
	bl	fread(PLT)
	cmp	r0, #44
	bne	.L35
	ldr	r3, [sp, #240]
	ldr	r2, [sp, #56]
	cmp	r3, r2
	bne	.L37
	ldr	r3, [sp, #248]
	ldr	r2, [sp, #60]
	cmp	r3, r2
	bne	.L37
	ldr	r3, [sp, #252]
	ldr	r2, [sp, #72]
	cmp	r3, r2
	bne	.L38
	ldrh	r2, [sp, #274]
	ldrh	r3, [sp, #260]
	ldrh	r1, [sp, #262]
	cmp	r2, #16
	it	eq
	cmpeq	r3, #1
	str	r1, [sp, #16]
	ldr	r1, [sp, #264]
	ite	ne
	movne	r2, #1
	moveq	r2, #0
	str	r1, [sp, #36]
	bne	.L39
	ldr	r1, [sp, #256]
	mov	r0, r5
	adds	r1, r1, #20
	bl	fseek(PLT)
	cmp	r0, #0
	bne	.L40
	ldr	r6, [sp, #64]
	add	r4, sp, #232
	b	.L10
.L69:
	ldrd	r3, r1, [sp, #232]
	cmp	r3, r6
	beq	.L67
	movs	r2, #1
	mov	r0, r5
	bl	fseek(PLT)
	cmp	r0, #0
	bne	.L68
.L10:
	mov	r3, r5
	movs	r2, #8
	movs	r1, #1
	mov	r0, r4
	bl	fread(PLT)
	cmp	r0, #8
	beq	.L69
	mvn	r3, #5
.L5:
	ldr	r1, .L80+24
	ldr	r0, [sp, #84]
	ldr	r2, .L80+28
	ldr	r1, [r0, r1]
.LPIC8:
	add	r2, pc
	ldr	r0, [r1]
	movs	r1, #2
	bl	__fprintf_chk(PLT)
	mov	r0, r5
	bl	fclose(PLT)
.L11:
	movs	r3, #1
	str	r3, [sp, #44]
.L1:
	ldr	r2, .L80+32
	ldr	r3, .L80+16
.LPIC35:
	add	r2, pc
	ldr	r3, [r2, r3]
	ldr	r2, [r3]
	ldr	r3, [sp, #284]
	eors	r2, r3, r2
	mov	r3, #0
	bne	.L70
	ldr	r0, [sp, #44]
	add	sp, sp, #292
	@ sp needed
	vldm	sp!, {d8-d11}
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L33:
	ldr	r3, .L80+36
.LPIC1:
	add	r3, pc
	str	r3, [sp, #32]
	ldr	r3, .L80+40
.LPIC2:
	add	r3, pc
	str	r3, [sp, #76]
	b	.L2
.L67:
	mov	r0, r5
	str	r1, [sp, #12]
	bl	ftell(PLT)
	ldr	r3, [sp, #16]
	ldr	r1, [sp, #12]
	mov	r4, r0
	lsls	r3, r3, #1
	mov	r0, r1
	mov	r1, r3
	str	r3, [sp, #52]
	bl	__aeabi_uidiv(PLT)
	mov	r1, r4
	str	r0, [sp, #24]
	movs	r2, #0
	mov	r0, r5
	bl	fseek(PLT)
	str	r0, [sp, #44]
	cmp	r0, #0
	bne	.L71
	ldr	r1, .L80+44
	ldr	r0, [sp, #32]
.LPIC11:
	add	r1, pc
	bl	fopen64(PLT)
	mov	r9, r0
	cmp	r0, #0
	beq	.L72
	ldr	r4, [sp, #16]
	movs	r0, #16
	lsls	r3, r4, #13
	lsl	r10, r4, #12
	mov	r1, r3
	str	r3, [sp, #12]
	bl	aligned_alloc(PLT)
	mov	r1, r10
	mov	r7, r0
	movs	r0, #16
	bl	aligned_alloc(PLT)
	mov	r8, r0
	cmp	r0, #0
	it	ne
	cmpne	r7, #0
	beq	.L73
	ldr	r3, [sp, #16]
	movs	r4, #1
	ldr	r2, [sp, #24]
	mul	r3, r2, r3
	str	r3, [sp, #28]
	mov	r6, r3
	cbz	r3, .L17
.L14:
	cmp	r10, r6
	mov	r3, r10
	ldr	r1, [sp, #12]
	it	cs
	movcs	r3, r6
	movs	r2, #2
	mov	r0, r7
	str	r5, [sp]
	bl	__fread_chk(PLT)
	mov	fp, r0
	cbz	r0, .L17
	mov	r3, r7
	mov	r1, r8
	add	lr, r7, r0, lsl #1
.L18:
	ldrsh	r0, [r3], #2
	.syntax unified
@ 117 "main.c" 1
	add r2, r0, r4
@ 0 "" 2
	.thumb
	.syntax unified
	cmp	r3, lr
	strb	r2, [r1], #1
	bne	.L18
	mov	r3, r9
	mov	r2, fp
	movs	r1, #1
	mov	r0, r8
	bl	fwrite(PLT)
	subs	r6, r6, fp
	bne	.L14
.L17:
	mov	r0, r7
	bl	free(PLT)
	mov	r0, r8
	bl	free(PLT)
	mov	r0, r5
	bl	fclose(PLT)
	mov	r0, r9
	bl	fclose(PLT)
	ldr	r3, [sp, #20]
	subs	r3, r3, #1
	str	r3, [sp, #20]
	bne	.L15
	ldr	r1, [sp, #80]
	movs	r0, #1
	bl	__clock_gettime64(PLT)
	ldrh	r3, [sp, #52]
	ldr	r2, [sp, #16]
	str	r3, [sp, #52]
	ldr	r3, [sp, #36]
	vldr.32	s16, [sp, #128]	@ int
	mul	r3, r2, r3
	lsls	r3, r3, #1
	str	r3, [sp, #48]
	ldr	r3, .L80+48
.LPIC14:
	add	r3, pc
	str	r3, [sp, #56]
	ldr	r3, .L80+52
.LPIC16:
	add	r3, pc
	str	r3, [sp, #60]
	ldr	r3, .L80+56
.LPIC18:
	add	r3, pc
	str	r3, [sp, #72]
	mov	r3, #500
	str	r3, [sp, #20]
	ldrd	r3, [sp, #120]
	strd	r3, [sp, #64]
.L24:
	ldr	r1, [sp, #56]
	ldr	r0, [sp, #32]
	bl	fopen64(PLT)
	mov	fp, r0
	cmp	r0, #0
	beq	.L74
	ldr	r1, [sp, #60]
	ldr	r0, [sp, #76]
	bl	fopen64(PLT)
	mov	r6, r0
	cmp	r0, #0
	beq	.L75
	movs	r2, #2
	movs	r1, #0
	mov	r0, fp
	mov	r9, #1
	bl	fseek(PLT)
	mov	r0, fp
	bl	ftell(PLT)
	movs	r2, #0
	mov	r1, r2
	mov	r5, r0
	mov	r0, fp
	movs	r4, #16
	bl	fseek(PLT)
	ldr	r7, [sp, #16]
	ldr	r2, [sp, #48]
	mov	r0, r5
	ldr	r3, [sp, #36]
	mov	r1, r7
	str	r2, [sp, #112]
	ldr	r2, [sp, #52]
	str	r4, [sp, #108]
	strh	r4, [sp, #100]	@ movhi
	str	r3, [sp, #104]
	strh	r7, [sp, #96]	@ movhi
	strh	r2, [sp, #102]	@ movhi
	strh	r9, [sp, #98]	@ movhi
	bl	__aeabi_idiv(PLT)
	mul	r3, r7, r0
	movs	r2, #4
	mov	r1, r9
	ldr	r0, [sp, #72]
	lsl	r3, r3, r9
	str	r3, [sp, #116]
	adds	r3, r3, #36
	str	r3, [sp, #120]
	mov	r3, r6
	bl	fwrite(PLT)
	mov	r3, r6
	mov	r2, r9
	movs	r1, #4
	ldr	r0, [sp, #80]
	bl	fwrite(PLT)
	ldr	r0, .L80+60
	mov	r3, r6
	movs	r2, #4
	mov	r1, r9
.LPIC19:
	add	r0, pc
	bl	fwrite(PLT)
	ldr	r0, .L80+64
	mov	r3, r6
	movs	r2, #4
	mov	r1, r9
.LPIC20:
	add	r0, pc
	bl	fwrite(PLT)
	mov	r3, r6
	mov	r2, r9
	movs	r1, #4
	add	r0, sp, #108
	bl	fwrite(PLT)
	mov	r3, r6
	mov	r2, r9
	movs	r1, #2
	add	r0, sp, #98
	bl	fwrite(PLT)
	mov	r3, r6
	mov	r2, r9
	movs	r1, #2
	add	r0, sp, #96
	bl	fwrite(PLT)
	mov	r3, r6
	mov	r2, r9
	movs	r1, #4
	add	r0, sp, #104
	bl	fwrite(PLT)
	mov	r3, r6
	mov	r2, r9
	movs	r1, #4
	add	r0, sp, #112
	bl	fwrite(PLT)
	mov	r3, r6
	mov	r2, r9
	movs	r1, #2
	add	r0, sp, #102
	bl	fwrite(PLT)
	mov	r3, r6
	mov	r2, r9
	movs	r1, #2
	add	r0, sp, #100
	bl	fwrite(PLT)
	ldr	r0, .L80+68
	mov	r3, r6
	movs	r2, #4
	mov	r1, r9
.LPIC21:
	add	r0, pc
	bl	fwrite(PLT)
	mov	r3, r6
	mov	r2, r9
	movs	r1, #4
	add	r0, sp, #116
	bl	fwrite(PLT)
	mov	r1, r10
	movs	r0, #8
	bl	aligned_alloc(PLT)
	ldr	r1, [sp, #12]
	mov	r8, r0
	mov	r0, r4
	bl	aligned_alloc(PLT)
	cmp	r0, #0
	it	ne
	cmpne	r8, #0
	mov	r7, r0
	ite	eq
	moveq	r4, #1
	movne	r4, #0
	beq	.L76
	mov	r9, r5
	cbz	r5, .L26
.L23:
	cmp	r10, r9
	mov	r2, r10
	mov	r3, fp
	it	cs
	movcs	r2, r9
	movs	r1, #1
	mov	r0, r8
	bl	fread(PLT)
	mov	r5, r0
	cbz	r0, .L26
	add	r3, r8, #-1
	mov	r2, r7
	add	ip, r3, r0
.L27:
	ldrb	r0, [r3, #1]!	@ zero_extendqisi2
	.syntax unified
@ 161 "main.c" 1
	add r1, r0, r4
@ 0 "" 2
	.thumb
	.syntax unified
	cmp	r3, ip
	strh	r1, [r2], #2	@ movhi
	bne	.L27
	mov	r3, r6
	mov	r2, r5
	movs	r1, #2
	mov	r0, r7
	bl	fwrite(PLT)
	subs	r9, r9, r5
	bne	.L23
.L26:
	mov	r0, r8
	bl	free(PLT)
	mov	r0, r7
	bl	free(PLT)
	mov	r0, fp
	bl	fclose(PLT)
	mov	r0, r6
	bl	fclose(PLT)
	ldr	r3, [sp, #20]
	subs	r3, r3, #1
	str	r3, [sp, #20]
	bne	.L24
	vcvt.f64.s32	d9, s18
	vldr.64	d11, .L80
	vcvt.f64.s32	d8, s16
	ldrd	r0, [sp, #88]
	bl	__aeabi_l2d(PLT)
	vmul.f64	d9, d9, d11
	vmov	d16, r0, r1
	vmul.f64	d8, d8, d11
	ldrd	r0, [sp, #64]
	vadd.f64	d9, d9, d16
	bl	__aeabi_l2d(PLT)
	ldr	r5, [sp, #80]
	vmov	d16, r0, r1
	movs	r0, #1
	mov	r1, r5
	vadd.f64	d8, d8, d16
	bl	__clock_gettime64(PLT)
	ldrd	r0, [sp, #120]
	bl	__aeabi_l2d(PLT)
	vldr.32	s15, [sp, #128]	@ int
	vmov	d10, r0, r1
	vsub.f64	d18, d8, d9
	ldr	r1, .L80+72
	movs	r0, #2
	vcvt.f64.s32	d17, s15
.LPIC23:
	add	r1, pc
	vadd.f64	d16, d18, d18
	vmla.f64	d10, d17, d11
	vmov	r2, r3, d16
	bl	__printf_chk(PLT)
	ldr	r1, .L80+76
	movs	r0, #2
.LPIC24:
	add	r1, pc
	vsub.f64	d8, d10, d8
	vsub.f64	d9, d10, d9
	vadd.f64	d16, d8, d8
	vmov	r2, r3, d16
	bl	__printf_chk(PLT)
	vadd.f64	d16, d9, d9
	ldr	r1, .L80+80
	movs	r0, #2
.LPIC25:
	add	r1, pc
	vmov	r2, r3, d16
	bl	__printf_chk(PLT)
	ldr	r0, .L80+84
.LPIC26:
	add	r0, pc
	bl	puts(PLT)
	ldr	r4, [sp, #36]
	ldr	r1, .L80+88
	movs	r0, #2
	mov	r2, r4
.LPIC27:
	add	r1, pc
	bl	__printf_chk(PLT)
	ldr	r1, .L80+92
	ldr	r2, [sp, #16]
	movs	r0, #2
.LPIC28:
	add	r1, pc
	bl	__printf_chk(PLT)
	vldr.32	s15, [sp, #24]	@ int
	ldr	r1, .L80+96
	movs	r0, #2
	vcvt.f64.u32	d16, s15
	vmov	s15, r4	@ int
.LPIC29:
	add	r1, pc
	vcvt.f64.u32	d17, s15
	vdiv.f64	d16, d16, d17
	vmov	r2, r3, d16
	bl	__printf_chk(PLT)
	ldr	r1, .L80+100
	ldr	r2, [sp, #28]
	movs	r0, #2
.LPIC30:
	add	r1, pc
	bl	__printf_chk(PLT)
	ldr	r0, [sp, #40]
	mov	r1, r5
	bl	__stat64_time64(PLT)
	cmp	r0, #0
	beq	.L77
.L28:
	ldr	r1, [sp, #80]
	ldr	r0, [sp, #32]
	bl	__stat64_time64(PLT)
	cmp	r0, #0
	beq	.L78
.L29:
	ldrd	r0, r1, [sp, #76]
	bl	__stat64_time64(PLT)
	cmp	r0, #0
	beq	.L79
.L30:
	ldr	r0, .L80+104
.LPIC34:
	add	r0, pc
	bl	puts(PLT)
	b	.L1
.L68:
	mvn	r3, #6
	b	.L5
.L32:
	ldr	r3, .L80+108
.LPIC3:
	add	r3, pc
	str	r3, [sp, #32]
	ldr	r3, .L80+112
.LPIC4:
	add	r3, pc
	str	r3, [sp, #40]
	ldr	r3, .L80+116
.LPIC5:
	add	r3, pc
	str	r3, [sp, #76]
	b	.L2
.L39:
	mvn	r3, #3
	b	.L5
.L37:
	mvn	r3, #1
	b	.L5
.L35:
	mov	r3, #-1
	b	.L5
.L40:
	mvn	r3, #4
	b	.L5
.L38:
	mvn	r3, #2
	b	.L5
.L34:
	ldr	r3, .L80+120
.LPIC0:
	add	r3, pc
	str	r3, [sp, #76]
	b	.L2
.L76:
	ldr	r3, .L80+24
	mov	r7, r8
	ldr	r2, [sp, #84]
	mov	r8, r0
	ldr	r0, .L80+124
	mov	r1, r9
	ldr	r3, [r2, r3]
.LPIC22:
	add	r0, pc
	movs	r2, #4
	ldr	r3, [r3]
	bl	fwrite(PLT)
	mov	r0, fp
	bl	fclose(PLT)
	mov	r0, r6
.L64:
	bl	fclose(PLT)
	mov	r0, r7
	bl	free(PLT)
	mov	r0, r8
	bl	free(PLT)
	b	.L11
.L73:
	ldr	r3, .L80+24
	movs	r1, #1
	ldr	r2, [sp, #84]
	ldr	r0, .L80+128
	ldr	r3, [r2, r3]
.LPIC13:
	add	r0, pc
	movs	r2, #4
	ldr	r3, [r3]
	bl	fwrite(PLT)
	mov	r0, r5
	bl	fclose(PLT)
	mov	r0, r9
	b	.L64
.L70:
	bl	__stack_chk_fail(PLT)
.L77:
	ldr	r1, .L80+132
	movs	r0, #2
	ldrd	r2, [sp, #160]
.LPIC31:
	add	r1, pc
	bl	__printf_chk(PLT)
	b	.L28
.L79:
	ldr	r1, .L80+136
	movs	r0, #2
	ldrd	r2, [sp, #160]
.LPIC33:
	add	r1, pc
	bl	__printf_chk(PLT)
	b	.L30
.L78:
	ldr	r1, .L80+140
	movs	r0, #2
	ldrd	r2, [sp, #160]
.LPIC32:
	add	r1, pc
	bl	__printf_chk(PLT)
	b	.L29
.L72:
	ldr	r0, .L80+144
.LPIC12:
	add	r0, pc
	bl	perror(PLT)
	mov	r0, r5
	bl	fclose(PLT)
	b	.L11
.L75:
	ldr	r0, .L80+148
.LPIC17:
	add	r0, pc
	bl	perror(PLT)
	mov	r0, fp
	bl	fclose(PLT)
	b	.L11
.L74:
	ldr	r0, .L80+152
.LPIC15:
	add	r0, pc
	bl	perror(PLT)
	b	.L11
.L66:
	ldr	r0, .L80+156
.LPIC7:
	add	r0, pc
	bl	perror(PLT)
	b	.L11
.L71:
	ldr	r0, .L80+160
.LPIC10:
	add	r0, pc
	bl	perror(PLT)
	mov	r0, r5
	bl	fclose(PLT)
	b	.L11
.L81:
	.align	3
.L80:
	.word	-400107883
	.word	1041313291
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC36+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC9+4)
	.word	__stack_chk_guard(GOT)
	.word	.LC3-(.LPIC6+4)
	.word	stderr(GOT)
	.word	.LC5-(.LPIC8+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC35+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC0-(.LPIC2+4)
	.word	.LC7-(.LPIC11+4)
	.word	.LC3-(.LPIC14+4)
	.word	.LC7-(.LPIC16+4)
	.word	.LC12-(.LPIC18+4)
	.word	.LC13-(.LPIC19+4)
	.word	.LC14-(.LPIC20+4)
	.word	.LC15-(.LPIC21+4)
	.word	.LC16-(.LPIC23+4)
	.word	.LC17-(.LPIC24+4)
	.word	.LC18-(.LPIC25+4)
	.word	.LC19-(.LPIC26+4)
	.word	.LC20-(.LPIC27+4)
	.word	.LC21-(.LPIC28+4)
	.word	.LC22-(.LPIC29+4)
	.word	.LC23-(.LPIC30+4)
	.word	.LC27-(.LPIC34+4)
	.word	.LC1-(.LPIC3+4)
	.word	.LC2-(.LPIC4+4)
	.word	.LC0-(.LPIC5+4)
	.word	.LC0-(.LPIC0+4)
	.word	.LC9-(.LPIC22+4)
	.word	.LC9-(.LPIC13+4)
	.word	.LC24-(.LPIC31+4)
	.word	.LC26-(.LPIC33+4)
	.word	.LC25-(.LPIC32+4)
	.word	.LC8-(.LPIC12+4)
	.word	.LC11-(.LPIC17+4)
	.word	.LC10-(.LPIC15+4)
	.word	.LC4-(.LPIC7+4)
	.word	.LC6-(.LPIC10+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",%progbits
