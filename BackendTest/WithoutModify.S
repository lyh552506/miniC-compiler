    .file  "/home/nanqin/compiler/SB-compiler/BackendTest/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	addi sp, sp, -912
	sd ra, 904(sp)
	sd s0, 896(sp)
	addi s0, sp, 912
	sd s11, -232(s0)
	sd s10, -240(s0)
	sd s9, -248(s0)
	sd s8, -256(s0)
	sd s7, -264(s0)
	sd s6, -272(s0)
	sd s5, -280(s0)
	sd s4, -288(s0)
	sd s3, -296(s0)
	sd s2, -304(s0)
	sd s1, -312(s0)
	li t2, 1
	#MarkDead t2
	li t2, -49
	#MarkDead t2
	li t2, 115
	#MarkDead t2
	li t2, 22
	#MarkDead t2
	li t2, -122
	#MarkDead t2
	li t2, 109
	#MarkDead t2
	li t2, -51
	#MarkDead t2
	li t2, 10
	#MarkDead t2
	li t2, -92
	#MarkDead t2
	li t2, 41
	#MarkDead t2
	li t2, 42
	#MarkDead t2
	li t2, 37
	#MarkDead t2
	li t2, 53
	#MarkDead t2
	li t2, -87
	#MarkDead t2
	li t2, -73
	#MarkDead t2
	li t2, -46
	#MarkDead t2
	li t2, 36
	#MarkDead t2
	li t2, -29
	#MarkDead t2
	li t2, -84
	#MarkDead t2
	li t2, 97
	#MarkDead t2
	li t2, 24
	#MarkDead t2
	li t2, 107
	#MarkDead t2
	li t2, 71
	#MarkDead t2
	li t2, -7
	#MarkDead t2
	li t2, -119
	#MarkDead t2
	li t2, 104
	#MarkDead t2
	li t2, 18
	#MarkDead t2
	li t2, -2
	#MarkDead t2
	li t2, 30
	#MarkDead t2
	li t2, 33
	#MarkDead t2
	li t2, 48
	#MarkDead t2
	li t2, -79
	#MarkDead t2
	li t2, 86
	#MarkDead t2
	li t2, 58
	#MarkDead t2
	li t2, 14
	#MarkDead t2
	li t2, -33
	#MarkDead t2
	li t2, -90
	#MarkDead t2
	li t2, -77
	#MarkDead t2
	li t2, 112
	#MarkDead t2
	li t2, 114
	#MarkDead t2
	li t2, -72
	#MarkDead t2
	li t2, -54
	#MarkDead t2
	li t2, -112
	#MarkDead t2
	li t2, -50
	#MarkDead t2
	li t2, -10
	#MarkDead t2
	li t2, 38
	#MarkDead t2
	li t2, -62
	#MarkDead t2
	li t2, -13
	#MarkDead t2
	li t2, 55
	#MarkDead t2
	li t2, -15
	#MarkDead t2
	li t2, 121
	#MarkDead t2
	li t2, -74
	#MarkDead t2
	li t2, 68
	#MarkDead t2
	li t2, 81
	#MarkDead t2
	li t2, -3
	#MarkDead t2
	li t2, -124
	#MarkDead t2
	li t2, 3
	#MarkDead t2
	li t2, 79
	#MarkDead t2
	li t2, 15
	#MarkDead t2
	li t2, -93
	#MarkDead t2
	li t2, 5
	#MarkDead t2
	li t2, 59
	#MarkDead t2
	li t2, -114
	#MarkDead t2
	li t2, -101
	#MarkDead t2
	li t2, -96
	#MarkDead t2
	li t2, 66
	#MarkDead t2
	li t2, 75
	#MarkDead t2
	li t2, -16
	#MarkDead t2
	li t2, -116
	#MarkDead t2
	li t2, 101
	#MarkDead t2
	li t2, -104
	#MarkDead t2
	li t2, 82
	#MarkDead t2
	li t2, -117
	#MarkDead t2
	li t2, -23
	#MarkDead t2
	li t2, 125
	#MarkDead t2
	li t2, 118
	#MarkDead t2
	li t2, 95
	#MarkDead t2
	li t2, -32
	#MarkDead t2
	li t2, -47
	#MarkDead t2
	li t2, 11
	#MarkDead t2
	li t2, 122
	#MarkDead t2
	li t2, 83
	#MarkDead t2
	li t2, -65
	#MarkDead t2
	li t2, 12
	#MarkDead t2
	li t2, -30
	#MarkDead t2
	li t2, 72
	#MarkDead t2
	li t2, 49
	#MarkDead t2
	li t2, 127
	#MarkDead t2
	li t2, 94
	#MarkDead t2
	li t2, -6
	#MarkDead t2
	li t2, 120
	#MarkDead t2
	li t2, -99
	#MarkDead t2
	li t2, -63
	#MarkDead t2
	li t2, 116
	#MarkDead t2
	li t2, 27
	#MarkDead t2
	li t2, -38
	#MarkDead t2
	li t2, 6
	#MarkDead t2
	li t2, 102
	#MarkDead t2
	li t2, -34
	#MarkDead t2
	li t2, -5
	#MarkDead t2
	li t2, -68
	#MarkDead t2
	li t2, 52
	#MarkDead t2
	li t2, 96
	#MarkDead t2
	li t2, -95
	#MarkDead t2
	li t2, -70
	#MarkDead t2
	li t2, 76
	#MarkDead t2
	li t2, 26
	#MarkDead t2
	li t2, 77
	#MarkDead t2
	li s1, -31
	li t2, -125
	#MarkDead t2
	li s2, -22
	li t2, -100
	#MarkDead t2
	li t2, -110
	#MarkDead t2
	li s3, 29
	li s4, 87
	li t2, -42
	#MarkDead t2
	li t2, 105
	#MarkDead t2
	li t2, -43
	#MarkDead t2
	li t2, -60
	#MarkDead t2
	li t2, -21
	#MarkDead t2
	li t2, 7
	#MarkDead t2
	li t2, -121
	#MarkDead t2
	li t2, -94
	#MarkDead t2
	li t2, 67
	#MarkDead t2
	li t2, -8
	#MarkDead t2
	li t2, -18
	#MarkDead t2
	li t2, 126
	#MarkDead t2
	li t2, 39
	#MarkDead t2
	li t2, 47
	#MarkDead t2
	li t2, 46
	#MarkDead t2
	li t2, 80
	#MarkDead t2
	li t2, -4
	#MarkDead t2
	li t2, 110
	#MarkDead t2
	li t2, 113
	#MarkDead t2
	li t2, 65
	#MarkDead t2
	li t2, -39
	#MarkDead t2
	li t2, 34
	#MarkDead t2
	li t2, -102
	#MarkDead t2
	li t2, -75
	#MarkDead t2
	li t2, -106
	#MarkDead t2
	li t2, -67
	#MarkDead t2
	li t2, -111
	#MarkDead t2
	li t2, -59
	#MarkDead t2
	li t2, 50
	#MarkDead t2
	li t2, -120
	#MarkDead t2
	li t2, -123
	#MarkDead t2
	li t2, -103
	#MarkDead t2
	li t2, -82
	#MarkDead t2
	li t2, 23
	#MarkDead t2
	li t2, 85
	#MarkDead t2
	li t2, 20
	#MarkDead t2
	addi t2, s0, -908
	#MarkDead t2
	call getint
	mv t2, a0
	sd t2, -616(s0)
	j .LBB1
