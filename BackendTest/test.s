    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  .C..95
    .bss
    .align  3
    .type  .C..95, @object
    .size  .C..95, 16348
.C..95:
    .zero  16348
    .globl  .C..104
    .align  3
    .type  .C..104, @object
    .size  .C..104, 12508
.C..104:
    .zero  12508
    .text
    .align  1
    .globl  func
    .type  func, @function
func:
.LBB0:
	addi sp, sp, -80
	sd ra, 72(sp)
	sd s0, 64(sp)
	addi s0, sp, 80
	sd s1, -76(s0)
	lw t2, 0(s0)
	mv a0, a0
	mv a1, a1
	mv a2, a2
	mv a3, a3
	mv a4, a4
	mv a5, a5
	mv a6, a6
	mv a7, a7
	j .LBB1
.LBB1:
	sw a0, -44(s0)
	sd a1, -68(s0)
	sw a2, -40(s0)
	sd a3, -60(s0)
	sw a4, -36(s0)
	sw a5, -32(s0)
	sd a6, -52(s0)
	sw a7, -28(s0)
	sw t2, -24(s0)
	li t2, 0
	sw t2, -20(s0)
	j .LBB2
.LBB2:
	lw t2, -20(s0)
	li t0, 10
	blt t2, t0, .LBB3
	j .LBB4
.LBB3:
	lw a0, -44(s0)
	lw t2, -20(s0)
	ld s1, -68(s0)
	add t0, zero, s1
	li s1, 236
	mulw s1, a0, s1
	add t0, t0, s1
	li s1, 4
	mulw t2, t2, s1
	add t0, t0, t2
	lw a0, 0(t0)
	mv a0, a0
	call putint
	lw t2, -20(s0)
	addiw t2, t2, 1
	sw t2, -20(s0)
	j .LBB2
.LBB4:
	li a0, 10
	call putch
	lw t2, -40(s0)
	ld s1, -60(s0)
	add t0, zero, s1
	li s1, 4
	mulw t2, t2, s1
	add t0, t0, t2
	lw a0, 0(t0)
	mv a0, a0
	call putint
	li a0, 10
	call putch
	j .LBB5
.LBB5:
	lw t2, -24(s0)
	li t0, 10
	blt t2, t0, .LBB6
	j .LBB7
.LBB6:
	lw s1, -28(s0)
	li t1, 126976
	addiw t1, t1, 1899
	mv t2, t1
	mulw s1, s1, t2
	li t1, 4096
	addiw t1, t1, -372
	mv t2, t1
	remw s1, s1, t2
	lw a0, -24(s0)
	ld t2, -52(s0)
	add t0, zero, t2
	li t2, 4
	mulw t2, a0, t2
	add t0, t0, t2
	sw s1, 0(t0)
	lw t2, -24(s0)
	addiw t2, t2, 1
	sw t2, -24(s0)
	lw t2, -28(s0)
	addiw t2, t2, 7
	sw t2, -28(s0)
	j .LBB5
