	.text
	.file	"test.c.ll"
	.globl	getint                          # -- Begin function getint
	.p2align	4, 0x90
	.type	getint,@function
getint:                                 # @getint
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	leaq	4(%rsp), %rsi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	__isoc99_scanf
	movl	4(%rsp), %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	getint, .Lfunc_end0-getint
	.cfi_endproc
                                        # -- End function
	.globl	getch                           # -- Begin function getch
	.p2align	4, 0x90
	.type	getch,@function
getch:                                  # @getch
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	leaq	7(%rsp), %rsi
	movl	$.L.str.1, %edi
	xorl	%eax, %eax
	callq	__isoc99_scanf
	movsbl	7(%rsp), %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	getch, .Lfunc_end1-getch
	.cfi_endproc
                                        # -- End function
	.globl	getfloat                        # -- Begin function getfloat
	.p2align	4, 0x90
	.type	getfloat,@function
getfloat:                               # @getfloat
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	leaq	4(%rsp), %rsi
	movl	$.L.str.2, %edi
	xorl	%eax, %eax
	callq	__isoc99_scanf
	movss	4(%rsp), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	getfloat, .Lfunc_end2-getfloat
	.cfi_endproc
                                        # -- End function
	.globl	getarray                        # -- Begin function getarray
	.p2align	4, 0x90
	.type	getarray,@function
getarray:                               # @getarray
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rdi, %r14
	leaq	4(%rsp), %rsi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	__isoc99_scanf
	movl	4(%rsp), %eax
	testl	%eax, %eax
	jle	.LBB3_3
# %bb.1:                                # %for.body.preheader
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB3_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$.L.str, %edi
	movq	%r14, %rsi
	xorl	%eax, %eax
	callq	__isoc99_scanf
	incq	%rbx
	movslq	4(%rsp), %rax
	addq	$4, %r14
	cmpq	%rax, %rbx
	jl	.LBB3_2
.LBB3_3:                                # %for.cond.cleanup
                                        # kill: def $eax killed $eax killed $rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	getarray, .Lfunc_end3-getarray
	.cfi_endproc
                                        # -- End function
	.globl	getfarray                       # -- Begin function getfarray
	.p2align	4, 0x90
	.type	getfarray,@function
getfarray:                              # @getfarray
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rdi, %r14
	leaq	4(%rsp), %rsi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	__isoc99_scanf
	movl	4(%rsp), %eax
	testl	%eax, %eax
	jle	.LBB4_3
# %bb.1:                                # %for.body.preheader
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB4_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$.L.str.2, %edi
	movq	%r14, %rsi
	xorl	%eax, %eax
	callq	__isoc99_scanf
	incq	%rbx
	movslq	4(%rsp), %rax
	addq	$4, %r14
	cmpq	%rax, %rbx
	jl	.LBB4_2
.LBB4_3:                                # %for.cond.cleanup
                                        # kill: def $eax killed $eax killed $rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	getfarray, .Lfunc_end4-getfarray
	.cfi_endproc
                                        # -- End function
	.globl	putint                          # -- Begin function putint
	.p2align	4, 0x90
	.type	putint,@function
putint:                                 # @putint
	.cfi_startproc
# %bb.0:                                # %entry
	movl	%edi, %esi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	jmp	printf                          # TAILCALL
.Lfunc_end5:
	.size	putint, .Lfunc_end5-putint
	.cfi_endproc
                                        # -- End function
	.globl	putch                           # -- Begin function putch
	.p2align	4, 0x90
	.type	putch,@function
putch:                                  # @putch
	.cfi_startproc
# %bb.0:                                # %entry
	jmp	putchar@PLT                     # TAILCALL
.Lfunc_end6:
	.size	putch, .Lfunc_end6-putch
	.cfi_endproc
                                        # -- End function
	.globl	putarray                        # -- Begin function putarray
	.p2align	4, 0x90
	.type	putarray,@function
