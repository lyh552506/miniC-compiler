	.file	"19_neg_expr.c"
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
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	call	getint
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(a)
	sw	a4,%lo(a)(a5)
	call	getint
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(b)
	sw	a4,%lo(b)(a5)
	lui	a5,%hi(a)
	lw	a4,%lo(a)(a5)
	lui	a5,%hi(b)
	lw	a5,%lo(b)(a5)
	addw	a5,a4,a5
	sext.w	a5,a5
	negw	a5,a5
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	putint
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
