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
	mv a0, -420(s0)
	mv a1, a1
	li a2, 404
	call memcpy@plt
	mv a0, 0
	ld ra, 424(sp)
	ld s0, 416(sp)
	addi sp, sp, 432
	ret 
    .size main, .-main