.LBB1:
	# ld t2, -616(s0)
	bgt t2, zero, .LBB54
	j .LBB3
.LBB2:
	li t0, 5
	blt s6, t0, .LBB76
	j .LBB5
.LBB4:
	li t0, 5
	blt s5, t0, .LBB6
	j .LBB7
.LBB7:
	addiw t2, s6, 1
	mv s6, t2
	j .LBB2
.LBB6:
	call getint
	mv t2, a0
	li a1, 20
	mul a2, s6, a1
	slli a1, s5, 2
	add a1, a2, a1
	addi a2, s0, -908
	add a1, a2, a1
	sw t2, 0(a1)
	addiw t2, s5, 1
	mv s5, t2
	j .LBB4
.LBB5:
	addi t2, s0, -908
	lw a0, 0(t2)
	li t2, 85
	mulw t2, a0, t2
	sd t2, -608(s0)
	addi t2, s0, -908
	addi t2, t2, 4
	lw a0, 0(t2)
	li t2, 23
	mulw t2, a0, t2
	sd t2, -600(s0)
	addi t2, s0, -908
	addi t2, t2, 8
	lw a0, 0(t2)
	li t2, -82
	mulw t2, a0, t2
	sd t2, -592(s0)
	addi t2, s0, -908
	addi t2, t2, 12
	lw a0, 0(t2)
	li t2, -103
	mulw t2, a0, t2
	sd t2, -584(s0)
	addi t2, s0, -908
	addi t2, t2, 16
	lw a0, 0(t2)
	li t2, -123
	mulw t2, a0, t2
	sd t2, -576(s0)
	addi t2, s0, -908
	addi t2, t2, 20
	lw t2, 0(t2)
	slliw t2, t2, 6
	sd t2, -568(s0)
	addi t2, s0, -908
	addi t2, t2, 24
	lw a0, 0(t2)
	li t2, -120
	mulw t2, a0, t2
	sd t2, -560(s0)
	addi t2, s0, -908
	addi t2, t2, 28
	lw a0, 0(t2)
	li t2, 50
	mulw t2, a0, t2
	sd t2, -552(s0)
	addi t2, s0, -908
	addi t2, t2, 32
	lw a0, 0(t2)
	li t2, -59
	mulw t2, a0, t2
	sd t2, -544(s0)
	addi t2, s0, -908
	addi t2, t2, 36
	lw s9, 0(t2)
	addi t2, s0, -908
	addi t2, t2, 40
	lw a0, 0(t2)
	li t2, -111
	mulw t2, a0, t2
	sd t2, -536(s0)
	addi t2, s0, -908
	addi t2, t2, 44
	lw a0, 0(t2)
	li t2, -67
	mulw s10, a0, t2
	addi t2, s0, -908
	addi t2, t2, 48
	lw a0, 0(t2)
	li t2, -106
	mulw s8, a0, t2
	addi t2, s0, -908
	addi t2, t2, 52
	lw a0, 0(t2)
	li t2, -75
	mulw s7, a0, t2
	addi t2, s0, -908
	addi t2, t2, 56
	lw a0, 0(t2)
	li t2, -102
	mulw s6, a0, t2
	addi t2, s0, -908
	addi t2, t2, 60
	lw a0, 0(t2)
	li t2, 34
	mulw s5, a0, t2
	addi t2, s0, -908
	addi t2, t2, 64
	lw a0, 0(t2)
	li t2, -39
	mulw a7, a0, t2
	addi t2, s0, -908
	addi t2, t2, 68
	lw a0, 0(t2)
	li t2, 65
	mulw a6, a0, t2
	addi t2, s0, -908
	addi t2, t2, 72
	lw a4, 0(t2)
	addi t2, s0, -908
	addi t2, t2, 76
	lw a0, 0(t2)
	li t2, 113
	mulw a5, a0, t2
	addi t2, s0, -908
	addi t2, t2, 80
	lw a0, 0(t2)
	li t2, 110
	mulw a3, a0, t2
	addi t2, s0, -908
	addi t2, t2, 84
	lw a2, 0(t2)
	addi t2, s0, -908
	addi t2, t2, 88
	lw a0, 0(t2)
	li t2, -4
	mulw a0, a0, t2
	addi t2, s0, -908
	addi t2, t2, 92
	lw a1, 0(t2)
	li t2, 80
	mulw t2, a1, t2
	addi a1, s0, -908
	addi a1, a1, 96
	lw s11, 0(a1)
	li a1, 46
	mulw a1, s11, a1
	addw a4, a4, s9
	addw a4, a2, a4
	li a2, 47
	mulw a2, a4, a2
	addw a0, a3, a0
	addw a0, a5, a0
	addw t2, t2, a0
	addw t2, a6, t2
	addw t2, a7, t2
	addw t2, s5, t2
	addw t2, s6, t2
	addw t2, s7, t2
	addw t2, s8, t2
	addw t2, s10, t2
	ld a0, -536(s0)
	addw t2, a0, t2
	addw t2, a1, t2
	ld a0, -544(s0)
	addw t2, a0, t2
	ld a0, -552(s0)
	addw t2, a0, t2
	ld a0, -560(s0)
	addw t2, a0, t2
	ld a0, -568(s0)
	addw t2, a0, t2
	ld a0, -576(s0)
	addw t2, a0, t2
	ld a0, -584(s0)
	addw t2, a0, t2
	ld a0, -592(s0)
	addw t2, a0, t2
	ld a0, -600(s0)
	addw a0, a0, t2
	ld t2, -608(s0)
	addw t2, t2, a0
	addw t2, t2, a2
	j .LBB8
.LBB8:
	li t0, 127
	bgt t2, t0, .LBB55
	j .LBB10
.LBB10:
	blt t2, zero, .LBB56
	j .LBB11
.LBB11:
	j .LBB9
