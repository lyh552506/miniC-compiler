	.file	"82_int_split.c"
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
	.globl	split
	.type	split, @function
split:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	sd	a1,-48(s0)
	sw	a5,-36(s0)
	lui	a5,%hi(N)
	lw	a5,%lo(N)(a5)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
	j	.L2
.L3:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-48(s0)
	add	a5,a4,a5
	lw	a4,-36(s0)
	mv	a3,a4
	li	a4,10
	remw	a4,a3,a4
	sext.w	a4,a4
	sw	a4,0(a5)
	lw	a5,-36(s0)
	mv	a4,a5
	li	a5,10
	divw	a5,a4,a5
	sw	a5,-36(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,-1
	bne	a4,a5,.L3
	li	a5,0
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	split, .-split
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	lui	a5,%hi(N)
	li	a4,4
	sw	a4,%lo(N)(a5)
	lui	a5,%hi(newline)
	li	a4,10
	sw	a4,%lo(newline)(a5)
	li	a5,1478
	sw	a5,-24(s0)
	addi	a4,s0,-48
	lw	a5,-24(s0)
	mv	a1,a4
	mv	a0,a5
	call	split
	mv	a5,a0
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L6
.L7:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-32(a5)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	mv	a0,a5
	call	putint
	lui	a5,%hi(newline)
	lw	a5,%lo(newline)(a5)
	mv	a0,a5
	call	putch
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L6:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L7
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
