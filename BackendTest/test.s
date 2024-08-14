    .file  "/home/nanqin/compiler/miniC-compiler/BackendTest/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	LoadImmReg t2, -94
	LoadImmReg t2, 27
	LoadImmReg t2, 12
	LoadImmReg t2, 125
	LoadImmReg t2, -65
	LoadImmReg t2, 83
	LoadImmReg t2, 7
	LoadImmReg t2, -121
	LoadImmReg t2, -96
	LoadImmReg t2, -119
	LoadImmReg t2, 104
	LoadImmReg t2, 18
	LoadImmReg t2, -2
	LoadImmReg t2, -49
	LoadImmReg t2, 75
	LoadImmReg t2, -77
	LoadImmReg t2, 10
	LoadImmReg t2, -68
	LoadImmReg t2, 14
	LoadImmReg t2, 120
	LoadImmReg t2, -124
	LoadImmReg t2, 85
	LoadImmReg s2, -46
	LoadImmReg s2, -31
	LoadImmReg s2, 95
	LoadImmReg s2, -30
	LoadImmReg s2, -54
	LoadImmReg s2, -39
	LoadImmReg s2, 37
	LoadImmReg s2, -70
	LoadImmReg s2, 58
	LoadImmReg s2, -6
	LoadImmReg s2, 114
	LoadImmReg s2, 113
	LoadImmReg s2, 112
	LoadImmReg s2, 110
	LoadImmReg s2, 101
	LoadImmReg s2, -18
	LoadImmReg s2, 71
	LoadImmReg s2, 11
	LoadImmReg s2, -74
	LoadImmReg s2, -123
	LoadImmReg s2, -90
	LoadImmReg s2, -63
	LoadImmReg s2, 5
	LoadImmReg s2, 105
	LoadImmReg s2, 30
	LoadImmReg s2, 116
	LoadImmReg s2, -15
	LoadImmReg s2, 50
	LoadImmReg s2, 115
	LoadImmReg s2, -38
	LoadImmReg s2, -112
	LoadImmReg s2, 34
	LoadImmReg s2, 22
	LoadImmReg s2, 6
	LoadImmReg s2, -29
	LoadImmReg s2, -22
	LoadImmReg s2, -87
	LoadImmReg s2, 26
	LoadImmReg s2, 109
	LoadImmReg s2, -34
	LoadImmReg s2, 86
	LoadImmReg s2, 94
	LoadImmReg s2, 66
	LoadImmReg s2, -4
	LoadImmReg s2, -101
	LoadImmReg s2, -21
	LoadImmReg s2, 68
	LoadImmReg s2, -103
	LoadImmReg s2, 33
	LoadImmReg s2, 72
	LoadImmReg s2, -79
	LoadImmReg s2, 127
	LoadImmReg s2, -3
	LoadImmReg s2, 23
	LoadImmReg s2, -122
	LoadImmReg s2, 102
	LoadImmReg s2, -33
	LoadImmReg s2, -99
	LoadImmReg s2, -13
	LoadImmReg s2, -111
	LoadImmReg s2, -117
	LoadImmReg s2, 47
	LoadImmReg s2, -51
	LoadImmReg s2, -5
	LoadImmReg s2, 121
	LoadImmReg s2, -120
	LoadImmReg s2, 15
	LoadImmReg s2, 87
	LoadImmReg s2, -93
	LoadImmReg s2, -42
	LoadImmReg s2, -92
	LoadImmReg s2, 52
	LoadImmReg s2, 118
	LoadImmReg s2, 80
	LoadImmReg s2, 59
	LoadImmReg s2, -43
	LoadImmReg s2, -114
	LoadImmReg s2, -60
	LoadImmReg s2, -7
	LoadImmReg s2, 122
	LoadImmReg s2, -72
	LoadImmReg s2, 65
	LoadImmReg s2, -23
	LoadImmReg s2, 46
	LoadImmReg s2, 48
	LoadImmReg s2, 49
	LoadImmReg s2, 53
	LoadImmReg s2, 76
	LoadImmReg s2, 107
	LoadImmReg s2, -47
	LoadImmReg s2, -16
	LoadImmReg s2, 67
	LoadImmReg s2, -116
	LoadImmReg s2, -8
	LoadImmReg s2, -73
	LoadImmReg s2, 77
	LoadImmReg s2, 55
	LoadImmReg s2, -59
	LoadImmReg s2, -104
	LoadImmReg s2, 126
	LoadImmReg s2, 82
	LoadImmReg s2, 39
	LoadImmReg s2, 36
	LoadImmReg s2, -125
	LoadImmReg s2, 81
	LoadImmReg s2, -82
	LoadImmReg s2, 24
	LoadImmReg s2, -32
	LoadImmReg s2, -50
	LoadImmReg s2, -102
	LoadImmReg s2, 97
	LoadImmReg s2, 96
	LoadImmReg s2, -10
	LoadImmReg s2, -75
	LoadImmReg s2, 79
	LoadImmReg s2, 29
	LoadImmReg s2, 38
	LoadImmReg s2, -106
	LoadImmReg s2, -84
	LoadImmReg s2, -100
	LoadImmReg s2, 3
	LoadImmReg s2, -67
	LoadImmReg s2, 42
	LoadImmReg s2, -95
	LoadImmReg s2, 41
	LoadImmReg s2, -110
	LoadImmReg s2, -62
	call getint
	bgt a0, 0, .LBB59
	j .LBB2