.LBB9:
	li a0, 39
	mulw t2, t2, a0
	addi a0, s0, -908
	lw a0, 0(a0)
	sd a0, -424(s0)
	addi a0, s0, -908
	addi a0, a0, 4
	lw a1, 0(a0)
	li a0, 126
	mulw a0, a1, a0
	sd a0, -520(s0)
	addi a0, s0, -908
	addi a0, a0, 8
	lw a1, 0(a0)
	li a0, -18
	mulw a0, a1, a0
	sd a0, -512(s0)
	addi a0, s0, -908
	addi a0, a0, 12
	lw a0, 0(a0)
	sd a0, -504(s0)
	addi a0, s0, -908
	addi a0, a0, 16
	lw a1, 0(a0)
	li a0, -8
	mulw a0, a1, a0
	sd a0, -496(s0)
	addi a0, s0, -908
	addi a0, a0, 20
	lw a1, 0(a0)
	li a0, 47
	mulw a0, a1, a0
	sd a0, -488(s0)
	addi a0, s0, -908
	addi a0, a0, 24
	lw a1, 0(a0)
	li a0, -4
	mulw a0, a1, a0
	sd a0, -480(s0)
	addi a0, s0, -908
	addi a0, a0, 28
	lw a1, 0(a0)
	li a0, 67
	mulw a0, a1, a0
	sd a0, -472(s0)
	addi a0, s0, -908
	addi a0, a0, 32
	lw a1, 0(a0)
	li a0, -94
	mulw a0, a1, a0
	sd a0, -464(s0)
	addi a0, s0, -908
	addi a0, a0, 36
	lw a1, 0(a0)
	li a0, -121
	mulw a0, a1, a0
	sd a0, -456(s0)
	addi a0, s0, -908
	addi a0, a0, 40
	lw a0, 0(a0)
	li a1, 7
	mulw a0, a0, a1
	sd a0, -448(s0)
	addi a0, s0, -908
	addi a0, a0, 44
	lw a1, 0(a0)
	li a0, -21
	mulw s11, a1, a0
	addi a0, s0, -908
	addi a0, a0, 48
	lw a1, 0(a0)
	li a0, -60
	mulw s10, a1, a0
	addi a0, s0, -908
	addi a0, a0, 52
	lw a1, 0(a0)
	li a0, -43
	mulw s9, a1, a0
	addi a0, s0, -908
	addi a0, a0, 56
	lw a1, 0(a0)
	li a0, 105
	mulw s8, a1, a0
	addi a0, s0, -908
	addi a0, a0, 60
	lw a1, 0(a0)
	li a0, -42
	mulw s7, a1, a0
	addi a0, s0, -908
	addi a0, a0, 64
	lw a0, 0(a0)
	mulw s6, a0, s4
	addi a0, s0, -908
	addi a0, a0, 68
	lw a0, 0(a0)
	mulw s5, a0, s3
	addi a0, s0, -908
	addi a0, a0, 72
	lw a4, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 76
	lw a5, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 80
	lw a1, 0(a0)
	li a0, -110
	mulw a3, a1, a0
	addi a0, s0, -908
	addi a0, a0, 84
	lw a1, 0(a0)
	li a0, -100
	mulw a2, a1, a0
	addi a0, s0, -908
	addi a0, a0, 88
	lw a0, 0(a0)
	mulw a1, a0, s2
	addi a0, s0, -908
	addi a0, a0, 92
	lw a6, 0(a0)
	li a0, -75
	mulw a0, a6, a0
	addi a6, s0, -908
	addi a6, a6, 96
	lw a7, 0(a6)
	li a6, -125
	mulw a7, a7, a6
	ld a6, -424(s0)
	addw a6, a4, a6
	li a4, -106
	mulw a6, a6, a4
	ld a4, -504(s0)
	addw a4, a5, a4
	mulw a4, a4, s1
	addw a2, a3, a2
	addw a1, a1, a2
	addw a0, a0, a1
	addw a0, s5, a0
	addw a0, s6, a0
	addw a0, s7, a0
	addw a0, s8, a0
	addw a0, s9, a0
	addw a0, s10, a0
	addw a0, s11, a0
	ld a1, -448(s0)
	addw a0, a1, a0
	ld a1, -456(s0)
	addw a0, a1, a0
	ld a1, -464(s0)
	addw a0, a1, a0
	ld a1, -472(s0)
	addw a0, a1, a0
	ld a1, -480(s0)
	addw a0, a1, a0
	ld a1, -488(s0)
	addw a0, a1, a0
	ld a1, -496(s0)
	addw a0, a1, a0
	ld a1, -512(s0)
	addw a0, a1, a0
	ld a1, -520(s0)
	addw a0, a1, a0
	addw a0, a7, a0
	addw a0, a0, a4
	addw a0, a6, a0
	j .LBB12
.LBB12:
	li t0, 127
	bgt a0, t0, .LBB57
	j .LBB14
.LBB14:
	blt a0, zero, .LBB58
	j .LBB15
.LBB15:
	j .LBB13
.LBB13:
	li a1, 77
	mulw a0, a0, a1
	addw t2, t2, a0
	addi a0, s0, -908
	lw a1, 0(a0)
	li a0, 26
	mulw a1, a1, a0
	addi a0, s0, -908
	addi a0, a0, 4
	lw a0, 0(a0)
	li a2, 76
	mulw a0, a0, a2
	addw a1, a1, a0
	addi a0, s0, -908
	addi a0, a0, 8
	lw a2, 0(a0)
	li a0, -70
	mulw a0, a2, a0
	addw a1, a0, a1
	addi a0, s0, -908
	addi a0, a0, 12
	lw a0, 0(a0)
	mulw a0, a0, s3
	addw a2, a0, a1
	addi a0, s0, -908
	addi a0, a0, 16
	lw a1, 0(a0)
	li a0, -95
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 20
	lw a1, 0(a0)
	li a0, 96
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 24
	lw a1, 0(a0)
	li a0, 52
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 28
	lw a1, 0(a0)
	li a0, -68
	mulw a0, a1, a0
	addw a1, a0, a2
	addi a0, s0, -908
	addi a0, a0, 32
	lw a2, 0(a0)
	li a0, -5
	mulw a0, a2, a0
	addw a2, a0, a1
	addi a0, s0, -908
	addi a0, a0, 36
	lw a1, 0(a0)
	li a0, 34
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 40
	lw a1, 0(a0)
	li a0, -34
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 44
	lw a1, 0(a0)
	li a0, 102
	mulw a0, a1, a0
	addw a1, a0, a2
	addi a0, s0, -908
	addi a0, a0, 48
	lw a2, 0(a0)
	li a0, 6
	mulw a0, a2, a0
	addw a1, a0, a1
	addi a0, s0, -908
	addi a0, a0, 52
	lw a2, 0(a0)
	li a0, -38
	mulw a0, a2, a0
	addw a2, a0, a1
	addi a0, s0, -908
	addi a0, a0, 56
	lw a1, 0(a0)
	li a0, 27
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 60
	lw a1, 0(a0)
	li a0, 110
	mulw a0, a1, a0
	addw a1, a0, a2
	addi a0, s0, -908
	addi a0, a0, 64
	lw a2, 0(a0)
	li a0, 116
	mulw a0, a2, a0
	addw a2, a0, a1
	addi a0, s0, -908
	addi a0, a0, 68
	lw a1, 0(a0)
	li a0, 39
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 72
	lw a1, 0(a0)
	li a0, -63
	mulw a0, a1, a0
	addw a1, a0, a2
	addi a0, s0, -908
	addi a0, a0, 76
	lw a0, 0(a0)
	li a2, -99
	mulw a0, a0, a2
	addw a1, a0, a1
	addi a0, s0, -908
	addi a0, a0, 80
	lw a2, 0(a0)
	li a0, 65
	mulw a0, a2, a0
	addw a2, a0, a1
	addi a0, s0, -908
	addi a0, a0, 84
	lw a1, 0(a0)
	li a0, 120
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 88
	lw a1, 0(a0)
	li a0, -39
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 92
	lw a1, 0(a0)
	li a0, -6
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 96
	lw a1, 0(a0)
	li a0, 94
	mulw a0, a1, a0
	addw a0, a0, a2
	j .LBB16
.LBB16:
	li t0, 127
	bgt a0, t0, .LBB59
	j .LBB18
.LBB18:
	blt a0, zero, .LBB60
	j .LBB19
.LBB19:
	j .LBB17
