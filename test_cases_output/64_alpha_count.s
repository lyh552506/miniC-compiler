	.file	"64_alpha_count.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-2032
	sd	ra,2024(sp)
	sd	s0,2016(sp)
	addi	s0,sp,2032
	sw	zero,-28(s0)
	sw	zero,-24(s0)
	sw	zero,-20(s0)
	j	.L2
.L6:
	call	getch
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,40
	ble	a4,a5,.L3
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,90
	ble	a4,a5,.L4
.L3:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,96
	ble	a4,a5,.L5
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,122
	bgt	a4,a5,.L5
.L4:
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
.L5:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,10
	bne	a4,a5,.L6
	lw	a5,-28(s0)
	mv	a0,a5
	call	putint
	li	a5,0
	mv	a0,a5
	ld	ra,2024(sp)
	ld	s0,2016(sp)
	addi	sp,sp,2032
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