.LBB1:
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv s3, a0
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv s11, a0
	call getint
	mv s10, a0
	call getint
	mv s9, a0
	call getint
	mv s8, a0
	call getint
	mv s7, a0
	call getint
	mv s6, a0
	call getint
	mv s4, a0
	call getint
	mv s5, a0
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mulw a1, s6, s2
	mulw t2, s5, s2
	mulw a2, s7, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a2, a1
	mulw a2, s9, s2
	addw t2, t2, a1
	mulw a1, s10, s2
	addw t2, a2, t2
	mulw a2, s11, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a3, a1
	mulw a2, s3, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a6, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a6, a1
	mulw a2, a0, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a4, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a4, a1
	ld a1, 0(s0)
	slliw a3, a1, 6
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a4, t2, s2
	ld t2, 0(s0)
	addw a5, s8, t2
	addw a3, a2, a1
	ld t2, 0(s0)
	LoadImmReg a1, 85
	mulw a2, t2, a1
	addw a1, s4, a5
	addw t2, a4, a3
	mulw a1, a1, s2
	addw t2, a2, t2
	addw t2, t2, a1
	bgt t2, 127, .LBB39
	j .LBB4
.LBB4:
	blt t2, 0, .LBB38
	j .LBB5
.LBB5:
	mv a4, t2
	j .LBB3
.LBB3:
	mulw t2, s6, s2
	mulw a1, s4, s2
	mulw a2, s5, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a2, a1
	mulw a2, s9, s2
	addw t2, t2, a1
	mulw a1, s10, s2
	addw t2, a2, t2
	mulw a2, s11, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	mulw a3, s3, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	LoadImmReg a3, 7
	mulw a3, t2, a3
	addw t2, a2, a1
	ld a1, 0(s0)
	LoadImmReg a2, -121
	mulw a2, a1, a2
	addw a1, a3, t2
	ld a3, 0(s0)
	LoadImmReg t2, -94
	mulw a3, a3, t2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw t2, a2, t2
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	mulw a5, a0, s2
	ld t2, 0(s0)
	addw a2, s7, t2
	addw t2, a3, a1
	ld a1, 0(s0)
	addw a1, s8, a1
	mulw a2, a2, s2
	addw t2, a5, t2
	mulw a1, a1, s2
	addw t2, t2, a2
	mulw a4, a4, s2
	addw t2, a1, t2
	bgt t2, 127, .LBB40
	j .LBB7
.LBB7:
	blt t2, 0, .LBB41
	j .LBB8
.LBB8:
	mv a5, t2
	j .LBB6
.LBB6:
	ld t2, 0(s0)
	mulw a2, t2, s2
	ld t2, 0(s0)
	mulw a1, t2, s2
	ld t2, 0(s0)
	mulw s1, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, s1, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	ld a2, 0(s0)
	LoadImmReg a1, -68
	mulw a2, a2, a1
	addw a1, a3, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	mulw a1, s3, s2
	addw a2, a2, t2
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a3, a1, a2
	ld a2, 0(s0)
	LoadImmReg a1, 27
	mulw a2, a2, a1
	addw t2, t2, a3
	mulw a1, s11, s2
	addw t2, a2, t2
	mulw a2, s10, s2
	addw t2, a1, t2
	mulw a1, s9, s2
	addw t2, a2, t2
	mulw a2, s8, s2
	addw t2, a1, t2
	mulw a1, s7, s2
	addw t2, a2, t2
	mulw t5, s6, s2
	addw a1, a1, t2
	LoadImmReg t2, 120
	mulw t2, s4, t2
	addw a2, t5, a1
	mulw a1, s5, s2
	addw t2, t2, a2
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw t2, a1, t2
	mulw a1, a5, s2
	mulw a2, a0, s2
	addw t2, a3, t2
	addw t3, a4, a1
	addw t2, a2, t2
	bgt t2, 127, .LBB42
	j .LBB10
.LBB10:
	blt t2, 0, .LBB43
	j .LBB11
.LBB11:
	mv a5, t2
	j .LBB9
.LBB9:
	mulw a1, s6, s2
	mulw a2, s4, s2
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a2, a1, a2
	mulw a1, s8, s2
	addw t2, t2, a2
	mulw a3, s9, s2
	addw a1, a1, t2
	LoadImmReg t2, 83
	mulw a2, s10, t2
	addw t2, a3, a1
	mulw a1, s11, s2
	addw t2, a2, t2
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	LoadImmReg t2, 125
	mulw a3, s3, t2
	addw a1, a2, a1
	ld a2, 0(s0)
	LoadImmReg t2, -65
	mulw a2, a2, t2
	addw a1, a3, a1
	ld t2, 0(s0)
	LoadImmReg a3, 125
	mulw a7, t2, a3
	addw a1, a2, a1
	ld t2, 0(s0)
	LoadImmReg a2, 12
	mulw a2, t2, a2
	addw a1, a7, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	ld a2, 0(s0)
	LoadImmReg a1, 85
	mulw a2, a2, a1
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a3, a1
	mulw a2, a0, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	addw a3, s5, t2
	addw a1, a2, a1
	ld t2, 0(s0)
	addw a4, s7, t2
	mulw a2, a3, s2
	addw t2, a6, a1
	mulw a1, a5, s2
	mulw a3, a4, s2
	addw t2, t2, a2
	addw a5, a1, t3
	addw t2, a3, t2
	bgt t2, 127, .LBB44
	j .LBB13
.LBB13:
	blt t2, 0, .LBB45
	j .LBB14
