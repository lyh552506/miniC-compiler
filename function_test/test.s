--------LiveInterval--------
inst0Liveness:
inst1Liveness:%2---FrameObject---
inst2Liveness:
inst3Liveness:---FrameObject---%3
inst4Liveness:---FrameObject---
inst5Liveness:%4
inst6Liveness:---FrameObject---%5
inst7Liveness:
inst8Liveness:
--------Block:.LBB0--------
%5[6,6]
%3[3,3]
%4[5,5]
---FrameObject---[3,3]
---FrameObject---[1,1][4,4][6,6]
%2[1,1]
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
	li %2, 0
	sw %2, ---FrameObject---
	li %3, 1
	sw %3, ---FrameObject---
	lw %4, ---FrameObject---
	addi %5, %4, 1
	sw %5, ---FrameObject---
	li a0, 0
	ret 
    .size main, -main

