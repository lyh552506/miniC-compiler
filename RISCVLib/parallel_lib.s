	.file	"parallel_lib.cpp"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.align	1
	.globl	_Z12WorkerThreadPv
	.type	_Z12WorkerThreadPv, @function
_Z12WorkerThreadPv:
.LFB2882:
	.cfi_startproc
	addi	sp,sp,-64
	.cfi_def_cfa_offset 64
	sd	s0,48(sp)
	.cfi_offset 8, -16
	lui	s0,%hi(_ZL4full)
	addi	s0,s0,%lo(_ZL4full)
	sd	s1,40(sp)
	.cfi_offset 9, -24
	andi	s1,s0,3
	sd	s4,16(sp)
	slliw	s1,s1,3
	.cfi_offset 20, -48
	li	s4,1
	sd	s2,32(sp)
	sd	s3,24(sp)
	sd	s5,8(sp)
	sd	ra,56(sp)
	.cfi_offset 18, -32
	.cfi_offset 19, -40
	.cfi_offset 21, -56
	.cfi_offset 1, -8
	lui	s5,%hi(buildin_funcptr)
	lui	s3,%hi(_ZL9task_done)
	andi	s0,s0,-4
	sllw	s2,s4,s1
.L2:
	fence iorw,ow; amoor.w.aq a5,s2,0(s0)
	srlw	a5,a5,s1
	andi	a5,a5,0xff
	bne	a5,zero,.L2
	ld	a5,%lo(buildin_funcptr)(s5)
	jalr	a5
	addi	a5,s3,%lo(_ZL9task_done)
	fence iorw,ow; amoadd.w.aq zero,s4,0(a5)
	j	.L2
	.cfi_endproc
.LFE2882:
	.size	_Z12WorkerThreadPv, .-_Z12WorkerThreadPv
	.align	1
	.globl	buildin_FenceArgLoaded
	.type	buildin_FenceArgLoaded, @function
buildin_FenceArgLoaded:
.LFB2876:
	.cfi_startproc
	fence	iorw,iorw
	lui	a5,%hi(_ZL5empty)
	sb	zero,%lo(_ZL5empty)(a5)
	fence	iorw,iorw
	ret
	.cfi_endproc
.LFE2876:
	.size	buildin_FenceArgLoaded, .-buildin_FenceArgLoaded
	.align	1
	.globl	buildin_NotifyWorkerLT
	.type	buildin_NotifyWorkerLT, @function
buildin_NotifyWorkerLT:
.LFB2880:
	.cfi_startproc
	addi	sp,sp,-112
	.cfi_def_cfa_offset 112
	sd	s9,24(sp)
	sd	ra,104(sp)
	sub	a5,a1,a0
	li	a4,63
	.cfi_offset 25, -88
	.cfi_offset 1, -8
	mv	s9,a1
	ble	a5,a4,.L23
	sd	s3,72(sp)
	sd	s8,32(sp)
	sd	s10,16(sp)
	addi	a5,a5,3
	.cfi_offset 19, -40
	.cfi_offset 24, -80
	.cfi_offset 26, -96
	mv	s8,a0
	srai	s3,a5,2
	lui	s10,%hi(_ZL5tasks)
	ble	a1,a0,.L10
	sd	s0,96(sp)
	.cfi_offset 8, -16
	lui	s0,%hi(_ZL5empty)
	addi	s0,s0,%lo(_ZL5empty)
	sd	s1,88(sp)
	.cfi_offset 9, -24
	andi	s1,s0,3
	sd	s5,56(sp)
	sd	s6,48(sp)
	sd	s7,40(sp)
	.cfi_offset 21, -56
	.cfi_offset 22, -64
	.cfi_offset 23, -72
	li	s6,1
	slliw	s1,s1,3
	lui	s7,%hi(.LANCHOR0)
	li	s5,-1
	sd	s2,80(sp)
	sd	s4,64(sp)
	sd	s11,8(sp)
	.cfi_offset 18, -32
	.cfi_offset 20, -48
	.cfi_offset 27, -104
	addi	s7,s7,%lo(.LANCHOR0)
	lui	s10,%hi(_ZL5tasks)
	lui	s4,%hi(_ZL4full)
	srli	s5,s5,32
	andi	s0,s0,-4
	sllw	s2,s6,s1
	lui	s11,%hi(buildin_funcptr)