.LBB14:
	mv a6, t2
	j .LBB12
.LBB12:
	ld t2, 0(s0)
	mulw t6, t2, s2
	ld t2, 0(s0)
	slliw a1, t2, 3
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a1, t6
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw t2, a2, t2
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw a1, a3, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a1, a1, s2
	addw t2, a2, t2
	addw a1, a1, t2
	ld t2, 0(s0)
	LoadImmReg a2, 75
	mulw a2, t2, a2
	addw a1, a7, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a4, a2, a1
	ld a1, 0(s0)
	LoadImmReg t2, -96
	mulw a2, a1, t2
	addw t2, a3, a4
	mulw a1, s3, s2
	addw t2, a2, t2
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	LoadImmReg a1, 12
	mulw a1, s11, a1
	addw t2, a2, t2
	mulw a2, s10, s2
	addw t2, a1, t2
	mulw a1, s9, s2
	addw t2, a2, t2
	mulw a2, s8, s2
	addw t2, a1, t2
	mulw a1, s7, s2
	addw t2, a2, t2
	mulw a2, s6, s2
	addw t2, a1, t2
	mulw a1, s4, s2
	addw t2, a2, t2
	mulw a2, s5, s2
	addw t2, a1, t2
	ld a1, 0(s0)
	mulw a4, a1, s2
	addw a2, a2, t2
	mulw a1, a6, s2
	LoadImmReg t2, -124
	mulw a3, a0, t2
	addw t2, a4, a2
	addw a6, a1, a5
	addw t2, a3, t2
	bgt t2, 127, .LBB46
	j .LBB16
.LBB16:
	blt t2, 0, .LBB47
	j .LBB17
.LBB17:
	mv a5, t2
	j .LBB15
.LBB15:
	mulw t2, s6, s2
	mulw a2, s4, s2
	mulw a1, s7, s2
	addw t2, t2, a2
	mulw a2, s8, s2
	addw t2, a1, t2
	mulw a1, s9, s2
	addw t2, a2, t2
	mulw a2, s5, s2
	addw t2, a1, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	mulw a1, s3, s2
	addw t2, a2, t2
	mulw a3, a0, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	slliw a2, t2, 6
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw t4, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, t4, a1
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw t3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, t3, a1
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a4, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	addw a3, s10, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a4, a1
	ld t2, 0(s0)
	addw a4, s11, t2
	mulw a3, a3, s2
	addw t2, a2, a1
	mulw a2, a5, s2
	mulw a1, a4, s2
	addw t2, t2, a3
	addw a4, a2, a6
	addw t2, a1, t2
	bgt t2, 127, .LBB48
	j .LBB19
.LBB19:
	blt t2, 0, .LBB49
	j .LBB20
.LBB20:
	mv a5, t2
	j .LBB18
.LBB18:
	mulw t2, s6, s2
	mulw a1, s4, s2
	mulw a2, s7, s2
	addw t2, t2, a1
	mulw a1, s8, s2
	addw t2, a2, t2
	mulw a2, s9, s2
	addw a1, a1, t2
	LoadImmReg t2, 14
	mulw t2, s10, t2
	addw a1, a2, a1
	mulw a2, s11, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	mulw a1, s3, s2
	addw t2, a2, t2
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	slliw t2, t2, 1
	addw a1, a3, a1
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw t2, t2, a1
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a2, a1
	mulw a6, s5, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	addw a3, t2, a0
	ld t2, 0(s0)
	LoadImmReg a2, -77
	mulw a2, t2, a2
	addw a6, a6, a1
	ld t2, 0(s0)
	ld a1, 0(s0)
	addw a1, t2, a1
	mulw a3, a3, s2
	addw t2, a2, a6
	slliw a2, a5, 5
	mulw a1, a1, s2
	addw t2, t2, a3
	addw a6, a2, a4
	addw t2, a1, t2
	bgt t2, 127, .LBB50
	j .LBB22
.LBB22:
	blt t2, 0, .LBB51
	j .LBB23
.LBB23:
	mv a5, t2
	j .LBB21
.LBB21:
	ld t2, 0(s0)
	mulw a1, t2, s2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a1, t6
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld a2, 0(s0)
	LoadImmReg t2, -2
	mulw a2, a2, t2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a2, a1
	ld a3, 0(s0)
	LoadImmReg a2, 120
	mulw a2, a3, a2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	ld a2, 0(s0)
	LoadImmReg a1, 18
	mulw a2, a2, a1
	addw a1, a3, t2
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a2, a1
	ld a3, 0(s0)
	LoadImmReg a2, 104
	mulw a3, a3, a2
	addw a1, t2, a1
	ld a2, 0(s0)
	LoadImmReg t2, -119
	mulw a2, a2, t2
	addw t2, a3, a1
	mulw a7, s3, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a7, a1
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	mulw a1, s11, s2
	addw t2, a2, t2
	mulw a2, s10, s2
	addw a1, a1, t2
	LoadImmReg t2, -96
	mulw t2, s9, t2
	addw a1, a2, a1
	mulw a2, s8, s2
	addw a1, t2, a1
	LoadImmReg t2, -121
	mulw a3, s7, t2
	addw t2, a2, a1
	addw t2, a3, t2
	mulw a2, s4, s2
	addw a1, t5, t2
	LoadImmReg t2, 83
	mulw a4, s5, t2
	addw t2, a2, a1
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw t2, a4, t2
	mulw a1, a5, s2
	mulw a2, a0, s2
	addw t2, a3, t2
	addw a5, a1, a6
	addw t2, a2, t2
	bgt t2, 127, .LBB52
	j .LBB25
