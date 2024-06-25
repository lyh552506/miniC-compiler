	.file	"sylib.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	_sysy_start
	.bss
	.align	3
	.type	_sysy_start, @object
	.size	_sysy_start, 16
_sysy_start:
	.zero	16
	.globl	_sysy_end
	.align	3
	.type	_sysy_end, @object
	.size	_sysy_end, 16
_sysy_end:
	.zero	16
	.globl	_sysy_l1
	.align	3
	.type	_sysy_l1, @object
	.size	_sysy_l1, 4096
_sysy_l1:
	.zero	4096
	.globl	_sysy_l2
	.align	3
	.type	_sysy_l2, @object
	.size	_sysy_l2, 4096
_sysy_l2:
	.zero	4096
	.globl	_sysy_h
	.align	3
	.type	_sysy_h, @object
	.size	_sysy_h, 4096
_sysy_h:
	.zero	4096
	.globl	_sysy_m
	.align	3
	.type	_sysy_m, @object
	.size	_sysy_m, 4096
_sysy_m:
	.zero	4096
	.globl	_sysy_s
	.align	3
	.type	_sysy_s, @object
	.size	_sysy_s, 4096
_sysy_s:
	.zero	4096
	.globl	_sysy_us
	.align	3
	.type	_sysy_us, @object
	.size	_sysy_us, 4096
_sysy_us:
	.zero	4096
	.globl	_sysy_idx
	.section	.sbss,"aw",@nobits
	.align	2
	.type	_sysy_idx, @object
	.size	_sysy_idx, 4
_sysy_idx:
	.zero	4
	.section	.rodata
	.align	3
.LC0:
	.string	"%d"
	.text
	.align	1
	.globl	getint
	.type	getint, @function
getint:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	addi	a5,s0,-20
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	scanf
	lw	a5,-20(s0)
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	getint, .-getint
	.section	.rodata
	.align	3
.LC1:
	.string	"%c"
	.text
	.align	1
	.globl	getch
	.type	getch, @function
getch:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	addi	a5,s0,-17
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	scanf
	lbu	a5,-17(s0)
	sext.w	a5,a5
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	getch, .-getch
	.section	.rodata
	.align	3
.LC2:
	.string	"%a"
	.text
	.align	1
	.globl	getfloat
	.type	getfloat, @function
getfloat:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	addi	a5,s0,-20
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	scanf
	flw	fa5,-20(s0)
	fmv.s	fa0,fa5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	getfloat, .-getfloat
	.align	1
	.globl	getarray
	.type	getarray, @function
getarray:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	addi	a5,s0,-24
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	scanf
	sw	zero,-20(s0)
	j	.L8
.L9:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	scanf
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L8:
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L9
	lw	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	getarray, .-getarray
	.align	1
	.globl	getfarray
	.type	getfarray, @function
getfarray:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	addi	a5,s0,-24
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	scanf
	sw	zero,-20(s0)
	j	.L12
.L13:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	scanf
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L12:
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L13
	lw	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	getfarray, .-getfarray
	.align	1
	.globl	putint
	.type	putint, @function
putint:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	putint, .-putint
	.align	1
	.globl	putch
	.type	putch, @function
putch:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	putchar
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	putch, .-putch
	.section	.rodata
	.align	3
.LC3:
	.string	"%d:"
	.align	3
.LC4:
	.string	" %d"
	.text
	.align	1
	.globl	putarray
	.type	putarray, @function
putarray:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	sd	a1,-48(s0)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	sw	zero,-20(s0)
	j	.L18
