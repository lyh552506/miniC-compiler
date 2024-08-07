    .file  "/home/nanqin/compiler/SB-compiler/BackendTest/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .C..6
    .bss
    .align  3
    .type  .C..6, @object
    .size  .C..6, 32
.C..6:
    .zero  32
    .globl  .C..24
    .data
    .align  3
    .type  .C..24, @object
    .size  .C..24, 32
.C..24:
    .word  1
    .word  2
    .word  3
    .word  4
    .word  5
    .word  6
    .word  7
    .word  8
    .globl  .C..32
    .align  3
    .type  .C..32, @object
    .size  .C..32, 32
.C..32:
    .word  1
    .word  2
    .word  3
    .word  4
    .word  5
    .word  6
    .word  7
    .word  8
    .globl  .C..40
    .align  3
    .type  .C..40, @object
    .size  .C..40, 32
.C..40:
    .word  1
    .word  2
    .word  3
    .zero  4
    .word  5
    .zero  4
    .word  7
    .word  8
    .globl  .C..53
    .align  3
    .type  .C..53, @object
    .size  .C..53, 32
.C..53:
    .zero  8
    .word  3
    .word  4
    .word  5
    .word  6
    .word  7
    .word  8
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	addi sp, sp, -176
	sd ra, 168(sp)
	sd s0, 160(sp)
	addi s0, sp, 176
	addi %1, s0, -80
	addi %0, s0, -48
	addi %2, s0, -112
	lui %5, %hi(.C..6)
	addi %5, %5, %lo(.C..6)
	lui %13, %hi(.C..53)
	addi %13, %13, %lo(.C..53)
	lui %8, %hi(.C..40)
	addi %8, %8, %lo(.C..40)
	lui %7, %hi(.C..32)
	addi %7, %7, %lo(.C..32)
	lui %6, %hi(.C..24)
	addi %6, %6, %lo(.C..24)
	addi %4, s0, -176
	addi %3, s0, -144
	mv a0, %4
	mv a1, %5
	li a2, 32
	call memcpy@plt
	mv a0, %3
	mv a1, %6
	li a2, 32
	call memcpy@plt
	mv a0, %2
	mv a1, %7
	li a2, 32
	call memcpy@plt
	mv a0, %1
	mv a1, %8
	li a2, 32
	call memcpy@plt
	addi %9, %1, 20
	lw %10, %9
	addi %11, %2, 20
	lw %12, %11
	mv a0, %0
	mv a1, %13
	li a2, 32
	call memcpy@plt
	sw %10, %0
	addi %15, %0, 28
	lw %16, %15
	addi %19, %0, 4
	lw %17, %0
	addi %14, %0, 4
	lw %20, %19
	addw %18, %16, %17
	addi %22, %4, 16
	addw %21, %18, %20
	lw %23, %22
	addw %24, %21, %23
	sw %12, %14
	mv a0, %24
	ld ra, 168(sp)
	ld s0, 160(sp)
	addi sp, sp, 176
	ret 
    .size main, .-main