.LBB25:
	blt t2, 0, .LBB53
	j .LBB26
.LBB26:
	mv a4, t2
	j .LBB24
.LBB24:
	mulw a1, s6, s2
	mulw t2, s5, s2
	LoadImmReg a2, -77
	mulw a2, s7, a2
	addw t2, a1, t2
	mulw a1, s8, s2
	addw t2, a2, t2
	mulw a2, s9, s2
	addw t2, a1, t2
	mulw a1, s10, s2
	addw t2, a2, t2
	mulw a3, s11, s2
	addw t2, a1, t2
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a1, a1, s2
	addw t2, a2, t2
	mulw a2, s3, s2
	addw t2, a1, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	ld a1, 0(s0)
	mulw a1, a1, s2
	addw t2, a2, t2
	mulw a2, a0, s2
	addw t2, a1, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	LoadImmReg a2, 7
	mulw a6, t2, a2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a3, a6, a1
	ld a1, 0(s0)
	ld t2, 0(s0)
	addw a1, a1, t2
	addw t2, a2, a3
	addw t2, t4, t2
	addw a1, s4, a1
	addw t2, t3, t2
	mulw a2, a4, s2
	mulw a1, a1, s2
	addw t2, s1, t2
	addw a6, a2, a5
	addw t2, t2, a1
	bgt t2, 127, .LBB54
	j .LBB28
.LBB28:
	blt t2, 0, .LBB55
	j .LBB29
.LBB29:
	mv a5, t2
	j .LBB27
.LBB27:
	LoadImmReg t2, -121
	mulw t2, s4, t2
	mulw a1, s5, s2
	mulw a2, s6, s2
	addw t2, t2, a1
	mulw a1, s7, s2
	addw t2, a2, t2
	mulw a3, s8, s2
	addw t2, a1, t2
	LoadImmReg a1, -68
	mulw a2, s9, a1
	addw t2, a3, t2
	mulw a1, s10, s2
	addw t2, a2, t2
	mulw a4, s11, s2
	addw a1, a1, t2
	LoadImmReg t2, -49
	ld a2, 0(s0)
	mulw a3, a2, t2
	addw a1, a4, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a4, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a4, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	LoadImmReg a2, 75
	mulw a2, t2, a2
	addw a3, a3, a1
	ld t2, 0(s0)
	LoadImmReg a1, -77
	mulw a1, t2, a1
	addw a4, a2, a3
	ld a2, 0(s0)
	LoadImmReg t2, 10
	mulw a3, a2, t2
	addw t2, a1, a4
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw t2, a2, t2
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw a1, a3, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	LoadImmReg a1, 85
	mulw a2, a0, a1
	addw a3, a3, t2
	ld a0, 0(s0)
	ld t2, 0(s0)
	addw a1, a0, t2
	addw t2, a2, a3
	mulw a0, a5, s2
	mulw a1, a1, s2
	addw t2, a7, t2
	addw a0, a0, a6
	addw t2, t2, a1
	bgt t2, 127, .LBB56
	j .LBB31
.LBB31:
	blt t2, 0, .LBB57
	j .LBB32
.LBB32:
	j .LBB30
.LBB30:
	mulw t2, t2, s2
	addw t2, t2, a0
	bgt t2, 0, .LBB58
	j .LBB34
.LBB34:
	li t2, 0
	j .LBB33
.LBB33:
	bne t2, 0, .LBB35
	j .LBB36
.LBB37:
	ld t2, 0(s0)
	addiw t2, t2, -1
	bgt t2, 0, .LBB60
	j .LBB2
.LBB36:
	li a0, 100
	call putch
	li a0, 111
	call putch
	li a0, 103
	call putch
	li a0, 10
	call putch
	j .LBB37
.LBB35:
	li a0, 99
	call putch
	li a0, 97
	call putch
	li a0, 116
	call putch
	li a0, 10
	call putch
	j .LBB37
.LBB2:
	li a0, 0
	ret 
.LBB38:
	li a4, 0
	j .LBB3
.LBB39:
	li a4, 127
	j .LBB3
.LBB40:
	li a5, 127
	j .LBB6
.LBB41:
	li a5, 0
	j .LBB6
.LBB42:
	li a5, 127
	j .LBB9
.LBB43:
	li a5, 0
	j .LBB9
.LBB44:
	li a6, 127
	j .LBB12
.LBB45:
	li a6, 0
	j .LBB12
.LBB46:
	li a5, 127
	j .LBB15
.LBB47:
	li a5, 0
	j .LBB15
.LBB48:
	li a5, 127
	j .LBB18
.LBB49:
	li a5, 0
	j .LBB18
.LBB50:
	li a5, 127
	j .LBB21
.LBB51:
	li a5, 0
	j .LBB21
.LBB52:
	li a4, 127
	j .LBB24
.LBB53:
	li a4, 0
	j .LBB24
.LBB54:
	li a5, 127
	j .LBB27
.LBB55:
	li a5, 0
	j .LBB27
.LBB56:
	li t2, 127
	j .LBB30
.LBB57:
	li t2, 0
	j .LBB30
.LBB58:
	li t2, 1
	j .LBB33
.LBB59:
	mv t2, a0
	sd t2, 0(s0)
	j .LBB1
