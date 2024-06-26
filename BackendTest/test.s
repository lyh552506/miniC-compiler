    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  M
    .bss
    .align  2
    .type  M, @object
    .size  M, 4
M:
    .zero  4
    .globl  L
    .align  2
    .type  L, @object
    .size  L, 4
L:
    .zero  4
    .globl  N
    .align  2
    .type  N, @object
    .size  N, 4
N:
    .zero  4
    .text
    .align  1
    .globl  mul
    .type  mul, @function
mul:
.LBB0:
	addi sp, sp, -96
	sd ra, 88(sp)
	sd s0, 80(sp)
	addi s0, sp, 96
	ld t0, 0(s0)
	mv a0, a0
	mv a1, a1
	mv a2, a2
	mv a3, a3
	mv a4, a4
	mv a5, a5
	mv a6, a6
	mv a7, a7
	j .LBB1
.LBB1:
	li t0, 0
	sw t0, -24(s0)
	flw t0, -100(s0)
	addw t0, s0, t0
	flw ft1, 0(t0)
	flw t0, -76(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	fmul.s ft2, ft1, ft0
	flw t0, -100(s0)
	addw t0, s0, t0
	flw ft1, 4(t0)
	flw t0, -68(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	fmul.s ft0, ft1, ft0
	fadd.s ft2, ft2, ft0
	flw t0, -100(s0)
	addw t0, s0, t0
	flw ft1, 8(t0)
	flw t0, -60(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	fmul.s ft0, ft1, ft0
	fadd.s ft0, ft2, ft0
	flw t0, -52(s0)
	addw t0, s0, t0
	fsw ft0, 0(t0)
	flw t0, -100(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	flw t0, -76(s0)
	addw t0, s0, t0
	flw ft1, 4(t0)
	fmul.s ft2, ft0, ft1
	flw t0, -100(s0)
	addw t0, s0, t0
	flw ft1, 4(t0)
	flw t0, -68(s0)
	addw t0, s0, t0
	flw ft0, 4(t0)
	fmul.s ft0, ft1, ft0
	fadd.s ft1, ft2, ft0
	flw t0, -100(s0)
	addw t0, s0, t0
	flw ft0, 8(t0)
	flw t0, -60(s0)
	addw t0, s0, t0
	flw ft2, 4(t0)
	fmul.s ft0, ft0, ft2
	fadd.s ft0, ft1, ft0
	flw t0, -52(s0)
	addw t0, s0, t0
	fsw ft0, 4(t0)
	flw t0, -100(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	flw t0, -76(s0)
	addw t0, s0, t0
	flw ft1, 8(t0)
	fmul.s ft1, ft0, ft1
	flw t0, -100(s0)
	addw t0, s0, t0
	flw ft2, 4(t0)
	flw t0, -68(s0)
	addw t0, s0, t0
	flw ft0, 8(t0)
	fmul.s ft0, ft2, ft0
	fadd.s ft2, ft1, ft0
	flw t0, -100(s0)
	addw t0, s0, t0
	flw ft1, 8(t0)
	flw t0, -60(s0)
	addw t0, s0, t0
	flw ft0, 8(t0)
	fmul.s ft0, ft1, ft0
	fadd.s ft0, ft2, ft0
	flw t0, -52(s0)
	addw t0, s0, t0
	fsw ft0, 8(t0)
	flw t0, -92(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	flw t0, -76(s0)
	addw t0, s0, t0
	flw ft1, 0(t0)
	fmul.s ft1, ft0, ft1
	flw t0, -92(s0)
	addw t0, s0, t0
	flw ft2, 4(t0)
	flw t0, -68(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	fmul.s ft0, ft2, ft0
	fadd.s ft2, ft1, ft0
	flw t0, -92(s0)
	addw t0, s0, t0
	flw ft1, 8(t0)
	flw t0, -60(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	fmul.s ft0, ft1, ft0
	fadd.s ft0, ft2, ft0
	flw t0, -44(s0)
	addw t0, s0, t0
	fsw ft0, 0(t0)
	flw t0, -92(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	flw t0, -76(s0)
	addw t0, s0, t0
	flw ft1, 4(t0)
	fmul.s ft1, ft0, ft1
	flw t0, -92(s0)
	addw t0, s0, t0
	flw ft0, 4(t0)
	flw t0, -68(s0)
	addw t0, s0, t0
	flw ft2, 4(t0)
	fmul.s ft0, ft0, ft2
	fadd.s ft1, ft1, ft0
	flw t0, -92(s0)
	addw t0, s0, t0
	flw ft2, 8(t0)
	flw t0, -60(s0)
	addw t0, s0, t0
	flw ft0, 4(t0)
	fmul.s ft0, ft2, ft0
	fadd.s ft0, ft1, ft0
	flw t0, -44(s0)
	addw t0, s0, t0
	fsw ft0, 4(t0)
	flw t0, -92(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	flw t0, -76(s0)
	addw t0, s0, t0
	flw ft1, 8(t0)
	fmul.s ft0, ft0, ft1
	flw t0, -92(s0)
	addw t0, s0, t0
	flw ft1, 4(t0)
	flw t0, -68(s0)
	addw t0, s0, t0
	flw ft2, 8(t0)
	fmul.s ft1, ft1, ft2
	fadd.s ft1, ft0, ft1
	flw t0, -92(s0)
	addw t0, s0, t0
	flw ft2, 8(t0)
	flw t0, -60(s0)
	addw t0, s0, t0
	flw ft0, 8(t0)
	fmul.s ft0, ft2, ft0
	fadd.s ft0, ft1, ft0
	flw t0, -44(s0)
	addw t0, s0, t0
	fsw ft0, 8(t0)
	flw t0, -84(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	flw t0, -76(s0)
	addw t0, s0, t0
	flw ft1, 0(t0)
	fmul.s ft0, ft0, ft1
	flw t0, -84(s0)
	addw t0, s0, t0
	flw ft2, 4(t0)
	flw t0, -68(s0)
	addw t0, s0, t0
	flw ft1, 0(t0)
	fmul.s ft1, ft2, ft1
	fadd.s ft0, ft0, ft1
	flw t0, -84(s0)
	addw t0, s0, t0
	flw ft1, 8(t0)
	flw t0, -60(s0)
	addw t0, s0, t0
	flw ft2, 0(t0)
	fmul.s ft1, ft1, ft2
	fadd.s ft0, ft0, ft1
	flw t0, -36(s0)
	addw t0, s0, t0
	fsw ft0, 0(t0)
	flw t0, -84(s0)
	addw t0, s0, t0
	flw ft0, 0(t0)
	flw t0, -76(s0)
	addw t0, s0, t0
	flw ft1, 4(t0)
	fmul.s ft1, ft0, ft1
	flw t0, -84(s0)
	addw t0, s0, t0
	flw ft2, 4(t0)
	flw t0, -68(s0)
	addw t0, s0, t0
	flw ft0, 4(t0)
	fmul.s ft0, ft2, ft0
	fadd.s ft0, ft1, ft0
	flw t0, -84(s0)
	addw t0, s0, t0
	flw ft1, 8(t0)
	flw t0, -60(s0)
	addw t0, s0, t0
	flw ft2, 4(t0)
	fmul.s ft1, ft1, ft2
	fadd.s ft0, ft0, ft1
	flw t0, -36(s0)
	addw t0, s0, t0
	fsw ft0, 4(t0)
	flw t0, -84(s0)
	addw t0, s0, t0
	flw ft1, 0(t0)
	flw t0, -76(s0)
	addw t0, s0, t0
	flw ft0, 8(t0)
	fmul.s ft1, ft1, ft0
	flw t0, -84(s0)
	addw t0, s0, t0
	flw ft2, 4(t0)
	flw t0, -68(s0)
	addw t0, s0, t0
	flw ft0, 8(t0)
	fmul.s ft0, ft2, ft0
	fadd.s ft1, ft1, ft0
	flw t0, -84(s0)
	addw t0, s0, t0
	flw ft2, 8(t0)
	flw t0, -60(s0)
	addw t0, s0, t0
	flw ft0, 8(t0)
	fmul.s ft0, ft2, ft0
	fadd.s ft0, ft1, ft0
	flw t0, -36(s0)
	addw t0, s0, t0
	fsw ft0, 8(t0)
	mv a0, zero
	ld ra, 88(sp)
	ld s0, 80(sp)
	addi sp, sp, 96
	ret 
    .size mul, .-mul
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB2:
	addi sp, sp, -160
	sd ra, 152(sp)
	sd s0, 144(sp)
	addi s0, sp, 160
	li t1, 3
	lui t0, %hi(N)
	sw t1, %lo(N)(t0)
	li t0, 3
	lui t1, %hi(M)
	sw t0, %lo(M)(t1)
	li t0, 3
	lui t1, %hi(L)
	sw t0, %lo(L)(t1)
	li t0, 0
	sw t0, -28(s0)
	j .LBB3
.LBB3:
	lw t1, -28(s0)
	lui t0, %hi(M)
	lw t0, %lo(M)(t0)
	blt t1, t0, .LBB4
	j .LBB5
.LBB4:
	lw t1, -28(s0)
	lw t2, -28(s0)
	addiw t0, s0, -120
	li t0, 4
	mulw t0, t2, t0
	addw t0, t0, t0
	fcvt.s.w ft0, t1
	fsw ft0, 0(t0)
	lw t1, -28(s0)
	lw t0, -28(s0)
	addiw t0, s0, -108
	li t2, 4
	mulw t0, t0, t2
	addw t0, t0, t0
	fcvt.s.w ft0, t1
	fsw ft0, 0(t0)
	lw t1, -28(s0)
	lw t2, -28(s0)
	addiw t0, s0, -96
	li t0, 4
	mulw t0, t2, t0
	addw t0, t0, t0
	fcvt.s.w ft0, t1
	fsw ft0, 0(t0)
	lw t1, -28(s0)
	lw t0, -28(s0)
	addiw t0, s0, -84
	li t2, 4
	mulw t0, t0, t2
	addw t0, t0, t0
	fcvt.s.w ft0, t1
	fsw ft0, 0(t0)
	lw t2, -28(s0)
	lw t1, -28(s0)
	addiw t0, s0, -72
	li t0, 4
	mulw t0, t1, t0
	addw t0, t0, t0
	fcvt.s.w ft0, t2
	fsw ft0, 0(t0)
	lw t1, -28(s0)
	lw t0, -28(s0)
	addiw t0, s0, -60
	li t2, 4
	mulw t0, t0, t2
	addw t0, t0, t0
	fcvt.s.w ft0, t1
	fsw ft0, 0(t0)
	lw t0, -28(s0)
	addiw t0, t0, 1
	sw t0, -28(s0)
	j .LBB3
.LBB5:
	addiw t2, s0, -120
	addiw a2, s0, -108
	addiw a4, s0, -96
	addiw s1, s0, -84
	addiw t0, s0, -72
	addiw t1, s0, -60
	addiw a1, s0, -144
	addiw a3, s0, -48
	addiw a0, s0, -36
	addiw a0, a0, 0
	sd a0, 0(sp)
	addiw a0, t2, 0
	mv a0, a0
	addiw a1, a2, 0
	mv a1, a1
	addiw a2, a4, 0
	mv a2, a2
	addiw a3, s1, 0
	mv a3, a3
	addiw a4, t0, 0
	mv a4, a4
	addiw a5, t1, 0
	mv a5, a5
	addiw a6, a1, 0
	mv a6, a6
	addiw a7, a3, 0
	mv a7, a7
	call mul
	mv a0, a0
	sw a0, -28(s0)
	j .LBB6
.LBB6:
	lw t1, -28(s0)
	lui t0, %hi(N)
	lw t0, %lo(N)(t0)
	blt t1, t0, .LBB7
	j .LBB8
.LBB7:
	lw t1, -28(s0)
	addiw t0, s0, -144
	li t0, 4
	mulw t0, t1, t0
	addw t0, t0, t0
	flw ft0, 0(t0)
	fcvt.w.s t0, ft0
	sw t0, -24(s0)
	lw a0, -24(s0)
	mv a0, a0
	call putint
	lw t0, -28(s0)
	addiw t0, t0, 1
	sw t0, -28(s0)
	j .LBB6
.LBB8:
	li t0, 10
	sw t0, -24(s0)
	li t0, 0
	sw t0, -28(s0)
	lw a0, -24(s0)
	mv a0, a0
	call putch
	j .LBB9
.LBB9:
	lw t1, -28(s0)
	lui t0, %hi(N)
	lw t0, %lo(N)(t0)
	blt t1, t0, .LBB10
	j .LBB11
.LBB10:
	lw t0, -28(s0)
	addiw t0, s0, -48
	li t1, 4
	mulw t0, t0, t1
	addw t0, t0, t0
	flw ft0, 0(t0)
	fcvt.w.s t0, ft0
	sw t0, -24(s0)
	lw a0, -24(s0)
	mv a0, a0
	call putint
	lw t0, -28(s0)
	addiw t0, t0, 1
	sw t0, -28(s0)
	j .LBB9
.LBB11:
	li t0, 10
	sw t0, -24(s0)
	li t0, 0
	sw t0, -28(s0)
	lw a0, -24(s0)
	mv a0, a0
	call putch
	j .LBB12
.LBB12:
	lw t1, -28(s0)
	lui t0, %hi(N)
	lw t0, %lo(N)(t0)
	blt t1, t0, .LBB13
	j .LBB14
.LBB13:
	lw t1, -28(s0)
	addiw t0, s0, -36
	li t0, 4
	mulw t0, t1, t0
	addw t0, t0, t0
	flw ft0, 0(t0)
	fcvt.w.s t0, ft0
	sw t0, -24(s0)
	lw a0, -24(s0)
	mv a0, a0
	call putint
	lw t0, -28(s0)
	addiw t0, t0, 1
	sw t0, -28(s0)
	j .LBB12
.LBB14:
	li t0, 10
	sw t0, -24(s0)
	lw a0, -24(s0)
	mv a0, a0
	call putch
	mv a0, zero
	ld ra, 152(sp)
	ld s0, 144(sp)
	addi sp, sp, 160
	ret 
    .size main, .-main
