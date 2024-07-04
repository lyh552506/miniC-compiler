    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.N
    .bss
    .align  2
    .type  .G.N, @object
    .size  .G.N, 4
.G.N:
    .zero  4
    .globl  .G.arr
    .data
    .align  3
    .type  .G.arr, @object
    .size  .G.arr, 24
.G.arr:
    .word  1
    .word  2
    .word  33
    .word  4
    .word  5
    .word  6
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
	sd s1, -32(s0)
	li t2, 0
	sw t2, -24(s0)
	li t2, 0
	sw t2, -20(s0)
	j .LBB1
.LBB1:
	lw t2, -24(s0)
	li t0, 6
	blt t2, t0, .LBB2
	j .LBB3
.LBB2:
	lw s1, -20(s0)
	lw a0, -24(s0)
	lui t2, %hi(.G.arr)
	addi t2, t2, %lo(.G.arr)
	add t2, zero, t2
	li a1, 4
	mulw a0, a0, a1
	add t2, t2, a0
	lw t2, 0(t2)
	addw t2, s1, t2
	sw t2, -20(s0)
	lw t2, -24(s0)
	addiw t2, t2, 1
	sw t2, -24(s0)
	j .LBB1
.LBB3:
	lw a0, -20(s0)
	ld s1, -32(s0)
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
    .size main, .-main
