	.file	"29_while_test3.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	g
	.section	.sbss,"aw",@nobits
	.align	2
	.type	g, @object
	.size	g, 4
g:
	.zero	4
	.globl	h
	.align	2
	.type	h, @object
	.size	h, 4
h:
	.zero	4
	.globl	f
	.align	2
	.type	f, @object
	.size	f, 4
f:
	.zero	4
	.globl	e
	.align	2
	.type	e, @object
	.size	e, 4
e:
	.zero	4
	.text
	.align	1
	.globl	EightWhile
	.type	EightWhile, @function
EightWhile:
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
.L17:
	lw	a5,-20(s0)
	addiw	a5,a5,3
	sw	a5,-20(s0)
	j	.L3
.L16:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
	j	.L4
.L15:
	lw	a5,-28(s0)
	addiw	a5,a5,-1
	sw	a5,-28(s0)
	j	.L5
.L14:
	lw	a5,-32(s0)
	addiw	a5,a5,3
	sw	a5,-32(s0)
	j	.L6
.L13:
	lui	a5,%hi(e)
	lw	a5,%lo(e)(a5)
	addiw	a5,a5,-1
	sext.w	a4,a5
	lui	a5,%hi(e)
	sw	a4,%lo(e)(a5)
	j	.L7
.L12:
	lui	a5,%hi(f)
	lw	a5,%lo(f)(a5)
	addiw	a5,a5,-2
	sext.w	a4,a5
	lui	a5,%hi(f)
	sw	a4,%lo(f)(a5)
	j	.L8
.L11:
	lui	a5,%hi(g)
	lw	a5,%lo(g)(a5)
	addiw	a5,a5,10
	sext.w	a4,a5
	lui	a5,%hi(g)
	sw	a4,%lo(g)(a5)
	j	.L9
.L10:
	lui	a5,%hi(h)
	lw	a5,%lo(h)(a5)
	addiw	a5,a5,8
	sext.w	a4,a5
	lui	a5,%hi(h)
	sw	a4,%lo(h)(a5)
.L9:
	lui	a5,%hi(h)
	lw	a5,%lo(h)(a5)
	mv	a4,a5
	li	a5,9
	ble	a4,a5,.L10
	lui	a5,%hi(h)
	lw	a5,%lo(h)(a5)
	addiw	a5,a5,-1
	sext.w	a4,a5
	lui	a5,%hi(h)
	sw	a4,%lo(h)(a5)
.L8:
	lui	a5,%hi(g)
	lw	a5,%lo(g)(a5)
	mv	a4,a5
	li	a5,2
	ble	a4,a5,.L11
	lui	a5,%hi(g)
	lw	a5,%lo(g)(a5)
	addiw	a5,a5,-8
	sext.w	a4,a5
	lui	a5,%hi(g)
	sw	a4,%lo(g)(a5)
.L7:
	lui	a5,%hi(f)
	lw	a5,%lo(f)(a5)
	mv	a4,a5
	li	a5,2
	bgt	a4,a5,.L12
	lui	a5,%hi(f)
	lw	a5,%lo(f)(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	lui	a5,%hi(f)
	sw	a4,%lo(f)(a5)
.L6:
	lui	a5,%hi(e)
	lw	a5,%lo(e)(a5)
	mv	a4,a5
	li	a5,1
	bgt	a4,a5,.L13
	lui	a5,%hi(e)
	lw	a5,%lo(e)(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	lui	a5,%hi(e)
	sw	a4,%lo(e)(a5)
.L5:
	lw	a5,-32(s0)
	sext.w	a4,a5
	li	a5,19
	ble	a4,a5,.L14
	lw	a5,-32(s0)
	addiw	a5,a5,-1
	sw	a5,-32(s0)
.L4:
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,7
	beq	a4,a5,.L15
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
.L3:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,9
	ble	a4,a5,.L16
	lw	a5,-24(s0)
	addiw	a5,a5,-2
	sw	a5,-24(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,19
	ble	a4,a5,.L17
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
	sext.w	a4,a5
	lui	a5,%hi(e)
	lw	a5,%lo(e)(a5)
	lw	a3,-32(s0)
	addw	a5,a3,a5
	sext.w	a3,a5
	lui	a5,%hi(g)
	lw	a5,%lo(g)(a5)
	subw	a5,a3,a5
	sext.w	a3,a5
	lui	a5,%hi(h)
	lw	a5,%lo(h)(a5)
	addw	a5,a3,a5
	sext.w	a5,a5
	subw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	EightWhile, .-EightWhile
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(g)
	li	a4,1
	sw	a4,%lo(g)(a5)
	lui	a5,%hi(h)
	li	a4,2
	sw	a4,%lo(h)(a5)
	lui	a5,%hi(e)
	li	a4,4
	sw	a4,%lo(e)(a5)
	lui	a5,%hi(f)
	li	a4,6
	sw	a4,%lo(f)(a5)
	call	EightWhile
	mv	a5,a0
	mv	a0,a5
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
