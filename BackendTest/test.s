    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.RADIUS
    .bss
    .align  2
    .type  .G.RADIUS, @object
    .size  .G.RADIUS, 4
.G.RADIUS:
    .zero  4
    .globl  .G.PI
    .align  2
    .type  .G.PI, @object
    .size  .G.PI, 4
.G.PI:
    .zero  4
    .globl  .G.EPS
    .align  2
    .type  .G.EPS, @object
    .size  .G.EPS, 4
.G.EPS:
    .zero  4
    .globl  .G.PI_HEX
    .align  2
    .type  .G.PI_HEX, @object
    .size  .G.PI_HEX, 4
.G.PI_HEX:
    .zero  4
    .globl  .G.HEX2
    .align  2
    .type  .G.HEX2, @object
    .size  .G.HEX2, 4
.G.HEX2:
    .zero  4
    .globl  .G.FACT
    .align  2
    .type  .G.FACT, @object
    .size  .G.FACT, 4
.G.FACT:
    .zero  4
    .globl  .G.EVAL1
    .align  2
    .type  .G.EVAL1, @object
    .size  .G.EVAL1, 4
.G.EVAL1:
    .zero  4
    .globl  .G.EVAL2
    .align  2
    .type  .G.EVAL2, @object
    .size  .G.EVAL2, 4
.G.EVAL2:
    .zero  4
    .globl  .G.EVAL3
    .align  2
    .type  .G.EVAL3, @object
    .size  .G.EVAL3, 4
.G.EVAL3:
    .zero  4
    .globl  .G.CONV1
    .align  2
    .type  .G.CONV1, @object
    .size  .G.CONV1, 4
.G.CONV1:
    .zero  4
    .globl  .G.CONV2
    .align  2
    .type  .G.CONV2, @object
    .size  .G.CONV2, 4
.G.CONV2:
    .zero  4
    .globl  .G.MAX
    .align  2
    .type  .G.MAX, @object
    .size  .G.MAX, 4
.G.MAX:
    .zero  4
    .globl  .G.TWO
    .align  2
    .type  .G.TWO, @object
    .size  .G.TWO, 4
.G.TWO:
    .zero  4
    .globl  .G.THREE
    .align  2
    .type  .G.THREE, @object
    .size  .G.THREE, 4
.G.THREE:
    .zero  4
    .globl  .G.FIVE
    .align  2
    .type  .G.FIVE, @object
    .size  .G.FIVE, 4
.G.FIVE:
    .zero  4
    .globl  .C..198
    .data
    .align  3
    .type  .C..198, @object
    .size  .C..198, 40
.C..198:
    .word  1065353216
    .word  1073741824
    .zero  32
    .text
    .align  1
    .globl  float_abs
    .type  float_abs, @function
float_abs:
.LBB0:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	j .LBB1
.LBB1:
	fsw fa0, -20(s0)
	flw ft1, -20(s0)
	fcvt.s.w ft0, zero
	flt.s t2, ft1, ft0
	beq t2, zero, .LBB2
	j .LBB3
.LBB3:
	flw ft1, -20(s0)
	lui t2, %hi(.LC0)
	flw ft0, %lo(.LC0)(t2)
	fsub.s fa0, ft0, ft1
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
.LBB2:
	flw fa0, -20(s0)
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
    .size float_abs, .-float_abs
    .align  1
    .globl  circle_area
    .type  circle_area, @function
circle_area:
.LBB4:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	sd s1, -28(s0)
	mv t2, a0
	j .LBB5
.LBB5:
	sw t2, -20(s0)
	lw t2, -20(s0)
	fcvt.s.w ft0, t2
	lui t2, %hi(.LC1)
	flw ft1, %lo(.LC1)(t2)
	fmul.s ft1, ft1, ft0
	lw t2, -20(s0)
	fcvt.s.w ft0, t2
	fmul.s ft2, ft1, ft0
	lw t2, -20(s0)
	lw s1, -20(s0)
	mulw t2, t2, s1
	fcvt.s.w ft0, t2
	lui t2, %hi(.LC1)
	flw ft1, %lo(.LC1)(t2)
	fmul.s ft0, ft0, ft1
	fadd.s ft0, ft2, ft0
	li t0, 2
	fcvt.s.w ft1, t0
	fdiv.s fa0, ft0, ft1
	ld s1, -28(s0)
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
    .size circle_area, .-circle_area
    .align  1
    .globl  float_eq
    .type  float_eq, @function
