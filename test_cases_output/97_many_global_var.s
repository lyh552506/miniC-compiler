	.file	"97_many_global_var.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	a0
	.section	.sbss,"aw",@nobits
	.align	2
	.type	a0, @object
	.size	a0, 4
a0:
	.zero	4
	.globl	a1
	.align	2
	.type	a1, @object
	.size	a1, 4
a1:
	.zero	4
	.globl	a2
	.align	2
	.type	a2, @object
	.size	a2, 4
a2:
	.zero	4
	.globl	a3
	.align	2
	.type	a3, @object
	.size	a3, 4
a3:
	.zero	4
	.globl	a4
	.align	2
	.type	a4, @object
	.size	a4, 4
a4:
	.zero	4
	.globl	a5
	.align	2
	.type	a5, @object
	.size	a5, 4
a5:
	.zero	4
	.globl	a6
	.align	2
	.type	a6, @object
	.size	a6, 4
a6:
	.zero	4
	.globl	a7
	.align	2
	.type	a7, @object
	.size	a7, 4
a7:
	.zero	4
	.globl	a8
	.align	2
	.type	a8, @object
	.size	a8, 4
a8:
	.zero	4
	.globl	a9
	.align	2
	.type	a9, @object
	.size	a9, 4
a9:
	.zero	4
	.globl	a10
	.align	2
	.type	a10, @object
	.size	a10, 4
a10:
	.zero	4
	.globl	a11
	.align	2
	.type	a11, @object
	.size	a11, 4
a11:
	.zero	4
	.globl	a12
	.align	2
	.type	a12, @object
	.size	a12, 4
a12:
	.zero	4
	.globl	a13
	.align	2
	.type	a13, @object
	.size	a13, 4
a13:
	.zero	4
	.globl	a14
	.align	2
	.type	a14, @object
	.size	a14, 4
a14:
	.zero	4
	.globl	a15
	.align	2
	.type	a15, @object
	.size	a15, 4
a15:
	.zero	4
	.globl	a16
	.align	2
	.type	a16, @object
	.size	a16, 4
a16:
	.zero	4
	.globl	a17
	.align	2
	.type	a17, @object
	.size	a17, 4
a17:
	.zero	4
	.globl	a18
	.align	2
	.type	a18, @object
	.size	a18, 4
a18:
	.zero	4
	.globl	a19
	.align	2
	.type	a19, @object
	.size	a19, 4
a19:
	.zero	4
	.globl	a20
	.align	2
	.type	a20, @object
	.size	a20, 4
a20:
	.zero	4
	.globl	a21
	.align	2
	.type	a21, @object
	.size	a21, 4
a21:
	.zero	4
	.globl	a22
	.align	2
	.type	a22, @object
	.size	a22, 4
a22:
	.zero	4
	.globl	a23
	.align	2
	.type	a23, @object
	.size	a23, 4
a23:
	.zero	4
	.globl	a24
	.align	2
	.type	a24, @object
	.size	a24, 4
a24:
	.zero	4
	.globl	a25
	.align	2
	.type	a25, @object
	.size	a25, 4
a25:
	.zero	4
	.globl	a26
	.align	2
	.type	a26, @object
	.size	a26, 4
a26:
	.zero	4
	.globl	a27
	.align	2
	.type	a27, @object
	.size	a27, 4
a27:
	.zero	4
	.globl	a28
	.align	2
	.type	a28, @object
	.size	a28, 4
a28:
	.zero	4
	.globl	a29
	.align	2
	.type	a29, @object
	.size	a29, 4
a29:
	.zero	4
	.globl	a30
	.align	2
	.type	a30, @object
	.size	a30, 4
a30:
	.zero	4
	.globl	a31
	.align	2
	.type	a31, @object
	.size	a31, 4
a31:
	.zero	4
	.globl	a32
	.align	2
	.type	a32, @object
	.size	a32, 4
a32:
	.zero	4
	.globl	a33
	.align	2
	.type	a33, @object
	.size	a33, 4
