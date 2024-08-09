    .file  "/home/nanqin/compiler/SB-compiler/BackendTest/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .G.head
    .bss
    .align  3
    .type  .G.head, @object
    .size  .G.head, 40000000
.G.head:
    .zero  40000000
    .globl  .G.next
    .align  3
    .type  .G.next, @object
    .size  .G.next, 40000000
.G.next:
    .zero  40000000
    .globl  .G.nextvalue
    .align  3
    .type  .G.nextvalue, @object
    .size  .G.nextvalue, 40000000
.G.nextvalue:
    .zero  40000000
    .globl  .G.key
    .align  3
    .type  .G.key, @object
    .size  .G.key, 40000000
.G.key:
    .zero  40000000
    .globl  .G.value
    .align  3
    .type  .G.value, @object
    .size  .G.value, 40000000
.G.value:
    .zero  40000000
    .globl  .G.keys
    .align  3
    .type  .G.keys, @object
    .size  .G.keys, 40000000
.G.keys:
    .zero  40000000
    .globl  .G.values
    .align  3
    .type  .G.values, @object
    .size  .G.values, 40000000
.G.values:
    .zero  40000000
    .globl  .G.requests
    .align  3
    .type  .G.requests, @object
    .size  .G.requests, 40000000
.G.requests:
    .zero  40000000
    .globl  .G.ans
    .align  3
    .type  .G.ans, @object
    .size  .G.ans, 40000000
.G.ans:
    .zero  40000000
    .text
    .align  1
    .globl  main
    .type  main, @function

main:
.LBB0:

	addi sp, sp, -128
	sd ra, 120(sp)
	sd s0, 112(sp)
	addi s0, sp, 128
	sd s11, -120(s0)
	sd s10, -112(s0)
	sd s9, -104(s0)
	sd s8, -96(s0)
	sd s7, -88(s0)
	sd s6, -80(s0)
	sd s5, -72(s0)
	sd s4, -64(s0)
	sd s3, -56(s0)
	sd s2, -48(s0)
	sd s1, -40(s0)
	lui s4, %hi(.G.next)
	addi s4, s4, %lo(.G.next)
	lui s2, %hi(.G.nextvalue)
	addi s2, s2, %lo(.G.nextvalue)
	lui s5, %hi(.G.value)
	addi s5, s5, %lo(.G.value)
	lui s7, %hi(.G.key)
	addi s7, s7, %lo(.G.key)
	lui s6, %hi(.G.head)
	addi s6, s6, %lo(.G.head)
	lui s8, %hi(.G.ans)
	addi s8, s8, %lo(.G.ans)
	lui s10, %hi(.G.requests)
	addi s10, s10, %lo(.G.requests)
	lui s9, %hi(.G.values)
	addi s9, s9, %lo(.G.values)
	lui s3, %hi(.G.keys)
	addi s3, s3, %lo(.G.keys)
	call getint
	mv t2, a0
	sd t2, -24(s0)
	mv a0, s3
	call getarray
	mv t2, a0
	sd t2, -32(s0)
	mv a0, s9
	call getarray
	mv a0, s10
	call getarray
	mv s11, a0
	li a0, 78
	call _sysy_starttime
	ld t2, -32(s0)
	blt zero, t2, .LBB18
	j .LBB2
.LBB2:
	blt zero, s11, .LBB23
	j .LBB4
.LBB4:
	li a0, 90
	call _sysy_stoptime
	mv a0, s11
	mv a1, s8
	call putarray
	li a0, 0
	ld s1, -40(s0)
	ld s2, -48(s0)
	ld s3, -56(s0)
	ld s4, -64(s0)
	ld s5, -72(s0)
	ld s6, -80(s0)
	ld s7, -88(s0)
	ld s8, -96(s0)
	ld s9, -104(s0)
	ld s10, -112(s0)
	ld s11, -120(s0)
	ld ra, 120(sp)
	ld s0, 112(sp)
	addi sp, sp, 128
	ret 
