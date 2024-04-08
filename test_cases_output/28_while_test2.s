	.file	"28_while_test2.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	FourWhile
	.type	FourWhile, @function
FourWhile:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	li	a5,5
	sw	a5,-20(s0)
	li	a5,6
	sw	a5,-24(s0)
	li	a5,7
	sw	a5,-28(s0)
	li	a5,10
	sw	a5,-32(s0)
	j	.L2
.L9:
	lw	a5,-20(s0)
	addiw	a5,a5,3
	sw	a5,-20(s0)
	j	.L3
.L8:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
	j	.L4
.L7:
	lw	a5,-28(s0)
	addiw	a5,a5,-1
	sw	a5,-28(s0)
	j	.L5
.L6:
	lw	a5,-32(s0)
	addiw	a5,a5,3
	sw	a5,-32(s0)
.L5:
	lw	a5,-32(s0)
	sext.w	a4,a5
	li	a5,19
	ble	a4,a5,.L6
	lw	a5,-32(s0)
	addiw	a5,a5,-1
	sw	a5,-32(s0)
.L4:
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,7
	beq	a4,a5,.L7
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
.L3:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,9
	ble	a4,a5,.L8
	lw	a5,-24(s0)
	addiw	a5,a5,-2
	sw	a5,-24(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,19
	ble	a4,a5,.L9
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-32(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-28(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	FourWhile, .-FourWhile
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	FourWhile
	mv	a5,a0
	mv	a0,a5
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
