    .file  "/home/nanqin/compiler/miniC-compiler/BackendTest/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.ints
    .bss
    .align  3
    .type  .G.ints, @object
    .size  .G.ints, 40000
.G.ints:
    .zero  40000
    .globl  .G.chas
    .align  3
    .type  .G.chas, @object
    .size  .G.chas, 40000
.G.chas:
    .zero  40000
    .globl  .G.get
    .align  3
    .type  .G.get, @object
    .size  .G.get, 40000
.G.get:
    .zero  40000
    .globl  .G.get2
    .align  3
    .type  .G.get2, @object
    .size  .G.get2, 40000
.G.get2:
    .zero  40000
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	addi sp, sp, -1200
	sd ra, 1192(sp)
	sd s0, 1184(sp)
	addi s0, sp, 1200
	li t0, -38912
	add sp, sp, t0
	sd s11, -112(s0)
	sd s10, -104(s0)
	sd s9, -96(s0)
	sd s8, -88(s0)
	sd s7, -80(s0)
	sd s6, -72(s0)
	sd s5, -64(s0)
	sd s4, -56(s0)
	sd s3, -48(s0)
	sd s2, -40(s0)
	sd s1, -32(s0)
	li s5, 40
	li s3, 94
	li s6, 37
	li s7, 47
	li t0, -40112
	add t2, s0, t0
	mv a0, t2
	lui a1, %hi(.G.get2)
	addi a1, a1, %lo(.G.get2)
	li s8, 43
	lui s4, %hi(.G.get)
	addi s4, s4, %lo(.G.get)
	li s9, 32
	lui s10, %hi(.G.chas)
	addi s10, s10, %lo(.G.chas)
	li s1, 10
	li s2, 64
	li a2, 40000
	call memcpy@plt
	call getch
	li t1, 13
	xor t2, a0, t1
	li t1, 10
	xor a1, a0, t1
	snez t2, t2
	snez a1, a1
	and t2, t2, a1
	bne t2, zero, .LBB72
.LBB137:
	li s11, 0
.LBB2:
	bge zero, s11, .LBB135
.LBB74:
	li a7, 0
	li t3, 1
	li a5, 0
.LBB3:
	slli t2, a5, 2
	add a6, s4, t2
	lw a0, 0(a6)
	li t1, 47
	slt t2, t1, a0
	li t1, 58
	slt a0, a0, t1
	and t2, t2, a0
	bne t2, zero, .LBB76
.LBB30:
	li t2, 0
	j .LBB29
.LBB135:
	li a7, 0
	li t3, 1
.LBB4:
	ble a7, zero, .LBB6
.LBB5:
	addiw a7, a7, -1
	addiw t2, a7, 1
	slli t2, t2, 2
	slli a2, t3, 2
	add t2, s10, t2
	addiw a0, t3, 1
	li t0, -40112
	add a1, s0, t0
	add a1, a1, a2
	slli a2, a0, 2
	lw t2, 0(t2)
	li t0, -40112
	add a0, s0, t0
	add a0, a0, a2
	sw s9, 0(a1)
	sw t2, 0(a0)
	addiw t3, t3, 2
	bgt a7, zero, .LBB5
.LBB6:
	slli a0, t3, 2
	li t0, -40112
	add t2, s0, t0
	add t2, t2, a0
	li t0, -40112
	add a0, s0, t0
	addi a5, a0, 4
	sw s2, 0(t2)
	lw t2, 0(a5)
	li t0, 64
	bne t2, t0, .LBB116
.LBB8:
	lui t2, %hi(.G.ints)
	addi t2, t2, %lo(.G.ints)
	addi t2, t2, 4
	lw a0, 0(t2)
	call putint
	li a0, 0
	ld s1, -32(s0)
	ld s2, -40(s0)
	ld s3, -48(s0)
	ld s4, -56(s0)
	ld s5, -64(s0)
	ld s6, -72(s0)
	ld s7, -80(s0)
	ld s8, -88(s0)
	ld s9, -96(s0)
	ld s10, -104(s0)
	ld s11, -112(s0)
	li t0, 38912
	add sp, sp, t0
	ld ra, 1192(sp)
	ld s0, 1184(sp)
	addi sp, sp, 1200
	ret 
.LBB73:
	mv t2, s11
	sd t2, -24(s0)
.LBB1:
	ld t2, -24(s0)
	slli t2, t2, 2
	add t2, s4, t2
	sw a2, 0(t2)
	ld t2, -24(s0)
	addiw s11, t2, 1
	call getch
	mv a2, a0
	li t1, 13
	xor t2, a2, t1
	li t1, 10
	xor a1, a2, t1
	snez t2, t2
	snez a1, a1
	and t2, t2, a1
	bne t2, zero, .LBB73
	j .LBB2