.LBB60:
	sd t2, 0(s0)
	j .LBB1
    .size main, .-main
    .file  "/home/nanqin/compiler/miniC-compiler/BackendTest/test.s"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	LoadImmReg s2, -46
	LoadImmReg s2, -31
	LoadImmReg s2, 95
	LoadImmReg s2, -30
	LoadImmReg s2, -54
	LoadImmReg s2, -39
	LoadImmReg s2, 37
	LoadImmReg s2, -70
	LoadImmReg s2, 58
	LoadImmReg s2, -6
	LoadImmReg s2, 114
	LoadImmReg s2, 113
	LoadImmReg s2, 112
	LoadImmReg s2, 110
	LoadImmReg s2, 101
	LoadImmReg s2, -18
	LoadImmReg s2, 71
	LoadImmReg s2, 11
	LoadImmReg s2, -74
	LoadImmReg s2, -123
	LoadImmReg s2, -90
	LoadImmReg s2, -63
	LoadImmReg s2, 5
	LoadImmReg s2, 105
	LoadImmReg s2, 30
	LoadImmReg s2, 116
	LoadImmReg s2, -15
	LoadImmReg s2, 50
	LoadImmReg s2, 115
	LoadImmReg s2, -38
	LoadImmReg s2, -112
	LoadImmReg s2, 34
	LoadImmReg s2, 22
	LoadImmReg s2, 6
	LoadImmReg s2, -29
	LoadImmReg s2, -22
	LoadImmReg s2, -87
	LoadImmReg s2, 26
	LoadImmReg s2, 109
	LoadImmReg s2, -34
	LoadImmReg s2, 86
	LoadImmReg s2, 94
	LoadImmReg s2, 66
	LoadImmReg s2, -4
	LoadImmReg s2, -101
	LoadImmReg s2, -21
	LoadImmReg s2, 68
	LoadImmReg s2, -103
	LoadImmReg s2, 33
	LoadImmReg s2, 72
	LoadImmReg s2, -79
	LoadImmReg s2, 127
	LoadImmReg s2, -3
	LoadImmReg s2, 23
	LoadImmReg s2, -122
	LoadImmReg s2, 102
	LoadImmReg s2, -33
	LoadImmReg s2, -99
	LoadImmReg s2, -13
	LoadImmReg s2, -111
	LoadImmReg s2, -117
	LoadImmReg s2, 47
	LoadImmReg s2, -51
	LoadImmReg s2, -5
	LoadImmReg s2, 121
	LoadImmReg s2, -120
	LoadImmReg s2, 15
	LoadImmReg s2, 87
	LoadImmReg s2, -93
	LoadImmReg s2, -42
	LoadImmReg s2, -92
	LoadImmReg s2, 52
	LoadImmReg s2, 118
	LoadImmReg s2, 80
	LoadImmReg s2, 59
	LoadImmReg s2, -43
	LoadImmReg s2, -114
	LoadImmReg s2, -60
	LoadImmReg s2, -7
	LoadImmReg s2, 122
	LoadImmReg s2, -72
	LoadImmReg s2, 65
	LoadImmReg s2, -23
	LoadImmReg s2, 46
	LoadImmReg s2, 48
	LoadImmReg s2, 49
	LoadImmReg s2, 53
	LoadImmReg s2, 76
	LoadImmReg s2, 107
	LoadImmReg s2, -47
	LoadImmReg s2, -16
	LoadImmReg s2, 67
	LoadImmReg s2, -116
	LoadImmReg s2, -8
	LoadImmReg s2, -73
	LoadImmReg s2, 77
	LoadImmReg s2, 55
	LoadImmReg s2, -59
	LoadImmReg s2, -104
	LoadImmReg s2, 126
	LoadImmReg s2, 82
	LoadImmReg s2, 39
	LoadImmReg s2, 36
	LoadImmReg s2, -125
	LoadImmReg s2, 81
	LoadImmReg s2, -82
	LoadImmReg s2, 24
	LoadImmReg s2, -32
	LoadImmReg s2, -50
	LoadImmReg s2, -102
	LoadImmReg s2, 97
	LoadImmReg s2, 96
	LoadImmReg s2, -10
	LoadImmReg s2, -75
	LoadImmReg s2, 79
	LoadImmReg s2, 29
	LoadImmReg s2, 38
	LoadImmReg s2, -106
	LoadImmReg s2, -84
	LoadImmReg s2, -100
	LoadImmReg s2, 3
	LoadImmReg s2, -67
	LoadImmReg s2, 42
	LoadImmReg s2, -95
	LoadImmReg s2, 41
	LoadImmReg s2, -110
	LoadImmReg s2, -62
	call getint
	bgt a0, 0, .LBB59
	j .LBB2
.LBB1:
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv s3, a0
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mv s11, a0
	call getint
	mv s10, a0
	call getint
	mv s9, a0
	call getint
	mv s8, a0
	call getint
	mv s7, a0
	call getint
	mv s6, a0
	call getint
	mv s4, a0
	call getint
	mv s5, a0
	call getint
	mv t2, a0
	sd t2, 0(s0)
	call getint
	mulw a1, s6, s2
	mulw t2, s5, s2
	mulw a2, s7, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a2, a1
	mulw a2, s9, s2
	addw t2, t2, a1
	mulw a1, s10, s2
	addw t2, a2, t2
	mulw a2, s11, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a3, a1
	mulw a2, s3, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a6, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a6, a1
	mulw a2, a0, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a4, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a4, a1
	ld a1, 0(s0)
	slliw a3, a1, 6
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a4, t2, s2
	ld t2, 0(s0)
	addw a5, s8, t2
	addw a3, a2, a1
	ld t2, 0(s0)
	LoadImmReg a1, 85
	mulw a2, t2, a1
	addw a1, s4, a5
	addw t2, a4, a3
	mulw a1, a1, s2
	addw t2, a2, t2
	addw t2, t2, a1
	bgt t2, 127, .LBB39
	j .LBB4
