R"(	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.align	1
	.globl	CacheLookUp
	.type	CacheLookUp, @function
CacheLookUp:
.LFB2001_cache:
	.cfi_startproc
	slli	a5,a0,32
	slli	a1,a1,32
	srli	a5,a5,32
	or	a5,a5,a1
	li	a3,1023
	remu	a3,a5,a3
	li	a2,1021
	lui	a4,%hi(list)
	addi	a4,a4,%lo(list)
	remu	a2,a5,a2
	slli	a1,a3,4
	add	a1,a4,a1
	lw	a1,12(a1)
	slli	a7,a3,4
	add	a0,a4,a7
	sext.w	a3,a3
	addi	a2,a2,1
	beq	a1,zero,.L23_cache
	ld	a1,0(a0)
	beq	a1,a5,.L1_cache
	add	a1,a3,a2
	li	t1,1022
	sext.w	a6,a2
	addw	a3,a3,a2
	bgtu	a1,t1,.L25_cache
.L6_cache:
	slli	a2,a1,32
	srli	a3,a2,28
	add	a3,a4,a3
	lw	a2,12(a3)
	beq	a2,zero,.L18_cache
	ld	a2,0(a3)
	beq	a2,a5,.L17_cache
	addw	a3,a1,a6
	li	a2,1022
	bgtu	a3,a2,.L26_cache
.L8_cache:
	slli	a1,a3,32
	srli	a2,a1,28
	add	a2,a4,a2
	lw	a1,12(a2)
	beq	a1,zero,.L14_cache
	ld	a1,0(a2)
	beq	a1,a5,.L15_cache
	addw	a2,a6,a3
	li	a1,1022
	bgtu	a2,a1,.L27_cache
.L9_cache:
	slli	a1,a2,32
	srli	a3,a1,28
	add	a3,a4,a3
	lw	a1,12(a3)
	beq	a1,zero,.L18_cache
	ld	a1,0(a3)
	beq	a5,a1,.L17_cache
	addw	a3,a6,a2
	li	a2,1022
	bgtu	a3,a2,.L28_cache
.L10_cache:
	slli	a2,a3,32
	srli	a3,a2,28
	add	a3,a4,a3
	lw	a2,12(a3)
	beq	a2,zero,.L18_cache
	ld	a2,0(a3)
	beq	a2,a5,.L17_cache
	add	a4,a4,a7
	sw	zero,12(a4)
.L23_cache:
	sd	a5,0(a0)
.L1_cache:
	ret
.L25_cache:
	addiw	a1,a3,-1023
	j	.L6_cache
.L26_cache:
	addiw	a3,a3,-1023
	j	.L8_cache
.L27_cache:
	addiw	a2,a2,-1023
	j	.L9_cache
.L28_cache:
	addiw	a3,a3,-1023
	j	.L10_cache
.L18_cache:
	mv	a0,a3
	sd	a5,0(a0)
	ret
.L17_cache:
	mv	a0,a3
	ret
.L14_cache:
	mv	a0,a2
	sd	a5,0(a0)
	ret
.L15_cache:
	mv	a0,a2
	ret
	.cfi_endproc
.LFE2001_cache:
	.size	CacheLookUp, .-CacheLookUp
	.globl	list
	.bss
	.align	3
	.type	list, @object
	.size	list, 16368
list:
	.zero	16368
)"