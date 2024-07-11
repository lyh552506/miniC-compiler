    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.__HELLO
    .data
    .align  3
    .type  .G.__HELLO, @object
    .size  .G.__HELLO, 400
.G.__HELLO:
    .word  87
    .word  101
    .word  108
    .word  99
    .word  111
    .word  109
    .word  101
    .word  32
    .word  116
    .word  111
    .word  32
    .word  116
    .word  104
    .word  101
    .word  32
    .word  74
    .word  97
    .word  112
    .word  97
    .word  114
    .word  105
    .word  32
    .word  80
    .word  97
    .word  114
    .word  107
    .word  33
    .word  10
    .zero  288
    .globl  .G.N4__mE___
    .align  3
    .type  .G.N4__mE___, @object
    .size  .G.N4__mE___, 1200
.G.N4__mE___:
    .word  83
    .word  97
    .word  97
    .word  98
    .word  97
    .word  114
    .word  117
    .zero  172
    .word  75
    .word  97
    .word  98
    .word  97
    .word  110
    .zero  180
    .word  72
    .word  97
    .word  115
    .word  104
    .word  105
    .word  98
    .word  105
    .word  114
    .word  111
    .word  107
    .word  111
    .word  117
    .zero  152
    .word  65
    .word  114
    .word  97
    .word  105
    .word  103
    .word  117
    .word  109
    .word  97
    .zero  168
    .word  72
    .word  117
    .word  110
    .word  98
    .word  111
    .word  114
    .word  117
    .word  116
    .word  111
    .word  32
    .word  80
    .word  101
    .word  110
    .word  103
    .word  105
    .word  110
    .zero  136
    .word  84
    .word  97
    .word  105
    .word  114
    .word  105
    .word  107
    .word  117
    .word  32
    .word  79
    .word  111
    .word  107
    .word  97
    .word  109
    .word  105
    .zero  144
    .globl  .G.saY_HeI10_To
    .align  3
    .type  .G.saY_HeI10_To, @object
    .size  .G.saY_HeI10_To, 160
.G.saY_HeI10_To:
    .word  32
    .word  115
    .word  97
    .word  121
    .word  115
    .word  32
    .word  104
    .word  101
    .word  108
    .word  108
    .word  111
    .word  32
    .word  116
    .word  111
    .word  32
    .zero  100
    .globl  .G.RET
    .align  3
    .type  .G.RET, @object
    .size  .G.RET, 20
.G.RET:
    .word  10
    .zero  16
    .text
    .align  1
    .globl  putstr
    .type  putstr, @function
putstr:
.LBB0:
	addi sp, sp, -48
	sd ra, 40(sp)
	sd s0, 32(sp)
	addi s0, sp, 48
	sd s1, -36(s0)
	mv t2, a0
	j .LBB1
.LBB1:
	sd t2, -28(s0)
	li t2, 0
	sw t2, -20(s0)
	j .LBB2
.LBB2:
	lw s1, -20(s0)
	ld t2, -28(s0)
	add t2, zero, t2
	li a0, 4
	mulw s1, s1, a0
	add t2, t2, s1
	lw t2, 0(t2)
	bne t2, zero, .LBB3
	j .LBB4
.LBB3:
	lw s1, -20(s0)
	ld t2, -28(s0)
	add a0, zero, t2
	li t2, 4
	mulw t2, s1, t2
	add a0, a0, t2
	lw s1, 0(a0)
	mv a0, s1
	call putch
	lw t2, -20(s0)
	addiw t2, t2, 1
	sw t2, -20(s0)
	j .LBB2
.LBB4:
	lw t2, -20(s0)
	mv a0, t2
	ld s1, -36(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
    .size putstr, .-putstr
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB5:
	addi sp, sp, -48
	sd ra, 40(sp)
	sd s0, 32(sp)
	addi s0, sp, 48
	sd s1, -36(s0)
	lui t2, %hi(.G.__HELLO)
	addi t2, t2, %lo(.G.__HELLO)
	add s1, zero, t2
	addi t2, s1, 0
	mv a0, t2
	call putstr
	li t2, 0
	sw t2, -28(s0)
	j .LBB6
.LBB6:
	j .LBB7
.LBB7:
	lw s1, -28(s0)
	li t2, 6
	divw t2, s1, t2
	sw t2, -24(s0)
	lw t2, -28(s0)
	li s1, 6
	remw t2, t2, s1
	sw t2, -20(s0)
	lw s1, -24(s0)
	lw t2, -20(s0)
	bne s1, t2, .LBB8
	j .LBB9
.LBB10:
	mv a0, zero
	ld s1, -36(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
.LBB8:
	lw a0, -24(s0)
	lui t2, %hi(.G.N4__mE___)
	addi t2, t2, %lo(.G.N4__mE___)
	add s1, zero, t2
	li t2, 200
	mulw t2, a0, t2
	add s1, s1, t2
	addi t2, s1, 0
	mv a0, t2
	call putstr
	lui t2, %hi(.G.saY_HeI10_To)
	addi t2, t2, %lo(.G.saY_HeI10_To)
	add s1, zero, t2
	addi t2, s1, 0
	mv a0, t2
	call putstr
	lw a0, -20(s0)
	lui t2, %hi(.G.N4__mE___)
	addi t2, t2, %lo(.G.N4__mE___)
	add s1, zero, t2
	li t2, 200
	mulw t2, a0, t2
	add s1, s1, t2
	addi t2, s1, 0
	mv a0, t2
	call putstr
	lui t2, %hi(.G.RET)
	addi t2, t2, %lo(.G.RET)
	add s1, zero, t2
	addi t2, s1, 0
	mv a0, t2
	call putstr
	j .LBB9
.LBB9:
	lw t2, -28(s0)
	li s1, 17
	mulw t2, t2, s1
	addiw t2, t2, 23
	li s1, 32
	remw t2, t2, s1
	sw t2, -28(s0)
	lw t2, -28(s0)
	beq t2, zero, .LBB11
	j .LBB12
.LBB11:
	j .LBB10
.LBB12:
	j .LBB6
    .size main, .-main