.L19:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-48(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L18:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-36(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L19
	li	a0,10
	call	putchar
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	putarray, .-putarray
	.align	1
	.globl	putfloat
	.type	putfloat, @function
putfloat:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	fsw	fa0,-20(s0)
	flw	fa5,-20(s0)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	putfloat, .-putfloat
	.section	.rodata
	.align	3
.LC5:
	.string	" %a"
	.text
	.align	1
	.globl	putfarray
	.type	putfarray, @function
putfarray:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	sd	a1,-48(s0)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	sw	zero,-20(s0)
	j	.L22
.L23:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-48(s0)
	add	a5,a4,a5
	flw	fa5,0(a5)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	printf
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L22:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-36(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L23
	li	a0,10
	call	putchar
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	putfarray, .-putfarray
	.align	1
	.globl	putf
	.type	putf, @function
putf:
	addi	sp,sp,-112
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,8(s0)
	sd	a2,16(s0)
	sd	a3,24(s0)
	sd	a4,32(s0)
	sd	a5,40(s0)
	sd	a6,48(s0)
	sd	a7,56(s0)
	addi	a5,s0,64
	sd	a5,-48(s0)
	ld	a5,-48(s0)
	addi	a5,a5,-56
	sd	a5,-24(s0)
	lui	a5,%hi(_impure_ptr)
	ld	a5,%lo(_impure_ptr)(a5)
	ld	a5,16(a5)
	ld	a4,-24(s0)
	mv	a2,a4
	ld	a1,-40(s0)
	mv	a0,a5
	call	vfprintf
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,112
	jr	ra
	.size	putf, .-putf
	.align	1
	.globl	before_main
	.type	before_main, @function
before_main:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
	j	.L26
.L27:
	lui	a5,%hi(_sysy_us)
	addi	a4,a5,%lo(_sysy_us)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	zero,0(a5)
	lui	a5,%hi(_sysy_us)
	addi	a4,a5,%lo(_sysy_us)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(_sysy_s)
	addi	a3,a5,%lo(_sysy_s)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_s)
	addi	a4,a5,%lo(_sysy_s)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(_sysy_m)
	addi	a3,a5,%lo(_sysy_m)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_m)
	addi	a4,a5,%lo(_sysy_m)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(_sysy_h)
	addi	a3,a5,%lo(_sysy_h)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L26:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1023
	ble	a4,a5,.L27
	lui	a5,%hi(_sysy_idx)
	li	a4,1
	sw	a4,%lo(_sysy_idx)(a5)
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	before_main, .-before_main
	.section	.init_array,"aw"
	.align	3
	.dword	before_main
	.section	.rodata
	.align	3
.LC6:
	.string	"Timer@%04d-%04d: %dH-%dM-%dS-%dus\n"
	.align	3
.LC7:
	.string	"TOTAL: %dH-%dM-%dS-%dus\n"
	.text
	.align	1
	.globl	after_main
	.type	after_main, @function
after_main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,1
	sw	a5,-20(s0)
	j	.L29
.L30:
	lui	a5,%hi(_impure_ptr)
	ld	a5,%lo(_impure_ptr)(a5)
	ld	a0,24(a5)
	lui	a5,%hi(_sysy_l1)
	addi	a4,a5,%lo(_sysy_l1)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a2,0(a5)
	lui	a5,%hi(_sysy_l2)
	addi	a4,a5,%lo(_sysy_l2)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a3,0(a5)
	lui	a5,%hi(_sysy_h)
	addi	a4,a5,%lo(_sysy_h)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a1,0(a5)
	lui	a5,%hi(_sysy_m)
	addi	a4,a5,%lo(_sysy_m)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	t1,0(a5)
	lui	a5,%hi(_sysy_s)
	addi	a4,a5,%lo(_sysy_s)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a6,0(a5)
	lui	a5,%hi(_sysy_us)
	addi	a4,a5,%lo(_sysy_us)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a7,a5
	mv	a5,t1
	mv	a4,a1
	lui	a1,%hi(.LC6)
	addi	a1,a1,%lo(.LC6)
	call	fprintf
	lui	a5,%hi(_sysy_us)
	addi	a5,a5,%lo(_sysy_us)
	lw	a4,0(a5)
	lui	a5,%hi(_sysy_us)
	addi	a3,a5,%lo(_sysy_us)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,0(a5)
	addw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(_sysy_us)
	addi	a5,a5,%lo(_sysy_us)
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_s)
	addi	a5,a5,%lo(_sysy_s)
	lw	a4,0(a5)
	lui	a5,%hi(_sysy_s)
	addi	a3,a5,%lo(_sysy_s)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,0(a5)
	addw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(_sysy_s)
	addi	a5,a5,%lo(_sysy_s)
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_us)
	addi	a5,a5,%lo(_sysy_us)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,999424
	addiw	a5,a5,576
	remw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(_sysy_us)
	addi	a5,a5,%lo(_sysy_us)
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_m)
	addi	a5,a5,%lo(_sysy_m)
	lw	a4,0(a5)
	lui	a5,%hi(_sysy_m)
	addi	a3,a5,%lo(_sysy_m)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,0(a5)
	addw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(_sysy_m)
	addi	a5,a5,%lo(_sysy_m)
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_s)
	addi	a5,a5,%lo(_sysy_s)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,60
	remw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(_sysy_s)
	addi	a5,a5,%lo(_sysy_s)
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_h)
	addi	a5,a5,%lo(_sysy_h)
	lw	a4,0(a5)
	lui	a5,%hi(_sysy_h)
	addi	a3,a5,%lo(_sysy_h)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,0(a5)
	addw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(_sysy_h)
	addi	a5,a5,%lo(_sysy_h)
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_m)
	addi	a5,a5,%lo(_sysy_m)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,60
	remw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(_sysy_m)
	addi	a5,a5,%lo(_sysy_m)
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L29:
	lui	a5,%hi(_sysy_idx)
	lw	a4,%lo(_sysy_idx)(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L30
	lui	a5,%hi(_impure_ptr)
	ld	a5,%lo(_impure_ptr)(a5)
	ld	a0,24(a5)
	lui	a5,%hi(_sysy_h)
	addi	a5,a5,%lo(_sysy_h)
	lw	a2,0(a5)
	lui	a5,%hi(_sysy_m)
	addi	a5,a5,%lo(_sysy_m)
	lw	a3,0(a5)
	lui	a5,%hi(_sysy_s)
	addi	a5,a5,%lo(_sysy_s)
	lw	a4,0(a5)
	lui	a5,%hi(_sysy_us)
	addi	a5,a5,%lo(_sysy_us)
	lw	a5,0(a5)
	lui	a1,%hi(.LC7)
	addi	a1,a1,%lo(.LC7)
	call	fprintf
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	after_main, .-after_main
	.section	.fini_array,"aw"
	.align	3
	.dword	after_main
	.text
	.align	1
	.globl	_sysy_starttime
	.type	_sysy_starttime, @function
_sysy_starttime:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_l1)
	addi	a4,a4,%lo(_sysy_l1)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,0(a5)
	li	a1,0
	lui	a5,%hi(_sysy_start)
	addi	a0,a5,%lo(_sysy_start)
	call	gettimeofday
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	_sysy_starttime, .-_sysy_starttime
	.align	1
	.globl	_sysy_stoptime
	.type	_sysy_stoptime, @function
