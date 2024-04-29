    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  def_a
    .data
    .align  2
    .type  def_a, @object
    .size  def_a, 4
def_a:
    .word  1
    .globl  def_b
    .align  2
    .type  def_b, @object
    .size  def_b, 4
def_b:
    .word  1078397501
    .globl  undef_a
    .bss
    .align  2
    .type  undef_a, @object
    .size  undef_a, 4
undef_a:
    .zero  4
    .globl  undef_b
    .align  2
    .type  undef_b, @object
    .size  undef_b, 4
undef_b:
    .zero  4
    .globl  def_arr
    .data
    .align  3
    .type  def_arr, @object
    .size  def_arr, 48
def_arr:
    .word  1
    .word  3
    .zero  40
    .globl  def_arrf
    .align  3
    .type  def_arrf, @object
    .size  def_arrf, 144
def_arrf:
    .word  1078867263
    .zero  140
main:
.19:
	lw %0, ***i32GlobalObject:def_a***

	flw %1, ***floatGlobalObject:def_b***

	fcvt.s.w %2, %0

.20:
	lw %3, ***i32GlobalObject:def_a***

	addi %4, %3, 3
	sw , %4, ***i32GlobalObject:def_a***

	j .30

.21:
	li %5, 5
	sw , %5, %6
	fsw , 0x400aa9fbe0000000, %7
	j .30

.30:
	lw x10, 0
	ret 