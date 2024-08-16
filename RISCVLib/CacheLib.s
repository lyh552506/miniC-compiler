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
	.globl	_Z11CacheLookUpii
	.type	_Z11CacheLookUpii, @function
_Z11CacheLookUpii:
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
	lw	a5,12(a5)
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
	sw	zero,12(a5)
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
	.size	_Z11CacheLookUpii, .-_Z11CacheLookUpii
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
