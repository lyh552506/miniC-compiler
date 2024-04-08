	.file	"52_recursion_test3.c"
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

	.globl	r
	.align	2
	.type	r, @object
	.size	r, 4
r:
	.zero	4
	
	.text
	.align	1
	.globl	fac
	.type	fac, @function
fac:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1
	bgt	a4,a5,.L2
	li	a5,1
	j	.L3
.L2:
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sext.w	a4,a5
	lui	a5,%hi(a)
	sw	a4,%lo(a)(a5)
	lui	a5,%hi(a)
	lw	a5,%lo(a)(a5)
	mv	a0,a5
	call	fac
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(r)
	sw	a4,%lo(r)(a5)
	lui	a5,%hi(r)
	lw	a5,%lo(r)(a5)
	lw	a4,-20(s0)
	mulw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(r)
	sw	a4,%lo(r)(a5)
	lui	a5,%hi(r)
	lw	a5,%lo(r)(a5)
.L3:
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	fac, .-fac
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,5
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	fac
	mv	a5,a0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
