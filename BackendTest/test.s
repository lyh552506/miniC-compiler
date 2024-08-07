    .file  "/home/nanqin/compiler/SB-compiler/BackendTest/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.arr1
    .bss
    .align  3
    .type  .G.arr1, @object
    .size  .G.arr1, 57600
.G.arr1:
    .zero  57600
    .globl  .G.arr2
    .align  3
    .type  .G.arr2, @object
    .size  .G.arr2, 107520
.G.arr2:
    .zero  107520
    .text
    .align  1
    .globl  loop1
    .type  loop1, @function
loop1:
.LBB0:
	addi sp, sp, -64
	sd ra, 56(sp)
	sd s0, 48(sp)
	addi s0, sp, 64
	lui s2, %hi(.G.arr1)
	addi s2, s2, %lo(.G.arr1)
	li a7, 48
	li s3, 240
	li s4, 960
	li s5, 2880
	li a6, 5760
	j .LBB1
.LBB1:
	sw a0, -52(s0)
	sw a1, -48(s0)
	sw zero, -44(s0)
	j .LBB2
.LBB2:
	lw t2, -44(s0)
	lw s1, -52(s0)
	blt t2, s1, .LBB3
	j .LBB4
.LBB3:
	lw t2, -44(s0)
	lw s1, -48(s0)
	blt t2, s1, .LBB5
	j .LBB4
.LBB5:
	sw zero, -40(s0)
	j .LBB6
.LBB6:
	lw t2, -40(s0)
	li t0, 2
	blt t2, t0, .LBB7
	j .LBB8
.LBB8:
	lw t2, -44(s0)
	addiw t2, t2, 1
	sw t2, -44(s0)
	j .LBB2
.LBB7:
	sw zero, -36(s0)
	j .LBB9
.LBB9:
	lw t2, -36(s0)
	li t0, 3
	blt t2, t0, .LBB10
	j .LBB11
.LBB11:
	lw t2, -40(s0)
	addiw t2, t2, 1
	sw t2, -40(s0)
	j .LBB6
.LBB10:
	sw zero, -32(s0)
	j .LBB12
.LBB12:
	lw t2, -32(s0)
	li t0, 4
	blt t2, t0, .LBB13
	j .LBB14
.LBB14:
	lw t2, -36(s0)
	addiw t2, t2, 1
	sw t2, -36(s0)
	j .LBB9
.LBB13:
	sw zero, -28(s0)
	j .LBB15
.LBB15:
	lw t2, -28(s0)
	li t0, 5
	blt t2, t0, .LBB16
	j .LBB17
.LBB17:
	lw t2, -32(s0)
	addiw t2, t2, 1
	sw t2, -32(s0)
	j .LBB12
.LBB16:
	sw zero, -24(s0)
	j .LBB18
.LBB18:
	lw t2, -24(s0)
	li t0, 6
	blt t2, t0, .LBB19
	j .LBB20
.LBB20:
	lw t2, -28(s0)
	addiw t2, t2, 1
	sw t2, -28(s0)
	j .LBB15
.LBB19:
	sw zero, -20(s0)
	j .LBB21
.LBB21:
	lw t2, -20(s0)
	li t0, 2
	blt t2, t0, .LBB22
	j .LBB23
.LBB23:
	lw t2, -24(s0)
	addiw t2, t2, 1
	sw t2, -24(s0)
	j .LBB18
.LBB22:
	lw t2, -44(s0)
	lw s1, -40(s0)
	addw s1, t2, s1
	lw t2, -36(s0)
	addw s1, s1, t2
	lw t2, -32(s0)
	addw s1, s1, t2
	lw t2, -28(s0)
	addw t2, s1, t2
	lw s1, -24(s0)
	addw t2, t2, s1
	lw s1, -20(s0)
	addw s1, t2, s1
	lw t2, -52(s0)
	addw s1, s1, t2
	lw t2, -48(s0)
	addw a1, s1, t2
	lw t2, -44(s0)
	lw a0, -40(s0)
	lw a3, -36(s0)
	lw a2, -32(s0)
	lw a4, -28(s0)
	lw a5, -24(s0)
	lw s1, -20(s0)
	mul t2, t2, a6
	mul a0, a0, s5
	add t2, t2, a0
	mul a0, a3, s4
	add a0, t2, a0
	mul t2, a2, s3
	add a0, a0, t2
	mul t2, a4, a7
	add a0, a0, t2
	slli t2, a5, 3
	add t2, a0, t2
	slli s1, s1, 2
	add t2, t2, s1
	add t2, s2, t2
	sw a1, 0(t2)
	lw t2, -20(s0)
	addiw t2, t2, 1
	sw t2, -20(s0)
	j .LBB21
.LBB4:
	ld ra, 56(sp)
	ld s0, 48(sp)
	addi sp, sp, 64
	ret 
    .size loop1, .-loop1
    .align  1
    .globl  loop2
    .type  loop2, @function
