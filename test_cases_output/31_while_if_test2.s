	.file	"31_while_if_test2.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	ifWhile
	.type	ifWhile, @function
ifWhile:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
	li	a5,3
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,5
	bne	a4,a5,.L6
	j	.L3
.L4:
	lw	a5,-24(s0)
	addiw	a5,a5,2
	sw	a5,-24(s0)
.L3:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,2
	beq	a4,a5,.L4
	lw	a5,-24(s0)
	addiw	a5,a5,25
	sw	a5,-24(s0)
	j	.L5
.L7:
	lw	a5,-24(s0)
	slliw	a5,a5,1
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L6:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,4
	ble	a4,a5,.L7
.L5:
	lw	a5,-24(s0)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	ifWhile, .-ifWhile
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	ifWhile
	mv	a5,a0
	mv	a0,a5
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