.LBB4:
	blt t2, 0, .LBB38
	j .LBB5
.LBB5:
	mv a4, t2
	j .LBB3
.LBB3:
	mulw t2, s6, s2
	mulw a1, s4, s2
	mulw a2, s5, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a2, a1
	mulw a2, s9, s2
	addw t2, t2, a1
	mulw a1, s10, s2
	addw t2, a2, t2
	mulw a2, s11, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	mulw a3, s3, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	LoadImmReg a3, 7
	mulw a3, t2, a3
	addw t2, a2, a1
	ld a1, 0(s0)
	LoadImmReg a2, -121
	mulw a2, a1, a2
	addw a1, a3, t2
	ld a3, 0(s0)
	LoadImmReg t2, -94
	mulw a3, a3, t2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw t2, a2, t2
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	mulw a5, a0, s2
	ld t2, 0(s0)
	addw a2, s7, t2
	addw t2, a3, a1
	ld a1, 0(s0)
	addw a1, s8, a1
	mulw a2, a2, s2
	addw t2, a5, t2
	mulw a1, a1, s2
	addw t2, t2, a2
	mulw a4, a4, s2
	addw t2, a1, t2
	bgt t2, 127, .LBB40
	j .LBB7
.LBB7:
	blt t2, 0, .LBB41
	j .LBB8
.LBB8:
	mv a5, t2
	j .LBB6
.LBB6:
	ld t2, 0(s0)
	mulw a2, t2, s2
	ld t2, 0(s0)
	mulw a1, t2, s2
	ld t2, 0(s0)
	mulw s1, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, s1, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	ld a2, 0(s0)
	LoadImmReg a1, -68
	mulw a2, a2, a1
	addw a1, a3, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	mulw a1, s3, s2
	addw a2, a2, t2
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a3, a1, a2
	ld a2, 0(s0)
	LoadImmReg a1, 27
	mulw a2, a2, a1
	addw t2, t2, a3
	mulw a1, s11, s2
	addw t2, a2, t2
	mulw a2, s10, s2
	addw t2, a1, t2
	mulw a1, s9, s2
	addw t2, a2, t2
	mulw a2, s8, s2
	addw t2, a1, t2
	mulw a1, s7, s2
	addw t2, a2, t2
	mulw t5, s6, s2
	addw a1, a1, t2
	LoadImmReg t2, 120
	mulw t2, s4, t2
	addw a2, t5, a1
	mulw a1, s5, s2
	addw t2, t2, a2
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw t2, a1, t2
	mulw a1, a5, s2
	mulw a2, a0, s2
	addw t2, a3, t2
	addw t3, a4, a1
	addw t2, a2, t2
	bgt t2, 127, .LBB42
	j .LBB10
.LBB10:
	blt t2, 0, .LBB43
	j .LBB11
.LBB11:
	mv a5, t2
	j .LBB9
.LBB9:
	mulw a1, s6, s2
	mulw a2, s4, s2
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a2, a1, a2
	mulw a1, s8, s2
	addw t2, t2, a2
	mulw a3, s9, s2
	addw a1, a1, t2
	LoadImmReg t2, 83
	mulw a2, s10, t2
	addw t2, a3, a1
	mulw a1, s11, s2
	addw t2, a2, t2
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	LoadImmReg t2, 125
	mulw a3, s3, t2
	addw a1, a2, a1
	ld a2, 0(s0)
	LoadImmReg t2, -65
	mulw a2, a2, t2
	addw a1, a3, a1
	ld t2, 0(s0)
	LoadImmReg a3, 125
	mulw a7, t2, a3
	addw a1, a2, a1
	ld t2, 0(s0)
	LoadImmReg a2, 12
	mulw a2, t2, a2
	addw a1, a7, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	ld a2, 0(s0)
	LoadImmReg a1, 85
	mulw a2, a2, a1
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a3, a1
	mulw a2, a0, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	addw a3, s5, t2
	addw a1, a2, a1
	ld t2, 0(s0)
	addw a4, s7, t2
	mulw a2, a3, s2
	addw t2, a6, a1
	mulw a1, a5, s2
	mulw a3, a4, s2
	addw t2, t2, a2
	addw a5, a1, t3
	addw t2, a3, t2
	bgt t2, 127, .LBB44
	j .LBB13
.LBB13:
	blt t2, 0, .LBB45
	j .LBB14
.LBB14:
	mv a6, t2
	j .LBB12
