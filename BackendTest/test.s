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
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	sd s1, -24(s0)
	mv a0, a0
	j .LBB1
.LBB1:
	mv t2, zero
	j .LBB2
.LBB2:
	lui s1, %hi(.G.n)
	lw a0, %lo(.G.n)(s1)
	li s1, 1
	subw s1, a0, s1
	blt t2, s1, .LBB3
	j .LBB4
.LBB3:
	lui s1, %hi(.G.n)
	lw s1, %lo(.G.n)(s1)
	subw s1, s1, t2
	li a0, 1
	subw s1, s1, a0
	blt zero, s1, .LBB4
	j .LBB5
.LBB4:
	mv a0, zero
	ld s1, -24(s0)
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
.LBB5:
	addiw t2, t2, 1
	mv t2, t2
	j .LBB2
    .size bubblesort, .-bubblesort
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB6:
	addi sp, sp, -64
	sd ra, 56(sp)
	sd s0, 48(sp)
	addi s0, sp, 64
	sd s1, -24(s0)
	li s1, 10
	lui t2, %hi(.G.n)
	sw s1, %lo(.G.n)(t2)
	addi t0, s0, -64
	li t2, 4
	sw t2, 0(t0)
	addi t0, s0, -64
	li t2, 3
	sw t2, 4(t0)
	addi t0, s0, -64
	li t2, 9
	sw t2, 8(t0)
	addi t0, s0, -64
	li t2, 2
	sw t2, 12(t0)
	addi t0, s0, -64
	li t2, 0
	sw t2, 16(t0)
	addi t0, s0, -64
	li t2, 1
	sw t2, 20(t0)
	addi t0, s0, -64
	li t2, 6
	sw t2, 24(t0)
	addi t0, s0, -64
	li t2, 5
	sw t2, 28(t0)
	addi t0, s0, -64
	li t2, 7
	sw t2, 32(t0)
	addi t0, s0, -64
	li t2, 8
	sw t2, 36(t0)
	addi t0, s0, -64
	addi t0, t0, 0
	mv a0, t0
	call bubblesort
	mv a0, a0
	mv t2, a0
	j .LBB7
.LBB7:
	lui s1, %hi(.G.n)
	lw s1, %lo(.G.n)(s1)
	blt t2, s1, .LBB8
	j .LBB9
.LBB8:
	addi t0, s0, -64
	li s1, 4
	mulw s1, t2, s1
	add t0, t0, s1
	lw a0, 0(t0)
	mv a0, a0
	call putint
	li a0, 10
	call putch
	addiw t2, t2, 1
	mv t2, t2
	j .LBB7
.LBB9:
	mv a0, zero
	ld s1, -24(s0)
	ld ra, 56(sp)
	ld s0, 48(sp)
	addi sp, sp, 64
	ret 
    .size main, .-main