float_eq:
.LBB6:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	j .LBB7
.LBB7:
	fsw fa0, -24(s0)
	fsw fa1, -20(s0)
	flw ft1, -24(s0)
	flw ft0, -20(s0)
	fsub.s fa0, ft1, ft0
	call float_abs
	lui t2, %hi(.LC2)
	flw ft0, %lo(.LC2)(t2)
	flt.s t2, fa0, ft0
	beq t2, zero, .LBB8
	j .LBB9
.LBB9:
	lui t2, %hi(.LC3)
	flw ft0, %lo(.LC3)(t2)
	fcvt.w.s a0, ft0, rtz
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
.LBB8:
	mv a0, zero
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
    .size float_eq, .-float_eq
    .align  1
    .globl  error
    .type  error, @function
error:
.LBB10:
	addi sp, sp, -16
	sd ra, 8(sp)
	sd s0, 0(sp)
	addi s0, sp, 16
	li a0, 101
	call putch
	li a0, 114
	call putch
	li a0, 114
	call putch
	li a0, 111
	call putch
	li a0, 114
	call putch
	li a0, 10
	call putch
	ld ra, 8(sp)
	ld s0, 0(sp)
	addi sp, sp, 16
	ret 
    .size error, .-error
    .align  1
    .globl  ok
    .type  ok, @function
ok:
.LBB11:
	addi sp, sp, -16
	sd ra, 8(sp)
	sd s0, 0(sp)
	addi s0, sp, 16
	li a0, 111
	call putch
	li a0, 107
	call putch
	li a0, 10
	call putch
	ld ra, 8(sp)
	ld s0, 0(sp)
	addi sp, sp, 16
	ret 
    .size ok, .-ok
    .align  1
    .globl  assert
    .type  assert, @function
assert:
.LBB12:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	j .LBB13
.LBB13:
	sw a0, -20(s0)
	lw t2, -20(s0)
	beq t2, zero, .LBB14
	j .LBB15
.LBB14:
	call error
	j .LBB16
.LBB15:
	call ok
	j .LBB16
.LBB16:
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
    .size assert, .-assert
    .align  1
    .globl  assert_not
    .type  assert_not, @function
assert_not:
.LBB17:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	j .LBB18
.LBB18:
	sw a0, -20(s0)
	lw t2, -20(s0)
	bne t2, zero, .LBB19
	j .LBB20
.LBB19:
	call error
	j .LBB21
.LBB20:
	call ok
	j .LBB21
.LBB21:
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
    .size assert_not, .-assert_not
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB22:
	addi sp, sp, -96
	sd ra, 88(sp)
	sd s0, 80(sp)
	addi s0, sp, 96
	fsd fs0, -56(s0)
	sd s1, -48(s0)
	lui t2, %hi(.LC4)
	flw ft0, %lo(.LC4)(t2)
	fmv.s fa0, ft0
	lui t2, %hi(.LC5)
	flw ft0, %lo(.LC5)(t2)
	fmv.s fa1, ft0
	lui t2, %hi(.LC4)
	flw ft0, %lo(.LC4)(t2)
	lui t2, %hi(.LC5)
	flw ft0, %lo(.LC5)(t2)
	call float_eq
	mv t2, a0
	mv a0, t2
	call assert_not
	lui t2, %hi(.LC6)
	flw ft0, %lo(.LC6)(t2)
	fmv.s fa0, ft0
	lui t2, %hi(.LC7)
	flw ft0, %lo(.LC7)(t2)
	fmv.s fa1, ft0
	lui t2, %hi(.LC6)
	flw ft0, %lo(.LC6)(t2)
	lui t2, %hi(.LC7)
	flw ft0, %lo(.LC7)(t2)
	call float_eq
	mv t2, a0
	mv a0, t2
	call assert_not
	lui t2, %hi(.LC7)
	flw ft0, %lo(.LC7)(t2)
	fmv.s fa0, ft0
	lui t2, %hi(.LC7)
	flw ft0, %lo(.LC7)(t2)
	fmv.s fa1, ft0
	lui t2, %hi(.LC7)
	flw ft0, %lo(.LC7)(t2)
	call float_eq
	mv t2, a0
	mv a0, t2
	call assert
	lui t2, %hi(.LC8)
	flw ft0, %lo(.LC8)(t2)
	fcvt.w.s t2, ft0, rtz
	mv a0, t2
	call circle_area
	fmv.s fs0, fa0
	li a0, 5
	call circle_area
	fmv.s fa1, fa0
	fmv.s fa0, fs0
	call float_eq
	mv t2, a0
	mv a0, t2
	call assert
	lui t2, %hi(.LC9)
	flw ft0, %lo(.LC9)(t2)
	fmv.s fa0, ft0
	lui t2, %hi(.LC10)
	flw ft0, %lo(.LC10)(t2)
	fmv.s fa1, ft0
	lui t2, %hi(.LC9)
	flw ft0, %lo(.LC9)(t2)
	lui t2, %hi(.LC10)
	flw ft0, %lo(.LC10)(t2)
	call float_eq
	mv t2, a0
	mv a0, t2
	call assert_not
	j .LBB23