.LBB12:
	ld t2, 0(s0)
	mulw t6, t2, s2
	ld t2, 0(s0)
	slliw a1, t2, 3
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a1, t6
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw t2, a2, t2
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw a1, a3, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a1, a1, s2
	addw t2, a2, t2
	addw a1, a1, t2
	ld t2, 0(s0)
	LoadImmReg a2, 75
	mulw a2, t2, a2
	addw a1, a7, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a4, a2, a1
	ld a1, 0(s0)
	LoadImmReg t2, -96
	mulw a2, a1, t2
	addw t2, a3, a4
	mulw a1, s3, s2
	addw t2, a2, t2
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	LoadImmReg a1, 12
	mulw a1, s11, a1
	addw t2, a2, t2
	mulw a2, s10, s2
	addw t2, a1, t2
	mulw a1, s9, s2
	addw t2, a2, t2
	mulw a2, s8, s2
	addw t2, a1, t2
	mulw a1, s7, s2
	addw t2, a2, t2
	mulw a2, s6, s2
	addw t2, a1, t2
	mulw a1, s4, s2
	addw t2, a2, t2
	mulw a2, s5, s2
	addw t2, a1, t2
	ld a1, 0(s0)
	mulw a4, a1, s2
	addw a2, a2, t2
	mulw a1, a6, s2
	LoadImmReg t2, -124
	mulw a3, a0, t2
	addw t2, a4, a2
	addw a6, a1, a5
	addw t2, a3, t2
	bgt t2, 127, .LBB46
	j .LBB16
.LBB16:
	blt t2, 0, .LBB47
	j .LBB17
.LBB17:
	mv a5, t2
	j .LBB15
.LBB15:
	mulw t2, s6, s2
	mulw a2, s4, s2
	mulw a1, s7, s2
	addw t2, t2, a2
	mulw a2, s8, s2
	addw t2, a1, t2
	mulw a1, s9, s2
	addw t2, a2, t2
	mulw a2, s5, s2
	addw t2, a1, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	mulw a1, s3, s2
	addw t2, a2, t2
	mulw a3, a0, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	slliw a2, t2, 6
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw t4, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, t4, a1
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw t3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, t3, a1
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a4, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	addw a3, s10, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a4, a1
	ld t2, 0(s0)
	addw a4, s11, t2
	mulw a3, a3, s2
	addw t2, a2, a1
	mulw a2, a5, s2
	mulw a1, a4, s2
	addw t2, t2, a3
	addw a4, a2, a6
	addw t2, a1, t2
	bgt t2, 127, .LBB48
	j .LBB19
.LBB19:
	blt t2, 0, .LBB49
	j .LBB20
.LBB20:
	mv a5, t2
	j .LBB18
.LBB18:
	mulw t2, s6, s2
	mulw a1, s4, s2
	mulw a2, s7, s2
	addw t2, t2, a1
	mulw a1, s8, s2
	addw t2, a2, t2
	mulw a2, s9, s2
	addw a1, a1, t2
	LoadImmReg t2, 14
	mulw t2, s10, t2
	addw a1, a2, a1
	mulw a2, s11, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	mulw a1, s3, s2
	addw t2, a2, t2
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw a1, a1, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	slliw t2, t2, 1
	addw a1, a3, a1
	ld a2, 0(s0)
	mulw a3, a2, s2
	addw t2, t2, a1
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a2, a1
	mulw a6, s5, s2
	addw a1, t2, a1
	ld t2, 0(s0)
	addw a3, t2, a0
	ld t2, 0(s0)
	LoadImmReg a2, -77
	mulw a2, t2, a2
	addw a6, a6, a1
	ld t2, 0(s0)
	ld a1, 0(s0)
	addw a1, t2, a1
	mulw a3, a3, s2
	addw t2, a2, a6
	slliw a2, a5, 5
	mulw a1, a1, s2
	addw t2, t2, a3
	addw a6, a2, a4
	addw t2, a1, t2
	bgt t2, 127, .LBB50
	j .LBB22
.LBB22:
	blt t2, 0, .LBB51
	j .LBB23
.LBB23:
	mv a5, t2
	j .LBB21
.LBB21:
	ld t2, 0(s0)
	mulw a1, t2, s2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a1, t6
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld a2, 0(s0)
	LoadImmReg t2, -2
	mulw a2, a2, t2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a2, a1
	ld a3, 0(s0)
	LoadImmReg a2, 120
	mulw a2, a3, a2
	addw a1, t2, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	ld a2, 0(s0)
	LoadImmReg a1, 18
	mulw a2, a2, a1
	addw a1, a3, t2
	ld t2, 0(s0)
	mulw t2, t2, s2
	addw a1, a2, a1
	ld a3, 0(s0)
	LoadImmReg a2, 104
	mulw a3, a3, a2
	addw a1, t2, a1
	ld a2, 0(s0)
	LoadImmReg t2, -119
	mulw a2, a2, t2
	addw t2, a3, a1
	mulw a7, s3, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a7, a1
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	mulw a1, s11, s2
	addw t2, a2, t2
	mulw a2, s10, s2
	addw a1, a1, t2
	LoadImmReg t2, -96
	mulw t2, s9, t2
	addw a1, a2, a1
	mulw a2, s8, s2
	addw a1, t2, a1
	LoadImmReg t2, -121
	mulw a3, s7, t2
	addw t2, a2, a1
	addw t2, a3, t2
	mulw a2, s4, s2
	addw a1, t5, t2
	LoadImmReg t2, 83
	mulw a4, s5, t2
	addw t2, a2, a1
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw t2, a4, t2
	mulw a1, a5, s2
	mulw a2, a0, s2
	addw t2, a3, t2
	addw a5, a1, a6
	addw t2, a2, t2
	bgt t2, 127, .LBB52
	j .LBB25
.LBB25:
	blt t2, 0, .LBB53
	j .LBB26
.LBB26:
	mv a4, t2
	j .LBB24
