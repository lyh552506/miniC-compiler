	.file	"77_unique_path.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	uniquePaths
	.type	uniquePaths, @function
uniquePaths:
	addi	sp,sp,-80
	sd	s0,72(sp)
	addi	s0,sp,80
	mv	a5,a0
	mv	a4,a1
	sw	a5,-68(s0)
	mv	a5,a4
	sw	a5,-72(s0)
	lw	a5,-68(s0)
	sext.w	a4,a5
	li	a5,1
	beq	a4,a5,.L2
	lw	a5,-72(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L3
.L2:
	li	a5,1
	j	.L13
.L3:
	sw	zero,-20(s0)
	j	.L5
.L6:
	lw	a5,-20(s0)
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,1
	addw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,-72(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	li	a4,1
	sw	a4,-48(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L5:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-68(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L6
	sw	zero,-20(s0)
	j	.L7
.L8:
	lw	a5,-68(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,1
	addw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	li	a4,1
	sw	a4,-48(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L7:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-72(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L8
	lw	a5,-68(s0)
	addiw	a5,a5,-2
	sw	a5,-20(s0)
	j	.L9
.L12:
	lw	a5,-72(s0)
	addiw	a5,a5,-2
	sw	a5,-24(s0)
	j	.L10
.L11:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,1
	addw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,-24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a3,-48(a5)
	lw	a5,-20(s0)
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,1
	addw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,-24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	addiw	a5,a5,1
	sext.w	a5,a5
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-48(a5)
	lw	a5,-20(s0)
	mv	a2,a5
	mv	a5,a2
	slliw	a5,a5,1
	addw	a5,a5,a2
	sext.w	a5,a5
	lw	a2,-24(s0)
	addw	a5,a2,a5
	sext.w	a5,a5
	addw	a4,a3,a4
	sext.w	a4,a4
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	sw	a4,-48(a5)
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
.L10:
	lw	a5,-24(s0)
	sext.w	a5,a5
	bge	a5,zero,.L11
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
.L9:
	lw	a5,-20(s0)
	sext.w	a5,a5
	bge	a5,zero,.L12
	lw	a5,-64(s0)
.L13:
	mv	a0,a5
	ld	s0,72(sp)
	addi	sp,sp,80
	jr	ra
	.size	uniquePaths, .-uniquePaths
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,3
	sw	a5,-20(s0)
	lw	a4,-20(s0)
	lw	a5,-20(s0)
	mv	a1,a4
	mv	a0,a5
	call	uniquePaths
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
