; ModuleID = 'output.ll'
source_filename = "output.ll"

define i32 @fib(i32 %a_0x5555555e2970) {
a_0x5555555e2180:
  %a_0x5555555e2570 = alloca i32, align 4
  store i32 %a_0x5555555e2970, i32* %a_0x5555555e2570, align 4
  %a_0x5555555e2af0 = load i32, i32* %a_0x5555555e2570, align 4
  %a_0x5555555e2bb0 = icmp sle i32 %a_0x5555555e2af0, 2
  br i1 %a_0x5555555e2bb0, label %a_0x5555555e2c90, label %a_0x5555555e2da0

a_0x5555555e2c90:                                 ; preds = %a_0x5555555e2180
  ret i32 1

a_0x5555555e2da0:                                 ; preds = %a_0x5555555e2180
  %a_0x5555555e2e20 = load i32, i32* %a_0x5555555e2570, align 4
  %a_0x5555555e2ee0 = sub i32 %a_0x5555555e2e20, 1
  %a_0x5555555e3000 = call i32 @fib(i32 %a_0x5555555e2ee0)
  %a_0x5555555e3100 = load i32, i32* %a_0x5555555e2570, align 4
  %a_0x5555555e31c0 = sub i32 %a_0x5555555e3100, 2
  %a_0x5555555e32a0 = call i32 @fib(i32 %a_0x5555555e31c0)
  %a_0x5555555e33a0 = add i32 %a_0x5555555e3000, %a_0x5555555e32a0
  ret i32 %a_0x5555555e33a0
}

define i32 @main() {
a_0x5555555e36a0:
  %a_0x5555555e3a30 = call i32 @fib(i32 14)
  %a_0x5555555e3b60 = call i32 @fib(i32 3)
  %a_0x5555555e3c40 = mul i32 %a_0x5555555e3a30, %a_0x5555555e3b60
  ret i32 %a_0x5555555e3c40
}
