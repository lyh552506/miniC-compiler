	.file	"02_arr_defn4.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text

	.section	.rodata
	.align	3
.LC0:
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	 
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	sd	s0,72(sp)
	addi	s0,sp,80
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	ld	a2,0(a5)
	ld	a3,8(a5)
	ld	a4,16(a5)
	ld	a5,24(a5)
	sd	a2,-48(s0)
	sd	a3,-40(s0)
	sd	a4,-32(s0)
	sd	a5,-24(s0)
	lw	a5,-48(s0)
	sw	a5,-80(s0)
	lw	a5,-44(s0)
	sw	a5,-76(s0)
	li	a5,3
	sw	a5,-72(s0)
	li	a5,4
	sw	a5,-68(s0)
	li	a5,5
	sw	a5,-64(s0)
	li	a5,6
	sw	a5,-60(s0)
	li	a5,7
	sw	a5,-56(s0)
	li	a5,8
	sw	a5,-52(s0)
	li	a5,0
	mv	a0,a5
	ld	s0,72(sp)
	addi	sp,sp,80
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