putarray:                               # @putarray
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r14
	movl	%edi, %ebp
	movl	$.L.str.3, %edi
	movl	%ebp, %esi
	xorl	%eax, %eax
	callq	printf
	testl	%ebp, %ebp
	jle	.LBB7_3
# %bb.1:                                # %for.body.preheader
	movl	%ebp, %ebp
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB7_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	(%r14,%rbx,4), %esi
	movl	$.L.str.4, %edi
	xorl	%eax, %eax
	callq	printf
	incq	%rbx
	cmpq	%rbx, %rbp
	jne	.LBB7_2
.LBB7_3:                                # %for.cond.cleanup
	movl	$10, %edi
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	putchar@PLT                     # TAILCALL
.Lfunc_end7:
	.size	putarray, .Lfunc_end7-putarray
	.cfi_endproc
                                        # -- End function
	.globl	putfloat                        # -- Begin function putfloat
	.p2align	4, 0x90
	.type	putfloat,@function
putfloat:                               # @putfloat
	.cfi_startproc
# %bb.0:                                # %entry
	cvtss2sd	%xmm0, %xmm0
	movl	$.L.str.2, %edi
	movb	$1, %al
	jmp	printf                          # TAILCALL
.Lfunc_end8:
	.size	putfloat, .Lfunc_end8-putfloat
	.cfi_endproc
                                        # -- End function
	.globl	putfarray                       # -- Begin function putfarray
	.p2align	4, 0x90
	.type	putfarray,@function
putfarray:                              # @putfarray
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r14
	movl	%edi, %ebp
	movl	$.L.str.3, %edi
	movl	%ebp, %esi
	xorl	%eax, %eax
	callq	printf
	testl	%ebp, %ebp
	jle	.LBB9_3
