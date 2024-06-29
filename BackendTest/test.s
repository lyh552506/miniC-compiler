    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	addi sp, sp, -1120
	sd ra, 1112(sp)
	sd s0, 1104(sp)
	addi s0, sp, 1120
	li %12, 32768
	addiw %12, %12, -2048
	add sp, sp, %12
	li %20, -81920
	addiw %20, %20, 1888
	addw %13, s0, %20
	mv a0, %13
	mv a1, a1
	li %14, 32768
	addiw %14, %14, -960
	mv a2, %14
	call memcpy@plt
	addiw %15, s0, -48
	mv a0, %15
	mv a1, t0
	li a2, 16
	call memcpy@plt
	addiw t0, s0, -32
	lui t1, %hi(.LC0)
	flw ft0, %lo(.LC0)(t1)
	fsw ft0, 12(t0)
	li %16, -40960
	addiw %16, %16, 928
	addw t1, s0, %16
	li %17, 344064
	addiw %17, %17, 1281
	mv t0, %17
	sw t0, 1864(t1)
	li %18, -40960
	addiw %18, %18, 928
	addw t0, s0, %18
	lw a0, 1864(t0)
	mv a0, a0
	li %19, 32768
	addiw %19, %19, -2048
	add sp, sp, %19
	ld ra, 1112(sp)
	ld s0, 1104(sp)
	addi sp, sp, 1120
	ret 
    .size main, .-main
    .section    .rodata
    .align  2
.LC0:
    .word  1076090634
