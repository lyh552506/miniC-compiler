	.file	"66_go_upstairs.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	climbStairs
	.type	climbStairs, @function
climbStairs:
	addi	sp,sp,-80
	sd	s0,72(sp)
	addi	s0,sp,80
	mv	a5,a0
	sw	a5,-68(s0)
	lw	a5,-68(s0)
	sext.w	a4,a5
	li	a5,3
	bgt	a4,a5,.L2
	lw	a5,-68(s0)
	j	.L6
.L2:
	sw	zero,-64(s0)
	li	a5,1
	sw	a5,-60(s0)
	li	a5,2
	sw	a5,-56(s0)
	li	a5,3
	sw	a5,-20(s0)
	j	.L4
.L5:
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-48(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,-2
	sext.w	a5,a5
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-48(a5)
	addw	a5,a4,a5
	sext.w	a4,a5
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	sw	a4,-48(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L4:
	lw	a5,-68(s0)
	mv	a4,a5
	lw	a5,-20(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L5
	lw	a5,-68(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-48(a5)
.L6:
	mv	a0,a5
	ld	s0,72(sp)
	addi	sp,sp,80
	jr	ra
	.size	climbStairs, .-climbStairs
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,5
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	climbStairs
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
