	.file	"20_arr_sum.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	a
	.bss
	.align	3
	.type	a, @object
	.size	a, 20
a:
	.zero	20
	.text
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
	lui	a5,%hi(a)
	addi	a5,a5,%lo(a)
	sw	a4,0(a5)
	call	getint
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(a)
	addi	a5,a5,%lo(a)
	sw	a4,4(a5)
	call	getint
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(a)
	addi	a5,a5,%lo(a)
	sw	a4,8(a5)
	call	getint
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(a)
	addi	a5,a5,%lo(a)
	sw	a4,12(a5)
	call	getint
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(a)
	addi	a5,a5,%lo(a)
	sw	a4,16(a5)
	li	a5,4
	sw	a5,-20(s0)
	sw	zero,-24(s0)
	j	.L2
.L3:
	lui	a5,%hi(a)
	addi	a4,a5,%lo(a)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a4,-24(s0)
	addw	a5,a4,a5
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1
	bgt	a4,a5,.L3
	lw	a5,-24(s0)
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