.LBB17:
	li a1, 127
	mulw a0, a0, a1
	addw t2, a0, t2
	addi a0, s0, -908
	lw a0, 0(a0)
	sd a0, -440(s0)
	addi a0, s0, -908
	addi a0, a0, 4
	lw a0, 0(a0)
	li a1, -63
	mulw a0, a0, a1
	sd a0, -432(s0)
	addi a0, s0, -908
	addi a0, a0, 8
	lw a0, 0(a0)
	li a1, 49
	mulw a0, a0, a1
	sd a0, -528(s0)
	addi a0, s0, -908
	addi a0, a0, 12
	lw a1, 0(a0)
	li a0, 50
	mulw a0, a1, a0
	sd a0, -808(s0)
	addi a0, s0, -908
	addi a0, a0, 16
	lw a0, 0(a0)
	li a1, 72
	mulw a0, a0, a1
	sd a0, -800(s0)
	addi a0, s0, -908
	addi a0, a0, 20
	lw a0, 0(a0)
	li a1, 85
	mulw a0, a0, a1
	sd a0, -792(s0)
	addi a0, s0, -908
	addi a0, a0, 24
	lw a1, 0(a0)
	li a0, -30
	mulw a0, a1, a0
	sd a0, -784(s0)
	addi a0, s0, -908
	addi a0, a0, 28
	lw a1, 0(a0)
	li a0, 12
	mulw a0, a1, a0
	sd a0, -776(s0)
	addi a0, s0, -908
	addi a0, a0, 32
	lw s10, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 36
	lw a0, 0(a0)
	sd a0, -768(s0)
	addi a0, s0, -908
	addi a0, a0, 40
	lw a1, 0(a0)
	li a0, -65
	mulw a0, a1, a0
	sd a0, -760(s0)
	addi a0, s0, -908
	addi a0, a0, 44
	lw a1, 0(a0)
	li a0, -67
	mulw a0, a1, a0
	sd a0, -752(s0)
	addi a0, s0, -908
	addi a0, a0, 48
	lw a6, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 52
	lw a1, 0(a0)
	li a0, 110
	mulw s9, a1, a0
	addi a0, s0, -908
	addi a0, a0, 56
	lw a0, 0(a0)
	mulw s8, a0, s1
	addi a0, s0, -908
	addi a0, a0, 60
	lw a1, 0(a0)
	li a0, -123
	mulw s7, a1, a0
	addi a0, s0, -908
	addi a0, a0, 64
	lw a1, 0(a0)
	li a0, 83
	mulw s6, a1, a0
	addi a0, s0, -908
	addi a0, a0, 68
	lw a1, 0(a0)
	li a0, 122
	mulw s5, a1, a0
	addi a0, s0, -908
	addi a0, a0, 72
	lw a0, 0(a0)
	li a1, 11
	mulw a7, a0, a1
	addi a0, s0, -908
	addi a0, a0, 76
	lw a4, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 80
	lw a1, 0(a0)
	li a0, -47
	mulw a5, a1, a0
	addi a0, s0, -908
	addi a0, a0, 84
	lw a1, 0(a0)
	li a0, -32
	mulw a3, a1, a0
	addi a0, s0, -908
	addi a0, a0, 88
	lw a0, 0(a0)
	addi a1, s0, -908
	addi a1, a1, 92
	lw a2, 0(a1)
	li a1, 95
	mulw a2, a2, a1
	addi a1, s0, -908
	addi a1, a1, 96
	lw s11, 0(a1)
	li a1, 118
	mulw a1, s11, a1
	addw s10, a6, s10
	li a6, 125
	mulw a6, s10, a6
	ld s10, -440(s0)
	addw a4, a4, s10
	li s10, -23
	mulw a4, a4, s10
	ld s10, -768(s0)
	addw s10, a0, s10
	li a0, -117
	mulw a0, s10, a0
	addw a3, a3, a5
	addw a3, a7, a3
	addw a3, s5, a3
	addw a3, s6, a3
	addw a3, s7, a3
	addw a3, s8, a3
	addw a3, s9, a3
	addw a2, a2, a3
	ld a3, -752(s0)
	addw a2, a3, a2
	ld a3, -760(s0)
	addw a2, a3, a2
	addw a1, a1, a2
	ld a2, -776(s0)
	addw a1, a2, a1
	ld a2, -784(s0)
	addw a1, a2, a1
	ld a2, -792(s0)
	addw a1, a2, a1
	ld a2, -800(s0)
	addw a1, a2, a1
	ld a2, -808(s0)
	addw a1, a2, a1
	ld a2, -528(s0)
	addw a2, a2, a1
	ld a1, -432(s0)
	addw a1, a1, a2
	addw a0, a1, a0
	addw a0, a4, a0
	addw a0, a6, a0
	j .LBB20
.LBB20:
	li t0, 127
	bgt a0, t0, .LBB61
	j .LBB22
.LBB22:
	blt a0, zero, .LBB62
	j .LBB23
.LBB23:
	j .LBB21
.LBB21:
	li a1, -106
	mulw a0, a0, a1
	addw t2, a0, t2
	addi a0, s0, -908
	lw a0, 0(a0)
	slliw a1, a0, 3
	addi a0, s0, -908
	addi a0, a0, 4
	lw a0, 0(a0)
	li a2, 82
	mulw a0, a0, a2
	addw a1, a1, a0
	addi a0, s0, -908
	addi a0, a0, 8
	lw a0, 0(a0)
	li a2, -104
	mulw a0, a0, a2
	addw a1, a0, a1
	addi a0, s0, -908
	addi a0, a0, 12
	lw a2, 0(a0)
	li a0, 101
	mulw a0, a2, a0
	addw a2, a0, a1
	addi a0, s0, -908
	addi a0, a0, 16
	lw a1, 0(a0)
	li a0, -116
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 20
	lw a1, 0(a0)
	li a0, -63
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 24
	lw a0, 0(a0)
	li a1, -16
	mulw a0, a0, a1
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 28
	lw a1, 0(a0)
	li a0, -70
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 32
	lw a1, 0(a0)
	li a0, 125
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 36
	lw a1, 0(a0)
	li a0, 75
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 40
	lw a1, 0(a0)
	li a0, 66
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 44
	lw a1, 0(a0)
	li a0, -96
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 48
	lw a1, 0(a0)
	li a0, -101
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 52
	lw a1, 0(a0)
	li a0, -114
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 56
	lw a1, 0(a0)
	li a0, 59
	mulw a0, a1, a0
	addw a1, a0, a2
	addi a0, s0, -908
	addi a0, a0, 60
	lw a2, 0(a0)
	li a0, 12
	mulw a0, a2, a0
	addw a1, a0, a1
	addi a0, s0, -908
	addi a0, a0, 64
	lw a2, 0(a0)
	li a0, 5
	mulw a0, a2, a0
	addw a1, a0, a1
	addi a0, s0, -908
	addi a0, a0, 68
	lw a2, 0(a0)
	li a0, -95
	mulw a0, a2, a0
	addw a1, a0, a1
	addi a0, s0, -908
	addi a0, a0, 72
	lw a2, 0(a0)
	li a0, 116
	mulw a0, a2, a0
	addw a1, a0, a1
	addi a0, s0, -908
	addi a0, a0, 76
	lw a2, 0(a0)
	li a0, -93
	mulw a0, a2, a0
	addw a2, a0, a1
	addi a0, s0, -908
	addi a0, a0, 80
	lw a1, 0(a0)
	li a0, 15
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 84
	lw a1, 0(a0)
	li a0, 79
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 88
	lw a1, 0(a0)
	li a0, 3
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 92
	lw a1, 0(a0)
	li a0, 49
	mulw a0, a1, a0
	addw a2, a0, a2
	addi a0, s0, -908
	addi a0, a0, 96
	lw a1, 0(a0)
	li a0, -124
	mulw a0, a1, a0
	addw a0, a0, a2
	j .LBB24
