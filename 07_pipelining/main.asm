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
	.global	__aeabi_l2d
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
	.align	2
.LC16:
	.ascii	"07: Unrolled, manual instruction pipelining:\000"
	.align	2
.LC17:
	.ascii	"compression mean time: %f ms\012\000"
	.align	2
.LC18:
	.ascii	"compression sd: %f ms\012\000"
	.align	2
.LC19:
	.ascii	"decompression mean time: %f ms\012\000"
	.align	2
.LC20:
	.ascii	"decompression sd: %f ms\012\012\000"
	.section	.text.startup,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8176
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r2, r0
	ldr	r0, .L75+8
	vpush.64	{d8, d9, d10, d11, d12, d13, d14, d15}
	sub	sp, sp, #8160
	sub	sp, sp, #28
	ldr	r4, .L75+12
	ldr	r3, .L75+16
.LPIC29:
	add	r0, pc
.LPIC9:
	add	r4, pc
	add	r5, sp, #8160
	str	r4, [sp, #72]
	adds	r5, r5, #20
	cmp	r2, #1
	ldr	r3, [r0, r3]
	ldr	r3, [r3]
	str	r3, [r5]
	mov	r3, #0
	ble	.L30
	mov	r3, r1
	ldr	r1, [r1, #4]
	cmp	r2, #2
	str	r1, [sp, #32]
	beq	.L31
	ldr	r1, [r3, #8]
	cmp	r2, #3
	str	r1, [sp, #24]
	beq	.L32
	ldr	r3, [r3, #12]
	str	r3, [sp, #68]
.L2:
	add	r1, sp, #128
	add	r2, sp, #4128
	movw	lr, #18770
	movt	lr, 17990
	movw	r3, #16727
	movt	r3, 17750
	str	r2, [sp, #28]
	add	r2, sp, #120
	str	r3, [sp, #56]
	movw	r3, #28006
	movt	r3, 8308
	str	r2, [sp, #76]
	str	r3, [sp, #60]
	add	r2, sp, #112
	movw	r3, #24932
	movt	r3, 24948
	str	r2, [sp, #8]
	addw	r2, sp, #4088
	str	r1, [sp, #16]
	str	r2, [sp, #12]
	str	r1, [sp, #80]
	str	lr, [sp, #52]
	str	r3, [sp, #64]
.L15:
	ldr	r1, [sp, #8]
	movs	r0, #1
	bl	__clock_gettime64(PLT)
	ldr	r3, [sp, #12]
	subw	r4, r3, #3976
	ldrd	r0, [r4]
	bl	__aeabi_l2d(PLT)
	vldr.32	s18, [r4, #8]	@ int
	vmov	d8, r0, r1
	vldr.64	d16, .L75
	ldr	r1, .L75+20
	vcvt.f64.s32	d9, s18
	ldr	r0, [sp, #32]
.LPIC6:
	add	r1, pc
	vmul.f64	d9, d9, d16
	bl	fopen64(PLT)
	mov	r4, r0
	cmp	r0, #0
	beq	.L64
	mov	r3, r0
	add	r0, sp, #8128
	movs	r2, #44
	movs	r1, #1
	adds	r0, r0, #8
	bl	fread(PLT)
	cmp	r0, #44
	bne	.L33
	add	r3, sp, #8128
	ldr	r2, [sp, #52]
	adds	r3, r3, #8
	ldr	r3, [r3]
	cmp	r3, r2
	bne	.L35
	add	r3, sp, #8128
	ldr	r2, [sp, #56]
	adds	r3, r3, #16
	ldr	r3, [r3]
	cmp	r3, r2
	bne	.L35
	add	r3, sp, #8128
	ldr	r2, [sp, #60]
	adds	r3, r3, #20
	ldr	r3, [r3]
	cmp	r3, r2
	bne	.L36
	add	r1, sp, #8128
	add	r3, sp, #8128
	add	r2, sp, #8160
	adds	r3, r3, #28
	adds	r2, r2, #10
	adds	r1, r1, #30
	ldrh	fp, [r1]
	add	r1, sp, #8160
	ldrh	r3, [r3]
	ldrh	r2, [r2]
	ldr	r1, [r1]
	cmp	r2, #16
	it	eq
	cmpeq	r3, #1
	str	r1, [sp, #36]
	ite	ne
	movne	r2, #1
	moveq	r2, #0
	bne	.L37
	add	r3, sp, #8128
	mov	r0, r4
	adds	r3, r3, #24
	ldr	r1, [r3]
	adds	r1, r1, #20
	bl	fseek(PLT)
	cmp	r0, #0
	bne	.L38
	add	r5, sp, #8128
	ldr	r6, [sp, #64]
	str	r5, [sp, #48]
	b	.L10
.L67:
	add	r3, sp, #8128
	add	r2, sp, #8128
	adds	r2, r2, #4
	ldr	r3, [r3]
	ldr	r1, [r2]
	cmp	r3, r6
	beq	.L65
	movs	r2, #1
	mov	r0, r4
	bl	fseek(PLT)
	cmp	r0, #0
	bne	.L66
.L10:
	mov	r3, r4
	movs	r2, #8
	movs	r1, #1
	mov	r0, r5
	bl	fread(PLT)
	cmp	r0, #8
	beq	.L67
	mov	r8, r4
	mvn	r3, #5
.L5:
	ldr	r1, .L75+24
	ldr	r0, [sp, #72]
	ldr	r2, .L75+28
	ldr	r1, [r0, r1]
.LPIC8:
	add	r2, pc
	ldr	r0, [r1]
	movs	r1, #2
	bl	__fprintf_chk(PLT)
	mov	r0, r8
	bl	fclose(PLT)
.L11:
	movs	r3, #1
	str	r3, [sp, #40]
.L1:
	ldr	r2, .L75+32
	add	r1, sp, #8160
	ldr	r3, .L75+16
	adds	r1, r1, #20
.LPIC28:
	add	r2, pc
	ldr	r3, [r2, r3]
	ldr	r2, [r3]
	ldr	r3, [r1]
	eors	r2, r3, r2
	mov	r3, #0
	bne	.L68
	ldr	r0, [sp, #40]
	add	sp, sp, #8160
	add	sp, sp, #28
	@ sp needed
	vldm	sp!, {d8-d15}
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L31:
	ldr	r3, .L75+36
.LPIC1:
	add	r3, pc
	str	r3, [sp, #24]
	ldr	r3, .L75+40
.LPIC2:
	add	r3, pc
	str	r3, [sp, #68]
	b	.L2
.L76:
	.align	3
.L75:
	.word	-400107883
	.word	1041313291
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC29+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC9+4)
	.word	__stack_chk_guard(GOT)
	.word	.LC3-(.LPIC6+4)
	.word	stderr(GOT)
	.word	.LC5-(.LPIC8+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC28+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC0-(.LPIC2+4)
.L65:
	mov	r0, r4
	str	r1, [sp, #20]
	bl	ftell(PLT)
	ldr	r1, [sp, #20]
	lsl	r3, fp, #1
	mov	r5, r0
	mov	r0, r1
	mov	r1, r3
	str	r3, [sp, #44]
	bl	__aeabi_uidiv(PLT)
	mov	r1, r5
	mov	r7, r0
	movs	r2, #0
	mov	r0, r4
	bl	fseek(PLT)
	str	r0, [sp, #40]
	cmp	r0, #0
	bne	.L69
	ldr	r1, .L77+16
	ldr	r0, [sp, #24]
.LPIC11:
	add	r1, pc
	bl	fopen64(PLT)
	mov	r10, r0
	cmp	r0, #0
	beq	.L70
	lsl	r5, fp, #13
	movs	r0, #16
	mov	r1, r5
	lsl	r8, fp, #12
	bl	aligned_alloc(PLT)
	mov	r1, r8
	mov	r9, r0
	movs	r0, #16
	bl	aligned_alloc(PLT)
	mov	r6, r0
	cmp	r0, #0
	it	ne
	cmpne	r9, #0
	beq	.L71
	mul	r7, r7, fp
	cmp	r7, #0
	beq	.L17
	vmov.i16	q6, #4  @ v8hi
	str	fp, [sp, #20]
	vmov.i16	q5, #11  @ v8hi
.L14:
	cmp	r8, r7
	mov	r3, r8
	mov	r2, #2
	it	cs
	movcs	r3, r7
	mov	r1, r5
	mov	r0, r9
	str	r4, [sp]
	bl	__fread_chk(PLT)
	mov	fp, r0
	cmp	r0, #0
	beq	.L59
	vmov.i16	q1, #8  @ v8hi
	mov	r0, r9
	vmov.i32	q2, #0  @ v8hi
	movs	r3, #0
	vmov.i16	q3, #14  @ v8hi
	vmov.i32	q15, #4294967295  @ v8hi
	vmov.i16	q14, #15  @ v8hi
	vmov.i16	q13, #32768  @ v8hi
.L18:
	mov	r2, r0
	adds	r0, r0, #32
	vld1.16	{d0-d1}, [r2:128]!
	vabs.s16	q11, q0
	vld1.16	{d24-d25}, [r2:128]
	adds	r2, r6, r3
	vand	q0, q0, q13
	adds	r3, r3, #16
	vclz.i16	q8, q11
	cmp	fp, r3
	vabs.s16	q7, q12
	vand	q12, q12, q13
	vshr.s16	q0, q0, #8
	vsub.i16	q9, q5, q8
	vclz.i16	q10, q7
	vsub.i16	q8, q1, q8
	vshr.s16	q12, q12, #8
	vmax.s16	q9, q6, q9
	vmax.s16	q8, q8, q2
	vneg.s16	q9, q9
	vshl.i16	q8, q8, #4
	vshl.s16	q11, q11, q9
	vsub.i16	q9, q5, q10
	vsub.i16	q10, q1, q10
	vmax.s16	q9, q6, q9
	vmax.s16	q10, q10, q2
	vneg.s16	q9, q9
	vshl.i16	q10, q10, #4
	vshl.s16	q9, q7, q9
	vcge.s16	q7, q3, q11
	vand	q11, q11, q14
	vbsl	q7, q15, q11
	vcge.s16	q11, q3, q9
	vand	q9, q9, q14
	vorr	q8, q8, q7
	vbit	q9, q15, q11
	vorr	q8, q8, q0
	vorr	q9, q10, q9
	vmovn.i16	d16, q8
	vorr	q9, q9, q12
	vmovn.i16	d18, q9
	vmov	d17, d18  @ v8qi
	vst1.8	{d16-d17}, [r2:128]
	bhi	.L18
	mov	r3, r10
	mov	r2, fp
	movs	r1, #1
	mov	r0, r6
	bl	fwrite(PLT)
	subs	r7, r7, fp
	bne	.L14
.L59:
	ldr	fp, [sp, #20]
.L17:
	mov	r0, r9
	bl	free(PLT)
	mov	r0, r6
	bl	free(PLT)
	mov	r0, r4
	bl	fclose(PLT)
	mov	r0, r10
	bl	fclose(PLT)
	ldr	r1, [sp, #8]
	movs	r0, #1
	bl	__clock_gettime64(PLT)
	ldr	r3, [sp, #12]
	subw	r4, r3, #3976
	ldrd	r0, [r4]
	bl	__aeabi_l2d(PLT)
	ldr	r3, [r4, #8]
	vmov	d16, r0, r1
	vmov	s15, r3	@ int
	vldr.64	d18, .L77
	ldr	r3, [sp, #16]
	vcvt.f64.s32	d17, s15
	ldr	r2, [sp, #28]
	vnmls.f64	d8, d17, d18
	vadd.f64	d16, d16, d8
	vsub.f64	d16, d16, d9
	vstmia.64	r3!, {d16}
	cmp	r2, r3
	str	r3, [sp, #16]
	bne	.L15
	ldrh	r3, [sp, #44]
	mov	r2, fp
	str	r3, [sp, #52]
	ldr	r3, [sp, #36]
	ldr	r6, [sp, #12]
	vldr.64	d10, .L77
	str	fp, [sp, #32]
	add	fp, sp, #4128
	mul	r3, r2, r3
	str	fp, [sp, #20]
	str	r5, [sp, #64]
	str	r8, [sp, #16]
	lsls	r3, r3, #1
	str	r3, [sp, #44]
	ldr	r3, .L77+20
	str	fp, [sp, #84]
.LPIC14:
	add	r3, pc
	str	r3, [sp, #56]
	ldr	r3, .L77+24
.LPIC16:
	add	r3, pc
	str	r3, [sp, #60]
.L24:
	subw	r10, r6, #3976
	ldr	r1, [sp, #8]
	movs	r0, #1
	bl	__clock_gettime64(PLT)
	ldrd	r0, [r10]
	bl	__aeabi_l2d(PLT)
	vldr.32	s15, [r10, #8]	@ int
	vmov	d8, r0, r1
	ldr	r1, [sp, #56]
	ldr	r0, [sp, #24]
	vcvt.f64.s32	d9, s15
	bl	fopen64(PLT)
	mov	r5, r0
	vmul.f64	d9, d9, d10
	cmp	r0, #0
	beq	.L72
	ldr	r1, [sp, #60]
	ldr	r0, [sp, #68]
	bl	fopen64(PLT)
	mov	r7, r0
	cmp	r0, #0
	beq	.L73
	movs	r2, #2
	movs	r1, #0
	mov	r0, r5
	mov	r8, #1
	bl	fseek(PLT)
	mov	r0, r5
	bl	ftell(PLT)
	movs	r2, #0
	mov	r1, r2
	mov	fp, r0
	mov	r0, r5
	mov	r9, #16
	bl	fseek(PLT)
	sub	r1, r6, #3984
	ldr	r4, [sp, #44]
	subw	r3, r6, #3992
	ldr	r0, [sp, #32]
	subw	ip, r6, #3988
	str	r4, [r1]
	subw	r1, r6, #3994
	ldr	r2, [sp, #36]
	str	r2, [r3]
	subw	r2, r6, #3996
	ldr	r4, [sp, #52]
	add	r3, sp, #88
	str	r3, [sp, #12]
	subw	r3, r6, #3998
	strh	r4, [r1]	@ movhi
	mov	r4, r0
	str	r9, [ip]
	mov	r1, r0
	strh	r9, [r2]	@ movhi
	strh	r0, [sp, #88]	@ movhi
	mov	r0, fp
	strh	r8, [r3]	@ movhi
	bl	__aeabi_idiv(PLT)
	mul	r3, r4, r0
	subw	r2, r6, #3980
	ldr	r0, .L77+28
	mov	r1, r8
	lsl	r3, r3, r8
.LPIC18:
	add	r0, pc
	str	r3, [r2]
	adds	r3, r3, #36
	movs	r2, #4
	str	r3, [r10]
	mov	r3, r7
	bl	fwrite(PLT)
	mov	r3, r7
	mov	r2, r8
	movs	r1, #4
	ldr	r0, [sp, #8]
	bl	fwrite(PLT)
	ldr	r0, .L77+32
	mov	r3, r7
	movs	r2, #4
	mov	r1, r8
.LPIC19:
	add	r0, pc
	bl	fwrite(PLT)
	ldr	r0, .L77+36
	mov	r3, r7
	movs	r2, #4
	mov	r1, r8
.LPIC20:
	add	r0, pc
	bl	fwrite(PLT)
	ldr	r4, [sp, #76]
	mov	r3, r7
	mov	r2, r8
	movs	r1, #4
	sub	r0, r4, #20
	bl	fwrite(PLT)
	mov	r3, r7
	mov	r2, r8
	movs	r1, #2
	sub	r0, r4, #30
	bl	fwrite(PLT)
	mov	r3, r7
	mov	r2, r8
	movs	r1, #2
	ldr	r0, [sp, #12]
	bl	fwrite(PLT)
	mov	r3, r7
	mov	r2, r8
	movs	r1, #4
	sub	r0, r4, #24
	bl	fwrite(PLT)
	mov	r3, r7
	mov	r2, r8
	movs	r1, #4
	sub	r0, r4, #16
	bl	fwrite(PLT)
	mov	r3, r7
	mov	r2, r8
	movs	r1, #2
	sub	r0, r4, #26
	bl	fwrite(PLT)
	mov	r3, r7
	mov	r2, r8
	movs	r1, #2
	sub	r0, r4, #28
	bl	fwrite(PLT)
	ldr	r0, .L77+40
	mov	r3, r7
	movs	r2, #4
	mov	r1, r8
.LPIC21:
	add	r0, pc
	bl	fwrite(PLT)
	mov	r3, r7
	mov	r2, r8
	movs	r1, #4
	sub	r0, r4, #12
	bl	fwrite(PLT)
	ldr	r1, [sp, #16]
	movs	r0, #8
	bl	aligned_alloc(PLT)
	mov	r3, r0
	ldr	r1, [sp, #64]
	mov	r0, r9
	mov	r9, r3
	bl	aligned_alloc(PLT)
	mov	r10, r0
	cmp	r0, #0
	it	ne
	cmpne	r9, #0
	beq	.L74
	cmp	fp, #0
	beq	.L26
	vmov.i8	d12, #0xf  @ v8qi
	vmov.i8	d11, #0x70  @ v8qi
	ldr	r4, [sp, #16]
.L23:
	cmp	r4, fp
	mov	r2, r4
	mov	r3, r5
	it	cs
	movcs	r2, fp
	movs	r1, #1
	mov	r0, r9
	bl	fread(PLT)
	mov	r8, r0
	cmp	r0, #0
	beq	.L60
	vmov.i32	d22, #0xffffffff  @ v8qi
	vmov.i32	d21, #0  @ v8qi
	vmov.i8	d20, #0x84  @ v8qi
	mov	r1, r10
	movs	r3, #0
.L27:
	add	r2, r9, r3
	adds	r3, r3, #16
	cmp	r8, r3
	vld1.8	{d16}, [r2:64]!
	vld1.8	{d24}, [r2:64]
	vand	d18, d16, d12
	vceq.i8	d23, d16, d22
	vshr.s8	d28, d16, #7
	vand	d16, d16, d11
	mov	r2, r1
	vand	d25, d24, d12
	vceq.i8	d19, d24, d22
	vshl.i8	d18, d18, #3
	vshr.s8	d26, d24, #7
	vand	d24, d24, d11
	add	r1, r1, #32
	vshr.s8	d30, d16, #4
	vshl.i8	d16, d25, #3
	vorr	d18, d18, d20
	vmovl.s8	q14, d28
	vmovl.s8	q13, d26
	vorr	d16, d16, d20
	vshr.s8	d24, d24, #4
	vbit	d18, d21, d23
	vmovl.s8	q15, d30
	vbit	d16, d21, d19
	vmovl.u8	q9, d18
	vmovl.s8	q12, d24
	vmovl.u8	q8, d16
	veor	q9, q14, q9
	veor	q8, q13, q8
	vshl.s16	q9, q9, q15
	vshl.s16	q8, q8, q12
	vsub.i16	q9, q9, q14
	vsub.i16	q8, q8, q13
	vst1.16	{d18-d19}, [r2:128]!
	vst1.16	{d16-d17}, [r2:128]
	bhi	.L27
	mov	r3, r7
	mov	r2, r8
	movs	r1, #2
	mov	r0, r10
	bl	fwrite(PLT)
	subs	fp, fp, r8
	bne	.L23
.L60:
	str	r4, [sp, #16]
.L26:
	mov	r0, r9
	bl	free(PLT)
	mov	r0, r10
	bl	free(PLT)
	mov	r0, r5
	subw	r5, r6, #3976
	bl	fclose(PLT)
	mov	r0, r7
	bl	fclose(PLT)
	ldr	r1, [sp, #8]
	movs	r0, #1
	bl	__clock_gettime64(PLT)
	ldrd	r0, [r5]
	bl	__aeabi_l2d(PLT)
	ldr	r3, [r5, #8]
	vmov	d16, r0, r1
	vmov	s15, r3	@ int
	ldr	r3, [sp, #20]
	ldr	r2, [sp, #48]
	vcvt.f64.s32	d17, s15
	vnmls.f64	d8, d17, d10
	vadd.f64	d16, d16, d8
	vsub.f64	d16, d16, d9
	vstmia.64	r3!, {d16}
	cmp	r2, r3
	str	r3, [sp, #20]
	bne	.L24
	vmov.i64	d16, #0	@ float
	ldr	r0, [sp, #28]
	ldrd	r1, fp, [sp, #80]
	vmov.f64	d9, d16
	mov	r2, fp
	mov	r3, r1
.L25:
	vldmia.64	r3!, {d18}
	vldmia.64	r2!, {d17}
	vadd.f64	d9, d9, d18
	cmp	r3, r0
	vadd.f64	d16, d16, d17
	bne	.L25
	vmov.i64	d18, #0	@ float
	vldr.64	d8, .L77+8
	ldr	r3, [sp, #28]
	vmul.f64	d9, d9, d8
	vmul.f64	d8, d16, d8
	vmov.f64	d19, d18
	b	.L78
.L79:
	.align	3
.L77:
	.word	-400107883
	.word	1041313291
	.word	-755914244
	.word	1063281229
	.word	.LC7-(.LPIC11+4)
	.word	.LC3-(.LPIC14+4)
	.word	.LC7-(.LPIC16+4)
	.word	.LC12-(.LPIC18+4)
	.word	.LC13-(.LPIC19+4)
	.word	.LC14-(.LPIC20+4)
	.word	.LC15-(.LPIC21+4)
.L78:
.L28:
	vldmia.64	r1!, {d17}
	vldmia.64	fp!, {d16}
	vsub.f64	d17, d17, d9
	cmp	r1, r3
	vsub.f64	d16, d16, d8
	vmla.f64	d19, d17, d17
	vmla.f64	d18, d16, d16
	bne	.L28
	vldr.64	d16, .L80
	vldr.64	d10, .L80+8
	ldr	r0, .L80+16
	vmul.f64	d19, d19, d16
	vmul.f64	d18, d18, d16
.LPIC23:
	add	r0, pc
	vsqrt.f64	d12, d19
	vsqrt.f64	d11, d18
	bl	puts(PLT)
	vmul.f64	d16, d9, d10
	ldr	r1, .L80+20
	movs	r0, #2
.LPIC24:
	add	r1, pc
	vmov	r2, r3, d16
	bl	__printf_chk(PLT)
	ldr	r1, .L80+24
	movs	r0, #2
.LPIC25:
	add	r1, pc
	vmul.f64	d16, d12, d10
	vmov	r2, r3, d16
	bl	__printf_chk(PLT)
	vmul.f64	d16, d8, d10
	ldr	r1, .L80+28
	movs	r0, #2
.LPIC26:
	add	r1, pc
	vmov	r2, r3, d16
	bl	__printf_chk(PLT)
	vmul.f64	d16, d11, d10
	ldr	r1, .L80+32
	movs	r0, #2
.LPIC27:
	add	r1, pc
	vmov	r2, r3, d16
	bl	__printf_chk(PLT)
	b	.L1
.L66:
	mov	r8, r4
	mvn	r3, #6
	b	.L5
.L30:
	ldr	r3, .L80+36
.LPIC3:
	add	r3, pc
	str	r3, [sp, #24]
	ldr	r3, .L80+40
.LPIC4:
	add	r3, pc
	str	r3, [sp, #32]
	ldr	r3, .L80+44
.LPIC5:
	add	r3, pc
	str	r3, [sp, #68]
	b	.L2
.L37:
	mov	r8, r4
	mvn	r3, #3
	b	.L5
.L35:
	mov	r8, r4
	mvn	r3, #1
	b	.L5
.L33:
	mov	r8, r4
	mov	r3, #-1
	b	.L5
.L38:
	mov	r8, r4
	mvn	r3, #4
	b	.L5
.L36:
	mov	r8, r4
	mvn	r3, #2
	b	.L5
.L32:
	ldr	r3, .L80+48
.LPIC0:
	add	r3, pc
	str	r3, [sp, #68]
	b	.L2
.L74:
	ldr	r3, .L80+52
	mov	r1, r8
	ldr	r2, [sp, #72]
	ldr	r0, .L80+56
	ldr	r3, [r2, r3]
.LPIC22:
	add	r0, pc
	movs	r2, #4
	ldr	r3, [r3]
	bl	fwrite(PLT)
	mov	r0, r5
	bl	fclose(PLT)
	mov	r0, r7
	bl	fclose(PLT)
	mov	r0, r9
	bl	free(PLT)
	mov	r0, r10
	bl	free(PLT)
	b	.L11
.L71:
	ldr	r3, .L80+52
	movs	r1, #1
	ldr	r2, [sp, #72]
	ldr	r0, .L80+60
	ldr	r3, [r2, r3]
.LPIC13:
	add	r0, pc
	movs	r2, #4
	ldr	r3, [r3]
	bl	fwrite(PLT)
	mov	r0, r4
	bl	fclose(PLT)
	mov	r0, r10
	bl	fclose(PLT)
	mov	r0, r9
	bl	free(PLT)
	mov	r0, r6
	bl	free(PLT)
	b	.L11
.L68:
	bl	__stack_chk_fail(PLT)
.L70:
	ldr	r0, .L80+64
.LPIC12:
	add	r0, pc
	bl	perror(PLT)
	mov	r0, r4
	bl	fclose(PLT)
	b	.L11
.L73:
	ldr	r0, .L80+68
.LPIC17:
	add	r0, pc
	bl	perror(PLT)
	mov	r0, r5
	bl	fclose(PLT)
	b	.L11
.L72:
	ldr	r0, .L80+72
.LPIC15:
	add	r0, pc
	bl	perror(PLT)
	b	.L11
.L64:
	ldr	r0, .L80+76
.LPIC7:
	add	r0, pc
	bl	perror(PLT)
	b	.L11
.L69:
	ldr	r0, .L80+80
.LPIC10:
	add	r0, pc
	bl	perror(PLT)
	mov	r0, r4
	bl	fclose(PLT)
	b	.L11
.L81:
	.align	3
.L80:
	.word	-755914244
	.word	1063281229
	.word	0
	.word	1083129856
	.word	.LC16-(.LPIC23+4)
	.word	.LC17-(.LPIC24+4)
	.word	.LC18-(.LPIC25+4)
	.word	.LC19-(.LPIC26+4)
	.word	.LC20-(.LPIC27+4)
	.word	.LC1-(.LPIC3+4)
	.word	.LC2-(.LPIC4+4)
	.word	.LC0-(.LPIC5+4)
	.word	.LC0-(.LPIC0+4)
	.word	stderr(GOT)
	.word	.LC9-(.LPIC22+4)
	.word	.LC9-(.LPIC13+4)
	.word	.LC8-(.LPIC12+4)
	.word	.LC11-(.LPIC17+4)
	.word	.LC10-(.LPIC15+4)
	.word	.LC4-(.LPIC7+4)
	.word	.LC6-(.LPIC10+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",%progbits