# %bb.1:                                # %for.body.preheader
	movl	%ebp, %ebp
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB9_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movss	(%r14,%rbx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movl	$.L.str.6, %edi
	movb	$1, %al
	callq	printf
	incq	%rbx
	cmpq	%rbx, %rbp
	jne	.LBB9_2
.LBB9_3:                                # %for.cond.cleanup
	movl	$10, %edi
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	putchar@PLT                     # TAILCALL
.Lfunc_end9:
	.size	putfarray, .Lfunc_end9-putfarray
	.cfi_endproc
                                        # -- End function
	.globl	before_main                     # -- Begin function before_main
	.p2align	4, 0x90
	.type	before_main,@function
before_main:                            # @before_main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$_sysy_us, %edi
	movl	$4096, %edx                     # imm = 0x1000
	xorl	%esi, %esi
	callq	memset@PLT
	movl	$_sysy_s, %edi
	movl	$4096, %edx                     # imm = 0x1000
	xorl	%esi, %esi
	callq	memset@PLT
	movl	$_sysy_m, %edi
	movl	$4096, %edx                     # imm = 0x1000
	xorl	%esi, %esi
	callq	memset@PLT
	movl	$_sysy_h, %edi
	movl	$4096, %edx                     # imm = 0x1000
	xorl	%esi, %esi
	callq	memset@PLT
	movl	$1, _sysy_idx(%rip)
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end10:
	.size	before_main, .Lfunc_end10-before_main
	.cfi_endproc
                                        # -- End function
	.globl	after_main                      # -- Begin function after_main
	.p2align	4, 0x90
	.type	after_main,@function
after_main:                             # @after_main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	cmpl	$2, _sysy_idx(%rip)
	movq	stderr(%rip), %rdi
	jl	.LBB11_3
# %bb.1:                                # %for.body.preheader
	movl	$1, %ebx
	.p2align	4, 0x90
.LBB11_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	_sysy_l1(,%rbx,4), %edx
	movl	_sysy_l2(,%rbx,4), %ecx
	movl	_sysy_h(,%rbx,4), %r8d
	movl	_sysy_m(,%rbx,4), %r9d
	movl	_sysy_s(,%rbx,4), %r10d
	movl	_sysy_us(,%rbx,4), %r11d
	movl	$.L.str.7, %esi
	xorl	%eax, %eax
	pushq	%r11
	.cfi_adjust_cfa_offset 8
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	callq	fprintf
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	movl	_sysy_us(%rip), %eax
	addl	_sysy_us(,%rbx,4), %eax
	movl	_sysy_s(%rip), %ecx
	addl	_sysy_s(,%rbx,4), %ecx
	movslq	%eax, %r9
	imulq	$1125899907, %r9, %rax          # imm = 0x431BDE83
	movq	%rax, %rdx
	shrq	$63, %rdx
	shrq	$32, %rax
	sarl	$18, %eax
	addl	%edx, %eax
	imull	$1000000, %eax, %eax            # imm = 0xF4240
	subl	%eax, %r9d
	movl	%r9d, _sysy_us(%rip)
	movl	_sysy_m(%rip), %eax
	addl	_sysy_m(,%rbx,4), %eax
	movslq	%ecx, %r8
	imulq	$-2004318071, %r8, %rcx         # imm = 0x88888889
	shrq	$32, %rcx
	addl	%r8d, %ecx
	movl	%ecx, %edx
	shrl	$31, %edx
	sarl	$5, %ecx
	addl	%edx, %ecx
	imull	$60, %ecx, %ecx
	subl	%ecx, %r8d
	movl	%r8d, _sysy_s(%rip)
	movl	_sysy_h(%rip), %edx
	addl	_sysy_h(,%rbx,4), %edx
	movl	%edx, _sysy_h(%rip)
	movslq	%eax, %rcx
	imulq	$-2004318071, %rcx, %rax        # imm = 0x88888889
	shrq	$32, %rax
	addl	%ecx, %eax
	movl	%eax, %esi
	shrl	$31, %esi
	sarl	$5, %eax
	addl	%esi, %eax
	imull	$60, %eax, %eax
	subl	%eax, %ecx
	movl	%ecx, _sysy_m(%rip)
	incq	%rbx
	movslq	_sysy_idx(%rip), %rax
	movq	stderr(%rip), %rdi
	cmpq	%rax, %rbx
	jl	.LBB11_2
	jmp	.LBB11_4
.LBB11_3:                               # %entry.for.cond.cleanup_crit_edge
	movl	_sysy_h(%rip), %edx
	movl	_sysy_m(%rip), %ecx
	movl	_sysy_s(%rip), %r8d
	movl	_sysy_us(%rip), %r9d
.LBB11_4:                               # %for.cond.cleanup
	movl	$.L.str.8, %esi
                                        # kill: def $ecx killed $ecx killed $rcx
                                        # kill: def $r8d killed $r8d killed $r8
                                        # kill: def $r9d killed $r9d killed $r9
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	fprintf                         # TAILCALL
.Lfunc_end11:
	.size	after_main, .Lfunc_end11-after_main
	.cfi_endproc
                                        # -- End function
	.globl	_sysy_starttime                 # -- Begin function _sysy_starttime
	.p2align	4, 0x90
	.type	_sysy_starttime,@function
_sysy_starttime:                        # @_sysy_starttime
	.cfi_startproc
# %bb.0:                                # %entry
	movslq	_sysy_idx(%rip), %rax
	movl	%edi, _sysy_l1(,%rax,4)
	movl	$_sysy_start, %edi
	xorl	%esi, %esi
	jmp	gettimeofday                    # TAILCALL
.Lfunc_end12:
	.size	_sysy_starttime, .Lfunc_end12-_sysy_starttime
	.cfi_endproc
                                        # -- End function
	.globl	_sysy_stoptime                  # -- Begin function _sysy_stoptime
	.p2align	4, 0x90
	.type	_sysy_stoptime,@function
_sysy_stoptime:                         # @_sysy_stoptime
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movl	%edi, %ebx
	movl	$_sysy_end, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movslq	_sysy_idx(%rip), %rax
	movl	_sysy_end(%rip), %ecx
	subl	_sysy_start(%rip), %ecx
	imull	$1000000, %ecx, %ecx            # imm = 0xF4240
	addl	_sysy_end+8(%rip), %ecx
	subl	_sysy_start+8(%rip), %ecx
	addl	_sysy_us(,%rax,4), %ecx
	movslq	%ecx, %rcx
	imulq	$1125899907, %rcx, %rdx         # imm = 0x431BDE83
	movq	%rdx, %rsi
	shrq	$63, %rsi
	shrq	$32, %rdx
	sarl	$18, %edx
	addl	%esi, %edx
	imull	$1000000, %edx, %esi            # imm = 0xF4240
	addl	_sysy_s(,%rax,4), %edx
	movl	%ebx, _sysy_l2(,%rax,4)
	subl	%esi, %ecx
	movl	%ecx, _sysy_us(,%rax,4)
	movslq	%edx, %rcx
	imulq	$-2004318071, %rcx, %rdx        # imm = 0x88888889
	shrq	$32, %rdx
	addl	%ecx, %edx
	movl	%edx, %esi
	shrl	$31, %esi
	sarl	$5, %edx
	addl	%esi, %edx
	imull	$60, %edx, %esi
	addl	_sysy_m(,%rax,4), %edx
	subl	%esi, %ecx
	movl	%ecx, _sysy_s(,%rax,4)
	movslq	%edx, %rcx
	imulq	$-2004318071, %rcx, %rdx        # imm = 0x88888889
	shrq	$32, %rdx
	addl	%ecx, %edx
	movl	%edx, %esi
	shrl	$31, %esi
	sarl	$5, %edx
	addl	%esi, %edx
	addl	%edx, _sysy_h(,%rax,4)
	imull	$60, %edx, %edx
	subl	%edx, %ecx
	movl	%ecx, _sysy_m(,%rax,4)
	incl	%eax
	movl	%eax, _sysy_idx(%rip)
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end13:
	.size	_sysy_stoptime, .Lfunc_end13-_sysy_stoptime
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %.2
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -16
	movq	.g.k@GOTPCREL(%rip), %rbx
	movl	$3389, (%rbx)                   # imm = 0xD3D
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB14_2
# %bb.1:                                # %.18
	movl	(%rsp), %edi
	callq	putint
.LBB14_2:                               # %.60
	movl	(%rbx), %eax
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end14:
	.size	main, .Lfunc_end14-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d"
	.size	.L.str, 3

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"%c"
	.size	.L.str.1, 3

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"%a"
	.size	.L.str.2, 3

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"%d:"
	.size	.L.str.3, 4

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	" %d"
	.size	.L.str.4, 4

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	" %a"
	.size	.L.str.6, 4

	.type	_sysy_us,@object                # @_sysy_us
	.comm	_sysy_us,4096,16
	.type	_sysy_s,@object                 # @_sysy_s
	.comm	_sysy_s,4096,16
	.type	_sysy_m,@object                 # @_sysy_m
	.comm	_sysy_m,4096,16
	.type	_sysy_h,@object                 # @_sysy_h
	.comm	_sysy_h,4096,16
	.type	_sysy_idx,@object               # @_sysy_idx
	.comm	_sysy_idx,4,4
	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"Timer@%04d-%04d: %dH-%dM-%dS-%dus\n"
	.size	.L.str.7, 35

	.type	_sysy_l1,@object                # @_sysy_l1
	.comm	_sysy_l1,4096,16
	.type	_sysy_l2,@object                # @_sysy_l2
	.comm	_sysy_l2,4096,16
	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"TOTAL: %dH-%dM-%dS-%dus\n"
	.size	.L.str.8, 25

	.type	_sysy_start,@object             # @_sysy_start
	.comm	_sysy_start,16,8
	.type	_sysy_end,@object               # @_sysy_end
	.comm	_sysy_end,16,8
	.section	.init_array,"aw",@init_array
	.p2align	3
	.quad	before_main
	.section	.fini_array,"aw",@fini_array
	.p2align	3
	.quad	after_main
	.type	.g.k,@object                    # @.g.k
	.bss
	.globl	.g.k
	.p2align	2
.g.k:
	.long	0                               # 0x0
	.size	.g.k, 4

	.section	".note.GNU-stack","",@progbits