.LBB24:
	mulw a1, s6, s2
	mulw t2, s5, s2
	LoadImmReg a2, -77
	mulw a2, s7, a2
	addw t2, a1, t2
	mulw a1, s8, s2
	addw t2, a2, t2
	mulw a2, s9, s2
	addw t2, a1, t2
	mulw a1, s10, s2
	addw t2, a2, t2
	mulw a3, s11, s2
	addw t2, a1, t2
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a1, a1, s2
	addw t2, a2, t2
	mulw a2, s3, s2
	addw t2, a1, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw t2, a3, a1
	ld a1, 0(s0)
	mulw a1, a1, s2
	addw t2, a2, t2
	mulw a2, a0, s2
	addw t2, a1, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw a1, a2, t2
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	LoadImmReg a2, 7
	mulw a6, t2, a2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a3, a6, a1
	ld a1, 0(s0)
	ld t2, 0(s0)
	addw a1, a1, t2
	addw t2, a2, a3
	addw t2, t4, t2
	addw a1, s4, a1
	addw t2, t3, t2
	mulw a2, a4, s2
	mulw a1, a1, s2
	addw t2, s1, t2
	addw a6, a2, a5
	addw t2, t2, a1
	bgt t2, 127, .LBB54
	j .LBB28
.LBB28:
	blt t2, 0, .LBB55
	j .LBB29
.LBB29:
	mv a5, t2
	j .LBB27
.LBB27:
	LoadImmReg t2, -121
	mulw t2, s4, t2
	mulw a1, s5, s2
	mulw a2, s6, s2
	addw t2, t2, a1
	mulw a1, s7, s2
	addw t2, a2, t2
	mulw a3, s8, s2
	addw t2, a1, t2
	LoadImmReg a1, -68
	mulw a2, s9, a1
	addw t2, a3, t2
	mulw a1, s10, s2
	addw t2, a2, t2
	mulw a4, s11, s2
	addw a1, a1, t2
	LoadImmReg t2, -49
	ld a2, 0(s0)
	mulw a3, a2, t2
	addw a1, a4, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	mulw a4, t2, s2
	addw a1, a3, a1
	ld t2, 0(s0)
	mulw a2, t2, s2
	addw a1, a4, a1
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw a1, a2, a1
	ld t2, 0(s0)
	LoadImmReg a2, 75
	mulw a2, t2, a2
	addw a3, a3, a1
	ld t2, 0(s0)
	LoadImmReg a1, -77
	mulw a1, t2, a1
	addw a4, a2, a3
	ld a2, 0(s0)
	LoadImmReg t2, 10
	mulw a3, a2, t2
	addw t2, a1, a4
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw t2, a3, t2
	ld a1, 0(s0)
	mulw a3, a1, s2
	addw t2, a2, t2
	ld a1, 0(s0)
	mulw a2, a1, s2
	addw a1, a3, t2
	ld t2, 0(s0)
	mulw a3, t2, s2
	addw t2, a2, a1
	LoadImmReg a1, 85
	mulw a2, a0, a1
	addw a3, a3, t2
	ld a0, 0(s0)
	ld t2, 0(s0)
	addw a1, a0, t2
	addw t2, a2, a3
	mulw a0, a5, s2
	mulw a1, a1, s2
	addw t2, a7, t2
	addw a0, a0, a6
	addw t2, t2, a1
	bgt t2, 127, .LBB56
	j .LBB31
.LBB31:
	blt t2, 0, .LBB57
	j .LBB32
.LBB32:
	j .LBB30
.LBB30:
	mulw t2, t2, s2
	addw t2, t2, a0
	bgt t2, 0, .LBB58
	j .LBB34
.LBB34:
	li t2, 0
	j .LBB33
.LBB33:
	bne t2, 0, .LBB35
	j .LBB36
.LBB37:
	ld t2, 0(s0)
	addiw t2, t2, -1
	bgt t2, 0, .LBB60
	j .LBB2
.LBB36:
	li a0, 100
	call putch
	li a0, 111
	call putch
	li a0, 103
	call putch
	li a0, 10
	call putch
	j .LBB37
.LBB35:
	li a0, 99
	call putch
	li a0, 97
	call putch
	li a0, 116
	call putch
	li a0, 10
	call putch
	j .LBB37
.LBB2:
	li a0, 0
	ret 
.LBB38:
	li a4, 0
	j .LBB3
.LBB39:
	li a4, 127
	j .LBB3
.LBB40:
	li a5, 127
	j .LBB6
.LBB41:
	li a5, 0
	j .LBB6
.LBB42:
	li a5, 127
	j .LBB9
.LBB43:
	li a5, 0
	j .LBB9
.LBB44:
	li a6, 127
	j .LBB12
.LBB45:
	li a6, 0
	j .LBB12
.LBB46:
	li a5, 127
	j .LBB15
.LBB47:
	li a5, 0
	j .LBB15
.LBB48:
	li a5, 127
	j .LBB18
.LBB49:
	li a5, 0
	j .LBB18
.LBB50:
	li a5, 127
	j .LBB21
.LBB51:
	li a5, 0
	j .LBB21
.LBB52:
	li a4, 127
	j .LBB24
.LBB53:
	li a4, 0
	j .LBB24
.LBB54:
	li a5, 127
	j .LBB27
.LBB55:
	li a5, 0
	j .LBB27
.LBB56:
	li t2, 127
	j .LBB30
.LBB57:
	li t2, 0
	j .LBB30
.LBB58:
	li t2, 1
	j .LBB33
.LBB59:
	mv t2, a0
	sd t2, 0(s0)
	j .LBB1
.LBB60:
	sd t2, 0(s0)
	j .LBB1
    .size main, .-main

