	.file	"61_rec_fibonacci.c"
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
	.globl	f
	.type	f, @function
f:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	sd	s1,40(sp)
	addi	s0,sp,64
	mv	a5,a0
	sw	a5,-52(s0)
	lw	a5,-52(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L2
	li	a5,1
	j	.L3
.L2:
	lw	a5,-52(s0)
	sext.w	a4,a5
	li	a5,2
	bne	a4,a5,.L4
	li	a5,1
	j	.L3
.L4:
	lw	a5,-52(s0)
	addiw	a5,a5,-1
	sw	a5,-36(s0)
	lw	a5,-52(s0)
	addiw	a5,a5,-2
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	mv	a0,a5
	call	f
	mv	a5,a0
	mv	s1,a5
	lw	a5,-40(s0)
	mv	a0,a5
	call	f
	mv	a5,a0
	addw	a5,s1,a5
	sw	a5,-44(s0)
	lw	a5,-44(s0)
.L3:
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	ld	s1,40(sp)
	addi	sp,sp,64
	jr	ra
	.size	f, .-f
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
	lui	a5,%hi(n)
	sw	a4,%lo(n)(a5)
	lui	a5,%hi(n)
	lw	a5,%lo(n)(a5)
	mv	a0,a5
	call	f
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	putint
	li	a5,10
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putch
	lw	a5,-20(s0)
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
