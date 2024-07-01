    .file  "file"
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
    .globl  .G.int1
    .align  2
    .type  .G.int1, @object
    .size  .G.int1, 4
.G.int1:
    .zero  4
    .globl  .G.int2
    .data
    .align  2
    .type  .G.int2, @object
    .size  .G.int2, 4
.G.int2:
    .word  2
    .globl  .G.float1
    .align  2
    .type  .G.float1, @object
    .size  .G.float1, 4
.G.float1:
    .word  1066192077
    .globl  .G.float2
    .bss
    .align  2
    .type  .G.float2, @object
    .size  .G.float2, 4
.G.float2:
    .zero  4
    .text
    .align  1
    .globl  loop1
    .type  loop1, @function
loop1:
.LBB0:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	sd s0, -24(s0)
	mv a0, a0
	mv a1, a1
	j .LBB1
.LBB1:
	mv a5, zero
	j .LBB2
.LBB2:
	blt a5, a0, .LBB3
	j .LBB4
.LBB4:
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
.LBB3:
	blt a5, a1, .LBB5
	j .LBB4
.LBB6:
	li t0, 2
	blt a4, t0, .LBB7
	j .LBB8
.LBB8:
	addiw a5, a5, 1
	mv a5, a5
	j .LBB2
.LBB9:
	li t0, 3
	blt a3, t0, .LBB10
	j .LBB11
.LBB11:
	addiw a4, a4, 1
	mv a4, a4
	j .LBB6
.LBB12:
	li t0, 4
	blt a2, t0, .LBB13
	j .LBB14
.LBB14:
	addiw a3, a3, 1
	mv a3, a3
	j .LBB9
.LBB15:
	li t0, 5
	blt s1, t0, .LBB16
	j .LBB17
.LBB17:
	addiw a2, a2, 1
	mv a2, a2
	j .LBB12
.LBB18:
	li t0, 6
	blt t2, t0, .LBB19
	j .LBB20
.LBB20:
	addiw s1, s1, 1
	mv s1, s1
	j .LBB15
.LBB21:
	li t0, 2
	blt s0, t0, .LBB22
	j .LBB23
.LBB22:
	addw a6, a5, a4
	addw a6, a3, a6
	addw a6, a2, a6
	addw a6, s1, a6
	addw a6, t2, a6
	addw a6, s0, a6
	addw a0, a0, a6
	addw a1, a1, a0
	lui a0, %hi(.G.arr1)
	addi a0, a0, %lo(.G.arr1)
	addw t2, s0, a0
	li t0, 4096
	addiw t0, t0, 1664
	mv a0, t0
	mulw a0, a5, a0
	addw t2, t2, a0
	li t0, -4096
	addiw t0, t0, -1216
	mv a0, t0
	mulw a0, a4, a0
	addw t2, t2, a0
	li a0, 960
	mulw a0, a3, a0
	addw t2, t2, a0
	li a0, 240
	mulw a0, a2, a0
	addw t2, t2, a0
	li a0, 48
	mulw s1, s1, a0
	addw t2, t2, s1
	li s1, 8
	mulw t2, t2, s1
	addw t2, t2, t2
	li t2, 4
	mulw t2, s0, t2
	addw t2, t2, t2
	sw a1, 0(t2)
	addiw s0, s0, 1
	mv s0, s0
	j .LBB21
.LBB23:
	addiw t2, t2, 1
	mv t2, t2
	j .LBB18
.LBB19:
	mv s0, zero
	j .LBB21
.LBB16:
	mv t2, zero
	j .LBB18
.LBB13:
	mv s1, zero
	j .LBB15
.LBB10:
	mv a2, zero
	j .LBB12
.LBB7:
	mv a3, zero
	j .LBB9
.LBB5:
	mv a4, zero
	j .LBB6
    .size loop1, .-loop1
    .align  1
    .globl  loop2
    .type  loop2, @function
loop2:
.LBB24:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	sd s0, -24(s0)
	mv t2, zero
	j .LBB25
.LBB25:
	li t0, 10
	blt t2, t0, .LBB26
	j .LBB27
.LBB27:
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
.LBB28:
	li t0, 2
	blt a3, t0, .LBB29
	j .LBB30
.LBB30:
	addiw t2, t2, 1
	mv t2, t2
	j .LBB25
.LBB31:
	li t0, 3
	blt a2, t0, .LBB32
	j .LBB33