_sysy_stoptime:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	li	a1,0
	lui	a5,%hi(_sysy_end)
	addi	a0,a5,%lo(_sysy_end)
	call	gettimeofday
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_l2)
	addi	a4,a4,%lo(_sysy_l2)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_us)
	addi	a4,a4,%lo(_sysy_us)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	sext.w	a4,a5
	lui	a5,%hi(_sysy_end)
	addi	a5,a5,%lo(_sysy_end)
	ld	a3,0(a5)
	lui	a5,%hi(_sysy_start)
	addi	a5,a5,%lo(_sysy_start)
	ld	a5,0(a5)
	sub	a5,a3,a5
	sext.w	a3,a5
	li	a5,999424
	addiw	a5,a5,576
	mulw	a5,a3,a5
	sext.w	a3,a5
	lui	a5,%hi(_sysy_end)
	addi	a5,a5,%lo(_sysy_end)
	ld	a5,8(a5)
	sext.w	a5,a5
	addw	a5,a3,a5
	sext.w	a3,a5
	lui	a5,%hi(_sysy_start)
	addi	a5,a5,%lo(_sysy_start)
	ld	a5,8(a5)
	sext.w	a5,a5
	subw	a5,a3,a5
	sext.w	a5,a5
	addw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	sext.w	a4,a4
	lui	a3,%hi(_sysy_us)
	addi	a3,a3,%lo(_sysy_us)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_s)
	addi	a4,a4,%lo(_sysy_s)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a3,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_us)
	addi	a4,a4,%lo(_sysy_us)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,999424
	addiw	a5,a5,576
	divw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	addw	a4,a3,a4
	sext.w	a4,a4
	lui	a3,%hi(_sysy_s)
	addi	a3,a3,%lo(_sysy_s)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_us)
	addi	a4,a4,%lo(_sysy_us)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	mv	a3,a4
	li	a4,999424
	addiw	a4,a4,576
	remw	a4,a3,a4
	sext.w	a4,a4
	lui	a3,%hi(_sysy_us)
	addi	a3,a3,%lo(_sysy_us)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_m)
	addi	a4,a4,%lo(_sysy_m)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a3,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_s)
	addi	a4,a4,%lo(_sysy_s)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,60
	divw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	addw	a4,a3,a4
	sext.w	a4,a4
	lui	a3,%hi(_sysy_m)
	addi	a3,a3,%lo(_sysy_m)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_s)
	addi	a4,a4,%lo(_sysy_s)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	mv	a3,a4
	li	a4,60
	remw	a4,a3,a4
	sext.w	a4,a4
	lui	a3,%hi(_sysy_s)
	addi	a3,a3,%lo(_sysy_s)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_h)
	addi	a4,a4,%lo(_sysy_h)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a3,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_m)
	addi	a4,a4,%lo(_sysy_m)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,60
	divw	a5,a4,a5
	sext.w	a4,a5
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	addw	a4,a3,a4
	sext.w	a4,a4
	lui	a3,%hi(_sysy_h)
	addi	a3,a3,%lo(_sysy_h)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	lui	a4,%hi(_sysy_m)
	addi	a4,a4,%lo(_sysy_m)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	mv	a3,a4
	li	a4,60
	remw	a4,a3,a4
	sext.w	a4,a4
	lui	a3,%hi(_sysy_m)
	addi	a3,a3,%lo(_sysy_m)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lui	a5,%hi(_sysy_idx)
	lw	a5,%lo(_sysy_idx)(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	lui	a5,%hi(_sysy_idx)
	sw	a4,%lo(_sysy_idx)(a5)
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	_sysy_stoptime, .-_sysy_stoptime
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
