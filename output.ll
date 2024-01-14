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
  %.26 = call i32 @fib(i32 14)
  %.28 = call i32 @fib(i32 3)
  %.29 = mul i32 %.26, %.28
  ret i32 %.29 
}
