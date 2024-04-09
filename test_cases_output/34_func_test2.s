	.file	"34_func_test2.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	func1
	.type	func1, @function
func1:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	li	a5,1
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	func1, .-func1
	.align	1
	.globl	func2
	.type	func2, @function
func2:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	li	a5,2
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	func2, .-func2
	.align	1
	.globl	func3
	.type	func3, @function
func3:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	li	a5,4
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	func3, .-func3
	.align	1
	.globl	func4
	.type	func4, @function
func4:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	li	a5,8
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	li	a5,16
	sw	a5,-28(s0)
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-28(s0)
	addw	a5,a4,a5
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	func4, .-func4
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	addi	s0,sp,48
	li	a5,32
	sw	a5,-36(s0)
	li	a5,32
	sw	a5,-40(s0)
	li	a5,32
	sw	a5,-44(s0)
	call	func1
	mv	a5,a0
	mv	s1,a5
	call	func2
	mv	a5,a0
	addw	a5,s1,a5
	sext.w	s1,a5
	call	func3
	mv	a5,a0
	addw	a5,s1,a5
	sext.w	s1,a5
	call	func4
	mv	a5,a0
	addw	a5,s1,a5
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
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
