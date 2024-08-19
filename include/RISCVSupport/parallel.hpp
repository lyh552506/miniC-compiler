R"(	.text
    .align  1
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
	sub	a5,a1,a0
	li	a4,63
	mv	a6,a0
	ble	a5,a4,.L20
	addi	a5,a5,3
	srai	t1,a5,2
	lui	a7,%hi(_ZL5tasks)
	ble	a1,a0,.L10
	lui	a4,%hi(_ZL5empty)
	addi	a4,a4,%lo(_ZL5empty)
	andi	a3,a4,3
	li	t5,1
	slliw	a3,a3,3
	lui	t4,%hi(.LANCHOR0)
	li	t3,-1
	addi	t4,t4,%lo(.LANCHOR0)
	lui	a7,%hi(_ZL5tasks)
	lui	t6,%hi(_ZL4full)
	srli	t3,t3,32
	andi	a4,a4,-4
	sllw	a2,t5,a3
.L13:
	mv	a0,a6
	slli	a0,a0,32
	add	a6,a6,t1
	srli	a0,a0,32
	mv	a5,a1
	ble	a1,a6,.L11
	mv	a5,a6
.L11:
	slli	a5,a5,32
	and	a0,a0,t3
	or	a0,a0,a5
.L12:
	fence iorw,ow; amoor.w.aq a5,a2,0(a4)
	srlw	a5,a5,a3
	andi	a5,a5,0xff
	bne	a5,zero,.L12
	sd	a0,0(t4)
	addi	a5,a7,%lo(_ZL5tasks)
	fence iorw,ow; amoadd.w.aq zero,t5,0(a5)
	fence	iorw,iorw
	sb	zero,%lo(_ZL4full)(t6)
	fence	iorw,iorw
	bgt	a1,a6,.L13
.L10:
	lui	a3,%hi(_ZL9task_done)
.L14:
	fence	iorw,iorw
	lw	a5,%lo(_ZL9task_done)(a3)
	fence	iorw,iorw
	fence	iorw,iorw
	sext.w	a5,a5
	lw	a4,%lo(_ZL5tasks)(a7)
	fence	iorw,iorw
	bne	a5,a4,.L14
	ret
.L20:
	slli	a5,a0,32
	lui	a4,%hi(buildin_funcptr)
	slli	a1,a1,32
	srli	a5,a5,32
	ld	a4,%lo(buildin_funcptr)(a4)
	or	a5,a5,a1
	lui	a3,%hi(.LANCHOR0)
	sd	a5,%lo(.LANCHOR0)(a3)
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
	sub	a5,a1,a0
	li	a4,62
	mv	a6,a0
	ble	a5,a4,.L33
	addi	a5,a5,4
	srai	t1,a5,2
	lui	a7,%hi(_ZL5tasks)
	ble	a1,a0,.L23
	lui	a4,%hi(_ZL5empty)
	addi	a4,a4,%lo(_ZL5empty)
	andi	a3,a4,3
	li	t5,1
	slliw	a3,a3,3
	lui	t4,%hi(.LANCHOR0)
	li	t3,-1
	addi	t4,t4,%lo(.LANCHOR0)
	lui	a7,%hi(_ZL5tasks)
	lui	t6,%hi(_ZL4full)
	srli	t3,t3,32
	andi	a4,a4,-4
	sllw	a2,t5,a3
.L26:
	mv	a0,a6
	add	a6,a6,t1
	slli	a0,a0,32
	addi	a5,a6,-1
	srli	a0,a0,32
	ble	a5,a1,.L24
	mv	a5,a1
.L24:
	slli	a5,a5,32
	and	a0,a0,t3
	or	a0,a0,a5
.L25:
	fence iorw,ow; amoor.w.aq a5,a2,0(a4)
	srlw	a5,a5,a3
	andi	a5,a5,0xff
	bne	a5,zero,.L25
	sd	a0,0(t4)
	addi	a5,a7,%lo(_ZL5tasks)
	fence iorw,ow; amoadd.w.aq zero,t5,0(a5)
	fence	iorw,iorw
	sb	zero,%lo(_ZL4full)(t6)
	fence	iorw,iorw
	bgt	a1,a6,.L26
.L23:
	lui	a3,%hi(_ZL9task_done)
.L27:
	fence	iorw,iorw
	lw	a5,%lo(_ZL9task_done)(a3)
	fence	iorw,iorw
	fence	iorw,iorw
	sext.w	a5,a5
	lw	a4,%lo(_ZL5tasks)(a7)
	fence	iorw,iorw
	bne	a5,a4,.L27
	ret
.L33:
	slli	a5,a0,32
	lui	a4,%hi(buildin_funcptr)
	slli	a1,a1,32
	srli	a5,a5,32
	ld	a4,%lo(buildin_funcptr)(a4)
	or	a5,a5,a1
	lui	a3,%hi(.LANCHOR0)
	sd	a5,%lo(.LANCHOR0)(a3)
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
	sd	s2,32(sp)
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	.cfi_offset 9, -24
	.cfi_offset 18, -32
	andi	a4,a4,-4
	sllw	a2,a2,a3
.L35:
	fence iorw,ow; amoor.w.aq a5,a2,0(a4)
	srlw	a5,a5,a3
	andi	a5,a5,0xff
	bne	a5,zero,.L35
	mv	s0,sp
	addi	s2,sp,32
	lui	s1,%hi(_Z12WorkerThreadPv)
.L36:
	li	a3,0
	addi	a2,s1,%lo(_Z12WorkerThreadPv)
	li	a1,0
	mv	a0,s0
	call	pthread_create
	ld	a0,0(s0)
	addi	s0,s0,8
	call	pthread_detach
	bne	s0,s2,.L36
	ld	ra,56(sp)
	.cfi_restore 1
	ld	s0,48(sp)
	.cfi_restore 8
	ld	s1,40(sp)
	.cfi_restore 9
	ld	s2,32(sp)
	.cfi_restore 18
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
.L41:
	lw	a4,0(a0)
	fmv.s.x	fa5,a4
	fadd.s	fa5,fa5,fa0
	fmv.x.s	a3,fa5
	fence iorw,ow;  1: lr.w.aq a5,0(a0); bne a5,a4,1f; sc.w.aq a2,a3,0(a0); bnez a2,1b; 1:
	subw	a5,a5,a4
	bne	a5,zero,.L41
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
)"