.LBB24:
	li t0, 127
	bgt a0, t0, .LBB63
	j .LBB26
.LBB26:
	blt a0, zero, .LBB64
	j .LBB27
.LBB27:
	j .LBB25
.LBB25:
	li a1, -3
	mulw a0, a0, a1
	addw t2, a0, t2
	addi a0, s0, -908
	lw a0, 0(a0)
	li a1, 81
	mulw a0, a0, a1
	sd a0, -744(s0)
	addi a0, s0, -908
	addi a0, a0, 4
	lw a1, 0(a0)
	li a0, 68
	mulw a0, a1, a0
	sd a0, -736(s0)
	addi a0, s0, -908
	addi a0, a0, 8
	lw a1, 0(a0)
	li a0, -102
	mulw a0, a1, a0
	sd a0, -728(s0)
	addi a0, s0, -908
	addi a0, a0, 12
	lw a1, 0(a0)
	li a0, -74
	mulw a0, a1, a0
	sd a0, -624(s0)
	addi a0, s0, -908
	addi a0, a0, 16
	lw a1, 0(a0)
	li a0, 121
	mulw a0, a1, a0
	sd a0, -720(s0)
	addi a0, s0, -908
	addi a0, a0, 20
	lw a0, 0(a0)
	li a1, -15
	mulw a0, a0, a1
	sd a0, -712(s0)
	addi a0, s0, -908
	addi a0, a0, 24
	lw a1, 0(a0)
	li a0, 55
	mulw a0, a1, a0
	sd a0, -704(s0)
	addi a0, s0, -908
	addi a0, a0, 28
	lw a0, 0(a0)
	li a1, 101
	mulw a0, a0, a1
	sd a0, -696(s0)
	addi a0, s0, -908
	addi a0, a0, 32
	lw a0, 0(a0)
	li a1, -13
	mulw a0, a0, a1
	sd a0, -688(s0)
	addi a0, s0, -908
	addi a0, a0, 36
	lw a0, 0(a0)
	li a1, -62
	mulw a0, a0, a1
	sd a0, -680(s0)
	addi a0, s0, -908
	addi a0, a0, 40
	lw a0, 0(a0)
	slliw a0, a0, 6
	sd a0, -672(s0)
	addi a0, s0, -908
	addi a0, a0, 44
	lw a7, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 48
	lw a0, 0(a0)
	li a1, 38
	mulw s10, a0, a1
	addi a0, s0, -908
	addi a0, a0, 52
	lw a0, 0(a0)
	li a1, -21
	mulw s9, a0, a1
	addi a0, s0, -908
	addi a0, a0, 56
	lw s8, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 60
	lw a5, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 64
	lw s6, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 68
	lw a0, 0(a0)
	li a1, -10
	mulw s7, a0, a1
	addi a0, s0, -908
	addi a0, a0, 72
	lw a0, 0(a0)
	li a1, -16
	mulw s5, a0, a1
	addi a0, s0, -908
	addi a0, a0, 76
	lw a1, 0(a0)
	li a0, -50
	mulw a6, a1, a0
	addi a0, s0, -908
	addi a0, a0, 80
	lw a0, 0(a0)
	li a1, -112
	mulw a4, a0, a1
	addi a0, s0, -908
	addi a0, a0, 84
	lw a0, 0(a0)
	li a1, -116
	mulw a3, a0, a1
	addi a0, s0, -908
	addi a0, a0, 88
	lw a0, 0(a0)
	li a1, -54
	mulw a2, a0, a1
	addi a0, s0, -908
	addi a0, a0, 92
	lw a0, 0(a0)
	li a1, 82
	mulw a1, a0, a1
	addi a0, s0, -908
	addi a0, a0, 96
	lw a0, 0(a0)
	li s11, -72
	mulw a0, a0, s11
	addw a5, a5, a7
	li a7, 114
	mulw a7, a5, a7
	addw a5, s6, s8
	li s6, 112
	mulw a5, a5, s6
	addw a3, a4, a3
	addw a3, a6, a3
	addw a3, s5, a3
	addw a3, s7, a3
	addw a2, a2, a3
	addw a1, a1, a2
	addw a1, s9, a1
	addw a1, s10, a1
	addw a0, a0, a1
	ld a1, -672(s0)
	addw a1, a1, a0
	ld a0, -680(s0)
	addw a1, a0, a1
	ld a0, -688(s0)
	addw a0, a0, a1
	ld a1, -696(s0)
	addw a0, a1, a0
	ld a1, -704(s0)
	addw a0, a1, a0
	ld a1, -712(s0)
	addw a1, a1, a0
	ld a0, -720(s0)
	addw a0, a0, a1
	ld a1, -624(s0)
	addw a0, a1, a0
	ld a1, -728(s0)
	addw a0, a1, a0
	ld a1, -736(s0)
	addw a0, a1, a0
	ld a1, -744(s0)
	addw a0, a1, a0
	addw a0, a0, a5
	addw a0, a7, a0
	j .LBB28
.LBB28:
	li t0, 127
	bgt a0, t0, .LBB65
	j .LBB30
.LBB30:
	blt a0, zero, .LBB66
	j .LBB31
.LBB31:
	j .LBB29
