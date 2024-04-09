	.file	"73_exchange_value.c"
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
	lw	a5,-20(s0)
	sw	a5,-28(s0)
	lw	a5,-24(s0)
	sw	a5,-20(s0)
	lw	a5,-28(s0)
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	putint
	li	a5,10
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	mv	a0,a5
	call	putch
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	li	a5,10
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	mv	a0,a5
	call	putch
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
