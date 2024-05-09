        .file   "test.c"
        .option nopic
        .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
        .attribute unaligned_access, 0
        .attribute stack_align, 16
        .text
        .globl  arr_global
        .bss
        .align  3
        .type   arr_global, @object
        .size   arr_global, 40000
arr_global:
        .zero   40000
        .text
        .align  1
        .globl  func
        .type   func, @function
func:
        addi    sp,sp,-32
        sd      s0,24(sp)
        addi    s0,sp,32
        mv      a5,a0
        mv      a3,a1
        mv      a4,a2
        sw      a5,-20(s0)
        mv      a5,a3
        sw      a5,-24(s0)
        mv      a5,a4
        sw      a5,-28(s0)
        lui     a5,%hi(arr_global)
        addi    a4,a5,%lo(arr_global)
        lw      a5,-24(s0)
        lw      a2,-20(s0)
        li      a3,100
        mul     a3,a2,a3
        add     a5,a3,a5
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,-28(s0)
        sw      a4,0(a5)
        nop
        ld      s0,24(sp)
        addi    sp,sp,32
        jr      ra
        .size   func, .-func
        .align  1
        .globl  main
        .type   main, @function
main:
        addi    sp,sp,-432
        sd      ra,424(sp)
        sd      s0,416(sp)
        addi    s0,sp,432
        li      a5,1
        sw      a5,-20(s0)
        li      a5,1
        sw      a5,-24(s0)
        lw      a3,-24(s0)
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,2
        add     a5,a5,a4
        slli    a5,a5,1
        add     a5,a5,a3
        slli    a5,a5,2
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,-416(a5)
        li      a5,2
        sw      a5,-28(s0)
        lw      a3,-28(s0)
        lw      a4,-24(s0)
        lw      a5,-20(s0)
        mv      a2,a3
        mv      a1,a4
        mv      a0,a5
        call    func
        li      a5,0
        mv      a0,a5
        ld      ra,424(sp)
        ld      s0,416(sp)
        addi    sp,sp,432
        jr      ra
        .size   main, .-main
        .ident  "GCC: (gc891d8dc23e) 13.2.0"