loop2:
.LBB24:
	addi sp, sp, -48
	sd ra, 40(sp)
	sd s0, 32(sp)
	addi s0, sp, 48
	lui a6, %hi(.G.arr2)
	addi a6, a6, %lo(.G.arr2)
	li a3, 28
	li a5, 224
	li s3, 896
	li s2, 1792
	li a4, 5376
	li a7, 10752
	sw zero, -44(s0)
	j .LBB25
.LBB25:
	lw t2, -44(s0)
	li t0, 10
	blt t2, t0, .LBB26
	j .LBB27
.LBB27:
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
.LBB26:
	sw zero, -40(s0)
	j .LBB28
.LBB28:
	lw t2, -40(s0)
	li t0, 2
	blt t2, t0, .LBB29
	j .LBB30
.LBB30:
	lw t2, -44(s0)
	addiw t2, t2, 1
	sw t2, -44(s0)
	j .LBB25
.LBB29:
	sw zero, -36(s0)
	j .LBB31
.LBB31:
	lw t2, -36(s0)
	li t0, 3
	blt t2, t0, .LBB32
	j .LBB33
.LBB33:
	lw t2, -40(s0)
	addiw t2, t2, 1
	sw t2, -40(s0)
	j .LBB28
.LBB32:
	sw zero, -32(s0)
	j .LBB34
.LBB34:
	lw t2, -32(s0)
	li t0, 2
	blt t2, t0, .LBB35
	j .LBB36
.LBB36:
	lw t2, -36(s0)
	addiw t2, t2, 1
	sw t2, -36(s0)
	j .LBB31
.LBB35:
	sw zero, -28(s0)
	j .LBB37
.LBB37:
	lw t2, -28(s0)
	li t0, 4
	blt t2, t0, .LBB38
	j .LBB39
.LBB39:
	lw t2, -32(s0)
	addiw t2, t2, 1
	sw t2, -32(s0)
	j .LBB34
.LBB38:
	sw zero, -24(s0)
	j .LBB40
.LBB40:
	lw t2, -24(s0)
	li t0, 8
	blt t2, t0, .LBB41
	j .LBB42
.LBB42:
	lw t2, -28(s0)
	addiw t2, t2, 1
	sw t2, -28(s0)
	j .LBB37
.LBB41:
	sw zero, -20(s0)
	j .LBB43
.LBB43:
	lw t2, -20(s0)
	li t0, 7
	blt t2, t0, .LBB44
	j .LBB45
.LBB45:
	lw t2, -24(s0)
	addiw t2, t2, 1
	sw t2, -24(s0)
	j .LBB40
.LBB44:
	lw t2, -44(s0)
	lw s1, -40(s0)
	addw t2, t2, s1
	lw s1, -32(s0)
	addw t2, t2, s1
	lw s1, -20(s0)
	addw a2, t2, s1
	lw s4, -44(s0)
	lw t2, -40(s0)
	lw s6, -36(s0)
	lw a1, -32(s0)
	lw s5, -28(s0)
	lw a0, -24(s0)
	lw s1, -20(s0)
	mul s4, s4, a7
	mul t2, t2, a4
	add t2, s4, t2
	mul s4, s6, s2
	add t2, t2, s4
	mul a1, a1, s3
	add t2, t2, a1
	mul a1, s5, a5
	add t2, t2, a1
	mul a0, a0, a3
	add t2, t2, a0
	slli s1, s1, 2
	add t2, t2, s1
	add t2, a6, t2
	sw a2, 0(t2)
	lw t2, -20(s0)
	addiw t2, t2, 1
	sw t2, -20(s0)
	j .LBB43
    .size loop2, .-loop2
    .align  1
    .globl  loop3
    .type  loop3, @function
loop3:
.LBB46:
	addi sp, sp, -80
	sd ra, 72(sp)
	sd s0, 64(sp)
	addi s0, sp, 80
	lui s7, %hi(.G.arr2)
	addi s7, s7, %lo(.G.arr2)
	li s8, 28
	li s5, 224
	li a7, 896
	li t3, 1792
	li t5, 5376
	li s3, 10752
	lui s4, %hi(.G.arr1)
	addi s4, s4, %lo(.G.arr1)
	li s6, 48
	li s2, 240
	li s10, 960
	li t4, 2880
	li s11, 5760
	li s9, 817
	j .LBB47
.LBB47:
	sw a0, -76(s0)
	sw a1, -72(s0)
	sw a2, -68(s0)
	sw a3, -64(s0)
	sw a4, -60(s0)
	sw a5, -56(s0)
	sw a6, -52(s0)
	sw zero, -20(s0)
	sw zero, -48(s0)
	j .LBB48
.LBB48:
	lw t2, -48(s0)
	li t0, 10
	blt t2, t0, .LBB49
	j .LBB50
.LBB50:
	lw a0, -20(s0)
	ld ra, 72(sp)
	ld s0, 64(sp)
	addi sp, sp, 80
	ret 
.LBB49:
	sw zero, -44(s0)
	j .LBB51
.LBB51:
	lw t2, -44(s0)
	li t0, 100
	blt t2, t0, .LBB52
	j .LBB53
