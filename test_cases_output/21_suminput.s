	.file	"21_suminput.c"
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
	.globl	a
	.bss
	.align	3
	.type	a, @object
	.size	a, 40
a:
	.zero	40
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
	lui	a5,%hi(n)
	sw	a4,%lo(n)(a5)
	lui	a5,%hi(n)
	lw	a5,%lo(n)(a5)
	mv	a4,a5
	li	a5,10
	ble	a4,a5,.L2
	li	a5,1
	j	.L3
.L2:
	sw	zero,-24(s0)
	lw	a5,-24(s0)
	sw	a5,-20(s0)
	j	.L4
.L5:
	call	getint
	mv	a5,a0
	mv	a3,a5
	lui	a5,%hi(a)
	addi	a4,a5,%lo(a)
	lw	a5,-24(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,0(a5)
	lui	a5,%hi(a)
	addi	a4,a5,%lo(a)
	lw	a5,-24(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L4:
	lui	a5,%hi(n)
	lw	a4,%lo(n)(a5)
	lw	a5,-24(s0)
	sext.w	a5,a5
	blt	a5,a4,.L5
	lw	a5,-20(s0)
	mv	a0,a5
	call	putint
	li	a5,10
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	mv	a0,a5
	call	putch
	lw	a5,-20(s0)
.L3:
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
