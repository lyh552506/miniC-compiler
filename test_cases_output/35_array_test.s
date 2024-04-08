	.file	"35_array_test.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	field
	.section	.sbss,"aw",@nobits
	.align	3
	.type	field, @object
	.size	field, 8
field:
	.zero	8
	
	.text
	.align	1
	.globl	func
	.type	func, @function
func:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	lui	a5,%hi(field)
	lw	a5,%lo(field)(a5)
	li	a4,3
	subw	a5,a4,a5
	sext.w	a5,a5
	slli	a5,a5,2
	ld	a4,-24(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	func, .-func
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	lui	a5,%hi(field)
	li	a4,1
	sw	a4,%lo(field)(a5)
	lui	a5,%hi(field)
	addi	a5,a5,%lo(field)
	li	a4,2
	sw	a4,4(a5)
	li	a5,-1
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	addiw	a5,a5,-2
	sext.w	a5,a5
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	sw	a5,-20(s0)
	li	a5,16
	sw	a5,-32(s0)
	addi	a5,s0,-40
	mv	a0,a5
	call	func
	mv	a5,a0
	addiw	a5,a5,2
	sext.w	a5,a5
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
