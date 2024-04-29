        .file   "test.c"
        .option nopic
        .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
        .attribute unaligned_access, 0
        .attribute stack_align, 16
        .text
        .align  1
        .globl  main
        .type   main, @function
main:
        addi    sp,sp,-32
        sd      s0,24(sp)
        addi    s0,sp,32
        lui     a5,%hi(.LC0)
        flw     fa5,%lo(.LC0)(a5)
        fsw     fa5,-20(s0)
        lui     a5,%hi(.LC0)
        flw     fa5,%lo(.LC0)(a5)
        fsw     fa5,-24(s0)
        flw     fa4,-20(s0)
        flw     fa5,-24(s0)
        fadd.s  fa5,fa4,fa5
        fsw     fa5,-28(s0)
        li      a5,2
        sw      a5,-32(s0)
        lw      a5,-32(s0)
        sext.w  a5,a5
        bne     a5,zero,.L2
        lw      a5,-32(s0)
        addiw   a5,a5,1
        sw      a5,-32(s0)
.L2:
        li      a5,0
        mv      a0,a5
        ld      s0,24(sp)
        addi    sp,sp,32
        jr      ra
        .size   main, .-main
        .section        .rodata
        .align  2
.LC0:
        .word   1078355558
        .ident  "GCC: (gc891d8dc23e) 13.2.0"