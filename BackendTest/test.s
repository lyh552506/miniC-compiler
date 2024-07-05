    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.loopCount
    .data
    .align  2
    .type  .G.loopCount, @object
    .size  .G.loopCount, 4
.G.loopCount:
    .zero  4
    .text
    .align  1
    .globl  func
    .type  func, @function
func:
.LBB0:
	addi sp, sp, -80
	sd ra, 72(sp)
	sd s0, 64(sp)
	addi s0, sp, 80
	sd s8, -80(s0)
	sd s7, -72(s0)
	sd s6, -64(s0)
	sd s5, -56(s0)
	sd s4, -48(s0)
	sd s3, -40(s0)
	sd s2, -32(s0)
	sd s1, -24(s0)
	lw t2, 0(s0)
	lw s6, 4(s0)
	lw s5, 8(s0)
	lw s4, 12(s0)
	lw s3, 16(s0)
	lw s2, 20(s0)
	lw s1, 24(s0)
	j .LBB1
.LBB1:
	mv s7, zero
	mv t2, zero
	j .LBB2
.LBB2:
	lui s8, %hi(.G.loopCount)
	lw s8, %lo(.G.loopCount)(s8)
	blt s7, s8, .LBB3
	j .LBB5
.LBB3:
	addw a0, a0, t2
	addw a0, a1, a0
	addw a0, a2, a0
	addw a0, a3, a0
	addw a0, a4, a0
	addw a0, a5, a0
	addw a0, a6, a0
	addw a0, a7, a0
	addw s1, s1, a0
	addw s1, s2, s1
	addw s1, s3, s1
	addw s1, s4, s1
	addw s1, s5, s1
	addw s1, s6, s1
	li a0, 100
	mulw s1, s1, a0
	li a0, 100
	divw s1, s1, a0
	addw s1, s1, t2
	li t1, 1500000256
	addi t1, t1, -255
	mv t2, t1
	remw t2, s1, t2
	addiw s7, s7, 1
	j .LBB2
.LBB4:
	mv a0, t2
	ld s1, -24(s0)
	ld s2, -32(s0)
	ld s3, -40(s0)
	ld s4, -48(s0)
	ld s5, -56(s0)
	ld s6, -64(s0)
	ld s7, -72(s0)
	ld s8, -80(s0)
	ld ra, 72(sp)
	ld s0, 64(sp)
	addi sp, sp, 80
	ret 
.LBB5:
	j .LBB4
    .size func, .-func
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB6:
	addi sp, sp, -64
	sd ra, 56(sp)
	sd s0, 48(sp)
	addi s0, sp, 64
	sd s1, -32(s0)
	sd sp, -24(s0)
	call getint
	mv t2, a0
	lui s1, %hi(.G.loopCount)
	sw t2, %lo(.G.loopCount)(s1)
	li a0, 121
	call _sysy_starttime
	li t0, 1
	sw t0, 0(sp)
	li t0, 1
	sw t0, 4(sp)
	li t0, 1
	sw t0, 8(sp)
	li t0, 1
	sw t0, 12(sp)
	li t0, 1
	sw t0, 16(sp)
	li t0, 1
	sw t0, 20(sp)
	li t0, 1
	sw t0, 24(sp)
	li a0, 1
	li a1, 1
	li a2, 1
	li a3, 1
	li a4, 1
	li a5, 1
	li a6, 1
	li a7, 1
	call func
	mv s1, a0
	li a0, 123
	call _sysy_stoptime
	mv a0, s1
	call putint
	li a0, 10
	call putch
	mv a0, zero
	ld sp, -24(s0)
	ld s1, -32(s0)
	ld ra, 56(sp)
	ld s0, 48(sp)
	addi sp, sp, 64
	ret 
    .size main, .-main
