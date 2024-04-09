	.file	"30_while_if_test1.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	whileIf
	.type	whileIf, @function
whileIf:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L2
.L6:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,5
	bne	a4,a5,.L3
	li	a5,25
	sw	a5,-24(s0)
	j	.L4
.L3:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,10
	bne	a4,a5,.L5
	li	a5,42
	sw	a5,-24(s0)
	j	.L4
.L5:
	lw	a5,-20(s0)
	slliw	a5,a5,1
	sw	a5,-24(s0)
.L4:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,99
	ble	a4,a5,.L6
	lw	a5,-24(s0)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	whileIf, .-whileIf
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	whileIf
	mv	a5,a0
	mv	a0,a5
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
