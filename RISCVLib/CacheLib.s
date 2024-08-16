	.text
	.align	1
	.globl	_Z11CacheLookUpii
	.type	_Z11CacheLookUpii, @function
_Z11CacheLookUpii:
.LFB0:
	.cfi_startproc
	and	a5,a0,a1
	slli	a5,a5,32
	or	a0,a0,a1
	or	a2,a0,a5
	li	a5,1023
	remu	a5,a2,a5
	li	a4,1021
	lui	a1,%hi(list)
	addi	a1,a1,%lo(list)
	remu	a4,a2,a4
	slli	a6,a5,4
	add	a6,a1,a6
	lw	a7,8(a6)
	mv	a3,a5
	mv	a0,a6
	sext.w	a5,a5
	addi	a4,a4,1
	beq	a7,zero,.L2
	ld	a3,0(a6)
	beq	a2,a3,.L1
	addw	a5,a5,a4
	li	a0,1022
	sext.w	a4,a4
	bgtu	a5,a0,.L29
.L6:
	slli	a3,a5,32
	srli	a3,a3,32
	slli	a0,a3,4
	add	a0,a1,a0
	lw	a6,8(a0)
	beq	a6,zero,.L2
	ld	a3,0(a0)
	beq	a2,a3,.L1
	addw	a5,a4,a5
	li	a0,1022
	bgtu	a5,a0,.L30
.L8:
	slli	a3,a5,32
	srli	a3,a3,32
	slli	a0,a3,4
	add	a0,a1,a0
	lw	a6,8(a0)
	beq	a6,zero,.L2
	ld	a3,0(a0)
	beq	a2,a3,.L1
	addw	a5,a4,a5
	li	a0,1022
	bgtu	a5,a0,.L31
.L9:
	slli	a3,a5,32
	srli	a3,a3,32
	slli	a0,a3,4
	add	a0,a1,a0
	lw	a6,8(a0)
	beq	a6,zero,.L2
	ld	a3,0(a0)
	beq	a2,a3,.L1
	addw	a5,a4,a5
	li	a3,1022
	bgtu	a5,a3,.L32
.L10:
	slli	a3,a5,32
	srli	a3,a3,32
	slli	a0,a3,4
	add	a0,a1,a0
	lw	a5,8(a0)
	beq	a5,zero,.L2
	ld	a5,0(a0)
	beq	a5,a2,.L1
	sw	zero,8(a0)
	sd	a2,0(a0)
.L1:
	ret
.L29:
	addiw	a5,a5,-1023
	j	.L6
.L30:
	addiw	a5,a5,-1023
	j	.L8
.L31:
	addiw	a5,a5,-1023
	j	.L9
.L32:
	addiw	a5,a5,-1023
	j	.L10
.L2:
	slli	a3,a3,4
	add	a3,a1,a3
	sd	a2,0(a3)
	ret
	.cfi_endproc
.LFE0:
	.size	_Z11CacheLookUpii, .-_Z11CacheLookUpii
	.globl	list
	.bss
	.align	3
	.type	list, @object
	.size	list, 16368
list:
	.zero	16368
