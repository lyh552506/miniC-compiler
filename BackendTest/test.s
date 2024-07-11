    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.maxlen
    .bss
    .align  2
    .type  .G.maxlen, @object
    .size  .G.maxlen, 4
.G.maxlen:
    .zero  4
    .globl  .G.temp
    .align  3
    .type  .G.temp, @object
    .size  .G.temp, 8388608
.G.temp:
    .zero  8388608
    .globl  .G.w
    .align  3
    .type  .G.w, @object
    .size  .G.w, 8388608
.G.w:
    .zero  8388608
    .globl  .G.dst
    .align  3
    .type  .G.dst, @object
    .size  .G.dst, 8388608
.G.dst:
    .zero  8388608
    .globl  .G.c
    .align  3
    .type  .G.c, @object
    .size  .G.c, 8388608
.G.c:
    .zero  8388608
    .text
    .align  1
    .globl  getvalue
    .type  getvalue, @function
getvalue:
.LBB0:
	addi sp, sp, -48
	sd ra, 40(sp)
	sd s0, 32(sp)
	addi s0, sp, 48
	sd s1, -44(s0)
	j .LBB1
.LBB1:
	sd a0, -36(s0)
	sw a1, -28(s0)
	sw a2, -24(s0)
	sw a3, -20(s0)
	lw t2, -24(s0)
	blt t2, zero, .LBB2
	j .LBB3