.LBB31:
	slli a0, t3, 2
	lw t2, 0(a6)
	li t0, -40112
	add a1, s0, t0
	add a0, a1, a0
	addiw t3, t3, 1
	sw t2, 0(a0)
.LBB33:
	addiw a5, a5, 1
	blt a5, s11, .LBB3
	j .LBB4
.LBB76:
	li t2, 1
.LBB29:
	li t0, 1
	beq t2, t0, .LBB31
.LBB32:
	lw t2, 0(a6)
	li t0, 40
	bne t2, t0, .LBB35
.LBB34:
	addiw a7, a7, 1
	slli t2, a7, 2
	add t2, s10, t2
	sw s5, 0(t2)
.LBB35:
	lw t2, 0(a6)
	li t0, 94
	bne t2, t0, .LBB37
.LBB36:
	addiw a7, a7, 1
	slli t2, a7, 2
	add t2, s10, t2
	sw s3, 0(t2)
.LBB37:
	lw t2, 0(a6)
	li t0, 41
	bne t2, t0, .LBB39
.LBB38:
	addiw a7, a7, -1
	addiw t2, a7, 1
	slli t2, t2, 2
	add t2, s10, t2
	lw a2, 0(t2)
	li t0, 40
	beq a2, t0, .LBB39
.LBB70:
	slli a1, t3, 2
	addiw a0, t3, 1
	li t0, -40112
	add t2, s0, t0
	add a1, t2, a1
	slli t2, a0, 2
	li t0, -40112
	add a0, s0, t0
	add a0, a0, t2
	addiw a7, a7, -1
	addiw t2, a7, 1
	slli t2, t2, 2
	sw s9, 0(a1)
	add t2, s10, t2
	sw a2, 0(a0)
	addiw t3, t3, 2
	lw a2, 0(t2)
	li t0, 40
	bne a2, t0, .LBB70
.LBB39:
	lw t2, 0(a6)
	li t0, 43
	bne t2, t0, .LBB41
.LBB40:
	slli t2, a7, 2
	add t2, s10, t2
	lw a1, 0(t2)
	li t1, 43
	xor t2, a1, t1
	li t1, 45
	xor a3, a1, t1
	li t1, 42
	xor a0, a1, t1
	seqz a2, t2
	seqz t2, a3
	li t1, 47
	xor a4, a1, t1
	seqz a3, a0
	li t1, 37
	xor a0, a1, t1
	seqz a4, a4
	or a2, a2, t2
	or a3, a3, a4
	li t1, 94
	xor a1, a1, t1
	seqz t2, a0
	seqz a1, a1
	or a0, a2, a3
	or t2, t2, a1
	or t2, t2, a0
	beq t2, zero, .LBB43
.LBB42:
	addiw a7, a7, -1
	addiw t2, a7, 1
	slli t2, t2, 2
	slli a2, t3, 2
	add a1, s10, t2
	addiw t2, t3, 1
	li t0, -40112
	add a0, s0, t0
	add a0, a0, a2
	slli t2, t2, 2
	lw a1, 0(a1)
	li t0, -40112
	add a2, s0, t0
	add t2, a2, t2
	sw s9, 0(a0)
	sw a1, 0(t2)
	addiw t3, t3, 2
	bne a7, zero, .LBB45
.LBB85:
	li t2, 0
.LBB44:
	bne t2, zero, .LBB40
.LBB43:
	addiw a7, a7, 1
	slli t2, a7, 2
	add t2, s10, t2
	sw s8, 0(t2)
.LBB41:
	lw t2, 0(a6)
	li t0, 45
	bne t2, t0, .LBB47
.LBB46:
	slli t2, a7, 2
	add t2, s10, t2
	lw a1, 0(t2)
	li t1, 43
	xor a2, a1, t1
	li t1, 45
	xor t2, a1, t1
	li t1, 42
	xor a0, a1, t1
	seqz a2, a2
	seqz t2, t2
	li t1, 47
	xor a4, a1, t1
	seqz a3, a0
	li t1, 37
	xor a0, a1, t1
	seqz a4, a4
	or a2, a2, t2
	or a3, a3, a4
	li t1, 94
	xor a1, a1, t1
	seqz t2, a0
	seqz a1, a1
	or a0, a2, a3
	or t2, t2, a1
	or t2, t2, a0
	bne t2, zero, .LBB48
.LBB49:
	addiw a7, a7, 1
	slli t2, a7, 2
	add t2, s10, t2
	li a0, 45
	sw a0, 0(t2)
.LBB47:
	lw t2, 0(a6)
	li t0, 42
	bne t2, t0, .LBB53
