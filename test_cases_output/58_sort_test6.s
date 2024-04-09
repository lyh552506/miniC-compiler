	.file	"58_sort_test6.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	n
	.section	.sbss,"aw",@nobits
	.align	2
	.type	n, @object
	.size	n, 4
n:
	.zero	4
	.text
	.align	1
	.globl	counting_sort
	.type	counting_sort, @function
counting_sort:
	addi	sp,sp,-112
	sd	s0,104(sp)
	addi	s0,sp,112
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	mv	a5,a2
	sw	a5,-100(s0)
	sw	zero,-28(s0)
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L2
.L3:
	lw	a5,-28(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	sw	zero,-56(a5)
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
.L2:
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,9
	ble	a4,a5,.L3
	j	.L4
.L5:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-88(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-56(a5)
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a3,-88(s0)
	add	a5,a3,a5
	lw	a5,0(a5)
	addiw	a4,a4,1
	sext.w	a4,a4
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	sw	a4,-56(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L4:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-100(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L5
	li	a5,1
	sw	a5,-28(s0)
	j	.L6
.L7:
	lw	a5,-28(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-56(a5)
	lw	a5,-28(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-56(a5)
	addw	a5,a4,a5
	sext.w	a4,a5
	lw	a5,-28(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	sw	a4,-56(a5)
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
.L6:
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,9
	ble	a4,a5,.L7
	lw	a5,-100(s0)
	sw	a5,-24(s0)
	j	.L8
.L9:
	lw	a5,-24(s0)
	slli	a5,a5,2
	addi	a5,a5,-4
	ld	a4,-88(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-56(a5)
	lw	a5,-24(s0)
	slli	a5,a5,2
	addi	a5,a5,-4
	ld	a3,-88(s0)
	add	a5,a3,a5
	lw	a5,0(a5)
	addiw	a4,a4,-1
	sext.w	a4,a4
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	sw	a4,-56(a5)
	lw	a5,-24(s0)
	slli	a5,a5,2
	addi	a5,a5,-4
	ld	a4,-88(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	slli	a5,a5,2
	addi	a5,a5,-4
	ld	a3,-88(s0)
	add	a5,a3,a5
	lw	a5,0(a5)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-56(a5)
	slli	a5,a5,2
	ld	a3,-96(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
.L8:
	lw	a5,-24(s0)
	sext.w	a5,a5
	bgt	a5,zero,.L9
	li	a5,0
	mv	a0,a5
	ld	s0,104(sp)
	addi	sp,sp,112
	jr	ra
	.size	counting_sort, .-counting_sort
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-112
	sd	ra,104(sp)
	sd	s0,96(sp)
	addi	s0,sp,112
	lui	a5,%hi(n)
	li	a4,10
	sw	a4,%lo(n)(a5)
	li	a5,4
	sw	a5,-64(s0)
	li	a5,3
	sw	a5,-60(s0)
	li	a5,9
	sw	a5,-56(s0)
	li	a5,2
	sw	a5,-52(s0)
	sw	zero,-48(s0)
	li	a5,1
	sw	a5,-44(s0)
	li	a5,6
	sw	a5,-40(s0)
	li	a5,5
	sw	a5,-36(s0)
	li	a5,7
	sw	a5,-32(s0)
	li	a5,8
	sw	a5,-28(s0)
	sw	zero,-20(s0)
	lui	a5,%hi(n)
	lw	a3,%lo(n)(a5)
	addi	a4,s0,-104
	addi	a5,s0,-64
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	counting_sort
	mv	a5,a0
	sw	a5,-20(s0)
	j	.L12
.L13:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-88(a5)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	li	a5,10
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putch
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L12:
	lui	a5,%hi(n)
	lw	a4,%lo(n)(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L13
	li	a5,0
	mv	a0,a5
	ld	ra,104(sp)
	ld	s0,96(sp)
	addi	sp,sp,112
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
