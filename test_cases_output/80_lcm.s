	.file	"80_lcm.c"
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
	.globl	gcd
	.type	gcd, @function
gcd:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	mv	a4,a1
	sw	a5,-36(s0)
	mv	a5,a4
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	sw	a5,-24(s0)
	lw	a5,-40(s0)
	sw	a5,-28(s0)
	lw	a5,-36(s0)
	mv	a4,a5
	lw	a5,-40(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L2
	lw	a5,-36(s0)
	sw	a5,-32(s0)
	lw	a5,-40(s0)
	sw	a5,-36(s0)
	lw	a5,-32(s0)
	sw	a5,-40(s0)
.L2:
	lw	a5,-36(s0)
	mv	a4,a5
	lw	a5,-40(s0)
	remw	a5,a4,a5
	sw	a5,-20(s0)
	j	.L3
.L4:
	lw	a5,-40(s0)
	sw	a5,-36(s0)
	lw	a5,-20(s0)
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	mv	a4,a5
	lw	a5,-40(s0)
	remw	a5,a4,a5
	sw	a5,-20(s0)
.L3:
	lw	a5,-20(s0)
	sext.w	a5,a5
	bne	a5,zero,.L4
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-28(s0)
	mulw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-40(s0)
	divw	a5,a5,a4
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	gcd, .-gcd
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
	sw	a5,-20(s0)
	call	getint
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	mv	a1,a4
	mv	a0,a5
	call	gcd
	mv	a5,a0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
