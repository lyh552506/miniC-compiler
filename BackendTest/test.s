    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .C..8
    .bss
    .align  -1
    .type  .C..8, @object
    .size  .C..8, 1919253024
.C..8:
    .zero  1919253024
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	addi sp, sp, -432
	sd ra, 424(sp)
	sd s0, 416(sp)
	addi s0, sp, 432
	sd a1, -24(a1)
	addi t0, s0, -428
	mv a0, t0
	lui t2, %hi(.C..8)
	addi a1, t2, %lo(.C..8)
	mv a1, a1
	li a2, 404
	lui t2, %hi(.C..8)
	addi t2, t2, %lo(.C..8)
	call memcpy@plt
	mv a0, zero
	ld ra, 424(sp)
	ld s0, 416(sp)
	addi sp, sp, 432
	ret 
    .size main, .-main
