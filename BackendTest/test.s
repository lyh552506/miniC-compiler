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
	addi sp, sp, -432
	sd ra, 424(sp)
	sd s0, 416(sp)
	addi s0, sp, 432
	sd t2, -24(s0)
	addi t0, s0, -428
	li t2, 1234
	sw t2, 176(t0)
	addi t0, s0, -428
	lw a0, 176(t0)
	mv a0, a0
	ld t2, -24(s0)
	ld ra, 424(sp)
	ld s0, 416(sp)
	addi sp, sp, 432
	ret 
    .size main, .-main
