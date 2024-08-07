	.file	"parallel_lib.cpp"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"work thread created"
	.align	3
.LC1:
	.string	"task %d done\n"
	.text
	.align	1
	.globl	_Z12WorkerThreadPv
	.type	_Z12WorkerThreadPv, @function
_Z12WorkerThreadPv:
.LFB1313:
	.cfi_startproc
	lui	a0,%hi(.LC0)
	addi	sp,sp,-80
	.cfi_def_cfa_offset 80
	addi	a0,a0,%lo(.LC0)
	sd	ra,72(sp)
	sd	s0,64(sp)
	sd	s1,56(sp)
	sd	s2,48(sp)
	sd	s3,40(sp)
	sd	s4,32(sp)
	sd	s5,24(sp)
	sd	s6,16(sp)
	sd	s7,8(sp)
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	.cfi_offset 9, -24
	.cfi_offset 18, -32
	.cfi_offset 19, -40
	.cfi_offset 20, -48
	.cfi_offset 21, -56
	.cfi_offset 22, -64
	.cfi_offset 23, -72
	lui	s4,%hi(stdout)
	call	puts
	lui	s0,%hi(_ZL4full)
	addi	s0,s0,%lo(_ZL4full)
	ld	a0,%lo(stdout)(s4)
	andi	s1,s0,3
	li	s5,1
	slliw	s1,s1,3
	call	fflush
	lui	s7,%hi(buildin_funcptr)
	lui	s3,%hi(_ZL9task_done)
	lui	s6,%hi(.LC1)
	andi	s0,s0,-4
	sllw	s2,s5,s1
.L2:
	fence iorw,ow; amoor.w.aq a5,s2,0(s0)
	srlw	a5,a5,s1
	andi	a5,a5,0xff
	bne	a5,zero,.L2
	ld	a5,%lo(buildin_funcptr)(s7)
	jalr	a5
	fence	iorw,iorw
	lw	a1,%lo(_ZL9task_done)(s3)
	fence	iorw,iorw
	addi	a0,s6,%lo(.LC1)
	call	printf
	ld	a0,%lo(stdout)(s4)
	call	fflush
	addi	a5,s3,%lo(_ZL9task_done)
	fence iorw,ow; amoadd.w.aq zero,s5,0(a5)
	j	.L2
	.cfi_endproc
.LFE1313:
	.size	_Z12WorkerThreadPv, .-_Z12WorkerThreadPv
	.align	1
	.globl	buildin_FenceArgLoaded
	.type	buildin_FenceArgLoaded, @function
buildin_FenceArgLoaded:
.LFB1308:
	.cfi_startproc
	fence	iorw,iorw
	lui	a5,%hi(_ZL5empty)
	sb	zero,%lo(_ZL5empty)(a5)
	fence	iorw,iorw
	ret
	.cfi_endproc
.LFE1308:
	.size	buildin_FenceArgLoaded, .-buildin_FenceArgLoaded
	.align	1
	.globl	buildin_NotifyWorker
	.type	buildin_NotifyWorker, @function
buildin_NotifyWorker:
.LFB1312:
	.cfi_startproc
	sub	a5,a1,a0
	srai	t1,a5,63
	andi	t1,t1,3
	add	t1,t1,a5
	srai	t1,t1,2
	lui	a7,%hi(_ZL5tasks)
	ble	a1,a0,.L9
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
.L12:
	mv	a6,a0
	slli	a6,a6,32
	add	a0,a0,t1
	srli	a6,a6,32
	mv	a5,a1
	ble	a1,a0,.L10
	mv	a5,a0
.L10:
	slli	a5,a5,32
	and	a6,a6,t3
	or	a6,a6,a5
.L11:
	fence iorw,ow; amoor.w.aq a5,a2,0(a4)
	srlw	a5,a5,a3
	andi	a5,a5,0xff
	bne	a5,zero,.L11
	sd	a6,0(t4)
	addi	a5,a7,%lo(_ZL5tasks)
	fence iorw,ow; amoadd.w.aq zero,t5,0(a5)
	fence	iorw,iorw
	sb	zero,%lo(_ZL4full)(t6)
	fence	iorw,iorw
	bgt	a1,a0,.L12
.L9:
	lui	a3,%hi(_ZL9task_done)
.L13:
	fence	iorw,iorw
	lw	a5,%lo(_ZL9task_done)(a3)
	fence	iorw,iorw
	fence	iorw,iorw
	sext.w	a5,a5
	lw	a4,%lo(_ZL5tasks)(a7)
	fence	iorw,iorw
	bne	a5,a4,.L13
	ret
	.cfi_endproc
.LFE1312:
	.size	buildin_NotifyWorker, .-buildin_NotifyWorker
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	_Z12CreateThreadv
	.type	_Z12CreateThreadv, @function
_Z12CreateThreadv:
.LFB1314:
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
.L20:
	fence iorw,ow; amoor.w.aq a5,a2,0(a4)
	srlw	a5,a5,a3
	andi	a5,a5,0xff
	bne	a5,zero,.L20
	mv	s0,sp
	addi	s2,sp,32
	lui	s1,%hi(_Z12WorkerThreadPv)
.L21:
	li	a3,0
	addi	a2,s1,%lo(_Z12WorkerThreadPv)
	li	a1,0
	mv	a0,s0
	call	pthread_create
	ld	a0,0(s0)
	addi	s0,s0,8
	call	pthread_detach
	bne	s0,s2,.L21
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
.LFE1314:
	.size	_Z12CreateThreadv, .-_Z12CreateThreadv
	.section	.init_array,"aw"
	.align	3
	.dword	_Z12CreateThreadv
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
