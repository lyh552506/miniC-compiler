    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.arr_global
    .data
    .align  3
    .type  .G.arr_global, @object
    .size  .G.arr_global, 400
.G.arr_global:
    .word  1
    .word  2
    .word  3
    .word  4
    .word  5
    .zero  380
    .globl  .C..18
    .align  3
    .type  .C..18, @object
    .size  .C..18, 32
.C..18:
    .word  1
    .word  2
    .word  3
    .word  4
    .word  5
    .word  6
    .zero  8
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	addi sp, sp, -64
	sd ra, 56(sp)
	sd s0, 48(sp)
	addi s0, sp, 64
	sd s1, -24(s0)
	addi t0, s0, -56
	mv a0, t0
	lui t2, %hi(.C..18)
	addi a1, t2, %lo(.C..18)
	mv a1, a1
	li a2, 32
	lui t2, %hi(.C..18)
	addi t2, t2, %lo(.C..18)
	call memcpy@plt
	lui t2, %hi(.G.arr_global)
	addi t2, t2, %lo(.G.arr_global)
	add t0, zero, t2
	lw s1, 0(t0)
	lui t2, %hi(.G.arr_global)
	addi t2, t2, %lo(.G.arr_global)
	add t0, zero, t2
	lw t2, 4(t0)
	addw s1, s1, t2
	lui t2, %hi(.G.arr_global)
	addi t2, t2, %lo(.G.arr_global)
	add t0, zero, t2
	lw t2, 8(t0)
	addw s1, t2, s1
	lui t2, %hi(.G.arr_global)
	addi t2, t2, %lo(.G.arr_global)
	add t0, zero, t2
	lw t2, 12(t0)
	addw t2, t2, s1
	lui s1, %hi(.G.arr_global)
	addi s1, s1, %lo(.G.arr_global)
	add t0, zero, s1
	lw s1, 16(t0)
	addw a0, s1, t2
	mv a0, a0
	ld s1, -24(s0)
	ld ra, 56(sp)
	ld s0, 48(sp)
	addi sp, sp, 64
	ret 
    .size main, .-main
