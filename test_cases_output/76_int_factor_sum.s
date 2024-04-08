	.file	"76_int_factor_sum.c"
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
	.globl	newline
	.align	2
	.type	newline, @object
	.size	newline, 4
newline:
	.zero	4
	.text
	.align	1
	.globl	factor
	.type	factor, @function
factor:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	sw	zero,-24(s0)
	li	a5,1
	sw	a5,-20(s0)
	j	.L2
.L4:
	lw	a5,-36(s0)
	mv	a4,a5
	lw	a5,-20(s0)
	remw	a5,a4,a5
	sext.w	a5,a5
	bne	a5,zero,.L3
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-20(s0)
	addw	a5,a4,a5
	sw	a5,-24(s0)
.L3:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-36(s0)
	mv	a4,a5
	lw	a5,-20(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L4
	lw	a5,-24(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	factor, .-factor
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(N)
	li	a4,4
	sw	a4,%lo(N)(a5)
	lui	a5,%hi(newline)
	li	a4,10
	sw	a4,%lo(newline)(a5)
	li	a5,1478
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	factor
	mv	a5,a0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
