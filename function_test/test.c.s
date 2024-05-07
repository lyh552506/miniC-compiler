        .file   "test.c"
        .option nopic
        .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
        .attribute unaligned_access, 0
        .attribute stack_align, 16
        .text
        .align  1
        .globl  func1
        .type   func1, @function
func1:
        addi    sp,sp,-48
        sd      s0,40(sp)
        addi    s0,sp,48
        mv      t4,a0
        mv      t3,a1
        mv      t1,a2
        mv      a0,a3
        mv      a1,a4
        mv      a2,a5
        mv      a3,a6
        mv      a4,a7
        mv      a5,t4
        sw      a5,-20(s0)
        mv      a5,t3
        sw      a5,-24(s0)
        mv      a5,t1
        sw      a5,-28(s0)
        mv      a5,a0
        sw      a5,-32(s0)
        mv      a5,a1
        sw      a5,-36(s0)
        mv      a5,a2
        sw      a5,-40(s0)
        mv      a5,a3
        sw      a5,-44(s0)
        mv      a5,a4
        sw      a5,-48(s0)
        lw      a5,-20(s0)
        mv      a4,a5
        lw      a5,-24(s0)
        addw    a5,a4,a5
        sext.w  a5,a5
        mv      a0,a5
        ld      s0,40(sp)
        addi    sp,sp,48
        jr      ra
        .size   func1, .-func1
        .align  1
        .globl  func2
        .type   func2, @function
func2:
        addi    sp,sp,-48
        sd      s0,40(sp)
        addi    s0,sp,48
        mv      t4,a0
        mv      t3,a1
        mv      t1,a2
        mv      a0,a3
        mv      a1,a4
        mv      a2,a5
        mv      a3,a6
        mv      a4,a7
        mv      a5,t4
        sw      a5,-20(s0)
        mv      a5,t3
        sw      a5,-24(s0)
        mv      a5,t1
        sw      a5,-28(s0)
        mv      a5,a0
        sw      a5,-32(s0)
        mv      a5,a1
        sw      a5,-36(s0)
        mv      a5,a2
        sw      a5,-40(s0)
        mv      a5,a3
        sw      a5,-44(s0)
        mv      a5,a4
        sw      a5,-48(s0)
        lw      a5,-20(s0)
        mv      a4,a5
        lw      a5,-24(s0)
        addw    a5,a4,a5
        sext.w  a5,a5
        mv      a0,a5
        ld      s0,40(sp)
        addi    sp,sp,48
        jr      ra
        .size   func2, .-func2
        .align  1
        .globl  main
        .type   main, @function
main:
        addi    sp,sp,-48
        sd      ra,40(sp)
        sd      s0,32(sp)
        addi    s0,sp,48
        li      a5,8
        sd      a5,0(sp)
        li      a7,7
        li      a6,6
        li      a5,5
        li      a4,4
        li      a3,3
        li      a2,2
        li      a1,1
        li      a0,0
        call    func1
        li      a5,11
        sd      a5,24(sp)
        li      a5,10
        sd      a5,16(sp)
        li      a5,9
        sd      a5,8(sp)
        li      a5,8
        sd      a5,0(sp)
        li      a7,7
        li      a6,6
        li      a5,5
        li      a4,4
        li      a3,3
        li      a2,2
        li      a1,1
        li      a0,0
        call    func2
        li      a5,0
        mv      a0,a5
        ld      ra,40(sp)
        ld      s0,32(sp)
        addi    sp,sp,48
        jr      ra
        .size   main, .-main
        .ident  "GCC: (gc891d8dc23e) 13.2.0"