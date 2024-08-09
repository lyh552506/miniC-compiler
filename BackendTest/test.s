    .file  "./function_test/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.temp
    .bss
    .align  3
    .type  .G.temp, @object
    .size  .G.temp, 8388608
.G.temp:
    .zero  8388608
    .globl  .G.a
    .align  3
    .type  .G.a, @object
    .size  .G.a, 8388608
.G.a:
    .zero  8388608
    .globl  .G.b
    .align  3
    .type  .G.b, @object
    .size  .G.b, 8388608
.G.b:
    .zero  8388608
    .text
    .align  1
    .globl  multiply
    .type  multiply, @function
multiply:
.LBB0:
	addi sp, sp, -48
	sd ra, 40(sp)
	sd s0, 32(sp)
	addi s0, sp, 48
	sd s4, -48(s0)
	sd s3, -40(s0)
	sd s2, -32(s0)
	sd s1, -24(s0)
	li s2, 2
	li s1, 998244353
	mv s3, a0
	mv s4, a1
.LBB1:
	bne s4, zero, .LBB3
.LBB7:
	li a0, 0
.LBB2:
	ld s1, -24(s0)
	ld s2, -32(s0)
	ld s3, -40(s0)
	ld s4, -48(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
.LBB3:
	li t0, 1
	bne s4, t0, .LBB5
.LBB4:
	remw a0, s3, s1
	ld s1, -24(s0)
	ld s2, -32(s0)
	ld s3, -40(s0)
	ld s4, -48(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
.LBB5:
	sraiw a1, s4, 31
	srliw a1, a1, 31
	addw a1, a1, s4
	sraiw a1, a1, 1
	mv a0, s3
	call multiply
	addw t2, a0, a0
	remw a0, t2, s1
	remw t2, s4, s2
	li t0, 1
	bne t2, t0, .LBB2
.LBB6:
	addw t2, s3, a0
	remw a0, t2, s1
	ld s1, -24(s0)
	ld s2, -32(s0)
	ld s3, -40(s0)
	ld s4, -48(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
    .size multiply, .-multiply
    .align  1
    .globl  power
    .type  power, @function
power:
.LBB9:
	addi sp, sp, -48
	sd ra, 40(sp)
	sd s0, 32(sp)
	addi s0, sp, 48
	sd s3, -40(s0)
	sd s2, -32(s0)
	sd s1, -24(s0)
	li s1, 2
	mv s2, a0
	mv s3, a1
.LBB10:
	bne s3, zero, .LBB12
.LBB14:
	li a0, 1
.LBB11:
	ld s1, -24(s0)
	ld s2, -32(s0)
	ld s3, -40(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
.LBB12:
	sraiw a1, s3, 31
	srliw a1, a1, 31
	addw a1, a1, s3
	sraiw a1, a1, 1
	mv a0, s2
	call power
	mv a1, a0
	call multiply
	remw t2, s3, s1
	li t0, 1
	bne t2, t0, .LBB11
.LBB13:
	mv a1, s2
	call multiply
	ld s1, -24(s0)
	ld s2, -32(s0)
	ld s3, -40(s0)
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret 
    .size power, .-power
    .align  1
    .globl  memmove
    .type  memmove, @function
memmove:
.LBB16:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	sd s1, -24(s0)
	mv a4, a0
.LBB17:
	bge zero, a3, .LBB23
.LBB21:
	li a0, 0
.LBB18:
	slli t2, a0, 2
	add t2, a2, t2
	lw s1, 0(t2)
	addw t2, a1, a0
	slli t2, t2, 2
	add t2, a4, t2
	sw s1, 0(t2)
	addiw a0, a0, 1
	blt a0, a3, .LBB18
.LBB19:
	ld s1, -24(s0)
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret 
.LBB23:
	li a0, 0
	j .LBB19
    .size memmove, .-memmove
    .align  1
    .globl  fft
    .type  fft, @function
fft:
.LBB25:
	addi sp, sp, -112
	sd ra, 104(sp)
	sd s0, 96(sp)
	addi s0, sp, 112
	sd s11, -104(s0)
	sd s10, -96(s0)
	sd s9, -88(s0)
	sd s8, -80(s0)
	sd s7, -72(s0)
	sd s6, -64(s0)
	sd s5, -56(s0)
	sd s4, -48(s0)
	sd s3, -40(s0)
	sd s2, -32(s0)
	sd s1, -24(s0)
	li a4, 2
	li s2, 998244353
	lui a5, %hi(.G.temp)
	addi a5, a5, %lo(.G.temp)
	mv s7, a0
	mv s6, a1
	mv s3, a2
	mv s8, a3
.LBB26:
	li t0, 1
	bne s3, t0, .LBB28
.LBB35:
	li a0, 1
.LBB27:
	ld s1, -24(s0)
	ld s2, -32(s0)
	ld s3, -40(s0)
	ld s4, -48(s0)
	ld s5, -56(s0)
	ld s6, -64(s0)
	ld s7, -72(s0)
	ld s8, -80(s0)
	ld s9, -88(s0)
	ld s10, -96(s0)
	ld s11, -104(s0)
	ld ra, 104(sp)
	ld s0, 96(sp)
	addi sp, sp, 112
	ret 
.LBB40:
	li s3, 0
	li s4, 1
.LBB31:
	addw s1, s6, s3
	slli t2, s1, 2
	add s9, s7, t2
	lw s11, 0(s9)
	addw t2, s5, s1
	slli t2, t2, 2
	add s10, s7, t2
	lw s1, 0(s10)
	mv a0, s4
	mv a1, s1
	call multiply
	addw t2, s11, a0
	remw t2, t2, s2
	sw t2, 0(s9)
	mv a0, s4
	mv a1, s1
	call multiply
	subw t2, s11, a0
	li t0, 998244353
	addw t2, t2, t0
	remw t2, t2, s2
	sw t2, 0(s10)
	mv a0, s4
	mv a1, s8
	call multiply
	mv s4, a0
	addiw s3, s3, 1
	blt s3, s5, .LBB31
.LBB37:
	li a0, 0
	j .LBB27
.LBB28:
	sraiw s1, s3, 31
	srliw s1, s1, 31
	addw s1, s1, s3
	sraiw s1, s1, 1
	bge zero, s3, .LBB30
.LBB39:
	li a1, 0
.LBB29:
	remw t2, a1, a4
	beq t2, zero, .LBB32
.LBB33:
	addw t2, s6, a1
	slli t2, t2, 2
	add t2, s7, t2
	lw a0, 0(t2)
	sraiw t2, a1, 31
	srliw t2, t2, 31
	addw t2, t2, a1
	sraiw t2, t2, 1
	addw t2, s1, t2
	slli t2, t2, 2
	add t2, a5, t2
	sw a0, 0(t2)
	j .LBB34
.LBB32:
	addw t2, s6, a1
	slli t2, t2, 2
	add t2, s7, t2
	lw a0, 0(t2)
	sraiw t2, a1, 31
	srliw t2, t2, 31
	addw t2, t2, a1
	sraiw t2, t2, 1
	slli t2, t2, 2
	add t2, a5, t2
	sw a0, 0(t2)
.LBB34:
	addiw a1, a1, 1
	blt a1, s3, .LBB29
.LBB30:
	mv a0, s7
	mv a1, s6
	mv a2, a5
	mv a3, s3
	call memmove
	sraiw s5, s3, 31
	srliw s5, s5, 31
	addw s5, s5, s3
	sraiw s5, s5, 1
	mv a0, s8
	mv a1, s8
	call multiply
	mv a3, a0
	mv a0, s7
	mv a1, s6
	mv a2, s5
	call fft
	addw s1, s6, s5
	mv a0, s8
	mv a1, s8
	call multiply
	mv a3, a0
	mv a0, s7
	mv a1, s1
	mv a2, s5
	call fft
	blt zero, s5, .LBB40
.LBB36:
	li a0, 0
	j .LBB27
    .size fft, .-fft
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB42:
	addi sp, sp, -80
	sd ra, 72(sp)
	sd s0, 64(sp)
	addi s0, sp, 80
	sd s7, -72(s0)
	sd s6, -64(s0)
	sd s5, -56(s0)
	sd s4, -48(s0)
	sd s3, -40(s0)
	sd s2, -32(s0)
	sd s1, -24(s0)
	lui s1, %hi(.G.b)
	addi s1, s1, %lo(.G.b)
	lui s2, %hi(.G.a)
	addi s2, s2, %lo(.G.a)
	mv a0, s2
	call getarray
	mv s4, a0
	mv a0, s1
	call getarray
	mv s3, a0
	li a0, 60
	call _sysy_starttime
	addw t2, s4, s3
	addiw s5, t2, -1
	li s6, 1
.LBB43:
	slliw t2, s6, 1
	bge s6, s5, .LBB44
.LBB49:
	mv s6, t2
	j .LBB43
.LBB44:
	li t1, 998244352
	divw s4, t1, s6
	li a0, 3
	mv a1, s4
	call power
	mv a3, a0
	mv a0, s2
	li a1, 0
	mv a2, s6
	call fft
	li a0, 3
	mv a1, s4
	call power
	mv a3, a0
	mv a0, s1
	li a1, 0
	mv a2, s6
	call fft
	bge zero, s6, .LBB46
.LBB51:
	li s3, 0
.LBB45:
	slli t2, s3, 2
	add s7, s2, t2
	lw a0, 0(s7)
	slli t2, s3, 2
	add t2, s1, t2
	lw a1, 0(t2)
	call multiply
	sw a0, 0(s7)
	addiw s3, s3, 1
	blt s3, s6, .LBB45
.LBB46:
	li t1, 998244352
	subw a1, t1, s4
	li a0, 3
	call power
	mv a3, a0
	mv a0, s2
	li a1, 0
	mv a2, s6
	call fft
	bge zero, s6, .LBB48
.LBB53:
	li s1, 0
.LBB47:
	slli t2, s1, 2
	add s4, s2, t2
	lw s3, 0(s4)
	mv a0, s6
	li a1, 998244351
	call power
	mv a1, a0
	mv a0, s3
	call multiply
	sw a0, 0(s4)
	addiw s1, s1, 1
	blt s1, s6, .LBB47
.LBB48:
	li a0, 79
	call _sysy_stoptime
	mv a0, s5
	mv a1, s2
	call putarray
	li a0, 0
	ld s1, -24(s0)
	ld s2, -32(s0)
	ld s3, -40(s0)
	ld s4, -48(s0)
	ld s5, -56(s0)
	ld s6, -64(s0)
	ld s7, -72(s0)
	ld ra, 72(sp)
	ld s0, 64(sp)
	addi sp, sp, 80
	ret 
    .size main, .-main
	