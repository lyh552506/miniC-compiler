    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.n
    .bss
    .align  2
    .type  .G.n, @object
    .size  .G.n, 4
.G.n:
    .zero  4
    .text
    .align  1
    .globl  bubblesort
    .type  bubblesort, @function
bubblesort:
.LBB0:
	addi sp, sp, -48
	sd ra, 40(sp)
	sd s0, 32(sp)
	addi s0, sp, 48
	sd s1, -40(s0)
	mv a0, a0
	j .LBB1
.LBB1:
	sd a0, -32(s0)
	li t2, 0
	sw t2, -24(s0)
	j .LBB2
.LBB2:
	lw s1, -24(s0)
	lui t2, %hi(.G.n)
	lw a0, %lo(.G.n)(t2)
	li t2, 1
	subw t2, a0, t2
	blt s1, t2, .LBB3
	j .LBB4
.LBB3:
	mv a0, zero
	ld s1, -40(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
.LBB4:
	mv a0, zero
	ld s1, -40(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
    .size bubblesort, .-bubblesort
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB5:
	addi sp, sp, -80
	sd ra, 72(sp)
	sd s0, 64(sp)
	addi s0, sp, 80
	sd s1, -32(s0)
	li s1, 10
	lui t2, %hi(.G.n)
	sw s1, %lo(.G.n)(t2)
	addi t0, s0, -72
	li t2, 4
	sw t2, 0(t0)
	addi t0, s0, -72
	li t2, 3
	sw t2, 4(t0)
	addi t0, s0, -72
	li t2, 9
	sw t2, 8(t0)
	addi t0, s0, -72
	li t2, 2
	sw t2, 12(t0)
	addi t0, s0, -72
	li t2, 0
	sw t2, 16(t0)
	addi t0, s0, -72
	li t2, 1
	sw t2, 20(t0)
	addi t0, s0, -72
	li t2, 6
	sw t2, 24(t0)
	addi t0, s0, -72
	li t2, 5
	sw t2, 28(t0)
	addi t0, s0, -72
	li t2, 7
	sw t2, 32(t0)
	addi t0, s0, -72
	li t2, 8
	sw t2, 36(t0)
	addi t0, s0, -72
	addi t0, t0, 0
	mv a0, t0
	call bubblesort
	mv a0, a0
	sw a0, -24(s0)
	j .LBB6
.LBB6:
	lw s1, -24(s0)
	lui t2, %hi(.G.n)
	lw t2, %lo(.G.n)(t2)
	blt s1, t2, .LBB7
	j .LBB8
.LBB7:
	lw s1, -24(s0)
	addi t0, s0, -72
	li t2, 4
	mulw t2, s1, t2
	add t0, t0, t2
	lw t2, 0(t0)
	sw t2, -20(s0)
	lw a0, -20(s0)
	mv a0, a0
	call putint
	li t2, 10
	sw t2, -20(s0)
	lw a0, -20(s0)
	mv a0, a0
	call putch
	lw t2, -24(s0)
	addiw t2, t2, 1
	sw t2, -24(s0)
	j .LBB6
.LBB8:
	mv a0, zero
	ld s1, -32(s0)
	ld ra, 72(sp)
	ld s0, 64(sp)
	addi sp, sp, 80
	ret 
    .size main, .-main