a33:
	.zero	4
	.globl	a34
	.align	2
	.type	a34, @object
	.size	a34, 4
a34:
	.zero	4
	.globl	a35
	.align	2
	.type	a35, @object
	.size	a35, 4
a35:
	.zero	4
	.globl	a36
	.align	2
	.type	a36, @object
	.size	a36, 4
a36:
	.zero	4
	.globl	a37
	.align	2
	.type	a37, @object
	.size	a37, 4
a37:
	.zero	4
	.globl	a38
	.align	2
	.type	a38, @object
	.size	a38, 4
a38:
	.zero	4
	.globl	a39
	.align	2
	.type	a39, @object
	.size	a39, 4
a39:
	.zero	4
	.text
	.align	1
	.globl	testParam8
	.type	testParam8, @function
testParam8:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	t4,a0
	mv	t3,a1
	mv	t1,a2
	mv	a0,a3
	mv	a1,a4
	mv	a2,a5
	mv	a3,a6
	mv	a4,a7
	mv	a5,t4
	sw	a5,-20(s0)
	mv	a5,t3
	sw	a5,-24(s0)
	mv	a5,t1
	sw	a5,-28(s0)
	mv	a5,a0
	sw	a5,-32(s0)
	mv	a5,a1
	sw	a5,-36(s0)
	mv	a5,a2
	sw	a5,-40(s0)
	mv	a5,a3
	sw	a5,-44(s0)
	mv	a5,a4
	sw	a5,-48(s0)
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-28(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-32(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-36(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-40(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-44(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-48(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	testParam8, .-testParam8
	.align	1
	.globl	testParam16
	.type	testParam16, @function
testParam16:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	t4,a0
	mv	t3,a1
	mv	t1,a2
	mv	a0,a3
	mv	a1,a4
	mv	a2,a5
	mv	a3,a6
	mv	a4,a7
	mv	a5,t4
	sw	a5,-20(s0)
	mv	a5,t3
	sw	a5,-24(s0)
	mv	a5,t1
	sw	a5,-28(s0)
	mv	a5,a0
	sw	a5,-32(s0)
	mv	a5,a1
	sw	a5,-36(s0)
	mv	a5,a2
	sw	a5,-40(s0)
	mv	a5,a3
	sw	a5,-44(s0)
	mv	a5,a4
	sw	a5,-48(s0)
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-28(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-32(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,-36(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,-40(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,-44(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,-48(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,0(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,8(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,16(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,32(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,40(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,48(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,56(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	testParam16, .-testParam16
	.align	1
	.globl	testParam32
	.type	testParam32, @function
testParam32:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	t4,a0
	mv	t3,a1
	mv	t1,a2
	mv	a0,a3
	mv	a1,a4
	mv	a2,a5
	mv	a3,a6
	mv	a4,a7
	mv	a5,t4
	sw	a5,-20(s0)
	mv	a5,t3
	sw	a5,-24(s0)
	mv	a5,t1
	sw	a5,-28(s0)
	mv	a5,a0
	sw	a5,-32(s0)
	mv	a5,a1
	sw	a5,-36(s0)
	mv	a5,a2
	sw	a5,-40(s0)
	mv	a5,a3
	sw	a5,-44(s0)
	mv	a5,a4
	sw	a5,-48(s0)
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-28(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-32(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-36(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-40(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-44(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-48(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,0(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,8(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,16(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,32(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,40(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,48(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,56(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,64(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,72(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,80(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,88(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,96(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,104(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,112(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	lw	a4,120(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,128(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,136(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,144(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,152(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,160(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,168(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,176(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,184(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	testParam32, .-testParam32
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-352
	sd	ra,344(sp)
	sd	s0,336(sp)
	sd	s1,328(sp)
	sd	s2,320(sp)
	sd	s3,312(sp)
	sd	s4,304(sp)
	sd	s5,296(sp)
	sd	s6,288(sp)
	sd	s7,280(sp)
	sd	s8,272(sp)
	sd	s9,264(sp)
	sd	s10,256(sp)
	sd	s11,248(sp)
	addi	s0,sp,352
	lui	a5,%hi(a0)
	sw	zero,%lo(a0)(a5)
	lui	a5,%hi(a1)
	li	a4,1
	sw	a4,%lo(a1)(a5)
	lui	a5,%hi(a2)
	li	a4,2
	sw	a4,%lo(a2)(a5)
	lui	a5,%hi(a3)
	li	a4,3
	sw	a4,%lo(a3)(a5)
	lui	a5,%hi(a4)
	li	a4,4
	sw	a4,%lo(a4)(a5)
	lui	a5,%hi(a5)
	li	a4,5
	sw	a4,%lo(a5)(a5)
	lui	a5,%hi(a6)
	li	a4,6
	sw	a4,%lo(a6)(a5)
	lui	a5,%hi(a7)
	li	a4,7
	sw	a4,%lo(a7)(a5)
	lui	a5,%hi(a8)
	li	a4,8
	sw	a4,%lo(a8)(a5)
	lui	a5,%hi(a9)
	li	a4,9
	sw	a4,%lo(a9)(a5)
	lui	a5,%hi(a10)
	sw	zero,%lo(a10)(a5)
	lui	a5,%hi(a11)
	li	a4,1
	sw	a4,%lo(a11)(a5)
	lui	a5,%hi(a12)
	li	a4,2
	sw	a4,%lo(a12)(a5)
	lui	a5,%hi(a13)
	li	a4,3
	sw	a4,%lo(a13)(a5)
	lui	a5,%hi(a14)
	li	a4,4
	sw	a4,%lo(a14)(a5)
	lui	a5,%hi(a15)
	li	a4,5
	sw	a4,%lo(a15)(a5)
	lui	a5,%hi(a16)
	li	a4,6
	sw	a4,%lo(a16)(a5)
	lui	a5,%hi(a17)
	li	a4,7
	sw	a4,%lo(a17)(a5)
	lui	a5,%hi(a18)
	li	a4,8
	sw	a4,%lo(a18)(a5)
	lui	a5,%hi(a19)
	li	a4,9
	sw	a4,%lo(a19)(a5)
	lui	a5,%hi(a20)
	sw	zero,%lo(a20)(a5)
	lui	a5,%hi(a21)
	li	a4,1
	sw	a4,%lo(a21)(a5)
	lui	a5,%hi(a22)
	li	a4,2
	sw	a4,%lo(a22)(a5)
	lui	a5,%hi(a23)
	li	a4,3
	sw	a4,%lo(a23)(a5)
	lui	a5,%hi(a24)
	li	a4,4
	sw	a4,%lo(a24)(a5)
	lui	a5,%hi(a25)
	li	a4,5
	sw	a4,%lo(a25)(a5)
	lui	a5,%hi(a26)
	li	a4,6
	sw	a4,%lo(a26)(a5)
	lui	a5,%hi(a27)
	li	a4,7
	sw	a4,%lo(a27)(a5)
	lui	a5,%hi(a28)
	li	a4,8
	sw	a4,%lo(a28)(a5)
	lui	a5,%hi(a29)
	li	a4,9
	sw	a4,%lo(a29)(a5)
	lui	a5,%hi(a30)
	sw	zero,%lo(a30)(a5)
	lui	a5,%hi(a31)
	li	a4,1
	sw	a4,%lo(a31)(a5)
	lui	a5,%hi(a32)
	li	a4,4
	sw	a4,%lo(a32)(a5)
	lui	a5,%hi(a33)
	li	a4,5
	sw	a4,%lo(a33)(a5)
	lui	a5,%hi(a34)
	li	a4,6
	sw	a4,%lo(a34)(a5)
	lui	a5,%hi(a35)
	li	a4,7
	sw	a4,%lo(a35)(a5)
	lui	a5,%hi(a36)
	li	a4,8
	sw	a4,%lo(a36)(a5)
	lui	a5,%hi(a37)
	li	a4,9
	sw	a4,%lo(a37)(a5)
	lui	a5,%hi(a38)
	sw	zero,%lo(a38)(a5)
	lui	a5,%hi(a39)
	li	a4,1
	sw	a4,%lo(a39)(a5)
	lui	a5,%hi(a0)
	lw	a0,%lo(a0)(a5)
	lui	a5,%hi(a1)
	lw	a1,%lo(a1)(a5)
	lui	a5,%hi(a2)
	lw	a2,%lo(a2)(a5)
	lui	a5,%hi(a3)
	lw	a3,%lo(a3)(a5)
	lui	a5,%hi(a4)
	lw	a4,%lo(a4)(a5)
	lui	a5,%hi(a5)
	lw	t1,%lo(a5)(a5)
	lui	a5,%hi(a6)
	lw	a6,%lo(a6)(a5)
	lui	a5,%hi(a7)
	lw	a5,%lo(a7)(a5)
	mv	a7,a5
	mv	a5,t1
	call	testParam8
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(a0)
	sw	a4,%lo(a0)(a5)
	lui	a5,%hi(a0)
	lw	a5,%lo(a0)(a5)
	mv	a0,a5
	call	putint
	lui	a5,%hi(a32)
	lw	t1,%lo(a32)(a5)
	lui	a5,%hi(a33)
	lw	t3,%lo(a33)(a5)
	lui	a5,%hi(a34)
	lw	t4,%lo(a34)(a5)
	lui	a5,%hi(a35)
	lw	t5,%lo(a35)(a5)
	lui	a5,%hi(a36)
	lw	t6,%lo(a36)(a5)
	lui	a5,%hi(a37)
	lw	t0,%lo(a37)(a5)
	lui	a5,%hi(a38)
	lw	t2,%lo(a38)(a5)
	lui	a5,%hi(a39)
	lw	ra,%lo(a39)(a5)
	lui	a5,%hi(a8)
	lw	a5,%lo(a8)(a5)
	lui	a4,%hi(a9)
	lw	a4,%lo(a9)(a4)
	lui	a3,%hi(a10)
	lw	a3,%lo(a10)(a3)
	lui	a2,%hi(a11)
	lw	a2,%lo(a11)(a2)
	lui	a1,%hi(a12)
	lw	a1,%lo(a12)(a1)
	lui	a0,%hi(a13)
	lw	a0,%lo(a13)(a0)
	lui	a6,%hi(a14)
	lw	a6,%lo(a14)(a6)
	lui	a7,%hi(a15)
	lw	a7,%lo(a15)(a7)
	sd	a7,56(sp)
	sd	a6,48(sp)
	sd	a0,40(sp)
	sd	a1,32(sp)
	sd	a2,24(sp)
	sd	a3,16(sp)
	sd	a4,8(sp)
	sd	a5,0(sp)
	mv	a7,ra
	mv	a6,t2
	mv	a5,t0
	mv	a4,t6
	mv	a3,t5
	mv	a2,t4
	mv	a1,t3
	mv	a0,t1
	call	testParam16
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(a0)
	sw	a4,%lo(a0)(a5)
	lui	a5,%hi(a0)
	lw	a5,%lo(a0)(a5)
	mv	a0,a5
	call	putint
	lui	a5,%hi(a0)
	lw	s9,%lo(a0)(a5)
	lui	a5,%hi(a1)
	lw	s10,%lo(a1)(a5)
	lui	a5,%hi(a2)
	lw	s11,%lo(a2)(a5)
	lui	a5,%hi(a3)
	lw	a5,%lo(a3)(a5)
	sd	a5,-120(s0)
	lui	a5,%hi(a4)
	lw	a4,%lo(a4)(a5)
	sd	a4,-128(s0)
	lui	a5,%hi(a5)
	lw	a2,%lo(a5)(a5)
	sd	a2,-136(s0)
	lui	a5,%hi(a6)
	lw	a1,%lo(a6)(a5)
	sd	a1,-144(s0)
	lui	a5,%hi(a7)
	lw	a0,%lo(a7)(a5)
	sd	a0,-152(s0)
	lui	a5,%hi(a8)
	lw	a0,%lo(a8)(a5)
	lui	a5,%hi(a9)
	lw	a6,%lo(a9)(a5)
	lui	a5,%hi(a10)
	lw	a7,%lo(a10)(a5)
	lui	a5,%hi(a11)
	lw	t1,%lo(a11)(a5)
	lui	a5,%hi(a12)
	lw	t3,%lo(a12)(a5)
	lui	a5,%hi(a13)
	lw	t4,%lo(a13)(a5)
	lui	a5,%hi(a14)
	lw	t5,%lo(a14)(a5)
	lui	a5,%hi(a15)
	lw	t6,%lo(a15)(a5)
	lui	a5,%hi(a16)
	lw	t0,%lo(a16)(a5)
	lui	a5,%hi(a17)
	lw	t2,%lo(a17)(a5)
	lui	a5,%hi(a18)
	lw	ra,%lo(a18)(a5)
	lui	a5,%hi(a19)
	lw	s1,%lo(a19)(a5)
	lui	a5,%hi(a20)
	lw	s2,%lo(a20)(a5)
	lui	a5,%hi(a21)
	lw	s3,%lo(a21)(a5)
	lui	a5,%hi(a22)
	lw	s4,%lo(a22)(a5)
	lui	a5,%hi(a23)
	lw	s5,%lo(a23)(a5)
	lui	a5,%hi(a24)
	lw	s6,%lo(a24)(a5)
	lui	a5,%hi(a25)
	lw	s7,%lo(a25)(a5)
	lui	a5,%hi(a26)
	lw	s8,%lo(a26)(a5)
	lui	a5,%hi(a27)
	lw	a1,%lo(a27)(a5)
	lui	a5,%hi(a28)
	lw	a2,%lo(a28)(a5)
	lui	a5,%hi(a29)
	lw	a3,%lo(a29)(a5)
	lui	a5,%hi(a30)
	lw	a4,%lo(a30)(a5)
	lui	a5,%hi(a31)
	lw	a5,%lo(a31)(a5)
	sd	a5,184(sp)
	sd	a4,176(sp)
	sd	a3,168(sp)
	sd	a2,160(sp)
	sd	a1,152(sp)
	sd	s8,144(sp)
	sd	s7,136(sp)
	sd	s6,128(sp)
	sd	s5,120(sp)
	sd	s4,112(sp)
	sd	s3,104(sp)
	sd	s2,96(sp)
	sd	s1,88(sp)
	sd	ra,80(sp)
	sd	t2,72(sp)
	sd	t0,64(sp)
	sd	t6,56(sp)
	sd	t5,48(sp)
	sd	t4,40(sp)
	sd	t3,32(sp)
	sd	t1,24(sp)
	sd	a7,16(sp)
	sd	a6,8(sp)
	sd	a0,0(sp)
	ld	a7,-152(s0)
	ld	a6,-144(s0)
	ld	a5,-136(s0)
	ld	a4,-128(s0)
	ld	a3,-120(s0)
	mv	a2,s11
	mv	a1,s10
	mv	a0,s9
	call	testParam32
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(a0)
	sw	a4,%lo(a0)(a5)
	lui	a5,%hi(a0)
	lw	a5,%lo(a0)(a5)
	mv	a0,a5
	call	putint
	li	a5,0
	mv	a0,a5
	ld	ra,344(sp)
	ld	s0,336(sp)
	ld	s1,328(sp)
	ld	s2,320(sp)
	ld	s3,312(sp)
	ld	s4,304(sp)
	ld	s5,296(sp)
	ld	s6,288(sp)
	ld	s7,280(sp)
	ld	s8,272(sp)
	ld	s9,264(sp)
	ld	s10,256(sp)
	ld	s11,248(sp)
	addi	sp,sp,352
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
