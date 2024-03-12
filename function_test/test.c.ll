define i32 @ifElse(){
.1:
  %.2 = alloca i32
  store i32 5, i32* %.2
  %.7 = load i32, i32* %.2
  %.8 = icmp eq i32 %.7, 5
  br i1 %.8, label %.5, label %.6
.5:
  store i32 25, i32* %.2
  br label %.12 
.6:
  %.16 = load i32, i32* %.2
  %.18 = icmp ne i32 %.16, 2
  br i1 %.18, label %.14, label %.15
.12:
  %.72 = load i32, i32* %.2
  ret i32 %.72 
.14:
  store i32 0, i32* %.2
  br label %.22 
.15:
  %.26 = load i32, i32* %.2
  %.27 = icmp sle i32 %.26, 2
  br i1 %.27, label %.24, label %.25
.22:
  br label %.12 
.24:
  %.29 = load i32, i32* %.2
  %.30 = mul i32 %.29, 2
  store i32 %.30, i32* %.2
  br label %.32 
.25:
  %.36 = load i32, i32* %.2
  %.38 = icmp sge i32 %.36, 10
  br i1 %.38, label %.34, label %.35
.32:
  br label %.22 
.34:
  %.40 = load i32, i32* %.2
  %.42 = mul i32 %.40, 3
  store i32 %.42, i32* %.2
  br label %.44 
.35:
  %.48 = load i32, i32* %.2
  %.50 = icmp slt i32 %.48, 7
  br i1 %.50, label %.46, label %.47
.44:
  br label %.32 
.46:
  %.52 = load i32, i32* %.2
  %.54 = mul i32 %.52, 4
  store i32 %.54, i32* %.2
  br label %.56 
.47:
  %.60 = load i32, i32* %.2
  %.61 = icmp sgt i32 %.60, 7
  br i1 %.61, label %.58, label %.59
.56:
  br label %.44 
.58:
  br label %.63 
.59:
  store i32 0, i32* %.2
  br label %.63 
.63:
  br label %.56 
}
define i32 @main(){
.75:
  %.76at31 = call i32 @ifElse()
  ret i32 %.76at31 
}
define i32 @ifElse(){
.1:
  %.2 = alloca i32
  store i32 5, i32* %.2
  %.7 = load i32, i32* %.2
  %.8 = icmp eq i32 %.7, 5
  br i1 %.8, label %.5, label %.6
.5:
  store i32 25, i32* %.2
  br label %.12 
.6:
  %.16 = load i32, i32* %.2
  %.18 = icmp ne i32 %.16, 2
  br i1 %.18, label %.14, label %.15
.12:
  %.72 = load i32, i32* %.2
  ret i32 %.72 
.14:
  store i32 0, i32* %.2
  br label %.22 
.15:
  %.26 = load i32, i32* %.2
  %.27 = icmp sle i32 %.26, 2
  br i1 %.27, label %.24, label %.25
.22:
  br label %.12 
.24:
  %.29 = load i32, i32* %.2
  %.30 = mul i32 %.29, 2
  store i32 %.30, i32* %.2
  br label %.32 
.25:
  %.36 = load i32, i32* %.2
  %.38 = icmp sge i32 %.36, 10
  br i1 %.38, label %.34, label %.35
.32:
  br label %.22 
.34:
  %.40 = load i32, i32* %.2
  %.42 = mul i32 %.40, 3
  store i32 %.42, i32* %.2
  br label %.44 
.35:
  %.48 = load i32, i32* %.2
  %.50 = icmp slt i32 %.48, 7
  br i1 %.50, label %.46, label %.47
.44:
  br label %.32 
.46:
  %.52 = load i32, i32* %.2
  %.54 = mul i32 %.52, 4
  store i32 %.54, i32* %.2
  br label %.56 
.47:
  %.60 = load i32, i32* %.2
  %.61 = icmp sgt i32 %.60, 7
  br i1 %.61, label %.58, label %.59
.56:
  br label %.44 
.58:
  br label %.63 
.59:
  store i32 0, i32* %.2
  br label %.63 
.63:
  br label %.56 
}
define i32 @main(){
.75:
  %.76at31 = call i32 @ifElse()
  ret i32 %.76at31 
}
ifElse:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32
.LBB0_0:
    sw 5, -20(s0)
    lw .7, -20(s0)
    i_xor_eq .8, .7, 5
    branch .8, .LBB0_1, .LBB0_2
.LBB0_1:
    sw 25, -20(s0)
    j .LBB0_3
.LBB0_2:
    lw .16, -20(s0)
    i_xor_ne .18, .16, 2
    branch .18, .LBB0_4, .LBB0_5
.LBB0_3:
    lw .72, -20(s0)
    lw a0, .72
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret
.LBB0_4:
    sw 0, -20(s0)
    j .LBB0_6
.LBB0_5:
    lw .26, -20(s0)
    i_slt_xori .27, .26, 2
    branch .27, .LBB0_7, .LBB0_8
.LBB0_6:
    j .LBB0_3
.LBB0_7:
    lw .29, -20(s0)
    mulw .30, .29, 2
    sw .30, -20(s0)
    j .LBB0_9
.LBB0_8:
    lw .36, -20(s0)
    i_slt_xori .38, .36, 10
    branch .38, .LBB0_10, .LBB0_11
.LBB0_9:
    j .LBB0_6
.LBB0_10:
    lw .40, -20(s0)
    mulw .42, .40, 3
    sw .42, -20(s0)
    j .LBB0_12
.LBB0_11:
    lw .48, -20(s0)
    i_slt .50, .48, 7
    branch .50, .LBB0_13, .LBB0_14
.LBB0_12:
    j .LBB0_9
.LBB0_13:
    lw .52, -20(s0)
    mulw .54, .52, 4
    sw .54, -20(s0)
    j .LBB0_15
.LBB0_14:
    lw .60, -20(s0)
    i_ .61, 7, .60
    branch .61, .LBB0_16, .LBB0_17
.LBB0_15:
    j .LBB0_12
.LBB0_16:
    j .LBB0_18
.LBB0_17:
    sw 0, -20(s0)
    j .LBB0_18
.LBB0_18:
    j .LBB0_15
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret
main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32
.LBB1_0:
    call ifElse
    lw a0, .76at31
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret
