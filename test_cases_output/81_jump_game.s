	.file	"81_jump_game.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	canJump
	.type	canJump, @function
canJump:
	addi	sp,sp,-80
	sd	s0,72(sp)
	addi	s0,sp,80
	sd	a0,-72(s0)
	mv	a5,a1
	sw	a5,-76(s0)
	lw	a5,-76(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L2
	li	a5,1
	j	.L14
.L2:
	lw	a5,-76(s0)
	addiw	a5,a5,-1
	sext.w	a4,a5
	ld	a5,-72(s0)
	lw	a5,0(a5)
	bgt	a4,a5,.L4
	li	a5,1
	j	.L14
.L4:
	sw	zero,-20(s0)
	j	.L5
.L6:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	sw	zero,-48(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L5:
	lw	a5,-76(s0)
	addiw	a5,a5,-1
	sext.w	a4,a5
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L6
	lw	a5,-76(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	li	a4,1
	sw	a4,-48(a5)
	lw	a5,-76(s0)
	addiw	a5,a5,-2
	sw	a5,-20(s0)
	j	.L7
.L13:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-72(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-76(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	lw	a3,-20(s0)
	subw	a5,a5,a3
	sext.w	a5,a5
	bge	a4,a5,.L8
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-72(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-24(s0)
	j	.L10
.L8:
	lw	a5,-76(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	lw	a4,-20(s0)
	subw	a5,a5,a4
	sw	a5,-24(s0)
	j	.L10
.L12:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-48(a5)
	beq	a5,zero,.L11
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	li	a4,1
	sw	a4,-48(a5)
.L11:
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
.L10:
	lw	a5,-24(s0)
	sext.w	a5,a5
	bge	a5,zero,.L12
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
.L7:
	lw	a5,-20(s0)
	sext.w	a5,a5
	bge	a5,zero,.L13
	lw	a5,-64(s0)
.L14:
	mv	a0,a5
	ld	s0,72(sp)
	addi	sp,sp,80
	jr	ra
	.size	canJump, .-canJump
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	li	a5,3
	sw	a5,-64(s0)
	li	a5,3
	sw	a5,-60(s0)
	li	a5,9
	sw	a5,-56(s0)
	sw	zero,-52(s0)
	sw	zero,-48(s0)
	li	a5,1
	sw	a5,-44(s0)
	li	a5,1
	sw	a5,-40(s0)
	li	a5,5
	sw	a5,-36(s0)
	li	a5,7
	sw	a5,-32(s0)
	li	a5,8
	sw	a5,-28(s0)
	li	a5,10
	sw	a5,-20(s0)
	lw	a4,-20(s0)
	addi	a5,s0,-64
	mv	a1,a4
	mv	a0,a5
	call	canJump
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
