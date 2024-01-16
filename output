define i32 @fib(i32){
  %2 = alloca i32
  store i32 %0, i32* %2
  %3 = load i32, i32* %2
  %4 = icmp sle i32 %3, 2
  br i1 %4, label %5, label %6
5:
  ret i32 1 
6:
  %7 = load i32, i32* %2
  %8 = sub i32 %7, 1
  %9 = call i32 @fib(i32 %8)
  %10 = load i32, i32* %2
  %11 = sub i32 %10, 2
  %12 = call i32 @fib(i32 %11)
  %13 = add i32 %9, %12
  ret i32 %13 
}
define i32 @main(){
  %1 = call i32 @fib(i32 14)
  %2 = call i32 @fib(i32 3)
  %3 = mul i32 %1, %2
  ret i32 %3 
}