.LBB33:
	addiw a3, a3, 1
	mv a3, a3
	j .LBB28
.LBB34:
	li t0, 2
	blt a1, t0, .LBB35
	j .LBB36
.LBB36:
	addiw a2, a2, 1
	mv a2, a2
	j .LBB31
.LBB37:
	li t0, 4
	blt a0, t0, .LBB38
	j .LBB39
.LBB39:
	addiw a1, a1, 1
	mv a1, a1
	j .LBB34
.LBB40:
	li t0, 8
	blt s0, t0, .LBB41
	j .LBB42
.LBB42:
	addiw a0, a0, 1
	mv a0, a0
	j .LBB37
.LBB43:
	li t0, 7
	blt s1, t0, .LBB44
	j .LBB45
.LBB44:
	addw a4, t2, a3
	addw a4, a1, a4
	addw a5, s1, a4
	lui a4, %hi(.G.arr2)
	addi a4, a4, %lo(.G.arr2)
	addw t2, s0, a4
	li t0, 4096
	addiw t0, t0, -1536
	mv a4, t0
	mulw t2, t2, a4
	addw t2, t2, t2
	li t0, 4096
	addiw t0, t0, 1280
	mv t2, t0
	mulw t2, a3, t2
	addw t2, t2, t2
	li t2, 1792
	mulw t2, a2, t2
	addw t2, t2, t2
	li t2, 896
	mulw t2, a1, t2
	addw t2, t2, t2
	li t2, 224
	mulw t2, a0, t2
	addw t2, t2, t2
	li t2, 28
	mulw t2, s0, t2
	addw t2, t2, t2
	li t2, 4
	mulw t2, s1, t2
	addw t2, t2, t2
	sw a5, 0(t2)
	addiw s1, s1, 1
	mv s1, s1
	j .LBB43
.LBB45:
	addiw s0, s0, 1
	mv s0, s0
	j .LBB40
.LBB41:
	mv s1, zero
	j .LBB43
.LBB38:
	mv s0, zero
	j .LBB40
.LBB35:
	mv a0, zero
	j .LBB37
.LBB32:
	mv a1, zero
	j .LBB34
.LBB29:
	mv a2, zero
	j .LBB31
.LBB26:
	mv a3, zero
	j .LBB28
    .size loop2, .-loop2
    .align  1
    .globl  loop3
    .type  loop3, @function
loop3:
.LBB46:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	sd s0, -24(s0)
	mv a0, a0
	mv a1, a1
	mv a2, a2
	mv a3, a3
	mv a4, a4
	mv a5, a5
	mv a6, a6
	j .LBB47
.LBB47:
	mv a2, zero
	mv t2, zero
	j .LBB48
.LBB48:
	li t0, 10
	blt a2, t0, .LBB49
	j .LBB70
.LBB50:
	mv a0, t2
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
.LBB51:
	li t0, 100
	blt a3, t0, .LBB52
	j .LBB73
.LBB53:
	addiw a2, a2, 1
	bge a2, a0, .LBB71
	j .LBB69
.LBB54:
	li t0, 1000
	blt a4, t0, .LBB55
	j .LBB76
.LBB56:
	addiw a3, a3, 1
	bge a3, a1, .LBB74
	j .LBB72
.LBB57:
	li t0, 8192
	addiw t0, t0, 1808
	mv t0, t0
	blt a0, t0, .LBB58
	j .LBB79
.LBB59:
	addiw a4, a4, 1
	bge a4, a2, .LBB77
	j .LBB75
.LBB60:
	li t0, 98304
	addiw t0, t0, 1696
	mv t0, t0
	blt s1, t0, .LBB61
	j .LBB82
.LBB62:
	addiw a0, a0, 1
	bge a0, a3, .LBB80
	j .LBB78
.LBB63:
	li t0, 999424
	addiw t0, t0, 576
	mv t0, t0
	blt s0, t0, .LBB64
	j .LBB85
.LBB65:
	addiw s1, s1, 1
	bge s1, a4, .LBB83
	j .LBB81
.LBB66:
	li t0, 9998336
	addiw t0, t0, 1664
	mv t0, t0
	blt t2, t0, .LBB67
	j .LBB88
