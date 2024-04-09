	.file	"26_if_test5.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	if_if_Else
	.type	if_if_Else, @function
if_if_Else:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	li	a5,5
	sw	a5,-20(s0)
	li	a5,10
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,5
	bne	a4,a5,.L2
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,10
	bne	a4,a5,.L3
	li	a5,25
	sw	a5,-20(s0)
	j	.L3
.L2:
	lw	a5,-20(s0)
	addiw	a5,a5,15
	sw	a5,-20(s0)
.L3:
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	if_if_Else, .-if_if_Else
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	if_if_Else
	mv	a5,a0
	mv	a0,a5
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
