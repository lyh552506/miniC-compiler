    .file  "/home/nanqin/compiler/miniC-compiler/BackendTest/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
	.text
	.globl	list
	.bss
	.align	3
	.type	list, @object
	.size	list, 16368
list:
	.zero	16368
	.section	.srodata,"a"
	.align	2
	.type	_ZL2m1, @object
	.size	_ZL2m1, 4
_ZL2m1:
	.word	1023
	.align	2
	.type	_ZL2m2, @object
	.size	_ZL2m2, 4
_ZL2m2:
	.word	1021
	.text
	.align	1
	.globl	CacheLookUp
	.type	CacheLookUp, @function
CacheLookUp:
.LFB0:
	.cfi_startproc
	addi	sp,sp,-96
	.cfi_def_cfa_offset 96
	sd	s0,88(sp)
	.cfi_offset 8, -8
	addi	s0,sp,96
	.cfi_def_cfa 8, 0
	mv	a5,a0
	mv	a4,a1
	sw	a5,-84(s0)
	mv	a5,a4
	sw	a5,-88(s0)
	lw	a5,-84(s0)
	mv	a4,a5
	lw	a5,-88(s0)
	and	a5,a4,a5
	sext.w	a5,a5
	slli	a5,a5,32
	sd	a5,-32(s0)
	lw	a5,-84(s0)
	mv	a4,a5
	lw	a5,-88(s0)
	or	a5,a4,a5
	sext.w	a5,a5
	mv	a4,a5
	ld	a5,-32(s0)
	or	a5,a5,a4
	sd	a5,-32(s0)
	ld	a4,-32(s0)
	li	a5,1023
	remu	a5,a4,a5
	sd	a5,-40(s0)
	ld	a4,-32(s0)
	li	a5,1021
	remu	a5,a4,a5
	addi	a5,a5,1
	sd	a5,-48(s0)
	ld	a5,-40(s0)
	sw	a5,-20(s0)
	li	a5,5
	sw	a5,-52(s0)
	sw	zero,-24(s0)
.L8:
	lwu	a5,-20(s0)
	slli	a4,a5,4
	lui	a5,%hi(list)
	addi	a5,a5,%lo(list)
	add	a5,a4,a5
	sd	a5,-64(s0)
	ld	a5,-64(s0)
	lw	a5,8(a5)
	bne	a5,zero,.L2
	ld	a5,-64(s0)
	ld	a4,-32(s0)
	sd	a4,0(a5)
	ld	a5,-64(s0)
	j	.L3
.L2:
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,-32(s0)
	bne	a4,a5,.L4
	ld	a5,-64(s0)
	j	.L3
.L4:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,4
	sgtu	a5,a4,a5
	andi	a5,a5,0xff
	bne	a5,zero,.L10
	ld	a5,-48(s0)
	sext.w	a5,a5
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1022
	bleu	a4,a5,.L8
	lw	a5,-20(s0)
	addiw	a5,a5,-1023
	sw	a5,-20(s0)
	j	.L8
.L10:
	nop
	lwu	a5,-20(s0)
	slli	a4,a5,4
	lui	a5,%hi(list)
	addi	a5,a5,%lo(list)
	add	a5,a4,a5
	sd	a5,-72(s0)
	ld	a5,-72(s0)
	sw	zero,8(a5)
	ld	a5,-72(s0)
	ld	a4,-32(s0)
	sd	a4,0(a5)
	ld	a5,-72(s0)
.L3:
	mv	a0,a5
	ld	s0,88(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 96
	addi	sp,sp,96
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE0:
	.size	CacheLookUp, .-CacheLookUp
    .align  1
    .globl  func
    .type  func, @function
func:
.LBB0:
	addi sp, sp, -64
	sd ra, 56(sp)
	sd s0, 48(sp)
	addi s0, sp, 64
	fsd fs1, -64(s0)
	fsd fs0, -56(s0)
	sd s4, -48(s0)
	sd s3, -40(s0)
	sd s2, -32(s0)
	sd s1, -24(s0)
	li t0, 0
	fmv.w.x fs0, t0
	li s1, 1
	fmv.s fs1, fa0
	mv s2, a0
	j .LBB1
.LBB1:
	fmv.x.w a0, fs1
	mv a1, s2
	call CacheLookUp
	addi s3, a0, 12
	lw t2, 0(s3)
	addi s4, a0, 8
	flw fa0, 0(s4)
	beq t2, zero, .LBB2
	j .LBB3
.LBB2:
	ld s1, -24(s0)
	ld s2, -32(s0)
	ld s3, -40(s0)
	ld s4, -48(s0)
	fld fs0, -56(s0)
	fld fs1, -64(s0)
	ld ra, 56(sp)
	ld s0, 48(sp)
	addi sp, sp, 64
	ret 
.LBB3:
	blt s2, zero, .LBB4
	j .LBB5
.LBB5:
	addiw s2, s2, -1
	fmv.s fa0, fs1
	mv a0, s2
	call func
	fadd.s fs0, fs1, fa0
	fmv.s fa0, fs0
	mv a0, s2
	call func
	fsub.s fa0, fs0, fa0
	sw s1, 0(s3)
	fsw fa0, 0(s4)
	ld s1, -24(s0)
	ld s2, -32(s0)
	ld s3, -40(s0)
	ld s4, -48(s0)
	fld fs0, -56(s0)
	fld fs1, -64(s0)
	ld ra, 56(sp)
	ld s0, 48(sp)
	addi sp, sp, 64
	ret 
.LBB4:
	sw s1, 0(s3)
	fsw fs0, 0(s4)
	fmv.s fa0, fs0
	ld s1, -24(s0)
	ld s2, -32(s0)
	ld s3, -40(s0)
	ld s4, -48(s0)
	fld fs0, -56(s0)
	fld fs1, -64(s0)
	ld ra, 56(sp)
	ld s0, 48(sp)
	addi sp, sp, 64
	ret 
    .size func, .-func
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB6:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	fsd fs1, -32(s0)
	fsd fs0, -24(s0)
	li t0, 0
	fmv.w.x fs1, t0
	li t0, 1065361605
	fmv.w.x fs0, t0
	li a0, 21
	call _sysy_starttime
	call getint
	fmv.s fa0, fs0
	call func
	feq.s t2, fa0, fs1
	bne t2, zero, .LBB7
	j .LBB8
.LBB8:
	li a0, 32
	call _sysy_stoptime
	li a0, 0
	fld fs0, -24(s0)
	fld fs1, -32(s0)
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
.LBB7:
	li a0, 112
	call putch
	j .LBB8
    .size main, .-main
