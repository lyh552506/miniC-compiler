	.file	"42_index_func_ret.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	_getMaxOfAll
	.type	_getMaxOfAll, @function
_getMaxOfAll:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	li	a5,-999424
	addi	a5,a5,-575
	sw	a5,-20(s0)
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sw	a5,-44(s0)
	j	.L2
.L4:
	lw	a5,-44(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	bge	a5,a4,.L3
	lw	a5,-44(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-20(s0)
.L3:
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sw	a5,-44(s0)
.L2:
	lw	a5,-44(s0)
	sext.w	a5,a5
	bge	a5,zero,.L4
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	_getMaxOfAll, .-_getMaxOfAll
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,-2
	sw	a5,-32(s0)
	li	a5,2
	sw	a5,-28(s0)
	li	a5,-7
	sw	a5,-24(s0)
	addi	a5,s0,-32
	li	a1,3
	mv	a0,a5
	call	_getMaxOfAll
	mv	a5,a0
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-16(a5)
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	putint
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