.L15:
	mv	a3,s8
	slli	a4,a3,32
	add	s8,s8,s3
	srli	a4,a4,32
	mv	a5,s9
	ble	s9,s8,.L11
	mv	a5,s8
.L11:
	slli	a5,a5,32
	and	a4,a4,s5
	or	a4,a4,a5
.L12:
	fence iorw,ow; amoor.w.aq a5,s2,0(s0)
	srlw	a5,a5,s1
	andi	a5,a5,0xff
	bne	a5,zero,.L12
	sd	a4,0(s7)
	addi	a5,s10,%lo(_ZL5tasks)
	fence iorw,ow; amoadd.w.aq zero,s6,0(a5)
	fence	iorw,iorw
	sb	zero,%lo(_ZL4full)(s4)
	fence	iorw,iorw
	blt	a3,zero,.L13
	ld	a5,%lo(buildin_funcptr)(s11)
	jalr	a5
	bgt	s9,s8,.L15
.L24:
	ld	s0,96(sp)
	.cfi_restore 8
	ld	s1,88(sp)
	.cfi_restore 9
	ld	s2,80(sp)
	.cfi_restore 18
	ld	s4,64(sp)
	.cfi_restore 20
	ld	s5,56(sp)
	.cfi_restore 21
	ld	s6,48(sp)
	.cfi_restore 22
	ld	s7,40(sp)
	.cfi_restore 23
	ld	s11,8(sp)
	.cfi_restore 27
.L10:
	lui	a3,%hi(_ZL9task_done)
.L16:
	fence	iorw,iorw
	lw	a5,%lo(_ZL9task_done)(a3)
	fence	iorw,iorw
	fence	iorw,iorw
	sext.w	a5,a5
	lw	a4,%lo(_ZL5tasks)(s10)
	fence	iorw,iorw
	bne	a5,a4,.L16
	ld	ra,104(sp)
	.cfi_restore 1
	ld	s3,72(sp)
	.cfi_restore 19
	ld	s8,32(sp)
	.cfi_restore 24
	ld	s10,16(sp)
	.cfi_restore 26
	ld	s9,24(sp)
	.cfi_restore 25
	addi	sp,sp,112
	.cfi_def_cfa_offset 0
	jr	ra
.L13:
	.cfi_def_cfa_offset 112
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	.cfi_offset 9, -24
	.cfi_offset 18, -32
	.cfi_offset 19, -40
	.cfi_offset 20, -48
	.cfi_offset 21, -56
	.cfi_offset 22, -64
	.cfi_offset 23, -72
	.cfi_offset 24, -80
	.cfi_offset 25, -88
	.cfi_offset 26, -96
	.cfi_offset 27, -104
	fence	iorw,iorw
	sb	zero,%lo(_ZL4full)(s4)
	fence	iorw,iorw
	bgt	s9,s8,.L15
	j	.L24
.L23:
	.cfi_restore 8
	.cfi_restore 9
	.cfi_restore 18
	.cfi_restore 19
	.cfi_restore 20
	.cfi_restore 21
	.cfi_restore 22
	.cfi_restore 23
	.cfi_restore 24
	.cfi_restore 26
	.cfi_restore 27
	slli	a5,a0,32
	slli	s9,a1,32
	srli	a5,a5,32
	lui	a4,%hi(buildin_funcptr)
	ld	ra,104(sp)
	.cfi_restore 1
	or	a5,a5,s9
	ld	a4,%lo(buildin_funcptr)(a4)
	ld	s9,24(sp)
	.cfi_restore 25
	lui	a3,%hi(.LANCHOR0)
	sd	a5,%lo(.LANCHOR0)(a3)
	addi	sp,sp,112
	.cfi_def_cfa_offset 0
	jr	a4
	.cfi_endproc
.LFE2880:
	.size	buildin_NotifyWorkerLT, .-buildin_NotifyWorkerLT
	.align	1
	.globl	buildin_NotifyWorkerLE
	.type	buildin_NotifyWorkerLE, @function
