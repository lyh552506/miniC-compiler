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
.LFB345:
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
	lui	s0,%hi(full)
	addi	s0,s0,%lo(full)
	ld	a0,%lo(stdout)(s4)
	andi	s1,s0,3
	li	s5,1
	slliw	s1,s1,3
	call	fflush
	lui	s7,%hi(func)
	lui	s3,%hi(task_done)
	lui	s6,%hi(.LC1)
	andi	s0,s0,-4
	sllw	s2,s5,s1
.L2:
	fence iorw,ow; amoor.w.aq a5,s2,0(s0)
	srlw	a5,a5,s1
	andi	a5,a5,0xff
	bne	a5,zero,.L2
	ld	a5,%lo(func)(s7)
	jalr	a5
	fence	iorw,iorw
	lw	a1,%lo(task_done)(s3)
	fence	iorw,iorw
	addi	a0,s6,%lo(.LC1)
	call	printf
	ld	a0,%lo(stdout)(s4)
	call	fflush
	addi	a5,s3,%lo(task_done)
	fence iorw,ow; amoadd.w.aq zero,s5,0(a5)
	j	.L2
	.cfi_endproc
.LFE345:
	.size	_Z12WorkerThreadPv, .-_Z12WorkerThreadPv
	.align	1
	.globl	_Z14FenceArgLoadedv
	.type	_Z14FenceArgLoadedv, @function
_Z14FenceArgLoadedv:
.LFB340:
	.cfi_startproc
	fence	iorw,iorw
	lui	a5,%hi(empty)
	sb	zero,%lo(empty)(a5)
	fence	iorw,iorw
	ret
	.cfi_endproc
.LFE340:
	.size	_Z14FenceArgLoadedv, .-_Z14FenceArgLoadedv
	.align	1
	.globl	_Z18WaitTasksCompletedv
	.type	_Z18WaitTasksCompletedv, @function
_Z18WaitTasksCompletedv:
.LFB341:
	.cfi_startproc
	lui	a2,%hi(task_done)
	lui	a3,%hi(tasks)
.L9:
	fence	iorw,iorw
	lw	a5,%lo(task_done)(a2)
	fence	iorw,iorw
	fence	iorw,iorw
	sext.w	a5,a5
	lw	a4,%lo(tasks)(a3)
	fence	iorw,iorw
	bne	a4,a5,.L9
	ret
	.cfi_endproc
.LFE341:
	.size	_Z18WaitTasksCompletedv, .-_Z18WaitTasksCompletedv
	.align	1
	.globl	_Z14WaitBufferReadv
	.type	_Z14WaitBufferReadv, @function
_Z14WaitBufferReadv:
.LFB342:
	.cfi_startproc
	lui	a4,%hi(full)
	addi	a4,a4,%lo(full)
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	andi	a3,a4,3
	sd	s1,8(sp)
	slliw	a3,a3,3
	.cfi_offset 9, -24
	li	s1,1
	sd	ra,24(sp)
	sd	s0,16(sp)
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	andi	a4,a4,-4
	sllw	a2,s1,a3
.L12:
	fence iorw,ow; amoor.w.aq a5,a2,0(a4)
	srlw	a5,a5,a3
	andi	a5,a5,0xff
	bne	a5,zero,.L12
	lui	a5,%hi(func)
	ld	a5,%lo(func)(a5)
	lui	s0,%hi(task_done)
	jalr	a5
	fence	iorw,iorw
	lw	a1,%lo(task_done)(s0)
	fence	iorw,iorw
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	printf
	lui	a5,%hi(stdout)
	ld	a0,%lo(stdout)(a5)
	call	fflush
	addi	a5,s0,%lo(task_done)
	fence iorw,ow; amoadd.w.aq zero,s1,0(a5)
	ld	ra,24(sp)
	.cfi_restore 1
	ld	s0,16(sp)
	.cfi_restore 8
	ld	s1,8(sp)
	.cfi_restore 9
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE342:
	.size	_Z14WaitBufferReadv, .-_Z14WaitBufferReadv
	.align	1
	.globl	_Z15WaitBufferWritev
	.type	_Z15WaitBufferWritev, @function
_Z15WaitBufferWritev:
.LFB343:
	.cfi_startproc
	lui	a4,%hi(empty)
	addi	a4,a4,%lo(empty)
	andi	a3,a4,3
	slliw	a3,a3,3
	li	a2,1
	andi	a4,a4,-4
	sllw	a2,a2,a3
.L16:
	fence iorw,ow; amoor.w.aq a5,a2,0(a4)
	srlw	a5,a5,a3
	andi	a5,a5,0xff
	bne	a5,zero,.L16
	ret
	.cfi_endproc
.LFE343:
	.size	_Z15WaitBufferWritev, .-_Z15WaitBufferWritev
	.align	1
	.globl	_Z12NotifyWorkerv
	.type	_Z12NotifyWorkerv, @function
_Z12NotifyWorkerv:
.LFB344:
	.cfi_startproc
	lui	a5,%hi(tasks)
	li	a4,1
	addi	a5,a5,%lo(tasks)
	fence iorw,ow; amoadd.w.aq zero,a4,0(a5)
	fence	iorw,iorw
	lui	a5,%hi(full)
	sb	zero,%lo(full)(a5)
	fence	iorw,iorw
	ret
	.cfi_endproc
.LFE344:
	.size	_Z12NotifyWorkerv, .-_Z12NotifyWorkerv
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	_Z12CreateThreadv
	.type	_Z12CreateThreadv, @function
_Z12CreateThreadv:
.LFB346:
	.cfi_startproc
	lui	a4,%hi(full)
	addi	a4,a4,%lo(full)
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
.LFE346:
	.size	_Z12CreateThreadv, .-_Z12CreateThreadv
	.section	.init_array,"aw"
	.align	3
	.dword	_Z12CreateThreadv
	.globl	task_done
	.globl	tasks
	.globl	full
	.globl	empty
	.globl	func
	.globl	parallel_arg_storage
	.bss
	.align	3
	.type	parallel_arg_storage, @object
	.size	parallel_arg_storage, 512
parallel_arg_storage:
	.zero	512
	.section	.sbss,"aw",@nobits
	.align	3
	.type	task_done, @object
	.size	task_done, 4
task_done:
	.zero	4
	.zero	4
	.type	tasks, @object
	.size	tasks, 4
tasks:
	.zero	4
	.zero	4
	.type	full, @object
	.size	full, 1
full:
	.zero	1
	.zero	7
	.type	empty, @object
	.size	empty, 1
empty:
	.zero	1
	.zero	7
	.type	func, @object
	.size	func, 8
func:
	.zero	8
	.ident	"GCC: () 13.2.0"
	.section	.note.GNU-stack,"",@progbits
