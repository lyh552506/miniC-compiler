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
	sd s1, -44(s0)
	mv a0, a0
	j .LBB1
.LBB1:
	sd a0, -36(s0)
	li t2, 0
	sw t2, -28(s0)
	j .LBB2
.LBB2:
	lw a0, -28(s0)
	lui t2, %hi(.G.n)
	lw s1, %lo(.G.n)(t2)
	li t2, 1
	subw t2, s1, t2
	blt a0, t2, .LBB3
	j .LBB4
.LBB3:
	li t2, 0
	sw t2, -24(s0)
	j .LBB5
.LBB4:
	mv a0, zero
	ld s1, -44(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
.LBB5:
	lw s1, -24(s0)
	lui t2, %hi(.G.n)
	lw t2, %lo(.G.n)(t2)
	lw a0, -28(s0)
	subw t2, t2, a0
	li a0, 1
	subw t2, t2, a0
	blt s1, t2, .LBB6
	j .LBB7
.LBB6:
	lw s1, -24(s0)
	ld t2, -36(s0)
	add t0, zero, t2
	li t2, 4
	mulw t2, s1, t2
	add t0, t0, t2
	lw s1, 0(t0)
	lw t2, -24(s0)
	addiw t2, t2, 1
	ld a0, -36(s0)
	add t0, zero, a0
	li a0, 4
	mulw t2, t2, a0
	add t0, t0, t2
	lw t2, 0(t0)
	blt t2, s1, .LBB8
	j .LBB9
.LBB7:
	lw t2, -28(s0)
	addiw t2, t2, 1
	sw t2, -28(s0)
	j .LBB2
.LBB8:
	lw t2, -24(s0)
	addiw t2, t2, 1
	ld s1, -36(s0)
	add t0, zero, s1
	li s1, 4
	mulw t2, t2, s1
	add t0, t0, t2
	lw t2, 0(t0)
	sw t2, -20(s0)
	lw s1, -24(s0)
	ld t2, -36(s0)
	add t0, zero, t2
	li t2, 4
	mulw t2, s1, t2
	add t0, t0, t2
	lw s1, 0(t0)
	lw t2, -24(s0)
	addiw a0, t2, 1
	ld t2, -36(s0)
	add t0, zero, t2
	li t2, 4
	mulw t2, a0, t2
	add t0, t0, t2
	sw s1, 0(t0)
	lw a0, -20(s0)
	lw s1, -24(s0)
	ld t2, -36(s0)
	add t0, zero, t2
	li t2, 4
	mulw t2, s1, t2
	add t0, t0, t2
	sw a0, 0(t0)
	j .LBB9
.LBB9:
	lw t2, -24(s0)
	addiw t2, t2, 1
	sw t2, -24(s0)
	j .LBB5
    .size bubblesort, .-bubblesort
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB10:
	addi sp, sp, -80
	sd ra, 72(sp)
	sd s0, 64(sp)
	addi s0, sp, 80
	sd s1, -32(s0)
	li t2, 10
	lui s1, %hi(.G.n)
	sw t2, %lo(.G.n)(s1)
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
	j .LBB11
.LBB11:
	lw s1, -24(s0)
	lui t2, %hi(.G.n)
	lw t2, %lo(.G.n)(t2)
	blt s1, t2, .LBB12
	j .LBB13
.LBB12:
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
	j .LBB11
.LBB13:
	mv a0, zero
	ld s1, -32(s0)
	ld ra, 72(sp)
	ld s0, 64(sp)
	addi sp, sp, 80
	ret 
    .size main, .-main
