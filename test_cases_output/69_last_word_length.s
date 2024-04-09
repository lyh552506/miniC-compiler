	.file	"69_last_word_length.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	lengthOfLastWord
	.type	lengthOfLastWord, @function
lengthOfLastWord:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	lw	a5,-44(s0)
	sext.w	a5,a5
	bne	a5,zero,.L2
	li	a5,0
	j	.L3
.L2:
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
	j	.L4
.L6:
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
.L4:
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,zero,.L5
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	beq	a5,zero,.L6
.L5:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,-1
	bne	a4,a5,.L7
	li	a5,0
	j	.L3
.L7:
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	j	.L8
.L10:
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	bne	a5,zero,.L9
	lw	a5,-44(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a4,a5
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	lw	a3,-20(s0)
	subw	a5,a5,a3
	sext.w	a5,a5
	subw	a5,a4,a5
	sext.w	a5,a5
	j	.L3
.L9:
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
.L8:
	lw	a5,-24(s0)
	sext.w	a5,a5
	bge	a5,zero,.L10
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
.L3:
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	lengthOfLastWord, .-lengthOfLastWord
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	li	a5,-4
	sw	a5,-64(s0)
	li	a5,3
	sw	a5,-60(s0)
	li	a5,9
	sw	a5,-56(s0)
	li	a5,-2
	sw	a5,-52(s0)
	sw	zero,-48(s0)
	li	a5,1
	sw	a5,-44(s0)
	li	a5,-6
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
	call	lengthOfLastWord
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
