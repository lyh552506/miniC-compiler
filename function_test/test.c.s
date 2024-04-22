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
        .word   343
        .globl  b
        .align  2
        .type   b, @object
        .size   b, 4
b:
        .word   1124938547
        .globl  arr_int_undef
        .bss
        .align  3
        .type   arr_int_undef, @object
        .size   arr_int_undef, 48
arr_int_undef:
        .zero   48
        .globl  arr_float_undef
        .data
        .align  3
        .type   arr_float_undef, @object
        .size   arr_float_undef, 32
arr_float_undef:
        .word   1067030938
        .word   1079613850
        .word   1073741824
        .word   1079194419
        .zero   16
        .text
        .align  1
        .globl  function
        .type   function, @function
function:
        addi    sp,sp,-48
        sd      s0,40(sp)
        addi    s0,sp,48
        mv      a5,a0
        mv      a4,a1
        sw      a5,-36(s0)
        mv      a5,a4
        sw      a5,-40(s0)
        lw      a5,-36(s0)
        mv      a4,a5
        lw      a5,-40(s0)
        addw    a5,a4,a5
        sw      a5,-20(s0)
        lw      a5,-20(s0)
        mv      a0,a5
        ld      s0,40(sp)
        addi    sp,sp,48
        jr      ra
        .size   function, .-function
        .align  1
        .globl  main
        .type   main, @function
main:
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)
        addi    s0,sp,16
        li      t0,-401408
        addi    t0,t0,1376
        add     sp,sp,t0
        li      a5,-401408
        addi    a5,a5,-16
        add     a5,a5,s0
        sw      zero,1388(a5)
        lui     a5,%hi(arr_int_undef)
        addi    a5,a5,%lo(arr_int_undef)
        li      a4,1
        sw      a4,8(a5)
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
        lui     a5,%hi(arr_float_undef)
        addi    a5,a5,%lo(arr_float_undef)
        flw     fa5,-28(s0)
        fsw     fa5,4(a5)
        li      a5,3
        sw      a5,-32(s0)
        flw     fa5,-20(s0)
        fcvt.w.s a5,fa5,rtz
        sext.w  a5,a5
        flw     fa5,-24(s0)
        fcvt.w.s a4,fa5,rtz
        sext.w  a4,a4
        mv      a1,a4
        mv      a0,a5
        call    function
        mv      a5,a0
        sw      a5,-36(s0)
        li      a5,0
        mv      a0,a5
        li      t0,401408
        addi    t0,t0,-1376
        add     sp,sp,t0
        ld      ra,8(sp)
        ld      s0,0(sp)
        addi    sp,sp,16
        jr      ra
        .size   main, .-main
        .section        .rodata
        .align  2
.LC0:
        .word   1078355558
        .ident  "GCC: (gc891d8dc23e) 13.2.0"