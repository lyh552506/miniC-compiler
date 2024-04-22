    .file  "test.c"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  a
    .data
    .align  2
    .type  a, @object
    .size  a, 4
a:
    .word  343
    .globl  b
    .align  2
    .type  b, @object
    .size  b, 4
b:
    .word  1124938547
    .globl  arr_int_undef
    .bss
    .align  3
    .type  arr_int_undef, @object
    .size  arr_int_undef, 48
arr_int_undef:
    .zero  48
    .globl  arr_float_undef
    .data
    .align  3
    .type  arr_float_undef, @object
    .size  arr_float_undef, 32
arr_float_undef:
    .word  1067030938
    .word  1079613850
    .word  1073741824
    .word  1079194419
    .zero  16
    .text
    .align  1
    .globl  function
    .type  function, @function
function:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32
.LBB0_0:
    addw .27, .19, .22
    lw a0, .27
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret
    .size function, -function
    .align  1
    .globl  main
    .type  main, @function
main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32
.LBB1_0:
    j .LBB1_1
.LBB1_1:
Error: No Such Instruction.
    li .70, 0
    slt .41, .70, .63
    beqz .41, .LBB1_3
    j .LBB1_2
.LBB1_2:
    subw .45, .63, 1
    j .LBB1_1
.LBB1_3:
    li .78, 0
    slt .51, .78, .63
    beqz .51, .LBB1_5
    j .LBB1_4
.LBB1_4:
    subw .54, .63, 1
    j .LBB1_6
.LBB1_5:
    addw .59, .63, 1
    j .LBB1_6
.LBB1_6:
    lw a0, 0
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret
    .size main, -main
