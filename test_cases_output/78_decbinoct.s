	.file	"78_decbinoct.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	dec2bin
	.type	dec2bin, @function
dec2bin:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	sw	zero,-20(s0)
	li	a5,1
	sw	a5,-24(s0)
	lw	a5,-36(s0)
	sw	a5,-28(s0)
	j	.L2
.L3:
	lw	a5,-28(s0)
	mv	a4,a5
	sraiw	a5,a4,31
	srliw	a5,a5,31
	addw	a4,a4,a5
	andi	a4,a4,1
	subw	a5,a4,a5
	sw	a5,-32(s0)
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-32(s0)
	mulw	a5,a4,a5
	sext.w	a5,a5
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,2
	addw	a5,a5,a4
	slliw	a5,a5,1
	sw	a5,-24(s0)
	lw	a5,-28(s0)
	srliw	a4,a5,31
	addw	a5,a4,a5
	sraiw	a5,a5,1
	sw	a5,-28(s0)
.L2:
	lw	a5,-28(s0)
	sext.w	a5,a5
	bne	a5,zero,.L3
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	dec2bin, .-dec2bin
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,400
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	dec2bin
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	li	a5,10
	sw	a5,-24(s0)
	lw	a5,-24(s0)
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