.LBB23:
	call ok
	j .LBB24
.LBB24:
	j .LBB25
.LBB25:
	call ok
	j .LBB26
.LBB26:
	j .LBB27
.LBB27:
	j .LBB28
.LBB29:
	call ok
	j .LBB30
.LBB28:
	j .LBB29
.LBB30:
	li t2, 1
	sw t2, -40(s0)
	li t2, 0
	sw t2, -36(s0)
	addi t0, s0, -96
	mv a0, t0
	lui t2, %hi(.C..198)
	addi t2, t2, %lo(.C..198)
	mv a1, t2
	li a2, 40
	lui t2, %hi(.C..198)
	addi t2, t2, %lo(.C..198)
	call memcpy@plt
	addi a0, s0, -96
	addi t0, a0, 0
	mv a0, t0
	call getfarray
	mv t2, a0
	sw t2, -32(s0)
	j .LBB31
.LBB31:
	lw t2, -40(s0)
	li t1, 1000001536
	addi t1, t1, -1536
	mv t0, t1
	blt t2, t0, .LBB32
	j .LBB33
.LBB32:
	call getfloat
	fmv.s ft0, fa0
	fsw ft0, -28(s0)
	flw ft0, -28(s0)
	lui t2, %hi(.LC1)
	flw ft1, %lo(.LC1)(t2)
	fmul.s ft1, ft1, ft0
	flw ft0, -28(s0)
	fmul.s ft0, ft1, ft0
	fsw ft0, -24(s0)
	flw ft0, -28(s0)
	fcvt.w.s t2, ft0, rtz
	mv a0, t2
	call circle_area
	fmv.s ft0, fa0
	fsw ft0, -20(s0)
	lw s1, -36(s0)
	addi a0, s0, -96
	li t2, 4
	mulw t2, s1, t2
	add a0, a0, t2
	flw ft1, 0(a0)
	flw ft0, -28(s0)
	fadd.s ft0, ft1, ft0
	lw s1, -36(s0)
	addi a0, s0, -96
	li t2, 4
	mulw t2, s1, t2
	add a0, a0, t2
	fsw ft0, 0(a0)
	flw ft0, -24(s0)
	fmv.s fa0, ft0
	call putfloat
	li a0, 32
	call putch
	flw ft0, -20(s0)
	fcvt.w.s t2, ft0, rtz
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -40(s0)
	fcvt.s.w ft0, t2
	lui t2, %hi(.LC11)
	flw ft1, %lo(.LC11)(t2)
	fmul.s ft0, ft0, ft1
	fcvt.w.s t2, ft0, rtz
	sw t2, -40(s0)
	lw t2, -36(s0)
	addiw t2, t2, 1
	sw t2, -36(s0)
	j .LBB31
.LBB33:
	lw t2, -32(s0)
	addi a1, s0, -96
	mv a0, t2
	addi t0, a1, 0
	mv a1, t0
	call putfarray
	mv a0, zero
	ld s1, -48(s0)
	fld fs0, -56(s0)
	ld ra, 88(sp)
	ld s0, 80(sp)
	addi sp, sp, 96
	ret 
    .size main, .-main
    .section    .rodata
    .align  2
.LC0:
    .word  0
    .align  2
.LC1:
    .word  1078530011
    .align  2
.LC2:
    .word  897988541
    .align  2
.LC3:
    .word  1065353216
    .align  2
.LC4:
    .word  1033895936
    .align  2
.LC5:
    .word  -956241920
    .align  2
.LC6:
    .word  1119752446
    .align  2
.LC7:
    .word  1107966695
    .align  2
.LC8:
    .word  1085276160
    .align  2
.LC9:
    .word  1130954752
    .align  2
.LC10:
    .word  1166012416
    .align  2
.LC11:
    .word  1092616192
