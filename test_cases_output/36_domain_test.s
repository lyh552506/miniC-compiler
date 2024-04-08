	.file	"36_domain_test.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	a
	.section	.sbss,"aw",@nobits
	.align	3
	.type	a, @object
	.size	a, 8
a:
	.zero	8
	.text
	.align	1
	.globl	func
	.type	func, @function
func:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	lui	a5,%hi(a)
	li	a4,1
	sw	a4,%lo(a)(a5)
	lui	a5,%hi(a)
	lw	a5,%lo(a)(a5)
	li	a4,3
	subw	a5,a4,a5
	sext.w	a5,a5
	slli	a5,a5,2
	ld	a4,-24(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
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
	li	a5,-1
	sw	a5,-32(s0)
	li	a5,4
	sw	a5,-28(s0)
	li	a5,8
	sw	a5,-24(s0)
	addi	a5,s0,-32
	mv	a0,a5
	call	func
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-28(s0)
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
