	.file	"test.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	li	a5,5
	sw	a5,-20(s0)
	li	a5,5
	sw	a5,-24(s0)
	li	a5,1
	sw	a5,-28(s0)
	li	a5,-2
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	srliw	a4,a5,31
	addw	a5,a4,a5
	sraiw	a5,a5,1
	sw	a5,-36(s0)
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	subw	a5,a4,a5
	sw	a5,-36(s0)
	li	a5,-3
	lw	a4,-28(s0)
	subw	a5,a5,a4
	sw	a5,-36(s0)
	lw	a5,-32(s0)
	srliw	a4,a5,31
	addw	a5,a4,a5
	sraiw	a5,a5,1
	sext.w	a4,a5
	lw	a5,-20(s0)
	mv	a3,a5
	lw	a5,-24(s0)
	subw	a5,a3,a5
	sext.w	a5,a5
	addw	a5,a4,a5
	sext.w	a3,a5
	li	a5,-3
	lw	a4,-28(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	mv	a4,a5
	sraiw	a5,a4,31
	srliw	a5,a5,31
	addw	a4,a4,a5
	andi	a4,a4,1
	subw	a5,a4,a5
	sext.w	a5,a5
	subw	a5,a3,a5
	sw	a5,-40(s0)
	lw	a5,-32(s0)
	mv	a4,a5
	sraiw	a5,a4,31
	srliw	a5,a5,31
	addw	a4,a4,a5
	andi	a4,a4,1
	subw	a5,a4,a5
	sext.w	a5,a5
	addiw	a5,a5,67
	sext.w	a4,a5
	lw	a5,-24(s0)
	mv	a3,a5
	lw	a5,-20(s0)
	subw	a5,a3,a5
	sext.w	a5,a5
	addw	a5,a4,a5
	sext.w	a3,a5
	lw	a5,-28(s0)
	addiw	a5,a5,2
	sext.w	a5,a5
	mv	a4,a5
	sraiw	a5,a4,31
	srliw	a5,a5,31
	addw	a4,a4,a5
	andi	a4,a4,1
	subw	a5,a4,a5
	sext.w	a5,a5
	addw	a5,a3,a5
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	addiw	a5,a5,3
	sw	a5,-40(s0)
	li	a5,0
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