.LBB29:
	slliw a0, a0, 5
	addw t2, a0, t2
	addi a0, s0, -908
	lw a0, 0(a0)
	sd a0, -664(s0)
	addi a0, s0, -908
	addi a0, a0, 4
	lw a0, 0(a0)
	li a1, -77
	mulw a0, a0, a1
	sd a0, -656(s0)
	addi a0, s0, -908
	addi a0, a0, 8
	lw a0, 0(a0)
	sd a0, -648(s0)
	addi a0, s0, -908
	addi a0, a0, 12
	lw a1, 0(a0)
	li a0, -90
	mulw a0, a1, a0
	sd a0, -640(s0)
	addi a0, s0, -908
	addi a0, a0, 16
	lw a1, 0(a0)
	li a0, -6
	mulw a0, a1, a0
	sd a0, -632(s0)
	addi a0, s0, -908
	addi a0, a0, 20
	lw a0, 0(a0)
	li a1, -30
	mulw a0, a0, a1
	sd a0, -328(s0)
	addi a0, s0, -908
	addi a0, a0, 24
	lw a1, 0(a0)
	li a0, -8
	mulw a0, a1, a0
	sd a0, -216(s0)
	addi a0, s0, -908
	addi a0, a0, 28
	lw a1, 0(a0)
	li a0, 81
	mulw a0, a1, a0
	sd a0, -208(s0)
	addi a0, s0, -908
	addi a0, a0, 32
	lw a0, 0(a0)
	slliw a0, a0, 1
	sd a0, -200(s0)
	addi a0, s0, -908
	addi a0, a0, 36
	lw a1, 0(a0)
	li a0, -110
	mulw a0, a1, a0
	sd a0, -192(s0)
	addi a0, s0, -908
	addi a0, a0, 40
	lw a1, 0(a0)
	li a0, -95
	mulw a0, a1, a0
	sd a0, -184(s0)
	addi a0, s0, -908
	addi a0, a0, 44
	lw a1, 0(a0)
	li a0, 59
	mulw s10, a1, a0
	addi a0, s0, -908
	addi a0, a0, 48
	lw a1, 0(a0)
	li a0, 52
	mulw s9, a1, a0
	addi a0, s0, -908
	addi a0, a0, 52
	lw a3, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 56
	lw a1, 0(a0)
	li a0, 55
	mulw s8, a1, a0
	addi a0, s0, -908
	addi a0, a0, 60
	lw a1, 0(a0)
	li a0, -33
	mulw s7, a1, a0
	addi a0, s0, -908
	addi a0, a0, 64
	lw a1, 0(a0)
	li a0, 14
	mulw s6, a1, a0
	addi a0, s0, -908
	addi a0, a0, 68
	lw a1, 0(a0)
	li a0, 58
	mulw s5, a1, a0
	addi a0, s0, -908
	addi a0, a0, 72
	lw a1, 0(a0)
	li a0, 67
	mulw a6, a1, a0
	addi a0, s0, -908
	addi a0, a0, 76
	lw a1, 0(a0)
	li a0, 86
	mulw a4, a1, a0
	addi a0, s0, -908
	addi a0, a0, 80
	lw a0, 0(a0)
	li a1, -79
	mulw a2, a0, a1
	addi a0, s0, -908
	addi a0, a0, 84
	lw a1, 0(a0)
	li a0, 48
	mulw a1, a1, a0
	addi a0, s0, -908
	addi a0, a0, 88
	lw a0, 0(a0)
	li a5, -13
	mulw a7, a0, a5
	addi a0, s0, -908
	addi a0, a0, 92
	lw a5, 0(a0)
	li a0, -15
	mulw a0, a5, a0
	addi a5, s0, -908
	addi a5, a5, 96
	lw s11, 0(a5)
	ld a5, -664(s0)
	addw a5, a3, a5
	li a3, 15
	mulw a5, a5, a3
	ld a3, -648(s0)
	addw s11, a3, s11
	li a3, 66
	mulw a3, s11, a3
	addw a1, a2, a1
	addw a1, a4, a1
	addw a1, a6, a1
	addw a1, s5, a1
	addw a1, s6, a1
	addw a1, s7, a1
	addw a1, s8, a1
	addw a0, a0, a1
	addw a0, s9, a0
	addw a0, s10, a0
	ld a1, -184(s0)
	addw a1, a1, a0
	ld a0, -192(s0)
	addw a0, a0, a1
	ld a1, -200(s0)
	addw a1, a1, a0
	ld a0, -208(s0)
	addw a0, a0, a1
	ld a1, -216(s0)
	addw a0, a1, a0
	ld a1, -328(s0)
	addw a1, a1, a0
	ld a0, -632(s0)
	addw a0, a0, a1
	ld a1, -640(s0)
	addw a0, a1, a0
	addw a0, a7, a0
	ld a1, -656(s0)
	addw a0, a1, a0
	addw a0, a0, a3
	addw a0, a5, a0
	j .LBB32
.LBB32:
	li t0, 127
	bgt a0, t0, .LBB67
	j .LBB34
.LBB34:
	blt a0, zero, .LBB68
	j .LBB35
.LBB35:
	j .LBB33
.LBB33:
	li a1, -95
	mulw a0, a0, a1
	addw t2, a0, t2
	addi a0, s0, -908
	lw a1, 0(a0)
	li a0, 33
	mulw a0, a1, a0
	sd a0, -176(s0)
	addi a0, s0, -908
	addi a0, a0, 4
	lw a0, 0(a0)
	sd a0, -168(s0)
	addi a0, s0, -908
	addi a0, a0, 8
	lw a0, 0(a0)
	li a1, 67
	mulw a0, a0, a1
	sd a0, -160(s0)
	addi a0, s0, -908
	addi a0, a0, 12
	lw a1, 0(a0)
	li a0, 30
	mulw a0, a1, a0
	sd a0, -152(s0)
	addi a0, s0, -908
	addi a0, a0, 16
	lw a1, 0(a0)
	li a0, -2
	mulw a0, a1, a0
	sd a0, -144(s0)
	addi a0, s0, -908
	addi a0, a0, 20
	lw a0, 0(a0)
	sd a0, -136(s0)
	addi a0, s0, -908
	addi a0, a0, 24
	lw a1, 0(a0)
	li a0, 120
	mulw a0, a1, a0
	sd a0, -24(s0)
	addi a0, s0, -908
	addi a0, a0, 28
	lw a0, 0(a0)
	li a1, -13
	mulw a0, a0, a1
	sd a0, -120(s0)
	addi a0, s0, -908
	addi a0, a0, 32
	lw a1, 0(a0)
	li a0, 18
	mulw a0, a1, a0
	sd a0, -112(s0)
	addi a0, s0, -908
	addi a0, a0, 36
	lw a0, 0(a0)
	li a1, 5
	mulw a0, a0, a1
	sd a0, -104(s0)
	addi a0, s0, -908
	addi a0, a0, 40
	lw a0, 0(a0)
	li a1, 104
	mulw a0, a0, a1
	sd a0, -96(s0)
	addi a0, s0, -908
	addi a0, a0, 44
	lw a0, 0(a0)
	li a1, -119
	mulw s10, a0, a1
	addi a0, s0, -908
	addi a0, a0, 48
	lw a1, 0(a0)
	li a0, -7
	mulw s9, a1, a0
	addi a0, s0, -908
	addi a0, a0, 52
	lw a1, 0(a0)
	li a0, 71
	mulw s8, a1, a0
	addi a0, s0, -908
	addi a0, a0, 56
	lw a1, 0(a0)
	li a0, 107
	mulw s7, a1, a0
	addi a0, s0, -908
	addi a0, a0, 60
	lw a0, 0(a0)
	li a1, 24
	mulw s6, a0, a1
	addi a0, s0, -908
	addi a0, a0, 64
	lw a5, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 68
	lw a0, 0(a0)
	li a1, -96
	mulw s5, a0, a1
	addi a0, s0, -908
	addi a0, a0, 72
	lw a1, 0(a0)
	li a0, -104
	mulw a7, a1, a0
	addi a0, s0, -908
	addi a0, a0, 76
	lw a1, 0(a0)
	li a0, -121
	mulw a4, a1, a0
	addi a0, s0, -908
	addi a0, a0, 80
	lw a3, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 84
	lw a1, 0(a0)
	li a0, 97
	mulw a2, a1, a0
	addi a0, s0, -908
	addi a0, a0, 88
	lw a1, 0(a0)
	li a0, 83
	mulw a1, a1, a0
	addi a0, s0, -908
	addi a0, a0, 92
	lw a6, 0(a0)
	li a0, 46
	mulw a0, a6, a0
	addi a6, s0, -908
	addi a6, a6, 96
	lw s11, 0(a6)
	li a6, -84
	mulw a6, s11, a6
	ld s11, -168(s0)
	addw s11, a5, s11
	li a5, 82
	mulw a5, s11, a5
	ld s11, -136(s0)
	addw s11, a3, s11
	li a3, 65
	mulw a3, s11, a3
	addw a1, a1, a2
	addw a1, a4, a1
	addw a1, a7, a1
	addw a1, s5, a1
	addw a0, a0, a1
	addw a0, s6, a0
	addw a0, s7, a0
	addw a0, s8, a0
	addw a0, s9, a0
	addw a1, s10, a0
	ld a0, -96(s0)
	addw a0, a0, a1
	ld a1, -104(s0)
	addw a1, a1, a0
	ld a0, -112(s0)
	addw a1, a0, a1
	ld a0, -120(s0)
	addw a0, a0, a1
	ld a1, -24(s0)
	addw a1, a1, a0
	ld a0, -144(s0)
	addw a1, a0, a1
	ld a0, -152(s0)
	addw a1, a0, a1
	ld a0, -160(s0)
	addw a0, a0, a1
	addw a1, a6, a0
	ld a0, -176(s0)
	addw a0, a0, a1
	addw a0, a0, a3
	addw a0, a5, a0
	j .LBB36