.LBB53:
	lw t2, -48(s0)
	addiw t2, t2, 1
	sw t2, -48(s0)
	lw s1, -48(s0)
	lw t2, -76(s0)
	bge s1, t2, .LBB50
	j .LBB48
.LBB52:
	sw zero, -40(s0)
	j .LBB56
.LBB56:
	lw t2, -40(s0)
	li t0, 1000
	blt t2, t0, .LBB57
	j .LBB58
.LBB58:
	lw t2, -44(s0)
	addiw t2, t2, 1
	sw t2, -44(s0)
	lw s1, -44(s0)
	lw t2, -72(s0)
	bge s1, t2, .LBB53
	j .LBB51
.LBB57:
	sw zero, -36(s0)
	j .LBB61
.LBB61:
	lw t2, -36(s0)
	li t0, 10000
	blt t2, t0, .LBB62
	j .LBB63
.LBB63:
	lw t2, -40(s0)
	addiw t2, t2, 1
	sw t2, -40(s0)
	lw s1, -40(s0)
	lw t2, -68(s0)
	bge s1, t2, .LBB58
	j .LBB56
.LBB62:
	sw zero, -32(s0)
	j .LBB66
.LBB66:
	lw t2, -32(s0)
	li t0, 100000
	blt t2, t0, .LBB67
	j .LBB68
.LBB68:
	lw t2, -36(s0)
	addiw t2, t2, 1
	sw t2, -36(s0)
	lw s1, -36(s0)
	lw t2, -64(s0)
	bge s1, t2, .LBB63
	j .LBB61
.LBB67:
	sw zero, -28(s0)
	j .LBB71
.LBB71:
	lw t2, -28(s0)
	li t0, 1000000
	blt t2, t0, .LBB72
	j .LBB73
.LBB73:
	lw t2, -32(s0)
	addiw t2, t2, 1
	sw t2, -32(s0)
	lw s1, -32(s0)
	lw t2, -60(s0)
	bge s1, t2, .LBB68
	j .LBB66
.LBB72:
	sw zero, -24(s0)
	j .LBB76
.LBB76:
	lw t2, -24(s0)
	li t0, 10000000
	blt t2, t0, .LBB77
	j .LBB78
.LBB78:
	lw t2, -28(s0)
	addiw t2, t2, 1
	sw t2, -28(s0)
	lw t2, -28(s0)
	lw s1, -56(s0)
	bge t2, s1, .LBB73
	j .LBB71
.LBB77:
	lw t2, -20(s0)
	remw a5, t2, s9
	lw a4, -48(s0)
	lw t2, -44(s0)
	lw s1, -40(s0)
	lw a0, -36(s0)
	lw a1, -32(s0)
	lw a2, -28(s0)
	lw a3, -24(s0)
	mul a4, a4, s11
	mul t2, t2, t4
	add t2, a4, t2
	mul s1, s1, s10
	add s1, t2, s1
	mul t2, a0, s2
	add s1, s1, t2
	mul t2, a1, s6
	add t2, s1, t2
	slli s1, a2, 3
	add t2, t2, s1
	slli s1, a3, 2
	add t2, t2, s1
	add t2, s4, t2
	lw t2, 0(t2)
	addw a4, a5, t2
	lw t2, -48(s0)
	lw a6, -44(s0)
	lw s1, -40(s0)
	lw a0, -36(s0)
	lw a2, -32(s0)
	lw a1, -28(s0)
	lw a3, -24(s0)
	mul a5, t2, s3
	mul t2, a6, t5
	add t2, a5, t2
	mul s1, s1, t3
	add t2, t2, s1
	mul s1, a0, a7
	add s1, t2, s1
	mul t2, a2, s5
	add t2, s1, t2
	mul s1, a1, s8
	add t2, t2, s1
	slli s1, a3, 2
	add t2, t2, s1
	add t2, s7, t2
	lw t2, 0(t2)
	addw t2, a4, t2
	sw t2, -20(s0)
	lw t2, -24(s0)
	addiw t2, t2, 1
	sw t2, -24(s0)
	lw s1, -24(s0)
	lw t2, -52(s0)
	bge s1, t2, .LBB78
	j .LBB76
    .size loop3, .-loop3
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB83:
	addi sp, sp, -64
	sd ra, 56(sp)
	sd s0, 48(sp)
	addi s0, sp, 64
	call getint
	sw a0, -52(s0)
	call getint
	sw a0, -48(s0)
	call getint
	sw a0, -44(s0)
	call getint
	sw a0, -40(s0)
	call getint
	sw a0, -36(s0)
	call getint
	sw a0, -32(s0)
	call getint
	sw a0, -28(s0)
	call getint
	sw a0, -24(s0)
	call getint
	sw a0, -20(s0)
	lw a0, -52(s0)
	lw a1, -48(s0)
	call loop1
	call loop2
	lw a0, -44(s0)
	lw a1, -40(s0)
	lw a2, -36(s0)
	lw a3, -32(s0)
	lw a4, -28(s0)
	lw a5, -24(s0)
	lw a6, -20(s0)
	call loop3
	ld ra, 56(sp)
	ld s0, 48(sp)
	addi sp, sp, 64
	ret 
    .size main, .-main