.LBB3:
	slli t2, a0, 2
	add t2, s10, t2
	lw s1, 0(t2)
	ld t2, -24(s0)
	remw t2, s1, t2
	slli t2, t2, 2
	add t2, s6, t2
	lw a1, 0(t2)
	bne a1, zero, .LBB5
	j .LBB27
.LBB6:
	slli t2, a0, 2
	add t2, s8, t2
	sw s1, 0(t2)
	addiw a0, a0, 1
	blt a0, s11, .LBB3
	j .LBB4
.LBB5:
	slli t2, a1, 2
	add t2, s7, t2
	lw t2, 0(t2)
	beq t2, s1, .LBB7
	j .LBB8
.LBB7:
	bne a1, zero, .LBB29
	j .LBB32
.LBB9:
	slli t2, a1, 2
	add t2, s5, t2
	lw t2, 0(t2)
	addw s1, s1, t2
	slli t2, a1, 2
	add t2, s2, t2
	lw a1, 0(t2)
	bne a1, zero, .LBB9
	j .LBB6
.LBB8:
	slli t2, a1, 2
	add t2, s4, t2
	lw a1, 0(t2)
	bne a1, zero, .LBB5
	j .LBB28
.LBB1:
	slli t2, a3, 2
	add t2, s3, t2
	lw a0, 0(t2)
	slli t2, a3, 2
	add t2, s9, t2
	lw a2, 0(t2)
	ld t2, -24(s0)
	remw t2, a0, t2
	slli t2, t2, 2
	add s1, s6, t2
	lw a1, 0(s1)
	beq a1, zero, .LBB11
	j .LBB12
.LBB12:
	bne a1, zero, .LBB13
	j .LBB14
.LBB14:
	addiw a4, a4, 1
	lw a1, 0(s1)
	slli t2, a4, 2
	add t2, s4, t2
	sw a1, 0(t2)
	sw a4, 0(s1)
	slli t2, a4, 2
	add t2, s7, t2
	sw a0, 0(t2)
	slli t2, a4, 2
	add t2, s5, t2
	sw a2, 0(t2)
	slli t2, a4, 2
	add t2, s2, t2
	sw zero, 0(t2)
	j .LBB15
.LBB13:
	slli t2, a1, 2
	add t2, s7, t2
	lw t2, 0(t2)
	beq t2, a0, .LBB16
	j .LBB17
.LBB17:
	slli t2, a1, 2
	add t2, s4, t2
	lw a1, 0(t2)
	bne a1, zero, .LBB13
	j .LBB14
.LBB16:
	addiw a4, a4, 1
	slli t2, a1, 2
	add s1, s2, t2
	lw a0, 0(s1)
	slli t2, a4, 2
	add t2, s2, t2
	sw a0, 0(t2)
	sw a4, 0(s1)
	slli t2, a4, 2
	add t2, s5, t2
	sw a2, 0(t2)
	j .LBB15
.LBB15:
	addiw a3, a3, 1
	ld t2, -32(s0)
	blt a3, t2, .LBB1
	j .LBB2
.LBB11:
	addiw a4, a4, 1
	sw a4, 0(s1)
	slli t2, a4, 2
	add t2, s7, t2
	sw a0, 0(t2)
	slli t2, a4, 2
	add t2, s5, t2
	sw a2, 0(t2)
	slli t2, a4, 2
	add t2, s4, t2
	sw zero, 0(t2)
	slli t2, a4, 2
	add t2, s2, t2
	sw zero, 0(t2)
	j .LBB15
.LBB18:
	li a3, 0
	li a4, 0
	j .LBB1
.LBB23:
	li a0, 0
	j .LBB3
.LBB27:
	li s1, 0
	j .LBB6
.LBB28:
	li s1, 0
	j .LBB6
.LBB29:
	li s1, 0
	j .LBB9
.LBB32:
	li s1, 0
	j .LBB6
    .size main, .-main
