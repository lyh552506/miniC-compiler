	.file	"test.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	a
	.section	.sbss,"aw",@nobits
	.align	2
	.type	a, @object
	.size	a, 4
a:
	.zero	4
	.globl	b
	.align	2
	.type	b, @object
	.size	b, 4
b:
	.zero	4
	.globl	arry
	.data
	.align	3
	.type	arry, @object
	.size	arry, 48
arry:
	.word	1
	.word	2
	.zero	4
	.zero	12
	.word	3
	.zero	8
	.zero	12
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	lui	a5,%hi(b)
	sw	zero,%lo(b)(a5)
	lui	a5,%hi(a)
	li	a4,3
	sw	a4,%lo(a)(a5)
	j	.L2
.L3:
	lui	a5,%hi(b)
	lw	a4,%lo(b)(a5)
	lui	a5,%hi(a)
	lw	a5,%lo(a)(a5)
	addw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(b)
	sw	a4,%lo(b)(a5)
	lui	a5,%hi(a)
	lw	a5,%lo(a)(a5)
	addiw	a5,a5,-1
	sext.w	a4,a5
	lui	a5,%hi(a)
	sw	a4,%lo(a)(a5)
.L2:
	lui	a5,%hi(a)
	lw	a5,%lo(a)(a5)
	bgt	a5,zero,.L3
	lui	a5,%hi(b)
	lw	a5,%lo(b)(a5)
	mv	a0,a5
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