.LBB7:
	lw t2, -36(s0)
	lw s1, -32(s0)
	addw a0, t2, s1
	mv a0, a0
	ld s1, -76(s0)
	ld ra, 72(sp)
	ld s0, 64(sp)
	addi sp, sp, 80
	ret 
    .size func, .-func
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB8:
	addi sp, sp, -224
	sd ra, 216(sp)
	sd s0, 208(sp)
	addi s0, sp, 224
	li t1, -28672
	add sp, sp, t1
	sd s1, -36(s0)
	sd sp, -28(s0)
	li t1, -28672
	addiw t1, t1, -220
	add t0, s0, t1
	mv a0, t0
	lui t2, %hi(.C..95)
	addi a1, t2, %lo(.C..95)
	mv a1, a1
	li t1, 16384
	addiw t1, t1, -36
	mv a2, t1
	lui t2, %hi(.C..95)
	addi t2, t2, %lo(.C..95)
	call memcpy@plt
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	mv a0, t0
	lui t2, %hi(.C..104)
	addi a1, t2, %lo(.C..104)
	mv a1, a1
	li t1, 12288
	addiw t1, t1, 220
	mv a2, t1
	lui t2, %hi(.C..104)
	addi t2, t2, %lo(.C..104)
	call memcpy@plt
	li t1, -28672
	addiw t1, t1, -220
	add t0, s0, t1
	li t2, 6
	li t1, 4096
	addiw t1, t1, -2
	addw t0, t0, t1
	sw t2, 466(t0)
	li t1, -28672
	addiw t1, t1, -220
	add t0, s0, t1
	li t2, 7
	li t1, 4096
	addiw t1, t1, -2
	addw t0, t0, t1
	sw t2, 474(t0)
	li t1, -28672
	addiw t1, t1, -220
	add t0, s0, t1
	li t2, 4
	li t1, 4096
	addiw t1, t1, -2
	addw t0, t0, t1
	sw t2, 478(t0)
	li t1, -28672
	addiw t1, t1, -220
	add t0, s0, t1
	li t2, 9
	li t1, 4096
	addiw t1, t1, -2
	addw t0, t0, t1
	sw t2, 490(t0)
	li t1, -28672
	addiw t1, t1, -220
	add t0, s0, t1
	li t2, 11
	li t1, 4096
	addiw t1, t1, -2
	addw t0, t0, t1
	sw t2, 506(t0)
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	li t2, 1
	sw t2, 1420(t0)
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	li t2, 2
	sw t2, 1424(t0)
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	li t2, 3
	sw t2, 1428(t0)
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	li t2, 9
	sw t2, 1452(t0)
	li t1, -28672
	addiw t1, t1, -220
	add t0, s0, t1
	li t1, 4096
	addiw t1, t1, -2
	addw t0, t0, t1
	lw a0, 466(t0)
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	li t1, -28672
	addiw t1, t1, -220
	add t0, s0, t1
	li t1, 4096
	addiw t1, t1, -2
	addw t0, t0, t1
	lw a2, 474(t0)
	li t1, -28672
	addiw t1, t1, -220
	add t0, s0, t1
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	lw a4, 1428(t0)
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	lw a5, 1416(t0)
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	li t1, 4096
	addiw t1, t1, 2045
	addw t0, t0, t1
	lw t2, 1899(t0)
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	li t1, 8192
	addiw t1, t1, 2043
	addw t0, t0, t1
	lw a7, 1873(t0)
	sw a7, 0(sp)
	mv a0, a0
	addi t0, t0, 0
	mv a1, t0
	mv a2, a2
	li t1, 4096
	addiw t1, t1, 460
	add t0, t0, t1
	mv a3, t0
	mv a4, a4
	mv a5, a5
	addi t0, t0, 1416
	mv a6, t0
	mv a7, a7
	call func
	mv a0, a0
	li t2, 3
	mulw t2, a0, t2
	sw t2, -20(s0)
	j .LBB9
.LBB9:
	lw t2, -20(s0)
	bge t2, zero, .LBB10
	j .LBB11
.LBB10:
	lw t2, -20(s0)
	li t1, -12288
	addiw t1, t1, -256
	add t0, s0, t1
	li s1, 4
	mulw t2, t2, s1
	add t0, t0, t2
	lw a0, 1416(t0)
	mv a0, a0
	call putint
	li a0, 32
	call putch
	lw s1, -20(s0)
	li t2, 1
	subw t2, s1, t2
	sw t2, -20(s0)
	j .LBB9
.LBB11:
	li a0, 10
	call putch
	mv a0, zero
	ld sp, -28(s0)
	ld s1, -36(s0)
	li t1, 28672
	add sp, sp, t1
	ld ra, 216(sp)
	ld s0, 208(sp)
	addi sp, sp, 224
	ret 
    .size main, .-main
