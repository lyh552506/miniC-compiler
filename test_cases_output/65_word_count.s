	.file	"65_word_count.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	wc
	.type	wc, @function
wc:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	sw	zero,-24(s0)
	sw	zero,-20(s0)
	sw	zero,-28(s0)
	j	.L2
.L5:
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,32
	beq	a4,a5,.L3
	lw	a5,-20(s0)
	sext.w	a5,a5
	bne	a5,zero,.L4
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
	li	a5,1
	sw	a5,-20(s0)
	j	.L4
.L3:
	sw	zero,-20(s0)
.L4:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L2:
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-44(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L5
	lw	a5,-28(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	wc, .-wc
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-2032
	sd	ra,2024(sp)
	sd	s0,2016(sp)
	addi	s0,sp,2032
	sw	zero,-24(s0)
	sw	zero,-20(s0)
	j	.L8
.L9:
	call	getch
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-20(s0)
	sw	a4,-2008(a5)
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L8:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,10
	bne	a4,a5,.L9
	lw	a4,-24(s0)
	addi	a5,s0,-2024
	mv	a1,a4
	mv	a0,a5
	call	wc
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
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
