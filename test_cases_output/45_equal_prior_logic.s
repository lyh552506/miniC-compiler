	.file	"45_equal_prior_logic.c"
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
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	li	a5,10
	sw	a5,-20(s0)
	li	a5,6
	sw	a5,-24(s0)
	li	a5,4
	sw	a5,-28(s0)
	li	a5,5
	sw	a5,-32(s0)
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-28(s0)
	addw	a5,a4,a5
	sext.w	a4,a5
	lw	a5,-20(s0)
	sext.w	a5,a5
	bne	a5,a4,.L2
	lw	a5,-20(s0)
	srliw	a4,a5,31
	addw	a5,a4,a5
	sraiw	a5,a5,1
	sext.w	a4,a5
	lw	a5,-32(s0)
	sext.w	a5,a5
	beq	a5,a4,.L2
	lw	a5,-28(s0)
	mv	a4,a5
	lw	a5,-32(s0)
	divw	a5,a4,a5
	sext.w	a5,a5
	slliw	a5,a5,1
	sext.w	a5,a5
	lw	a4,-24(s0)
	addw	a5,a4,a5
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	mv	a0,a5
	call	putint
.L2:
	lw	a5,-28(s0)
	sext.w	a5,a5
	blt	a5,zero,.L3
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-28(s0)
	subw	a5,a4,a5
	sext.w	a4,a5
	lw	a5,-24(s0)
	sext.w	a5,a5
	bne	a5,a4,.L4
	lw	a5,-32(s0)
	slliw	a5,a5,1
	sext.w	a4,a5
	lw	a5,-20(s0)
	sext.w	a5,a5
	beq	a5,a4,.L4
.L3:
	li	a5,1
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	mv	a0,a5
	call	putint
.L4:
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
