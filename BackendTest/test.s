    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.arr
    .data
    .align  3
    .type  .G.arr, @object
    .size  .G.arr, 400
.G.arr:
    .word  1
    .word  2
    .word  3
    .word  4
    .word  5
    .zero  380
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	sd t0, -24(s0)
	lui t2, %hi(.G.arr)
	addi t2, t2, %lo(.G.arr)
	add t0, zero, t2
	lw a0, 0(t0)
	mv a0, a0
	ld t0, -24(s0)
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
    .size main, .-main
