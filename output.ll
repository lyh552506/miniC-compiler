define i32 @fib(i32 %.3){
.1:
  %x_0 = alloca i32
  store i32 %.3, i32* %x_0
  %.5 = load i32, i32* %x_0
  %.7 = icmp sle i32 %.5, 2
  br i1 %.7, label %.8, label %.11
.8:
  ret i32 1 
.11:
  %.12 = load i32, i32* %x_0
  %.14 = sub i32 %.12, 1
  %.15 = call i32 @fib(i32 %.14)
  %.16 = load i32, i32* %x_0
  %.18 = sub i32 %.16, 2
  %.19 = call i32 @fib(i32 %.18)
  %.20 = add i32 %.15, %.19
  ret i32 %.20 
}
define i32 @main(){
.24:
  %b_0 = alloca i32
  %a_0 = alloca i32
  %.28 = call i32 @fib(i32 14)
  %.30 = call i32 @fib(i32 3)
  %.31 = mul i32 %.28, %.30
  ret i32 %.31 
}
fib:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32
    sw a0, -20(s0)
InstSelect Error
InstSelect Error
error: no such machineinst!
InstSelect Error
.LBB0_1:
InstSelect Error
.LBB0_2:
InstSelect Error
error: no such machineinst!
InstSelect Error
InstSelect Error
error: no such machineinst!
InstSelect Error
InstSelect Error
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret
main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32
    sw a0, -20(s0)
    sw a1, -24(s0)
InstSelect Error
InstSelect Error
error: no such machineinst!
InstSelect Error
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret
Output redirected to file.
