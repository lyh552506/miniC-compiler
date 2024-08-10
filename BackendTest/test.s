    .file  "/home/nanqin/compiler/SB-compiler/BackendTest/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	addi sp, sp, -16
	sd ra, 8(sp)
	sd s0, 0(sp)
	addi s0, sp, 16
	li a0, 0
	ld ra, 8(sp)
	ld s0, 0(sp)
	addi sp, sp, 16
	ret 
    .size main, .-main