.LBB2:
	li a0, -1
	ld s1, -44(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
.LBB4:
	lw t2, -24(s0)
	lw s1, -28(s0)
	mulw s1, t2, s1
	lw t2, -20(s0)
	addw s1, s1, t2
	ld t2, -36(s0)
	add a0, zero, t2
	li t2, 4
	mulw t2, s1, t2
	add a0, a0, t2
	lw a0, 0(a0)
	ld s1, -44(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
.LBB3:
	lw s1, -24(s0)
	lw t2, -28(s0)
	bge s1, t2, .LBB2
	j .LBB5
.LBB5:
	lw t2, -20(s0)
	blt t2, zero, .LBB2
	j .LBB6
.LBB6:
	lw s1, -20(s0)
	lw t2, -28(s0)
	bge s1, t2, .LBB2
	j .LBB4
    .size getvalue, .-getvalue
    .align  1
    .globl  mem_move
    .type  mem_move, @function
mem_move:
.LBB7:
	addi sp, sp, -48
	sd ra, 40(sp)
	sd s0, 32(sp)
	addi s0, sp, 48
	sd s1, -48(s0)
	j .LBB8
.LBB8:
	sd a0, -40(s0)
	sd a1, -32(s0)
	sw a2, -24(s0)
	li t2, 0
	sw t2, -20(s0)
	j .LBB9
.LBB9:
	lw s1, -20(s0)
	lw t2, -24(s0)
	blt s1, t2, .LBB10
	j .LBB11
.LBB10:
	lw t2, -20(s0)
	ld s1, -40(s0)
	add s1, zero, s1
	li a0, 4
	mulw t2, t2, a0
	add s1, s1, t2
	lw a1, 0(s1)
	lw s1, -20(s0)
	ld t2, -32(s0)
	add a0, zero, t2
	li t2, 4
	mulw t2, s1, t2
	add a0, a0, t2
	sw a1, 0(a0)
	lw t2, -20(s0)
	addiw t2, t2, 1
	sw t2, -20(s0)
	j .LBB9
.LBB11:
	ld s1, -48(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
    .size mem_move, .-mem_move
    .align  1
    .globl  floyd
    .type  floyd, @function
floyd:
.LBB12:
	addi sp, sp, -80
	sd ra, 72(sp)
	sd s0, 64(sp)
	addi s0, sp, 80
	sd s2, -68(s0)
	sd s1, -60(s0)
	mv s1, a0
	mv t2, a1
	mv a0, a2
	j .LBB13
.LBB13:
	sd s1, -52(s0)
	sd t2, -44(s0)
	sw a0, -36(s0)
	li t2, 0
	sw t2, -32(s0)
	j .LBB14
.LBB14:
	lw s1, -32(s0)
	lw t2, -36(s0)
	blt s1, t2, .LBB15
	j .LBB16
.LBB15:
	li t2, 0
	sw t2, -28(s0)
	j .LBB17
.LBB16:
	li t2, 0
	sw t2, -32(s0)
	lw s1, -36(s0)
	lw t2, -36(s0)
	mulw t2, s1, t2
	lui s1, %hi(.G.temp)
	addi s1, s1, %lo(.G.temp)
	add a1, zero, s1
	mv a0, t2
	addi t0, a1, 0
	mv a1, t0
	call putarray
	j .LBB18
.LBB17:
	lw s1, -28(s0)
	lw t2, -36(s0)
	blt s1, t2, .LBB19
	j .LBB20
.LBB19:
	ld a0, -52(s0)
	lw a1, -36(s0)
	lw s1, -28(s0)
	lw t2, -32(s0)
	mv a2, s1
	mv a3, t2
	call getvalue
	mv t2, a0
	lw a0, -28(s0)
	lw s1, -36(s0)
	mulw a0, a0, s1
	lw s1, -32(s0)
	addw a0, a0, s1
	lui s1, %hi(.G.temp)
	addi s1, s1, %lo(.G.temp)
	add a1, zero, s1
	li s1, 4
	mulw s1, a0, s1
	add a1, a1, s1
	sw t2, 0(a1)
	lw t2, -28(s0)
	addiw t2, t2, 1
	sw t2, -28(s0)
	j .LBB17
.LBB20:
	lw t2, -32(s0)
	addiw t2, t2, 1
	sw t2, -32(s0)
	j .LBB14
.LBB18:
	lw s1, -32(s0)
	lw t2, -36(s0)
	blt s1, t2, .LBB21
	j .LBB22
.LBB21:
	li t2, 0
	sw t2, -24(s0)
	j .LBB23
.LBB22:
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	ld s1, -44(s0)
	lw t2, -36(s0)
	lw a1, -36(s0)
	mulw t2, t2, a1
	addi t0, a0, 0
	mv a0, t0
	mv a1, s1
	mv a2, t2
	call mem_move
	ld s1, -60(s0)
	ld s2, -68(s0)
	ld ra, 72(sp)
	ld s0, 64(sp)
	addi sp, sp, 80
	ret 
.LBB23:
	lw s1, -24(s0)
	lw t2, -36(s0)
	blt s1, t2, .LBB24
	j .LBB25
.LBB24:
	li t2, 0
	sw t2, -20(s0)
	j .LBB26
.LBB25:
	lw t2, -32(s0)
	addiw t2, t2, 1
	sw t2, -32(s0)
	j .LBB18
.LBB26:
	lw s1, -20(s0)
	lw t2, -36(s0)
	blt s1, t2, .LBB27
	j .LBB28
.LBB27:
	lw t2, -36(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -24(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lw t2, -20(s0)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	lw s1, -36(s0)
	lw a2, -24(s0)
	lw t2, -32(s0)
	addi t0, a0, 0
	mv a0, t0
	mv a1, s1
	mv a3, t2
	call getvalue
	mv t2, a0
	bge t2, zero, .LBB29
	j .LBB30
.LBB28:
	lw t2, -24(s0)
	addiw t2, t2, 1
	sw t2, -24(s0)
	j .LBB23
.LBB31:
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	lw t2, -36(s0)
	lw s1, -24(s0)
	lw a3, -20(s0)
	addi t0, a0, 0
	mv a0, t0
	mv a1, t2
	mv a2, s1
	call getvalue
	mv t2, a0
	blt t2, zero, .LBB32
	j .LBB33
.LBB30:
	lw t2, -20(s0)
	addiw t2, t2, 1
	sw t2, -20(s0)
	j .LBB26
.LBB29:
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	lw t2, -36(s0)
	lw a2, -32(s0)
	lw s1, -20(s0)
	addi t0, a0, 0
	mv a0, t0
	mv a1, t2
	mv a3, s1
	call getvalue
	mv t2, a0
	bge t2, zero, .LBB31
	j .LBB30
.LBB32:
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	lw t2, -36(s0)
	lw s1, -24(s0)
	lw a3, -32(s0)
	addi t0, a0, 0
	mv a0, t0
	mv a1, t2
	mv a2, s1
	call getvalue
	mv s1, a0
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	lw a1, -36(s0)
	lw t2, -32(s0)
	lw a3, -20(s0)
	addi t0, a0, 0
	mv a0, t0
	mv a2, t2
	call getvalue
	mv t2, a0
	addw a1, s1, t2
	lw s1, -24(s0)
	lw t2, -36(s0)
	mulw s1, s1, t2
	lw t2, -20(s0)
	addw s1, s1, t2
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	li t2, 4
	mulw t2, s1, t2
	add a0, a0, t2
	sw a1, 0(a0)
	lw t2, -24(s0)
	lw s1, -36(s0)
	mulw t2, t2, s1
	lw s1, -20(s0)
	addw a0, t2, s1
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add s1, zero, t2
	li t2, 4
	mulw t2, a0, t2
	add s1, s1, t2
	lw t2, 0(s1)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	j .LBB34
.LBB33:
	lw t2, -24(s0)
	lw s1, -36(s0)
	mulw s1, t2, s1
	lw t2, -20(s0)
	addw s1, s1, t2
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	li t2, 4
	mulw t2, s1, t2
	add a0, a0, t2
	lw s1, 0(a0)
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	lw a1, -36(s0)
	lw t2, -24(s0)
	lw a3, -32(s0)
	addi t0, a0, 0
	mv a0, t0
	mv a2, t2
	call getvalue
	mv s2, a0
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	lw a1, -36(s0)
	lw t2, -32(s0)
	lw a3, -20(s0)
	addi t0, a0, 0
	mv a0, t0
	mv a2, t2
	call getvalue
	mv t2, a0
	addw t2, s2, t2
	bgt s1, t2, .LBB35
	j .LBB36
.LBB34:
	j .LBB30
.LBB35:
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	lw t2, -36(s0)
	lw s1, -24(s0)
	lw a3, -32(s0)
	addi t0, a0, 0
	mv a0, t0
	mv a1, t2
	mv a2, s1
	call getvalue
	mv s1, a0
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	lw a1, -36(s0)
	lw t2, -32(s0)
	lw a3, -20(s0)
	addi t0, a0, 0
	mv a0, t0
	mv a2, t2
	call getvalue
	mv t2, a0
	addw a1, s1, t2
	lw s1, -24(s0)
	lw t2, -36(s0)
	mulw t2, s1, t2
	lw s1, -20(s0)
	addw s1, t2, s1
	lui t2, %hi(.G.temp)
	addi t2, t2, %lo(.G.temp)
	add a0, zero, t2
	li t2, 4
	mulw t2, s1, t2
	add a0, a0, t2
	sw a1, 0(a0)
	lw t2, -24(s0)
	lw s1, -36(s0)
	mulw t2, t2, s1
	lw s1, -20(s0)
	addw t2, t2, s1
	lui s1, %hi(.G.temp)
	addi s1, s1, %lo(.G.temp)
	add s1, zero, s1
	li a0, 4
	mulw t2, t2, a0
	add s1, s1, t2
	lw t2, 0(s1)
	mv a0, t2
	call putint
	li a0, 10
	call putch
	j .LBB36
.LBB36:
	j .LBB34
    .size floyd, .-floyd
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB37:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	call getint
	sw a0, -20(s0)
	lui t2, %hi(.G.w)
	addi t2, t2, %lo(.G.w)
	add a0, zero, t2
	addi t0, a0, 0
	mv a0, t0
	call getarray
	lui t2, %hi(.G.w)
	addi t2, t2, %lo(.G.w)
	add a0, zero, t2
	lui t2, %hi(.G.dst)
	addi t2, t2, %lo(.G.dst)
	add a1, zero, t2
	lw a2, -20(s0)
	addi t0, a0, 0
	mv a0, t0
	addi t0, a1, 0
	mv a1, t0
	call floyd
	mv a0, zero
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
    .size main, .-main