.LBB52:
	slli t2, a7, 2
	add t2, s10, t2
	lw a3, 0(t2)
	li t1, 42
	xor a0, a3, t1
	li t1, 47
	xor t2, a3, t1
	li t1, 37
	xor a1, a3, t1
	seqz a2, a0
	seqz a0, t2
	li t1, 94
	xor t2, a3, t1
	seqz a1, a1
	seqz t2, t2
	or a0, a2, a0
	or t2, a1, t2
	or t2, a0, t2
	bne t2, zero, .LBB54
.LBB55:
	addiw a7, a7, 1
	slli t2, a7, 2
	add a0, s10, t2
	li t2, 42
	sw t2, 0(a0)
.LBB53:
	lw t2, 0(a6)
	li t0, 47
	bne t2, t0, .LBB59
.LBB58:
	slli t2, a7, 2
	add t2, s10, t2
	lw a1, 0(t2)
	li t1, 42
	xor a0, a1, t1
	li t1, 47
	xor a3, a1, t1
	li t1, 37
	xor t2, a1, t1
	seqz a2, a0
	seqz a0, a3
	li t1, 94
	xor a1, a1, t1
	seqz t2, t2
	seqz a1, a1
	or a0, a2, a0
	or t2, t2, a1
	or t2, a0, t2
	bne t2, zero, .LBB60
.LBB61:
	addiw a7, a7, 1
	slli t2, a7, 2
	add t2, s10, t2
	sw s7, 0(t2)
.LBB59:
	lw t2, 0(a6)
	li t0, 37
	bne t2, t0, .LBB65
.LBB64:
	slli t2, a7, 2
	add t2, s10, t2
	lw a1, 0(t2)
	li t1, 42
	xor a2, a1, t1
	li t1, 47
	xor t2, a1, t1
	li t1, 37
	xor a0, a1, t1
	seqz a2, a2
	seqz t2, t2
	li t1, 94
	xor a1, a1, t1
	seqz a0, a0
	seqz a1, a1
	or t2, a2, t2
	or a0, a0, a1
	or t2, t2, a0
	bne t2, zero, .LBB66
.LBB67:
	addiw a7, a7, 1
	slli t2, a7, 2
	add t2, s10, t2
	sw s6, 0(t2)
.LBB65:
	slli t2, t3, 2
	li t0, -40112
	add a0, s0, t0
	add t2, a0, t2
	addiw t3, t3, 1
	sw s9, 0(t2)
	j .LBB33
.LBB116:
	li a7, 0
	li a6, 1
.LBB7:
	lw a3, 0(a5)
	li t1, 43
	xor a0, a3, t1
	li t1, 45
	xor t2, a3, t1
	li t1, 42
	xor a1, a3, t1
	seqz a0, a0
	seqz t2, t2
	li t1, 47
	xor a4, a3, t1
	seqz a2, a1
	li t1, 37
	xor a1, a3, t1
	seqz a4, a4
	or a0, a0, t2
	or a2, a2, a4
	li t1, 94
	xor t2, a3, t1
	seqz a1, a1
	seqz t2, t2
	or a0, a0, a2
	or t2, a1, t2
	or t2, t2, a0
	bne t2, zero, .LBB9
.LBB10:
	lw t2, 0(a5)
	li t0, 32
	beq t2, t0, .LBB11
.LBB12:
	addiw a7, a7, 1
	slli a1, a7, 2
	addiw a0, t2, -48
	lui t2, %hi(.G.ints)
	addi t2, t2, %lo(.G.ints)
	add a1, t2, a1
	addiw a4, a6, 1
	slli a2, a4, 2
	li t0, -40112
	add t2, s0, t0
	add t2, t2, a2
	sw a0, 0(a1)
	lw t2, 0(t2)
	li t0, 32
	bne t2, t0, .LBB127
.LBB14:
	addiw a6, a4, -1
	j .LBB11
.LBB9:
	addiw a7, a7, -1
	addiw t2, a7, 1
	slli a0, t2, 2
	lui t2, %hi(.G.ints)
	addi t2, t2, %lo(.G.ints)
	add t2, t2, a0
	slli a1, a7, 2
	lui a0, %hi(.G.ints)
	addi a0, a0, %lo(.G.ints)
	add a1, a0, a1
	lw a3, 0(t2)
	lw a0, 0(a1)
	lw t2, 0(a5)
	li t0, 43
	beq t2, t0, .LBB15
.LBB118:
	li a2, 0
.LBB16:
	lw t2, 0(a5)
	li t0, 45
	bne t2, t0, .LBB18
.LBB17:
	subw a2, a0, a3
.LBB18:
	lw t2, 0(a5)
	li t0, 42
	bne t2, t0, .LBB20
.LBB19:
	mulw a2, a3, a0
