	.file	"test.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-416
	sd	ra,408(sp)
	sd	s0,400(sp)
	addi	s0,sp,416
	li	a5,123457536
	addi	a0,a5,-747
	call	putint
	li	a5,12288
	addi	a5,a5,57
	sw	a5,-376(s0)
	lw	a5,-376(s0)
	mv	a0,a5
	call	putint
	li	a5,0
	mv	a0,a5
	ld	ra,408(sp)
	ld	s0,400(sp)
	addi	sp,sp,416
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
