    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .align  1
    .globl  func
    .type  func, @function
func:
.LBB0:
	addi sp, sp, -256
	sd ra, 248(sp)
	sd s0, 240(sp)
	addi s0, sp, 256
	sd s11, -128(s0)
	sd s10, -136(s0)
	sd s9, -144(s0)
	sd s8, -152(s0)
	sd s7, -160(s0)
	sd s6, -168(s0)
	sd s5, -176(s0)
	sd s4, -184(s0)
	sd s3, -192(s0)
	sd s2, -200(s0)
	sd s1, -208(s0)
	lw s4, 0(s0)
	lw t2, 4(s0)
	sd t2, -232(s0)
	lw t2, 8(s0)
	sd t2, -224(s0)
	lw t2, 12(s0)
	sd t2, -248(s0)
	lw t5, 16(s0)
	lw s5, 20(s0)
	lw s6, 24(s0)
	lw s2, 28(s0)
	lw t2, 32(s0)
	sd t2, -216(s0)
	lw t2, 36(s0)
	sd t2, -240(s0)
	lw s7, 40(s0)
	lw s8, 44(s0)
	lw s9, 48(s0)
	lw s10, 52(s0)
	lw t4, 56(s0)
	lw s11, 60(s0)
	lw s1, 64(s0)
	lw t3, 68(s0)
	mv s3, a0
	mv t2, a1
	mv a0, a2
	mv t6, a4
	mv a4, a5
	mv a2, a6
	mv a1, a7
	j .LBB1
.LBB1:
	sw s3, -24(s0)
	sw t2, -28(s0)
	sw a0, -32(s0)
	sw a3, -36(s0)
	sw t6, -40(s0)
	sw a4, -44(s0)
	sw a2, -48(s0)
	sw a1, -52(s0)
	sw t3, -56(s0)
	sw s1, -60(s0)
	sw s11, -64(s0)
	sw t4, -68(s0)
	sw s10, -76(s0)
	sw s9, -72(s0)
	sw s8, -120(s0)
	sw s7, -116(s0)
	ld t2, -240(s0)
	sw t2, -112(s0)
	ld t2, -216(s0)
	sw t2, -108(s0)
	sw s2, -104(s0)
	sw s6, -100(s0)
	sw s5, -96(s0)
	sw t5, -92(s0)
	ld t2, -248(s0)
	sw t2, -88(s0)
	ld t2, -224(s0)
	sw t2, -84(s0)
	ld t2, -232(s0)
	sw t2, -20(s0)
	sw s4, -80(s0)
	lw t2, -24(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -28(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -32(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -36(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -40(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -44(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -48(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -52(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -56(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -60(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -64(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -68(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -76(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -72(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -120(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -116(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -112(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -108(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -104(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -100(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -96(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -92(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -88(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -84(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -20(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -80(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -24(s0)
	lw s1, -28(s0)
	addw t2, t2, s1
	lw s1, -32(s0)
	addw s1, t2, s1
	lw t2, -36(s0)
	addw s1, s1, t2
	lw t2, -40(s0)
	addw t2, s1, t2
	lw s1, -44(s0)
	addw s1, t2, s1
	lw t2, -48(s0)
	addw s1, s1, t2
	lw t2, -52(s0)
	addw t2, s1, t2
	lw s1, -56(s0)
	addw t2, t2, s1
	lw s1, -60(s0)
	addw t2, t2, s1
	lw s1, -64(s0)
	addw t2, t2, s1
	lw s1, -68(s0)
	addw t2, t2, s1
	lw s1, -76(s0)
	addw t2, t2, s1
	lw s1, -72(s0)
	addw t2, t2, s1
	lw s1, -120(s0)
	addw t2, t2, s1
	lw s1, -116(s0)
	addw s1, t2, s1
	lw t2, -112(s0)
	addw t2, s1, t2
	lw s1, -108(s0)
	addw s1, t2, s1
	lw t2, -104(s0)
	addw t2, s1, t2
	lw s1, -100(s0)
	addw t2, t2, s1
	lw s1, -96(s0)
	addw t2, t2, s1
	lw s1, -92(s0)
	addw s1, t2, s1
	lw t2, -88(s0)
	addw t2, s1, t2
	lw s1, -84(s0)
	addw s1, t2, s1
	lw t2, -20(s0)
	addw t2, s1, t2
	lw s1, -80(s0)
	addw t2, t2, s1
	mv a0, t2
	ld s1, -208(s0)
	ld s2, -200(s0)
	ld s3, -192(s0)
	ld s4, -184(s0)
	ld s5, -176(s0)
	ld s6, -168(s0)
	ld s7, -160(s0)
	ld s8, -152(s0)
	ld s9, -144(s0)
	ld s10, -136(s0)
	ld s11, -128(s0)
	ld ra, 248(sp)
	ld s0, 240(sp)
	addi sp, sp, 256
	ret 
    .size func, .-func
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB2:
	addi sp, sp, -112
	sd ra, 104(sp)
	sd s0, 96(sp)
	addi s0, sp, 112
	sd sp, -28(s0)
	li t0, 26
	sw t0, 0(sp)
	li t0, 25
	sw t0, 4(sp)
	li t0, 24
	sw t0, 8(sp)
	li t0, 23
	sw t0, 12(sp)
	li t0, 22
	sw t0, 16(sp)
	li t0, 21
	sw t0, 20(sp)
	li t0, 20
	sw t0, 24(sp)
	li t0, 19
	sw t0, 28(sp)
	li t0, 18
	sw t0, 32(sp)
	li t0, 17
	sw t0, 36(sp)
	li t0, 16
	sw t0, 40(sp)
	li t0, 15
	sw t0, 44(sp)
	li t0, 14
	sw t0, 48(sp)
	li t0, 13
	sw t0, 52(sp)
	li t0, 12
	sw t0, 56(sp)
	li t0, 11
	sw t0, 60(sp)
	li t0, 10
	sw t0, 64(sp)
	li t0, 9
	sw t0, 68(sp)
	li a0, 1
	li a1, 2
	li a2, 3
	li a3, 4
	li a4, 5
	li a5, 6
	li a6, 7
	li a7, 8
	call func
	sw a0, -20(s0)
	lw a0, -20(s0)
	call putint
	mv a0, zero
	ld sp, -28(s0)
	ld ra, 104(sp)
	ld s0, 96(sp)
	addi sp, sp, 112
	ret 
    .size main, .-main