.LBB20:
	lw t2, 0(a5)
	li t0, 47
	bne t2, t0, .LBB22
.LBB21:
	divw a2, a0, a3
.LBB22:
	lw t2, 0(a5)
	li t0, 37
	bne t2, t0, .LBB24
.LBB23:
	remw a2, a0, a3
.LBB24:
	lw t2, 0(a5)
	li t0, 94
	beq t2, t0, .LBB25
.LBB26:
	sw a2, 0(a1)
.LBB11:
	addiw a6, a6, 1
	slli a0, a6, 2
	li t0, -40112
	add t2, s0, t0
	add a5, t2, a0
	lw t2, 0(a5)
	li t0, 64
	bne t2, t0, .LBB7
	j .LBB8
.LBB124:
	li a2, 1
.LBB27:
	mulw a2, a0, a2
	addiw a3, a3, -1
	bne a3, zero, .LBB27
	j .LBB26
.LBB25:
	bne a3, zero, .LBB124
.LBB132:
	li a2, 1
	j .LBB26
.LBB127:
	li a3, 1
.LBB13:
	lw a0, 0(a1)
	addiw t2, t2, -48
	mulw a0, a0, s1
	addw a0, t2, a0
	addiw a3, a3, 1
	addw a4, a6, a3
	slli a2, a4, 2
	li t0, -40112
	add t2, s0, t0
	add t2, t2, a2
	sw a0, 0(a1)
	lw t2, 0(t2)
	li t0, 32
	bne t2, t0, .LBB13
	j .LBB14
.LBB48:
	addiw a7, a7, -1
	addiw t2, a7, 1
	slli t2, t2, 2
	slli a0, t3, 2
	add t2, s10, t2
	addiw a2, t3, 1
	li t0, -40112
	add a1, s0, t0
	add a1, a1, a0
	slli a2, a2, 2
	lw t2, 0(t2)
	li t0, -40112
	add a0, s0, t0
	add a0, a0, a2
	sw s9, 0(a1)
	sw t2, 0(a0)
	addiw t3, t3, 2
	bne a7, zero, .LBB51
.LBB91:
	li t2, 0
.LBB50:
	beq t2, zero, .LBB49
	j .LBB46
.LBB97:
	li t2, 0
.LBB56:
	beq t2, zero, .LBB55
	j .LBB52
.LBB54:
	addiw a7, a7, -1
	addiw t2, a7, 1
	slli a0, t2, 2
	slli t2, t3, 2
	add a0, s10, a0
	addiw a2, t3, 1
	li t0, -40112
	add a1, s0, t0
	add a1, a1, t2
	slli a2, a2, 2
	lw a0, 0(a0)
	li t0, -40112
	add t2, s0, t0
	add t2, t2, a2
	sw s9, 0(a1)
	sw a0, 0(t2)
	addiw t3, t3, 2
	beq a7, zero, .LBB97
.LBB57:
	li t2, 1
	j .LBB56
.LBB66:
	addiw a7, a7, -1
	addiw t2, a7, 1
	slli t2, t2, 2
	slli a2, t3, 2
	add a0, s10, t2
	addiw t2, t3, 1
	li t0, -40112
	add a1, s0, t0
	add a1, a1, a2
	slli a2, t2, 2
	lw a0, 0(a0)
	li t0, -40112
	add t2, s0, t0
	add t2, t2, a2
	sw s9, 0(a1)
	sw a0, 0(t2)
	addiw t3, t3, 2
	beq a7, zero, .LBB109
.LBB69:
	li t2, 1
.LBB68:
	beq t2, zero, .LBB67
	j .LBB64
.LBB60:
	addiw a7, a7, -1
	addiw t2, a7, 1
	slli t2, t2, 2
	slli a0, t3, 2
	add a3, s10, t2
	addiw t2, t3, 1
	li t0, -40112
	add a1, s0, t0
	add a1, a1, a0
	slli a2, t2, 2
	lw a0, 0(a3)
	li t0, -40112
	add t2, s0, t0
	add t2, t2, a2
	sw s9, 0(a1)
	sw a0, 0(t2)
	addiw t3, t3, 2
	bne a7, zero, .LBB63
.LBB103:
	li t2, 0
.LBB62:
	beq t2, zero, .LBB61
	j .LBB58
.LBB51:
	li t2, 1
	j .LBB50
.LBB109:
	li t2, 0
	j .LBB68
.LBB72:
	mv a2, a0
	li t2, 0
	sd t2, -24(s0)
	j .LBB1
.LBB63:
	li t2, 1
	j .LBB62
.LBB45:
	li t2, 1
	j .LBB44
.LBB15:
	addw a2, a3, a0
	j .LBB16
    .size main, .-main