.LBB36:
	li t0, 127
	bgt a0, t0, .LBB69
	j .LBB38
.LBB38:
	blt a0, zero, .LBB70
	j .LBB39
.LBB39:
	j .LBB37
.LBB37:
	li a1, -50
	mulw a0, a0, a1
	addw t2, a0, t2
	addi a0, s0, -908
	lw a0, 0(a0)
	li a1, -29
	mulw a0, a0, a1
	sd a0, -88(s0)
	addi a0, s0, -908
	addi a0, a0, 4
	lw a1, 0(a0)
	li a0, 7
	mulw a0, a1, a0
	sd a0, -80(s0)
	addi a0, s0, -908
	addi a0, a0, 8
	lw a0, 0(a0)
	sd a0, -72(s0)
	addi a0, s0, -908
	addi a0, a0, 12
	lw a0, 0(a0)
	li a1, 38
	mulw a0, a0, a1
	sd a0, -64(s0)
	addi a0, s0, -908
	addi a0, a0, 16
	lw a0, 0(a0)
	li a1, -90
	mulw a0, a0, a1
	sd a0, -56(s0)
	addi a0, s0, -908
	addi a0, a0, 20
	lw a0, 0(a0)
	li a1, -15
	mulw a0, a0, a1
	sd a0, -48(s0)
	addi a0, s0, -908
	addi a0, a0, 24
	lw a1, 0(a0)
	li a0, -32
	mulw a0, a1, a0
	sd a0, -40(s0)
	addi a0, s0, -908
	addi a0, a0, 28
	lw s10, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 32
	lw a0, 0(a0)
	li a1, 36
	mulw a0, a0, a1
	sd a0, -32(s0)
	addi a0, s0, -908
	addi a0, a0, 36
	lw a1, 0(a0)
	li a0, -62
	mulw a0, a1, a0
	sd a0, -128(s0)
	addi a0, s0, -908
	addi a0, a0, 40
	lw a1, 0(a0)
	li a0, -125
	mulw a0, a1, a0
	sd a0, -416(s0)
	addi a0, s0, -908
	addi a0, a0, 44
	lw a0, 0(a0)
	li a1, -46
	mulw a0, a0, a1
	sd a0, -408(s0)
	addi a0, s0, -908
	addi a0, a0, 48
	lw s9, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 52
	lw a6, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 56
	lw a0, 0(a0)
	li a1, -73
	mulw s8, a0, a1
	addi a0, s0, -908
	addi a0, a0, 60
	lw a0, 0(a0)
	li a1, -34
	mulw s7, a0, a1
	addi a0, s0, -908
	addi a0, a0, 64
	lw a0, 0(a0)
	li a1, -87
	mulw s6, a0, a1
	addi a0, s0, -908
	addi a0, a0, 68
	lw a0, 0(a0)
	li a1, -75
	mulw s5, a0, a1
	addi a0, s0, -908
	addi a0, a0, 72
	lw a1, 0(a0)
	li a0, 71
	mulw a7, a1, a0
	addi a0, s0, -908
	addi a0, a0, 76
	lw a0, 0(a0)
	li a1, -77
	mulw a5, a0, a1
	addi a0, s0, -908
	addi a0, a0, 80
	lw a1, 0(a0)
	li a0, 53
	mulw a4, a1, a0
	addi a0, s0, -908
	addi a0, a0, 84
	lw a0, 0(a0)
	addi a1, s0, -908
	addi a1, a1, 88
	lw a2, 0(a1)
	li a1, -103
	mulw a3, a2, a1
	addi a1, s0, -908
	addi a1, a1, 92
	lw a1, 0(a1)
	li a2, -13
	mulw a1, a1, a2
	addi a2, s0, -908
	addi a2, a2, 96
	lw s11, 0(a2)
	li a2, -114
	mulw a2, s11, a2
	addw a6, a6, s10
	addw a0, a0, a6
	li a6, 37
	mulw a6, a0, a6
	ld a0, -72(s0)
	addw s9, s9, a0
	li a0, -70
	mulw a0, s9, a0
	addw a4, a5, a4
	addw a4, a7, a4
	addw a4, s5, a4
	addw a4, s6, a4
	addw a4, s7, a4
	addw a4, s8, a4
	addw a1, a1, a4
	addw a3, a3, a1
	ld a1, -408(s0)
	addw a1, a1, a3
	ld a3, -416(s0)
	addw a1, a3, a1
	ld a3, -128(s0)
	addw a1, a3, a1
	ld a3, -32(s0)
	addw a1, a3, a1
	addw a1, a2, a1
	ld a2, -40(s0)
	addw a1, a2, a1
	ld a2, -48(s0)
	addw a1, a2, a1
	ld a2, -56(s0)
	addw a1, a2, a1
	ld a2, -64(s0)
	addw a1, a2, a1
	ld a2, -80(s0)
	addw a1, a2, a1
	ld a2, -88(s0)
	addw a1, a2, a1
	addw a0, a1, a0
	addw a0, a6, a0
	j .LBB40
.LBB40:
	li t0, 127
	bgt a0, t0, .LBB71
	j .LBB42
.LBB42:
	blt a0, zero, .LBB72
	j .LBB43
.LBB43:
	j .LBB41
