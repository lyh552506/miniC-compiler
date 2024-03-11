define i32 @func2(i32 %.3){
.1:
  %.2 = alloca i32
  store i32 %.3, i32* %.2
  %.5 = load i32, i32* %.2
  %.7 = add i32 %.5, 3
  ret i32 %.7 
}
define i32 @func(i32 %.12, i32 %.15, i32 %.18){
.10:
  %.23 = alloca i32
  %.20 = alloca i32
  %.17 = alloca i32
  %.14 = alloca i32
  %.11 = alloca i32
  store i32 %.12, i32* %.11
  store i32 %.15, i32* %.14
  store i32 %.18, i32* %.17
  store i32 1, i32* %.20
  %.25at8 = call i32 @func2(i32 2)
  store i32 %.25at8, i32* %.23
  %.29 = load i32, i32* %.17
  %.30 = icmp sgt i32 %.29, 1
  br i1 %.30, label %.27, label %.28
.27:
  %.32 = load i32, i32* %.11
  %.33 = load i32, i32* %.14
  %.34 = add i32 %.32, %.33
  store i32 %.34, i32* %.20
  br label %.36 
.28:
  %.38 = load i32, i32* %.11
  %.39 = load i32, i32* %.14
  %.40 = sub i32 %.38, %.39
  store i32 %.40, i32* %.20
  br label %.36 
.36:
  %.43 = load i32, i32* %.20
  ret i32 %.43 
}
define i32 @func2(i32 %.3){
.1:
  %.2 = alloca i32
  store i32 %.3, i32* %.2
  %.5 = load i32, i32* %.2
  %.7 = add i32 %.5, 3
  ret i32 %.7 
}
define i32 @func(i32 %.12, i32 %.15, i32 %.18){
.10:
  %.23 = alloca i32
  %.20 = alloca i32
  %.17 = alloca i32
  %.14 = alloca i32
  %.11 = alloca i32
  store i32 %.12, i32* %.11
  store i32 %.15, i32* %.14
  store i32 %.18, i32* %.17
  store i32 1, i32* %.20
  %.25at8 = call i32 @func2(i32 2)
  store i32 %.25at8, i32* %.23
  %.29 = load i32, i32* %.17
  %.30 = icmp sgt i32 %.29, 1
  br i1 %.30, label %.27, label %.28
.27:
  %.32 = load i32, i32* %.11
  %.33 = load i32, i32* %.14
  %.34 = add i32 %.32, %.33
  store i32 %.34, i32* %.20
  br label %.36 
.28:
  %.38 = load i32, i32* %.11
  %.39 = load i32, i32* %.14
  %.40 = sub i32 %.38, %.39
  store i32 %.40, i32* %.20
  br label %.36 
.36:
  %.43 = load i32, i32* %.20
  ret i32 %.43 
}
func2:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32
    sw .3, -20(s0)
    lw .5, -20(s0)
    addw .7, .5, 3
    lw a0, .7
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret
func:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    addi s0, sp, 48
    sw .12, -36(s0)
    sw .15, -32(s0)
    sw .18, -28(s0)
    sw 1, -24(s0)
    call func2
    sw .25at8, -20(s0)
    lw .29, -28(s0)
    icmp_gt .30, .29, 1
    branch .30, .LBB1_1, .LBB1_2
.LBB1_1:
    lw .32, -36(s0)
    lw .33, -32(s0)
    addw .34, .32, .33
    sw .34, -24(s0)
    j .LBB1_3
.LBB1_2:
    lw .38, -36(s0)
    lw .39, -32(s0)
    subw .40, .38, .39
    sw .40, -24(s0)
    j .LBB1_3
.LBB1_3:
    lw .43, -24(s0)
    lw a0, .43
    ld ra, 40(sp)
    ld s0, 32(sp)
    addi sp, sp, 48
    ret
Here is a br instruction
%.30 = icmp sgt i32 %.29, 1
%.29