.LBB67:
	li a1, 817
	remw a7, t2, a1
	lui a1, %hi(.G.arr1)
	addi a1, a1, %lo(.G.arr1)
	addw a1, s0, a1
	li t0, 4096
	addiw t0, t0, 1664
	mv a1, t0
	mulw a1, a2, a1
	addw a1, a1, a1
	li t0, -4096
	addiw t0, t0, -1216
	mv a1, t0
	mulw a1, a3, a1
	addw a1, a1, a1
	li a1, 960
	mulw a1, a4, a1
	addw a1, a1, a1
	li a1, 240
	mulw a1, a0, a1
	addw a1, a1, a1
	li a1, 48
	mulw a1, s1, a1
	addw a1, a1, a1
	li a1, 8
	mulw a1, s0, a1
	addw a1, a1, a1
	li a1, 4
	mulw a1, t2, a1
	addw a1, a1, a1
	lw a1, 0(a1)
	addw a7, a1, a7
	lui a1, %hi(.G.arr2)
	addi a1, a1, %lo(.G.arr2)
	addw s1, s0, a1
	li t0, 4096
	addiw t0, t0, -1536
	mv a1, t0
	mulw a1, a2, a1
	addw s1, s1, a1
	li t0, 4096
	addiw t0, t0, 1280
	mv a1, t0
	mulw a1, a3, a1
	addw s1, s1, a1
	li a1, 1792
	mulw a1, a4, a1
	addw s1, s1, a1
	li a1, 896
	mulw a0, a0, a1
	addw s1, s1, a0
	li a0, 224
	mulw s1, s1, a0
	addw s1, s1, s1
	li s1, 28
	mulw s1, s0, s1
	addw s1, s1, s1
	li s1, 4
	mulw s1, t2, s1
	addw s1, s1, s1
	lw s1, 0(s1)
	addw t2, s1, a7
	addiw t2, t2, 1
	bge t2, a6, .LBB89
	j .LBB87
.LBB68:
	addiw s0, s0, 1
	bge s0, a5, .LBB86
	j .LBB84
.LBB64:
	mv t2, zero
	mv t2, t2
	j .LBB66
.LBB61:
	mv s0, zero
	mv t2, t2
	j .LBB63
.LBB58:
	mv s1, zero
	mv t2, t2
	j .LBB60
.LBB55:
	mv a0, zero
	mv t2, t2
	j .LBB57
.LBB52:
	mv a4, zero
	mv t2, t2
	j .LBB54
.LBB49:
	mv a3, zero
	mv t2, t2
	j .LBB51
.LBB69:
	mv a2, a2
	mv t2, t2
	j .LBB48
.LBB70:
	mv t2, t2
	j .LBB50
.LBB71:
	mv t2, t2
	j .LBB50
.LBB72:
	mv a3, a3
	mv t2, t2
	j .LBB51
.LBB73:
	mv t2, t2
	j .LBB53
.LBB74:
	mv t2, t2
	j .LBB53
.LBB75:
	mv a4, a4
	mv t2, t2
	j .LBB54
.LBB76:
	mv t2, t2
	j .LBB56
.LBB77:
	mv t2, t2
	j .LBB56
.LBB78:
	mv a0, a0
	mv t2, t2
	j .LBB57
.LBB79:
	mv t2, t2
	j .LBB59
.LBB80:
	mv t2, t2
	j .LBB59
.LBB81:
	mv s1, s1
	mv t2, t2
	j .LBB60
.LBB82:
	mv t2, t2
	j .LBB62
.LBB83:
	mv t2, t2
	j .LBB62
.LBB84:
	mv s0, s0
	mv t2, t2
	j .LBB63
.LBB85:
	mv t2, t2
	j .LBB65
.LBB86:
	mv t2, t2
	j .LBB65
.LBB87:
	mv t2, t2
	mv t2, t2
	j .LBB66
.LBB88:
	mv t2, t2
	j .LBB68
.LBB89:
	mv t2, t2
	j .LBB68
    .size loop3, .-loop3
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB90:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	sd s0, -24(s0)
	call getint
	mv t2, a0
	call getint
	mv s1, a0
	call getint
	mv s0, a0
	call getint
	mv a1, a0
	call getint
	mv a2, a0
	call getint
	mv a3, a0
	call getint
	mv a4, a0
	call getint
	mv a5, a0
	call getint
	mv a6, a0
	mv a0, t2
	mv a1, s1
	call loop1
	call loop2
	mv a0, s0
	mv a1, a1
	mv a2, a2
	mv a3, a3
	mv a4, a4
	mv a5, a5
	mv a6, a6
	call loop3
	mv a0, a0
	mv a0, a0
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
    .size main, .-main
