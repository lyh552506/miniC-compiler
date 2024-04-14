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
        .word   1092975258
        .globl  b
        .align  2
        .type   b, @object
        .size   b, 4
b:
        .word   1
        .globl  c
        .section        .sbss,"aw",@nobits
        .align  2
        .type   c, @object
        .size   c, 4
c:
        .zero   4
        .globl  d
        .align  2
        .type   d, @object
        .size   d, 4
d:
        .zero   4
        .globl  arri
        .data
        .align  3
        .type   arri, @object
        .size   arri, 48
arri:
        .word   1
        .word   3
        .word   4
        .zero   12
        .zero   24
        .globl  arrf
        .align  3
        .type   arrf, @object
        .size   arrf, 108
arrf:
        .word   1067030938
        .zero   8
        .zero   24
        .zero   72
        .globl  arri_un
        .bss
        .align  3
        .type   arri_un, @object
        .size   arri_un, 76
arri_un:
        .zero   76
        .globl  arrf_un
        .align  3
        .type   arrf_un, @object
        .size   arrf_un, 48
arrf_un:
        .zero   48
        .text
        .align  1
        .globl  main
        .type   main, @function
main:
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)
        addi    s0,sp,16
        li      t0,-40960
        addi    t0,t0,944
        add     sp,sp,t0
        li      a5,-40960
        addi    a5,a5,-16
        add     a5,a5,s0
        addi    a4,a5,952
        li      a5,40960
        addi    a5,a5,-960
        mv      a2,a5
        li      a1,0
        mv      a0,a4
        call    memset
        li      a5,-40960
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,952(a5)
        li      a5,-40960
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,2
        sw      a4,956(a5)
        sw      zero,-20(s0)
        j       .L2
.L3:
        li      a5,-40960
        addi    a5,a5,-16
        add     a4,a5,s0
        lw      a5,-20(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,-20(s0)
        sw      a4,952(a5)
        lw      a5,-20(s0)
        addiw   a5,a5,1
        sw      a5,-20(s0)
.L2:
        lw      a5,-20(s0)
        sext.w  a4,a5
        li      a5,8192
        addi    a5,a5,1807
        ble     a4,a5,.L3
        li      a5,-40960
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,40960
        add     a5,a4,a5
        li      a4,8192
        addi    a4,a4,1807
        sw      a4,-12(a5)
        lui     a5,%hi(a)
        flw     fa4,%lo(a)(a5)
        lui     a5,%hi(.LC0)
        flw     fa5,%lo(.LC0)(a5)
        fadd.s  fa5,fa4,fa5
        lui     a5,%hi(a)
        fsw     fa5,%lo(a)(a5)
        lui     a5,%hi(b)
        lw      a5,%lo(b)(a5)
        addiw   a5,a5,1
        sext.w  a4,a5
        lui     a5,%hi(b)
        sw      a4,%lo(b)(a5)
        lui     a5,%hi(c)
        lui     a4,%hi(.LC1)
        flw     fa5,%lo(.LC1)(a4)
        fsw     fa5,%lo(c)(a5)
        li      a5,-40960
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,1004(a5)
        lui     a5,%hi(d)
        sw      a4,%lo(d)(a5)
        lui     a5,%hi(arri)
        addi    a5,a5,%lo(arri)
        sw      zero,12(a5)
        lui     a5,%hi(arrf)
        addi    a5,a5,%lo(arrf)
        fmv.s.x fa5,zero
        fsw     fa5,12(a5)
        lui     a5,%hi(arri_un)
        addi    a5,a5,%lo(arri_un)
        sw      zero,4(a5)
        lui     a5,%hi(arrf_un)
        addi    a5,a5,%lo(arrf_un)
        fmv.s.x fa5,zero
        fsw     fa5,12(a5)
        li      a5,0
        mv      a0,a5
        li      t0,40960
        addi    t0,t0,-944
        add     sp,sp,t0
        ld      ra,8(sp)
        ld      s0,0(sp)
        addi    sp,sp,16
        jr      ra
        .size   main, .-main
        .section        .rodata
        .align  2
.LC0:
        .word   1073741824
        .align  2
.LC1:
        .word   1065353216
        .ident  "GCC: (gc891d8dc23e) 13.2.0"