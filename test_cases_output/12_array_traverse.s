	.file	"12_array_traverse.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	
	.globl	a
	.bss
	.align	3
	.type	a, @object
	.size	a, 48
a:
	.zero	48
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L2
.L6:
	lw	a5,-20(s0)
	sw	a5,-28(s0)
	j	.L3
.L5:
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,3
	bgt	a4,a5,.L4
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-28(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	mv	a4,a5
	li	a5,2
	bgt	a4,a5,.L4
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-28(s0)
	subw	a5,a4,a5
	sext.w	a3,a5
	lui	a5,%hi(a)
	addi	a4,a5,%lo(a)
	lw	a5,-28(s0)
	slli	a3,a3,2
	add	a5,a3,a5
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,-24(s0)
	sw	a4,0(a5)
	li	a5,1
	sw	a5,-24(s0)
.L4:
	lw	a5,-28(s0)
	addiw	a5,a5,-1
	sw	a5,-28(s0)
.L3:
	lw	a5,-28(s0)
	sext.w	a5,a5
	bge	a5,zero,.L5
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,5
	ble	a4,a5,.L6
	li	a5,0
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
