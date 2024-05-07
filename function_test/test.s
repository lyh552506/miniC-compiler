<<<<<<< HEAD
    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .globl  def_arrf
    .data
    .align  3
    .type  def_arrf, @object
    .size  def_arrf, 144
def_arrf:
    .word  1078867263
    .zero  140
    .text
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB0:
	lui %1, %hi(.LC0)
	flw %2, %lo(.LC0)(%1)
	fsw 0x4009c28f60000000, %0
	lw a0, 0
	ret 
    .size main, -main
=======
>>>>>>> 8426a32ab0abd15daba0cd31fccad1970714fc77
