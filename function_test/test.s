        .file   "test.c"
        .option nopic
        .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
        .attribute unaligned_access, 0
        .attribute stack_align, 16
        .text
        
        .globl  a
        .section        .sdata,"aw"
        .align  2
        .type   a, @object
        .size   a, 4
a:
        .word   1
        
        .globl  b
        .section        .sbss,"aw",@nobits
        .align  2
        .type   b, @object
        .size   b, 4
b:
        .zero   4
        .globl  d
        .align  2
        .type   d, @object
        .size   d, 4
d:
        .zero   4
        .globl  arri
        .bss
        .align  3
        .type   arri, @object
        .size   arri, 20
arri:
        .zero   20
        .text
        .align  1
        .globl  main
        .type   main, @function
main:
        addi    sp,sp,-64
        sd      s0,56(sp)
        addi    s0,sp,64
        li      a5,1
        sw      a5,-64(s0)
        lui     a5,%hi(a)
        li      a4,10
        sw      a4,%lo(a)(a5)
        lui     a5,%hi(b)
        li      a4,3
        sw      a4,%lo(b)(a5)
        lui     a5,%hi(d)
        lui     a4,%hi(.LC0)
        flw     fa5,%lo(.LC0)(a4)
        fsw     fa5,%lo(d)(a5)
        lui     a5,%hi(a)
        lw      a4,%lo(a)(a5)
        lui     a5,%hi(b)
        lw      a5,%lo(b)(a5)
        remw    a5,a4,a5
        sw      a5,-20(s0)
        lw      a5,-20(s0)
        mv      a0,a5
        ld      s0,56(sp)
        addi    sp,sp,64
        jr      ra
        .size   main, .-main
        .section        .rodata
        .align  2
.LC0:
        .word   1065353216
        .ident  "GCC: (gc891d8dc23e) 13.2.0"