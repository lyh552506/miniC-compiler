	.file	"13_array_traverse2.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	a
	.bss
	.align	3
	.type	a, @object
	.size	a, 108
a:
	.zero	108
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
	sw	zero,-28(s0)
	sw	zero,-32(s0)
	j	.L2
.L5:
	lui	a5,%hi(a)
	addi	a2,a5,%lo(a)
	lw	a1,-28(s0)
	lw	a5,-20(s0)
	lw	a3,-24(s0)
	mv	a4,a5
	slli	a4,a4,3
	add	a4,a4,a5
	mv	a5,a3
	slli	a5,a5,1
	add	a5,a5,a3
	add	a5,a4,a5
	add	a5,a5,a1
	slli	a5,a5,2
	add	a5,a2,a5
	lw	a4,-32(s0)
	sw	a4,0(a5)
	lw	a5,-32(s0)
	addiw	a5,a5,1
	sw	a5,-32(s0)
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
.L4:
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L5
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L3:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L4
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L3
	li	a5,0
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
