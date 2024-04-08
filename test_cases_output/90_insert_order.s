	.file	"90_insert_order.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	N
	.section	.sbss,"aw",@nobits
	.align	2
	.type	N, @object
	.size	N, 4
N:
	.zero	4
	.text
	.align	1
	.globl	insert
	.type	insert, @function
insert:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	sw	zero,-20(s0)
	j	.L2
.L4:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-44(s0)
	sext.w	a5,a5
	ble	a5,a4,.L3
	lui	a5,%hi(N)
	lw	a4,%lo(N)(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L4
.L3:
	lui	a5,%hi(N)
	lw	a5,%lo(N)(a5)
	sw	a5,-24(s0)
	j	.L5
.L6:
	lw	a5,-24(s0)
	slli	a5,a5,2
	addi	a5,a5,-4
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a3,-40(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,-44(s0)
	sw	a4,0(a5)
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
.L5:
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-20(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bgt	a4,a5,.L6
	li	a5,0
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	insert, .-insert
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	lui	a5,%hi(N)
	li	a4,10
	sw	a4,%lo(N)(a5)
	li	a5,1
	sw	a5,-72(s0)
	li	a5,3
	sw	a5,-68(s0)
	li	a5,4
	sw	a5,-64(s0)
	li	a5,7
	sw	a5,-60(s0)
	li	a5,8
	sw	a5,-56(s0)
	li	a5,11
	sw	a5,-52(s0)
	li	a5,13
	sw	a5,-48(s0)
	li	a5,18
	sw	a5,-44(s0)
	li	a5,56
	sw	a5,-40(s0)
	li	a5,78
	sw	a5,-36(s0)
	sw	zero,-20(s0)
	call	getint
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	addi	a5,s0,-72
	mv	a1,a4
	mv	a0,a5
	call	insert
	mv	a5,a0
	sw	a5,-24(s0)
	j	.L9
.L10:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-56(a5)
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
.L9:
	lui	a5,%hi(N)
	lw	a4,%lo(N)(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L10
	li	a5,0
	mv	a0,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
