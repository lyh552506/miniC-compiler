    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.a
    .bss
    .align  3
    .type  .G.a, @object
    .size  .G.a, 16384
.G.a:
    .zero  16384
    .globl  .C..47
    .data
    .align  3
    .type  .C..47, @object
    .size  .C..47, 16384
.C..47:
    .zero  4096
    .word  1
    .zero  4092
    .word  2
    .word  3
    .zero  4088
    .word  4
    .word  5
    .word  6
    .zero  4084
    .globl  .C..57
    .align  3
    .type  .C..57, @object
    .size  .C..57, 16384
.C..57:
    .word  1
    .word  2
    .zero  8
    .word  3
    .word  4
    .zero  16360
    .text
    .align  1
    .globl  f1
    .type  f1, @function
f1:
.LBB0:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	sd s1, -32(s0)
	j .LBB1
.LBB1:
	sd a0, -24(s0)
	lui t2, %hi(.G.a)
	addi t2, t2, %lo(.G.a)
	add t2, zero, t2
	li t1, 4096
	addi t1, t1, -96
	mv s1, t1
	sw s1, 20(t2)
	lui t2, %hi(.G.a)
	addi t2, t2, %lo(.G.a)
	add t2, zero, t2
	li s1, 3
	li t1, 12288
	addi t1, t1, 2041
	add t0, t2, t1
	sw s1, 1671(t0)
	lui t2, %hi(.G.a)
	addi t2, t2, %lo(.G.a)
	add t2, zero, t2
	li s1, 7
	li t1, 16384
	addi t1, t1, -8
	add t0, t2, t1
	sw s1, 4(t0)
	lui t2, %hi(.G.a)
	addi t2, t2, %lo(.G.a)
	add t2, zero, t2
	li t1, 8192
	addi t1, t1, -4
	add t0, t2, t1
	lw t2, 676(t0)
	addiw a0, t2, 9
	lui t2, %hi(.G.a)
	addi t2, t2, %lo(.G.a)
	add t2, zero, t2
	li t1, 16384
	addi t1, t1, -8
	add t0, t2, t1
	lw s1, 4(t0)
	ld t2, -24(s0)
	add a1, zero, t2
	li t2, 4
	mulw t2, s1, t2
	add a1, a1, t2
	sw a0, 0(a1)
	lui t2, %hi(.G.a)
	addi t2, t2, %lo(.G.a)
	add t2, zero, t2
	lw s1, 20(t2)
	lui t2, %hi(.G.a)
	addi t2, t2, %lo(.G.a)
	add a0, zero, t2
	li t2, 4
	mulw t2, s1, t2
	add a0, a0, t2
	lw a0, 0(a0)
	ld s1, -32(s0)
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
    .size f1, .-f1
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB2:
	addi sp, sp, -16
	sd ra, 8(sp)
	sd s0, 0(sp)
	addi s0, sp, 16
	li t1, -32768
	add sp, sp, t1
	li t1, -32768
	addi t1, t1, -16
	add t0, s0, t1
	mv a0, t0
	lui t2, %hi(.C..47)
	addi a1, t2, %lo(.C..47)
	li a2, 16384
	call memcpy@plt
	li t1, -16384
	addi t1, t1, -16
	add t0, s0, t1
	mv a0, t0
	lui t2, %hi(.C..57)
	addi a1, t2, %lo(.C..57)
	li a2, 16384
	call memcpy@plt
	li t1, -16384
	addi t1, t1, -16
	add a0, s0, t1
	addi t0, a0, 0
	mv a0, t0
	call f1
	call putint
	li a0, 10
	call putch
	li t1, -16384
	addi t1, t1, -16
	add t2, s0, t1
	lw a0, 32(t2)
	li t1, 32768
	add sp, sp, t1
	ld ra, 8(sp)
	ld s0, 0(sp)
	addi sp, sp, 16
	ret 
    .size main, .-main