.LBB41:
	li a1, -23
	mulw a0, a0, a1
	addw t2, a0, t2
	addi a0, s0, -908
	lw a0, 0(a0)
	sd a0, -400(s0)
	addi a0, s0, -908
	addi a0, a0, 4
	lw a0, 0(a0)
	li a1, 42
	mulw a0, a0, a1
	sd a0, -392(s0)
	addi a0, s0, -908
	addi a0, a0, 8
	lw a1, 0(a0)
	li a0, 41
	mulw a0, a1, a0
	sd a0, -384(s0)
	addi a0, s0, -908
	addi a0, a0, 12
	lw a0, 0(a0)
	li a1, -123
	mulw a0, a0, a1
	sd a0, -376(s0)
	addi a0, s0, -908
	addi a0, a0, 16
	lw a1, 0(a0)
	li a0, -92
	mulw a0, a1, a0
	sd a0, -368(s0)
	addi a0, s0, -908
	addi a0, a0, 20
	lw a0, 0(a0)
	li a1, 10
	mulw a0, a0, a1
	sd a0, -360(s0)
	addi a0, s0, -908
	addi a0, a0, 24
	lw a1, 0(a0)
	li a0, -77
	mulw a0, a1, a0
	sd a0, -352(s0)
	addi a0, s0, -908
	addi a0, a0, 28
	lw a1, 0(a0)
	li a0, 75
	mulw a0, a1, a0
	sd a0, -344(s0)
	addi a0, s0, -908
	addi a0, a0, 32
	lw a1, 0(a0)
	li a0, 96
	mulw a0, a1, a0
	sd a0, -336(s0)
	addi a0, s0, -908
	addi a0, a0, 36
	lw a0, 0(a0)
	li a1, -51
	mulw a0, a0, a1
	sd a0, -224(s0)
	addi a0, s0, -908
	addi a0, a0, 40
	lw a0, 0(a0)
	li a1, 109
	mulw a0, a0, a1
	sd a0, -320(s0)
	addi a0, s0, -908
	addi a0, a0, 44
	lw a1, 0(a0)
	li a0, -74
	mulw s10, a1, a0
	addi a0, s0, -908
	addi a0, a0, 48
	lw a0, 0(a0)
	li a1, -7
	mulw s9, a0, a1
	addi a0, s0, -908
	addi a0, a0, 52
	lw a1, 0(a0)
	li a0, -122
	mulw s7, a1, a0
	addi a0, s0, -908
	addi a0, a0, 56
	lw a1, 0(a0)
	addi a0, s0, -908
	addi a0, a0, 60
	lw a2, 0(a0)
	li a0, 47
	mulw a7, a2, a0
	addi a0, s0, -908
	addi a0, a0, 64
	lw a2, 0(a0)
	li a0, 22
	mulw a5, a2, a0
	addi a0, s0, -908
	addi a0, a0, 68
	lw a0, 0(a0)
	li a2, -68
	mulw a3, a0, a2
	addi a0, s0, -908
	addi a0, a0, 72
	lw a2, 0(a0)
	li a0, 38
	mulw s6, a2, a0
	addi a0, s0, -908
	addi a0, a0, 76
	lw a0, 0(a0)
	mulw s8, a0, s3
	addi a0, s0, -908
	addi a0, a0, 80
	lw a2, 0(a0)
	li a0, 115
	mulw s5, a2, a0
	addi a0, s0, -908
	addi a0, a0, 84
	lw a2, 0(a0)
	li a0, -121
	mulw a6, a2, a0
	addi a0, s0, -908
	addi a0, a0, 88
	lw a2, 0(a0)
	li a0, 36
	mulw a4, a2, a0
	addi a0, s0, -908
	addi a0, a0, 92
	lw a2, 0(a0)
	li a0, -49
	mulw a2, a2, a0
	addi a0, s0, -908
	addi a0, a0, 96
	lw s11, 0(a0)
	li a0, 85
	mulw a0, s11, a0
	ld s11, -400(s0)
	addw a1, a1, s11
	li s11, 67
	mulw a1, a1, s11
	addw a5, a7, a5
	addw a3, a3, a5
	addw a3, s7, a3
	addw a3, s9, a3
	addw a3, s10, a3
	ld a5, -320(s0)
	addw a3, a5, a3
	ld a5, -224(s0)
	addw a3, a5, a3
	ld a5, -336(s0)
	addw a3, a5, a3
	ld a5, -344(s0)
	addw a5, a5, a3
	ld a3, -352(s0)
	addw a3, a3, a5
	ld a5, -360(s0)
	addw a3, a5, a3
	ld a5, -368(s0)
	addw a3, a5, a3
	ld a5, -376(s0)
	addw a5, a5, a3
	ld a3, -384(s0)
	addw a3, a3, a5
	ld a5, -392(s0)
	addw a3, a5, a3
	addw a3, s6, a3
	addw a0, a0, a3
	addw a0, a2, a0
	addw a0, a4, a0
	addw a0, a6, a0
	addw a0, s5, a0
	addw a0, s8, a0
	addw a0, a0, a1
	j .LBB44
.LBB44:
	li t0, 127
	bgt a0, t0, .LBB73
	j .LBB46
.LBB46:
	blt a0, zero, .LBB74
	j .LBB47
.LBB47:
	j .LBB45
.LBB45:
	j .LBB48
.LBB48:
	li a1, 46
	mulw a0, a0, a1
	addw t2, a0, t2
	bgt t2, zero, .LBB75
	j .LBB50
.LBB50:
	mv t2, zero
	j .LBB49
.LBB49:
	bne t2, zero, .LBB51
	j .LBB52
.LBB53:
	ld t2, -616(s0)
	li a1, 1
	subw t2, t2, a1
	ld t2, -616(s0)
	j .LBB1
.LBB52:
	li a0, 100
	call putch
	li a0, 111
	call putch
	li a0, 103
	call putch
	li a0, 10
	call putch
	j .LBB53
.LBB51:
	li a0, 99
	call putch
	li a0, 97
	call putch
	li a0, 116
	call putch
	li a0, 10
	call putch
	j .LBB53
.LBB3:
	mv a0, zero
	ld s1, -312(s0)
	ld s2, -304(s0)
	ld s3, -296(s0)
	ld s4, -288(s0)
	ld s5, -280(s0)
	ld s6, -272(s0)
	ld s7, -264(s0)
	ld s8, -256(s0)
	ld s9, -248(s0)
	ld s10, -240(s0)
	ld s11, -232(s0)
	ld ra, 904(sp)
	ld s0, 896(sp)
	addi sp, sp, 912
	ret 
.LBB54:
	mv s6, zero
	j .LBB2
.LBB55:
	li t2, 127
	j .LBB9
.LBB56:
	mv t2, zero
	j .LBB9
.LBB57:
	li a0, 127
	j .LBB13
.LBB58:
	mv a0, zero
	j .LBB13
.LBB59:
	li a0, 127
	j .LBB17
.LBB60:
	mv a0, zero
	j .LBB17
.LBB61:
	li a0, 127
	j .LBB21
.LBB62:
	mv a0, zero
	j .LBB21
.LBB63:
	li a0, 127
	j .LBB25
.LBB64:
	mv a0, zero
	j .LBB25
.LBB65:
	li a0, 127
	j .LBB29
.LBB66:
	mv a0, zero
	j .LBB29
.LBB67:
	li a0, 127
	j .LBB33
.LBB68:
	mv a0, zero
	j .LBB33
.LBB69:
	li a0, 127
	j .LBB37
.LBB70:
	mv a0, zero
	j .LBB37
.LBB71:
	li a0, 127
	j .LBB41
.LBB72:
	mv a0, zero
	j .LBB41
.LBB73:
	li a0, 127
	j .LBB45
.LBB74:
	mv a0, zero
	j .LBB45
.LBB75:
	li t2, 1
	j .LBB49
.LBB76:
	mv s5, zero
	j .LBB4
    .size main, .-main
