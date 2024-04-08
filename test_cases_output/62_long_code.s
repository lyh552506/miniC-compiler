	.file	"62_long_code.c"
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
	.globl	bubblesort
	.type	bubblesort, @function
bubblesort:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	j	.L2
.L6:
	sw	zero,-24(s0)
	j	.L3
.L5:
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
	ble	a4,a5,.L4
	lw	a5,-24(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-28(s0)
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	ld	a3,-40(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,-28(s0)
	sw	a4,0(a5)
.L4:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L3:
	lui	a5,%hi(n)
	lw	a5,%lo(n)(a5)
	lw	a4,-20(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a4,a5
	lw	a5,-24(s0)
	sext.w	a5,a5
	blt	a5,a4,.L5
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lui	a5,%hi(n)
	lw	a5,%lo(n)(a5)
	addiw	a5,a5,-1
	sext.w	a4,a5
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L6
	li	a5,0
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	bubblesort, .-bubblesort
	.align	1
	.globl	insertsort
	.type	insertsort, @function
insertsort:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	li	a5,1
	sw	a5,-20(s0)
	j	.L9
.L13:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
	j	.L10
.L12:
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	ld	a3,-40(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
.L10:
	lw	a5,-24(s0)
	sext.w	a5,a5
	blt	a5,zero,.L11
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-28(s0)
	sext.w	a5,a5
	blt	a5,a4,.L12
.L11:
	lw	a5,-24(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,-28(s0)
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L9:
	lui	a5,%hi(n)
	lw	a4,%lo(n)(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L13
	li	a5,0
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	insertsort, .-insertsort
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
	bge	a4,a5,.L16
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
	j	.L17
.L20:
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
.L18:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L19
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-28(s0)
	sext.w	a5,a5
	ble	a5,a4,.L20
.L19:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L22
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
	j	.L22
.L24:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L22:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L23
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-28(s0)
	sext.w	a5,a5
	bgt	a5,a4,.L24
.L23:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L17
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
.L17:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L18
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
.L16:
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	QuickSort, .-QuickSort
	.align	1
	.globl	getMid
	.type	getMid, @function
getMid:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	lui	a5,%hi(n)
	lw	a5,%lo(n)(a5)
	sext.w	a5,a5
	andi	a5,a5,1
	sext.w	a5,a5
	bne	a5,zero,.L28
	lui	a5,%hi(n)
	lw	a5,%lo(n)(a5)
	srliw	a4,a5,31
	addw	a5,a4,a5
	sraiw	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-4
	ld	a3,-40(s0)
	add	a5,a3,a5
	lw	a5,0(a5)
	addw	a5,a4,a5
	sext.w	a5,a5
	srliw	a4,a5,31
	addw	a5,a4,a5
	sraiw	a5,a5,1
	sext.w	a5,a5
	j	.L29
.L28:
	lui	a5,%hi(n)
	lw	a5,%lo(n)(a5)
	srliw	a4,a5,31
	addw	a5,a4,a5
	sraiw	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
.L29:
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	getMid, .-getMid
	.align	1
	.globl	getMost
	.type	getMost, @function
getMost:
	addi	sp,sp,-2032
	sd	s0,2024(sp)
	addi	s0,sp,2032
	addi	sp,sp,-2016
	li	a5,-4096
	addi	a5,a5,-16
	add	a5,a5,s0
	sd	a0,72(a5)
	sw	zero,-20(s0)
	j	.L31
.L32:
	li	a5,-4096
	addi	a5,a5,-16
	add	a4,a5,s0
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	zero,80(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L31:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,999
	ble	a4,a5,.L32
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L33
.L35:
	lw	a5,-20(s0)
	slli	a5,a5,2
	li	a4,-4096
	addi	a4,a4,-16
	add	a4,a4,s0
	ld	a4,72(a4)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-32(s0)
	li	a5,-4096
	addi	a5,a5,-16
	add	a4,a5,s0
	lw	a5,-32(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,80(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	li	a5,-4096
	addi	a5,a5,-16
	add	a3,a5,s0
	lw	a5,-32(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,80(a5)
	li	a5,-4096
	addi	a5,a5,-16
	add	a4,a5,s0
	lw	a5,-32(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,80(a5)
	lw	a5,-24(s0)
	sext.w	a5,a5
	bge	a5,a4,.L34
	li	a5,-4096
	addi	a5,a5,-16
	add	a4,a5,s0
	lw	a5,-32(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,80(a5)
	sw	a5,-24(s0)
	lw	a5,-32(s0)
	sw	a5,-28(s0)
.L34:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L33:
	lui	a5,%hi(n)
	lw	a4,%lo(n)(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L35
	lw	a5,-28(s0)
	mv	a0,a5
	addi	sp,sp,2016
	ld	s0,2024(sp)
	addi	sp,sp,2032
	jr	ra
	.size	getMost, .-getMost
	.align	1
	.globl	revert
	.type	revert, @function
revert:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L38
.L39:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-28(s0)
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
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,-28(s0)
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
.L38:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L39
	li	a5,0
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	revert, .-revert
	.align	1
	.globl	arrCopy
	.type	arrCopy, @function
arrCopy:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sw	zero,-20(s0)
	j	.L42
.L43:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a3,-48(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L42:
	lui	a5,%hi(n)
	lw	a4,%lo(n)(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L43
	li	a5,0
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	arrCopy, .-arrCopy
	.align	1
	.globl	calSum
	.type	calSum, @function
calSum:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L46
.L49:
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-44(s0)
	remw	a5,a4,a5
	sext.w	a4,a5
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	beq	a4,a5,.L47
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	sw	zero,0(a5)
	j	.L48
.L47:
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,0(a5)
	sw	zero,-20(s0)
.L48:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L46:
	lui	a5,%hi(n)
	lw	a4,%lo(n)(a5)
	lw	a5,-24(s0)
	sext.w	a5,a5
	blt	a5,a4,.L49
	li	a5,0
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	calSum, .-calSum
	.align	1
	.globl	avgPooling
	.type	avgPooling, @function
avgPooling:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	sw	zero,-24(s0)
	sw	zero,-20(s0)
	j	.L52
.L56:
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sext.w	a4,a5
	lw	a5,-24(s0)
	sext.w	a5,a5
	bge	a5,a4,.L53
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sw	a5,-20(s0)
	j	.L54
.L53:
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sext.w	a4,a5
	lw	a5,-24(s0)
	sext.w	a5,a5
	bne	a5,a4,.L55
	ld	a5,-40(s0)
	lw	a5,0(a5)
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-44(s0)
	divw	a5,a4,a5
	sext.w	a4,a5
	ld	a5,-40(s0)
	sw	a4,0(a5)
	j	.L54
.L55:
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-28(s0)
	subw	a5,a5,a4
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-44(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	addi	a5,a5,1
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-28(s0)
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-44(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	addi	a5,a5,1
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,-20(s0)
	mv	a3,a4
	lw	a4,-44(s0)
	divw	a4,a3,a4
	sext.w	a4,a4
	sw	a4,0(a5)
.L54:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L52:
	lui	a5,%hi(n)
	lw	a4,%lo(n)(a5)
	lw	a5,-24(s0)
	sext.w	a5,a5
	blt	a5,a4,.L56
	lui	a5,%hi(n)
	lw	a5,%lo(n)(a5)
	lw	a4,-44(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	addiw	a5,a5,1
	sw	a5,-24(s0)
	j	.L57
.L58:
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	sw	zero,0(a5)
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L57:
	lui	a5,%hi(n)
	lw	a4,%lo(n)(a5)
	lw	a5,-24(s0)
	sext.w	a5,a5
	blt	a5,a4,.L58
	li	a5,0
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	avgPooling, .-avgPooling
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-288
	sd	ra,280(sp)
	sd	s0,272(sp)
	addi	s0,sp,288
	lui	a5,%hi(n)
	li	a4,32
	sw	a4,%lo(n)(a5)
	li	a5,7
	sw	a5,-152(s0)
	li	a5,23
	sw	a5,-148(s0)
	li	a5,89
	sw	a5,-144(s0)
	li	a5,26
	sw	a5,-140(s0)
	li	a5,282
	sw	a5,-136(s0)
	li	a5,254
	sw	a5,-132(s0)
	li	a5,27
	sw	a5,-128(s0)
	li	a5,5
	sw	a5,-124(s0)
	li	a5,83
	sw	a5,-120(s0)
	li	a5,273
	sw	a5,-116(s0)
	li	a5,574
	sw	a5,-112(s0)
	li	a5,905
	sw	a5,-108(s0)
	li	a5,354
	sw	a5,-104(s0)
	li	a5,657
	sw	a5,-100(s0)
	li	a5,935
	sw	a5,-96(s0)
	li	a5,264
	sw	a5,-92(s0)
	li	a5,639
	sw	a5,-88(s0)
	li	a5,459
	sw	a5,-84(s0)
	li	a5,29
	sw	a5,-80(s0)
	li	a5,68
	sw	a5,-76(s0)
	li	a5,929
	sw	a5,-72(s0)
	li	a5,756
	sw	a5,-68(s0)
	li	a5,452
	sw	a5,-64(s0)
	li	a5,279
	sw	a5,-60(s0)
	li	a5,58
	sw	a5,-56(s0)
	li	a5,87
	sw	a5,-52(s0)
	li	a5,96
	sw	a5,-48(s0)
	li	a5,36
	sw	a5,-44(s0)
	li	a5,39
	sw	a5,-40(s0)
	li	a5,28
	sw	a5,-36(s0)
	li	a5,1
	sw	a5,-32(s0)
	li	a5,290
	sw	a5,-28(s0)
	addi	a4,s0,-280
	addi	a5,s0,-152
	mv	a1,a4
	mv	a0,a5
	call	arrCopy
	mv	a5,a0
	sw	a5,-24(s0)
	addi	a5,s0,-280
	mv	a0,a5
	call	revert
	mv	a5,a0
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L61
.L62:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-264(a5)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L61:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,31
	ble	a4,a5,.L62
	addi	a5,s0,-280
	mv	a0,a5
	call	bubblesort
	mv	a5,a0
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L63
.L64:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-264(a5)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L63:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,31
	ble	a4,a5,.L64
	addi	a5,s0,-280
	mv	a0,a5
	call	getMid
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	addi	a5,s0,-280
	mv	a0,a5
	call	getMost
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	addi	a4,s0,-280
	addi	a5,s0,-152
	mv	a1,a4
	mv	a0,a5
	call	arrCopy
	mv	a5,a0
	sw	a5,-24(s0)
	addi	a5,s0,-280
	mv	a0,a5
	call	bubblesort
	mv	a5,a0
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L65
.L66:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-264(a5)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L65:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,31
	ble	a4,a5,.L66
	addi	a4,s0,-280
	addi	a5,s0,-152
	mv	a1,a4
	mv	a0,a5
	call	arrCopy
	mv	a5,a0
	sw	a5,-24(s0)
	addi	a5,s0,-280
	mv	a0,a5
	call	insertsort
	mv	a5,a0
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L67
.L68:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-264(a5)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L67:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,31
	ble	a4,a5,.L68
	addi	a4,s0,-280
	addi	a5,s0,-152
	mv	a1,a4
	mv	a0,a5
	call	arrCopy
	mv	a5,a0
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	li	a5,31
	sw	a5,-24(s0)
	lw	a3,-24(s0)
	lw	a4,-20(s0)
	addi	a5,s0,-280
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	QuickSort
	mv	a5,a0
	sw	a5,-24(s0)
	j	.L69
.L70:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-264(a5)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L69:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,31
	ble	a4,a5,.L70
	addi	a4,s0,-280
	addi	a5,s0,-152
	mv	a1,a4
	mv	a0,a5
	call	arrCopy
	mv	a5,a0
	sw	a5,-24(s0)
	addi	a5,s0,-280
	li	a1,4
	mv	a0,a5
	call	calSum
	mv	a5,a0
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L71
.L72:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-264(a5)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L71:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,31
	ble	a4,a5,.L72
	addi	a4,s0,-280
	addi	a5,s0,-152
	mv	a1,a4
	mv	a0,a5
	call	arrCopy
	mv	a5,a0
	sw	a5,-24(s0)
	addi	a5,s0,-280
	li	a1,3
	mv	a0,a5
	call	avgPooling
	mv	a5,a0
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L73
.L74:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-264(a5)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L73:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,31
	ble	a4,a5,.L74
	li	a5,0
	mv	a0,a5
	ld	ra,280(sp)
	ld	s0,272(sp)
	addi	sp,sp,288
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"