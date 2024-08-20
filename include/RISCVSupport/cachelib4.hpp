R"(	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	__umodti3
	.align	1
	.globl	CacheLookUp4
	.type	CacheLookUp4, @function
CacheLookUp4:
.LFB12:
	.cfi_startproc
	li	a4,-1
	srli	a5,a4,32
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	and	a0,a0,a5
	and	a2,a2,a5
	slli	a1,a1,32
	slli	a3,a3,32
	sd	s0,16(sp)
	sd	s2,0(sp)
	.cfi_offset 8, -16
	.cfi_offset 18, -32
	or	s0,a0,a1
	or	s2,a2,a3
	slli	a3,s2,4
	srli	a5,s0,60
	srli	a4,a4,4
	or	a5,a3,a5
	and	a5,a5,a4
	sd	s1,8(sp)
	.cfi_offset 9, -24
	and	s1,s0,a4
	add	s1,s1,a5
	srli	a5,s2,56
	add	s1,s1,a5
	li	a5,1023
	remu	s1,s1,a5
	li	a3,0
	li	a2,1021
	mv	a0,s0
	mv	a1,s2
	sd	ra,24(sp)
	.cfi_offset 1, -8
	call	__umodti3
	lui	a6,%hi(list)
	addi	a6,a6,%lo(list)
	addi	a5,a0,1
	sltu	a0,a5,a0
	add	a1,a0,a1
	slli	a7,s1,1
	add	a3,a7,s1
	slli	a3,a3,3
	add	a3,a6,a3
	lw	a4,20(a3)
	beq	a4,zero,.L43
	ld	a4,0(a3)
	beq	a4,s0,.L46
.L27:
	add	a0,s1,a5
	sltu	a2,a0,s1
	add	a2,a2,a1
	mv	a4,a0
	mv	t1,a2
	bne	a2,zero,.L28
	li	t3,1022
	bleu	a0,t3,.L7
.L28:
	addi	a4,a0,-1023
	sltu	a0,a4,a0
	addi	a2,a2,-1
	add	t1,a0,a2
.L7:
	slli	a2,a4,1
	add	a2,a2,a4
	slli	a2,a2,3
	add	a2,a6,a2
	lw	a0,20(a2)
	beq	a0,zero,.L24
	ld	a0,0(a2)
	beq	a0,s0,.L47
.L29:
	add	a4,a5,a4
	add	t1,a1,t1
	sltu	a0,a4,a5
	add	a0,a0,t1
	mv	a2,a4
	mv	t1,a0
	bne	a0,zero,.L30
	li	t3,1022
	bleu	a4,t3,.L11
.L30:
	addi	a2,a4,-1023
	sltu	a4,a2,a4
	addi	a0,a0,-1
	add	t1,a4,a0
.L11:
	slli	a4,a2,1
	add	a4,a4,a2
	slli	a4,a4,3
	add	a4,a6,a4
	lw	a0,20(a4)
	beq	a0,zero,.L22
	ld	a0,0(a4)
	beq	a0,s0,.L48
.L31:
	add	a2,a5,a2
	add	t1,a1,t1
	sltu	a0,a2,a5
	add	a0,a0,t1
	mv	a4,a2
	mv	t1,a0
	bne	a0,zero,.L32
	li	t3,1022
	bleu	a2,t3,.L14
.L32:
	addi	a4,a2,-1023
	sltu	a2,a4,a2
	addi	a0,a0,-1
	add	t1,a2,a0
.L14:
	slli	a2,a4,1
	add	a2,a2,a4
	slli	a2,a2,3
	add	a2,a6,a2
	lw	a0,20(a2)
	beq	a0,zero,.L24
	ld	a0,0(a2)
	beq	a0,s0,.L49
.L33:
	add	a4,a5,a4
	sltu	a5,a4,a5
	add	a1,a1,t1
	add	a5,a5,a1
	mv	a2,a4
	bne	a5,zero,.L34
	li	a5,1022
	bgtu	a4,a5,.L34
.L17:
	slli	a5,a2,1
	add	a5,a5,a2
	slli	a5,a5,3
	add	a5,a6,a5
	lw	a4,20(a5)
	beq	a4,zero,.L26
	ld	a4,0(a5)
	beq	a4,s0,.L50
.L19:
	add	a7,a7,s1
	slli	a7,a7,3
	add	a6,a6,a7
	sw	zero,20(a6)
.L43:
	sd	s0,0(a3)
	sd	s2,8(a3)
.L4:
	ld	ra,24(sp)
	.cfi_remember_state
	.cfi_restore 1
	ld	s0,16(sp)
	.cfi_restore 8
	ld	s1,8(sp)
	.cfi_restore 9
	ld	s2,0(sp)
	.cfi_restore 18
	mv	a0,a3
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
.L34:
	.cfi_restore_state
	addi	a2,a4,-1023
	j	.L17
.L24:
	mv	a3,a2
	j	.L43
.L46:
	ld	a4,8(a3)
	bne	a4,s2,.L27
	j	.L4
.L47:
	ld	a0,8(a2)
	bne	a0,s2,.L29
	mv	a3,a2
	j	.L4
.L22:
	mv	a3,a4
	j	.L43
.L48:
	ld	a0,8(a4)
	bne	a0,s2,.L31
	mv	a3,a4
	j	.L4
.L49:
	ld	a0,8(a2)
	bne	a0,s2,.L33
	mv	a3,a2
	j	.L4
.L26:
	mv	a3,a5
	j	.L43
.L50:
	ld	a4,8(a5)
	bne	a4,s2,.L19
	mv	a3,a5
	j	.L4
	.cfi_endproc
.LFE12:
	.size	CacheLookUp4, .-CacheLookUp4
	.globl	list
	.bss
	.align	3
	.type	list, @object
	.size	list, 24552
list:
	.zero	24552
)"