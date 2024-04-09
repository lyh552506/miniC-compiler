	.file	"84_palindrome_number.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	palindrome
	.type	palindrome, @function
palindrome:
	addi	sp,sp,-64
	sd	s0,56(sp)
	addi	s0,sp,64
	mv	a5,a0
	sw	a5,-52(s0)
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a5,-52(s0)
	mv	a4,a5
	li	a5,10
	remw	a5,a4,a5
	sext.w	a4,a5
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	sw	a4,-24(a5)
	lw	a5,-52(s0)
	mv	a4,a5
	li	a5,10
	divw	a5,a4,a5
	sw	a5,-52(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L3
	lw	a4,-40(s0)
	lw	a5,-28(s0)
	bne	a4,a5,.L4
	lw	a4,-36(s0)
	lw	a5,-32(s0)
	bne	a4,a5,.L4
	li	a5,1
	sw	a5,-24(s0)
	j	.L5
.L4:
	sw	zero,-24(s0)
.L5:
	lw	a5,-24(s0)
	mv	a0,a5
	ld	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	palindrome, .-palindrome
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,1221
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	palindrome
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L8
	lw	a5,-20(s0)
	mv	a0,a5
	call	putint
	j	.L9
.L8:
	sw	zero,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
.L9:
	li	a5,10
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putch
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
