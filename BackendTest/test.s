    .file  "/home/nanqin/compiler/SB-compiler/BackendTest/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .C..13
    .data
    .align  3
    .type  .C..13, @object
    .size  .C..13, 32
.C..13:
    .word  1
    .word  2
    .word  3
    .word  4
    .zero  8
    .word  7
    .zero  4
    .globl  .C..21
    .bss
    .align  3
    .type  .C..21, @object
    .size  .C..21, 32
.C..21:
    .zero  32
    .globl  .C..32
    .data
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
    .globl  .C..43
    .align  3
    .type  .C..43, @object
    .size  .C..43, 32
.C..43:
    .word  1
    .word  2
    .word  3
    .zero  4
    .word  5
    .zero  8
    .word  8
    .globl  .C..65
    .align  3
    .type  .C..65, @object
    .size  .C..65, 32
.C..65:
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
	LoadGlobalAddr %16, .C..65
	LoadGlobalAddr %10, .C..43
	LoadGlobalAddr %7, .C..32
	LoadGlobalAddr %6, .C..21
	LoadGlobalAddr %5, .C..13
	StackAlloc %0
	StackAlloc %1
	StackAlloc %2
	StackAlloc %3
	StackAlloc %4
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
	addi %8, %4, 24
	lw %9, %8
	mv a0, %1
	mv a1, %10
	li a2, 32
	call memcpy@plt
	addi %11, %1, 24
	sw %9, %11
	addi %12, %1, 20
	lw %13, %12
	addi %14, %2, 20
	lw %15, %14
	mv a0, %0
	mv a1, %16
	li a2, 32
	call memcpy@plt
	sw %13, %0
	addi %17, %0, 4
	sw %15, %17
	addi %18, %0, 28
	lw %19, %18
	lw %20, %0
	addw %21, %19, %20
	addi %22, %0, 4
	lw %23, %22
	addw %24, %21, %23
	addi %25, %1, 24
	lw %26, %25
	addw %27, %24, %26
	mv a0, %27
	ret 
    .size main, .-main
