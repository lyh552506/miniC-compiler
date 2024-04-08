	.file	"57_sort_test5.c"
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
	.globl	swap
	.type	swap, @function
swap:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	mv	a4,a2
	sw	a5,-44(s0)
	mv	a5,a4
	sw	a5,-48(s0)
	lw	a5,-44(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-20(s0)
	lw	a5,-48(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-44(s0)
	slli	a5,a5,2
	ld	a3,-40(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-48(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,0(a5)
	li	a5,0
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	swap, .-swap
	.align	1
	.globl	heap_ajust
	.type	heap_ajust, @function
heap_ajust:
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
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	slliw	a5,a5,1
	sext.w	a5,a5
	addiw	a5,a5,1
	sw	a5,-24(s0)
	j	.L4
.L8:
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-48(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L5
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a3,0(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a4,a3
	bge	a4,a5,.L5
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L5:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a3,0(a5)
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a4,a3
	ble	a4,a5,.L6
	li	a5,0
	j	.L7
.L6:
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	mv	a2,a4
	mv	a1,a5
	ld	a0,-40(s0)
	call	swap
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	slliw	a5,a5,1
	sext.w	a5,a5
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L4:
	lw	a5,-48(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L8
	li	a5,0
.L7:
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	heap_ajust, .-heap_ajust
	.align	1
	.globl	heap_sort
	.type	heap_sort, @function
heap_sort:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	lw	a5,-44(s0)
	srliw	a4,a5,31
	addw	a5,a4,a5
	sraiw	a5,a5,1
	sext.w	a5,a5
	addiw	a5,a5,-1
	sw	a5,-20(s0)
	j	.L10
.L11:
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sw	a5,-28(s0)
	lw	a4,-28(s0)
	lw	a5,-20(s0)
	mv	a2,a4
	mv	a1,a5
	ld	a0,-40(s0)
	call	heap_ajust
	mv	a5,a0
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
.L10:
	lw	a5,-20(s0)
	sext.w	a5,a5
	bge	a5,zero,.L11
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
	j	.L12
.L13:
	sw	zero,-24(s0)
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	mv	a2,a4
	mv	a1,a5
	ld	a0,-40(s0)
	call	swap
	mv	a5,a0
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-28(s0)
	lw	a4,-28(s0)
	lw	a5,-24(s0)
	mv	a2,a4
	mv	a1,a5
	ld	a0,-40(s0)
	call	heap_ajust
	mv	a5,a0
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
.L12:
	lw	a5,-20(s0)
	sext.w	a5,a5
	bgt	a5,zero,.L13
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	heap_sort, .-heap_sort
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
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
	lw	a4,%lo(n)(a5)
	addi	a5,s0,-64
	mv	a1,a4
	mv	a0,a5
	call	heap_sort
	mv	a5,a0
	sw	a5,-20(s0)
	j	.L16
.L17:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-48(a5)
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
.L16:
	lui	a5,%hi(n)
	lw	a4,%lo(n)(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L17
	li	a5,0
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
