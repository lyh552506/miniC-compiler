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
	li %0, 1
	sw %0, ---i32*FrameObject:.2---
	li %1, 98799616
	addiw %1, %1, -837
	sw %1, ---i32*FrameObject:.5---
	lw %2, ---i32*FrameObject:.2---
	lw %3, ---i32*FrameObject:.5---
	addw %4, %2, %3
	sw %4, ---i32*FrameObject:.2---
	li %5, 989892608
	addiw %5, -902
	mv a0, %5
	ret 
    .size main, -main
