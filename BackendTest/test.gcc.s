	.file	"test.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	func
	.type	func, @function
func:
	addi	sp,sp,-80
	sd	s0,72(sp)
	addi	s0,sp,80
	mv	t4,a0
	fsw	fa0,-24(s0)
	mv	t3,a1
	fsw	fa1,-32(s0)
	mv	t1,a2
	fsw	fa2,-40(s0)
	mv	a0,a3
	fsw	fa3,-48(s0)
	mv	a1,a4
	fsw	fa4,-56(s0)
	mv	a2,a5
	fsw	fa5,-64(s0)
	mv	a3,a6
	fsw	fa6,-72(s0)
	mv	a4,a7
	fsw	fa7,-80(s0)
	mv	a5,t4
	sw	a5,-20(s0)
	mv	a5,t3
	sw	a5,-28(s0)
	mv	a5,t1
	sw	a5,-36(s0)
	mv	a5,a0
	sw	a5,-44(s0)
	mv	a5,a1
	sw	a5,-52(s0)
	mv	a5,a2
	sw	a5,-60(s0)
	mv	a5,a3
	sw	a5,-68(s0)
	mv	a5,a4
	sw	a5,-76(s0)
	li	a5,1
	sw	a5,-20(s0)
	lui	a5,%hi(.LC0)
	flw	fa5,%lo(.LC0)(a5)
	fsw	fa5,-24(s0)
	li	a5,3
	sw	a5,-28(s0)
	lui	a5,%hi(.LC1)
	flw	fa5,%lo(.LC1)(a5)
	fsw	fa5,-32(s0)
	li	a5,5
	sw	a5,-36(s0)
	lui	a5,%hi(.LC2)
	flw	fa5,%lo(.LC2)(a5)
	fsw	fa5,-40(s0)
	li	a5,7
	sw	a5,-44(s0)
	lui	a5,%hi(.LC3)
	flw	fa5,%lo(.LC3)(a5)
	fsw	fa5,-48(s0)
	li	a5,9
	sw	a5,-52(s0)
	lui	a5,%hi(.LC4)
	flw	fa5,%lo(.LC4)(a5)
	fsw	fa5,-56(s0)
	li	a5,11
	sw	a5,-60(s0)
	lui	a5,%hi(.LC5)
	flw	fa5,%lo(.LC5)(a5)
	fsw	fa5,-64(s0)
	li	a5,13
	sw	a5,-68(s0)
	lui	a5,%hi(.LC6)
	flw	fa5,%lo(.LC6)(a5)
	fsw	fa5,-72(s0)
	li	a5,15
	sw	a5,-76(s0)
	lui	a5,%hi(.LC7)
	flw	fa5,%lo(.LC7)(a5)
	fsw	fa5,-80(s0)
	lw	a5,16(s0)
	fcvt.s.w	fa4,a5
	flw	fa5,8(s0)
	fadd.s	fa4,fa4,fa5
	flw	fa5,24(s0)
	fadd.s	fa4,fa4,fa5
	lw	a5,32(s0)
	fcvt.s.w	fa5,a5
	fadd.s	fa4,fa4,fa5
	flw	fa5,40(s0)
	fadd.s	fa4,fa4,fa5
	lw	a5,48(s0)
	fcvt.s.w	fa5,a5
	fadd.s	fa4,fa4,fa5
	flw	fa5,56(s0)
	fadd.s	fa5,fa4,fa5
	fcvt.w.s a5,fa5,rtz
	sw	a5,0(s0)
	lw	a5,0(s0)
	mv	a0,a5
	ld	s0,72(sp)
	addi	sp,sp,80
	jr	ra
	.size	func, .-func
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	lui	a5,%hi(.LC7)
	flw	ft2,%lo(.LC7)(a5)
	lui	a5,%hi(.LC6)
	flw	ft1,%lo(.LC6)(a5)
	lui	a5,%hi(.LC5)
	flw	ft0,%lo(.LC5)(a5)
	lui	a5,%hi(.LC4)
	flw	fa4,%lo(.LC4)(a5)
	lui	a5,%hi(.LC3)
	flw	fa3,%lo(.LC3)(a5)
	lui	a5,%hi(.LC2)
	flw	fa2,%lo(.LC2)(a5)
	lui	a5,%hi(.LC1)
	flw	fa1,%lo(.LC1)(a5)
	lui	a5,%hi(.LC0)
	flw	fa0,%lo(.LC0)(a5)
	lui	a5,%hi(.LC8)
	flw	fa5,%lo(.LC8)(a5)
	fsw	fa5,56(sp)
	li	a5,23
	sd	a5,48(sp)
	lui	a5,%hi(.LC9)
	flw	fa5,%lo(.LC9)(a5)
	fsw	fa5,40(sp)
	li	a5,21
	sd	a5,32(sp)
	lui	a5,%hi(.LC10)
	flw	fa5,%lo(.LC10)(a5)
	fsw	fa5,24(sp)
	li	a5,19
	sd	a5,16(sp)
	lui	a5,%hi(.LC11)
	flw	fa5,%lo(.LC11)(a5)
	fsw	fa5,8(sp)
	li	a5,17
	sd	a5,0(sp)
	fmv.s	fa7,ft2
	li	a7,15
	fmv.s	fa6,ft1
	li	a6,13
	fmv.s	fa5,ft0
	li	a5,11
	li	a4,9
	li	a3,7
	li	a2,5
	li	a1,3
	li	a0,1
	call	func
	mv	a5,a0
	mv	a0,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	2
.LC0:
	.word	1073741824
	.align	2
.LC1:
	.word	1082130432
	.align	2
.LC2:
	.word	1086324736
	.align	2
.LC3:
	.word	1090519040
	.align	2
.LC4:
	.word	1092616192
	.align	2
.LC5:
	.word	1094713344
	.align	2
.LC6:
	.word	1096810496
	.align	2
.LC7:
	.word	1098907648
	.align	2
.LC8:
	.word	1103101952
	.align	2
.LC9:
	.word	1102053376
	.align	2
.LC10:
	.word	1101004800
	.align	2
.LC11:
	.word	1099956224
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