buildin_NotifyWorkerLE:
.LFB2881:
	.cfi_startproc
	addi	sp,sp,-112
	.cfi_def_cfa_offset 112
	sd	s9,24(sp)
	sd	ra,104(sp)
	sub	a5,a1,a0
	li	a4,62
	.cfi_offset 25, -88
	.cfi_offset 1, -8
	mv	s9,a1
	ble	a5,a4,.L40
	sd	s3,72(sp)
	sd	s8,32(sp)
	sd	s10,16(sp)
	addi	a5,a5,4
	.cfi_offset 19, -40
	.cfi_offset 24, -80
	.cfi_offset 26, -96
	mv	s8,a0
	srai	s3,a5,2
	lui	s10,%hi(_ZL5tasks)
	ble	a1,a0,.L27
	sd	s0,96(sp)
	.cfi_offset 8, -16
	lui	s0,%hi(_ZL5empty)
	addi	s0,s0,%lo(_ZL5empty)
	sd	s1,88(sp)
	.cfi_offset 9, -24
	andi	s1,s0,3
	sd	s4,64(sp)
	sd	s5,56(sp)
	sd	s6,48(sp)
	.cfi_offset 20, -48
	.cfi_offset 21, -56
	.cfi_offset 22, -64
	li	s5,1
	slliw	s1,s1,3
	lui	s6,%hi(.LANCHOR0)
	li	s4,-1
	sd	s2,80(sp)
	sd	s7,40(sp)
	sd	s11,8(sp)
	.cfi_offset 18, -32
	.cfi_offset 23, -72
	.cfi_offset 27, -104
	addi	s6,s6,%lo(.LANCHOR0)
	lui	s10,%hi(_ZL5tasks)
	srli	s4,s4,32
	andi	s0,s0,-4
	sllw	s2,s5,s1
	lui	s7,%hi(_ZL4full)
	lui	s11,%hi(buildin_funcptr)
.L32:
	mv	a3,s8
	add	s8,s8,s3
	slli	a4,a3,32
	addi	a5,s8,-1
	srli	a4,a4,32
	ble	a5,s9,.L28
	mv	a5,s9
.L28:
	slli	a5,a5,32
	and	a4,a4,s4
	or	a4,a4,a5
.L29:
	fence iorw,ow; amoor.w.aq a5,s2,0(s0)
	srlw	a5,a5,s1
	andi	a5,a5,0xff
	bne	a5,zero,.L29
	sd	a4,0(s6)
	addi	a5,s10,%lo(_ZL5tasks)
	fence iorw,ow; amoadd.w.aq zero,s5,0(a5)
	blt	a3,zero,.L30
	ld	a5,%lo(buildin_funcptr)(s11)
	jalr	a5
	bgt	s9,s8,.L32
.L41:
	ld	s0,96(sp)
	.cfi_restore 8
	ld	s1,88(sp)
	.cfi_restore 9
	ld	s2,80(sp)
	.cfi_restore 18
	ld	s4,64(sp)
	.cfi_restore 20
	ld	s5,56(sp)
	.cfi_restore 21
	ld	s6,48(sp)
	.cfi_restore 22
	ld	s7,40(sp)
	.cfi_restore 23
	ld	s11,8(sp)
	.cfi_restore 27
.L27:
	lui	a3,%hi(_ZL9task_done)
.L33:
	fence	iorw,iorw
	lw	a5,%lo(_ZL9task_done)(a3)
	fence	iorw,iorw
	fence	iorw,iorw
	sext.w	a5,a5
	lw	a4,%lo(_ZL5tasks)(s10)
	fence	iorw,iorw
	bne	a5,a4,.L33
	ld	ra,104(sp)
	.cfi_restore 1
	ld	s3,72(sp)
	.cfi_restore 19
	ld	s8,32(sp)
	.cfi_restore 24
	ld	s10,16(sp)
	.cfi_restore 26
	ld	s9,24(sp)
	.cfi_restore 25
	addi	sp,sp,112
	.cfi_def_cfa_offset 0
	jr	ra
.L30:
	.cfi_def_cfa_offset 112
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	.cfi_offset 9, -24
	.cfi_offset 18, -32
	.cfi_offset 19, -40
	.cfi_offset 20, -48
	.cfi_offset 21, -56
	.cfi_offset 22, -64
	.cfi_offset 23, -72
	.cfi_offset 24, -80
	.cfi_offset 25, -88
	.cfi_offset 26, -96
	.cfi_offset 27, -104
	fence	iorw,iorw
	sb	zero,%lo(_ZL4full)(s7)
	fence	iorw,iorw
	bgt	s9,s8,.L32
	j	.L41
