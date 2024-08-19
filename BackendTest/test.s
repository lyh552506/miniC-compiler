    .file  "/home/nanqin/compiler/miniC-compiler/BackendTest/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0_zba1p0_zbb1p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.a
    .data
    .align  2
    .type  .G.a, @object
    .size  .G.a, 4
.G.a:
    .word  1
    .globl  .G.b
    .align  2
    .type  .G.b, @object
    .size  .G.b, 4
.G.b:
    .zero  4
    .globl  .G.c
    .align  2
    .type  .G.c, @object
    .size  .G.c, 4
.G.c:
    .word  1
    .globl  .G.d
    .align  2
    .type  .G.d, @object
    .size  .G.d, 4
.G.d:
    .word  2
    .globl  .G.e
    .align  2
    .type  .G.e, @object
    .size  .G.e, 4
.G.e:
    .word  4
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	lui a2, %hi(.G.a)
	addi a2, a2, %lo(.G.a)
	lui a0, %hi(.G.b)
	addi a0, a0, %lo(.G.b)
	lui a3, %hi(.G.c)
	addi a3, a3, %lo(.G.c)
	lui t4, %hi(.G.e)
	addi t4, t4, %lo(.G.e)
	sw zero, -20(s0)
	lui a1, %hi(.G.d)
	addi a1, a1, %lo(.G.d)
	lw t2, 0(a2)
	lw a4, 0(a0)
	lw a7, 0(a3)
	lw a5, 0(t4)
	mulw t2, t2, a4
	lw a6, 0(a1)
	li a4, 1
	divw t2, t2, a7
	addw a5, a5, a6
	beq t2, a5, .LBB1
	j .LBB2
.LBB1:
	lw a7, 0(a2)
	lw a6, 0(a2)
	lw t2, 0(a0)
	lw a5, 0(a3)
	addw t3, a6, t2
	lw a6, 0(a1)
	lw t2, 0(t4)
	mulw a7, a7, t3
	addw a5, a7, a5
	addw t2, a6, t2
	ble a5, t2, .LBB3
	j .LBB2
.LBB2:
	lw a5, 0(a2)
	lw a6, 0(a0)
	lw t2, 0(a3)
	lw a0, 0(a1)
	lw a1, 0(a2)
	lw a2, 0(a3)
	divw a1, a1, a2
	mulw t2, a6, t2
	subw t2, a5, t2
	subw a0, a0, a1
	beq t2, a0, .LBB3
	j .LBB4
.LBB4:
	lw a0, -20(s0)
	call putint
	lw a0, -20(s0)
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
.LBB3:
	sw a4, -20(s0)
	j .LBB4
    .size main, .-main
