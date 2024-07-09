    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.b
    .data
    .align  2
    .type  .G.b, @object
    .size  .G.b, 4
.G.b:
    .word  5
    .globl  .G.c
    .align  3
    .type  .G.c, @object
    .size  .G.c, 16
.G.c:
    .word  6
    .word  7
    .word  8
    .word  9
    .globl  .C..58
    .align  3
    .type  .C..58, @object
    .size  .C..58, 64
.C..58:
    .zero  4
    .word  9
    .zero  24
    .word  8
    .word  3
    .zero  24
    .globl  .C..80
    .align  3
    .type  .C..80, @object
    .size  .C..80, 140
.C..80:
    .zero  40
    .word  2
    .word  1
    .word  8
    .zero  88
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	addi sp, sp, -240
	sd ra, 232(sp)
	sd s0, 224(sp)
	addi s0, sp, 240
	sd s1, -24(s0)
	li a0, 3
	call putint
	li a0, 3
	call putint
	li a0, 1
	call putint
	li a0, 10
	call putch
	j .LBB1
.LBB1:
	li t0, 1
	xor t2, t0, zero
	snez t2, t2
	bne t2, zero, .LBB2
	j .LBB1
.LBB2:
	li a0, 1
	call putint
	li a0, 10
	call putch
	lui t2, %hi(.G.c)
	addi t2, t2, %lo(.G.c)
	add s1, zero, t2
	li t2, 1
	sw t2, 8(s1)
	addi t0, s0, -88
	mv a0, t0
	lui t2, %hi(.C..58)
	addi a1, t2, %lo(.C..58)
	li a2, 64
	lui t2, %hi(.C..58)
	addi t2, t2, %lo(.C..58)
	call memcpy@plt
	lui t2, %hi(.G.c)
	addi t2, t2, %lo(.G.c)
	add t2, zero, t2
	lw t2, 8(t2)
	xor t2, t2, zero
	snez t2, t2
	bne t2, zero, .LBB3
	j .LBB4
.LBB3:
	addi t0, s0, -228
	mv a0, t0
	lui t2, %hi(.C..80)
	addi a1, t2, %lo(.C..80)
	li a2, 140
	lui t2, %hi(.C..80)
	addi t2, t2, %lo(.C..80)
	call memcpy@plt
	addi t2, s0, -228
	lw a0, 40(t2)
	call putint
	addi t2, s0, -228
	lw a0, 44(t2)
	call putint
	addi t2, s0, -228
	lw a0, 48(t2)
	call putint
	j .LBB4
.LBB4:
	li a0, 10
	call putch
	lui t2, %hi(.G.b)
	lw a0, %lo(.G.b)(t2)
	call putint
	li a0, 10
	call putch
	lui t2, %hi(.G.c)
	addi t2, t2, %lo(.G.c)
	add t2, zero, t2
	lw a0, 0(t2)
	call putint
	lui t2, %hi(.G.c)
	addi t2, t2, %lo(.G.c)
	add t2, zero, t2
	lw a0, 4(t2)
	call putint
	lui t2, %hi(.G.c)
	addi t2, t2, %lo(.G.c)
	add t2, zero, t2
	lw a0, 8(t2)
	call putint
	lui t2, %hi(.G.c)
	addi t2, t2, %lo(.G.c)
	add t2, zero, t2
	lw a0, 12(t2)
	call putint
	li a0, 10
	call putch
	mv a0, zero
	ld s1, -24(s0)
	ld ra, 232(sp)
	ld s0, 224(sp)
	addi sp, sp, 240
	ret 
    .size main, .-main
