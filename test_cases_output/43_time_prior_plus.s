	.file	"43_time_prior_plus.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,20
	sw	a5,-20(s0)
	li	a5,5
	sw	a5,-24(s0)
	li	a5,6
	sw	a5,-28(s0)
	li	a5,-4
	sw	a5,-32(s0)
	lw	a5,-28(s0)
	mv	a4,a5
	lw	a5,-32(s0)
	mulw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sext.w	a4,a5
	lw	a5,-20(s0)
	mv	a3,a5
	lw	a5,-32(s0)
	addw	a5,a3,a5
	sext.w	a5,a5
	lw	a3,-24(s0)
	remw	a5,a3,a5
	sext.w	a5,a5
	lw	a3,-20(s0)
	divw	a5,a5,a3
	sext.w	a5,a5
	subw	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	putint
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
