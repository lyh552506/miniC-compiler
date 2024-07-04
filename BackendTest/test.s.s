	.file	"test.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	func
	.type	func, @function
func:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	t4,a0
	mv	t3,a1
	mv	t1,a2
	mv	a0,a3
	mv	a1,a4
	mv	a2,a5
	mv	a3,a6
	mv	a4,a7
	mv	a5,t4
	sw	a5,-20(s0)
	mv	a5,t3
	sw	a5,-24(s0)
	mv	a5,t1
	sw	a5,-28(s0)
	mv	a5,a0
	sw	a5,-32(s0)
	mv	a5,a1
	sw	a5,-36(s0)
	mv	a5,a2
	sw	a5,-40(s0)
	mv	a5,a3
	sw	a5,-44(s0)
	mv	a5,a4
	sw	a5,-48(s0)
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-28(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-32(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-36(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-40(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-44(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-48(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,0(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	func, .-func
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,9
	sd	a5,0(sp)
	li	a7,8
	li	a6,7
	li	a5,6
	li	a4,5
	li	a3,4
	li	a2,3
	li	a1,2
	li	a0,1
	call	func
	mv	a5,a0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
