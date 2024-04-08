	.file	"55_sort_test3.c"
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
	.globl	QuickSort
	.type	QuickSort, @function
QuickSort:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	mv	a4,a2
	sw	a5,-44(s0)
	mv	a5,a4
	sw	a5,-48(s0)
	lw	a5,-44(s0)
	mv	a4,a5
	lw	a5,-48(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L2
	lw	a5,-44(s0)
	sw	a5,-20(s0)
	lw	a5,-48(s0)
	sw	a5,-24(s0)
	lw	a5,-44(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-28(s0)
	j	.L3
.L6:
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
.L4:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L5
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-28(s0)
	sext.w	a5,a5
	ble	a5,a4,.L6
.L5:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L8
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a3,-40(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
	j	.L8
.L10:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L8:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L9
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-28(s0)
	sext.w	a5,a5
	bgt	a5,a4,.L10
.L9:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L3
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a3,-40(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
.L3:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L4
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,-28(s0)
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-32(s0)
	lw	a4,-32(s0)
	lw	a5,-44(s0)
	mv	a2,a4
	mv	a1,a5
	ld	a0,-40(s0)
	call	QuickSort
	mv	a5,a0
	sw	a5,-32(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-32(s0)
	lw	a4,-48(s0)
	lw	a5,-32(s0)
	mv	a2,a4
	mv	a1,a5
	ld	a0,-40(s0)
	call	QuickSort
	mv	a5,a0
	sw	a5,-32(s0)
.L2:
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	QuickSort, .-QuickSort
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	lui	a5,%hi(n)
	li	a4,10
	sw	a4,%lo(n)(a5)
	li	a5,4
	sw	a5,-72(s0)
	li	a5,3
	sw	a5,-68(s0)
	li	a5,9
	sw	a5,-64(s0)
	li	a5,2
	sw	a5,-60(s0)
	sw	zero,-56(s0)
	li	a5,1
	sw	a5,-52(s0)
	li	a5,6
	sw	a5,-48(s0)
	li	a5,5
	sw	a5,-44(s0)
	li	a5,7
	sw	a5,-40(s0)
	li	a5,8
	sw	a5,-36(s0)
	sw	zero,-20(s0)
	li	a5,9
	sw	a5,-24(s0)
	lw	a3,-24(s0)
	lw	a4,-20(s0)
	addi	a5,s0,-72
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	QuickSort
	mv	a5,a0
	sw	a5,-20(s0)
	j	.L14
.L15:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-56(a5)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	mv	a0,a5
	call	putint
	li	a5,10
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	mv	a0,a5
	call	putch
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L14:
	lui	a5,%hi(n)
	lw	a4,%lo(n)(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L15
	li	a5,0
	mv	a0,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