.L40:
	.cfi_restore 8
	.cfi_restore 9
	.cfi_restore 18
	.cfi_restore 19
	.cfi_restore 20
	.cfi_restore 21
	.cfi_restore 22
	.cfi_restore 23
	.cfi_restore 24
	.cfi_restore 26
	.cfi_restore 27
	slli	a5,a0,32
	slli	s9,a1,32
	srli	a5,a5,32
	lui	a4,%hi(buildin_funcptr)
	ld	ra,104(sp)
	.cfi_restore 1
	or	a5,a5,s9
	ld	a4,%lo(buildin_funcptr)(a4)
	ld	s9,24(sp)
	.cfi_restore 25
	lui	a3,%hi(.LANCHOR0)
	sd	a5,%lo(.LANCHOR0)(a3)
	addi	sp,sp,112
	.cfi_def_cfa_offset 0
	jr	a4
	.cfi_endproc
.LFE2881:
	.size	buildin_NotifyWorkerLE, .-buildin_NotifyWorkerLE
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	_Z12CreateThreadv
	.type	_Z12CreateThreadv, @function
_Z12CreateThreadv:
.LFB2883:
	.cfi_startproc
	lui	a4,%hi(_ZL4full)
	addi	a4,a4,%lo(_ZL4full)
	andi	a3,a4,3
	addi	sp,sp,-64
	.cfi_def_cfa_offset 64
	slliw	a3,a3,3
	li	a2,1
	sd	ra,56(sp)
	sd	s0,48(sp)
	sd	s1,40(sp)
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	.cfi_offset 9, -24
	andi	a4,a4,-4
	sllw	a2,a2,a3
.L43:
	fence iorw,ow; amoor.w.aq a5,a2,0(a4)
	srlw	a5,a5,a3
	andi	a5,a5,0xff
	bne	a5,zero,.L43
	addi	s0,sp,8
	lui	s1,%hi(_Z12WorkerThreadPv)
.L44:
	li	a3,0
	addi	a2,s1,%lo(_Z12WorkerThreadPv)
	li	a1,0
	mv	a0,s0
	call	pthread_create
	ld	a0,0(s0)
	addi	s0,s0,8
	call	pthread_detach
	addi	a5,sp,32
	bne	s0,a5,.L44
	ld	ra,56(sp)
	.cfi_restore 1
	ld	s0,48(sp)
	.cfi_restore 8
	ld	s1,40(sp)
	.cfi_restore 9
	addi	sp,sp,64
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE2883:
	.size	_Z12CreateThreadv, .-_Z12CreateThreadv
	.section	.init_array,"aw"
	.align	3
	.dword	_Z12CreateThreadv
	.text
	.align	1
	.globl	buildin_AtomicF32add
	.type	buildin_AtomicF32add, @function
buildin_AtomicF32add:
.LFB2884:
	.cfi_startproc
.L49:
	lw	a4,0(a0)
	fmv.s.x	fa5,a4
	fadd.s	fa5,fa5,fa0
	fmv.x.s	a3,fa5
	fence iorw,ow;  1: lr.w.aq a5,0(a0); bne a5,a4,1f; sc.w.aq a2,a3,0(a0); bnez a2,1b; 1:
	subw	a5,a5,a4
	bne	a5,zero,.L49
	ret
	.cfi_endproc
.LFE2884:
	.size	buildin_AtomicF32add, .-buildin_AtomicF32add
	.globl	buildin_funcptr
	.globl	buildin_parallel_arg_storage
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	buildin_parallel_arg_storage, @object
	.size	buildin_parallel_arg_storage, 512
buildin_parallel_arg_storage:
	.zero	512
	.section	.sbss,"aw",@nobits
	.align	3
	.type	_ZL9task_done, @object
	.size	_ZL9task_done, 4
_ZL9task_done:
	.zero	4
	.zero	4
	.type	_ZL5tasks, @object
	.size	_ZL5tasks, 4
_ZL5tasks:
	.zero	4
	.zero	4
	.type	_ZL4full, @object
	.size	_ZL4full, 1
_ZL4full:
	.zero	1
	.zero	7
	.type	_ZL5empty, @object
	.size	_ZL5empty, 1
_ZL5empty:
	.zero	1
	.zero	7
	.type	buildin_funcptr, @object
	.size	buildin_funcptr, 8
buildin_funcptr:
	.zero	8
	.ident	"GCC: () 13.2.0"
	.section	.note.GNU-stack,"",@progbits
