	.file	"91_line_search.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	addi	s0,sp,96
	sw	zero,-32(s0)
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a4,a5
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	sw	a4,-80(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,9
	ble	a4,a5,.L3
	li	a5,10
	sw	a5,-36(s0)
	call	getint
	mv	a5,a0
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	addiw	a5,a5,-1
	sw	a5,-44(s0)
	sw	zero,-48(s0)
	lw	a5,-44(s0)
	mv	a4,a5
	lw	a5,-48(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	srliw	a4,a5,31
	addw	a5,a4,a5
	sraiw	a5,a5,1
	sw	a5,-52(s0)
	sw	zero,-24(s0)
	sw	zero,-20(s0)
	sw	zero,-28(s0)
	j	.L4
.L7:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-80(a5)
	lw	a5,-40(s0)
	sext.w	a5,a5
	bne	a5,a4,.L5
	li	a5,1
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	sw	a5,-28(s0)
.L5:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L4:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,9
	bgt	a4,a5,.L6
	lw	a5,-24(s0)
	sext.w	a5,a5
	beq	a5,zero,.L7
.L6:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L8
	lw	a5,-28(s0)
	mv	a0,a5
	call	putint
	j	.L9
.L8:
	sw	zero,-40(s0)
	lw	a5,-40(s0)
	mv	a0,a5
	call	putint
.L9:
	li	a5,10
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	mv	a0,a5
	call	putch
	li	a5,0
	mv	a0,a5
	ld	ra,88(sp)
	ld	s0,80(sp)
	addi	sp,sp,96
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
