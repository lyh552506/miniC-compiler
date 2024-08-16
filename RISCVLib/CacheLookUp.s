	.file	"CacheLookUp.cpp"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
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
	.globl	_Z11CacheLookUpiii
	.type	_Z11CacheLookUpiii, @function
_Z11CacheLookUpiii:
.LFB0:
	.cfi_startproc
	addi	sp,sp,-80
	.cfi_def_cfa_offset 80
	sd	s0,72(sp)
	.cfi_offset 8, -8
	addi	s0,sp,80
	.cfi_def_cfa 8, 0
	mv	a5,a0
	mv	a3,a1
	mv	a4,a2
	sw	a5,-68(s0)
	mv	a5,a3
	sw	a5,-72(s0)
	mv	a5,a4
	sw	a5,-76(s0)
	lw	a5,-72(s0)
	slli	a4,a5,32
	lw	a5,-76(s0)
	or	a5,a4,a5
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
.L7:
	lwu	a5,-20(s0)
	slli	a4,a5,4
	lui	a5,%hi(list)
	addi	a5,a5,%lo(list)
	add	a5,a4,a5
	sd	a5,-64(s0)
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,-32(s0)
	bne	a4,a5,.L2
	ld	a5,-64(s0)
	lw	a4,-68(s0)
	sw	a4,8(a5)
	ld	a5,-64(s0)
	li	a4,1
	sw	a4,12(a5)
	li	a5,-1
	j	.L3
.L2:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,4
	sgtu	a5,a4,a5
	andi	a5,a5,0xff
	bne	a5,zero,.L9
	ld	a5,-48(s0)
	sext.w	a5,a5
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1022
	bleu	a4,a5,.L7
	lw	a5,-20(s0)
	addiw	a5,a5,-1023
	sw	a5,-20(s0)
	j	.L7
.L9:
	nop
	li	a5,-1
.L3:
	mv	a0,a5
	ld	s0,72(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 80
	addi	sp,sp,80
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE0:
	.size	_Z11CacheLookUpiii, .-_Z11CacheLookUpiii
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
