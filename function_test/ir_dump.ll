define dso_local i32 @whileIf{
%0:
  %1 = alloca i32
  %2 = alloca i32
  store i32 0 ptr %2 
  store i32 0 ptr %1 
  br label %3 

%3:
  %4 = load ptr %2 
  %5 = i32 %4 Op_L i32 100 
  br i32 %5 label %6 label %7 

%6:
  %8 = load ptr %2 
  %9 = i32 %8 Op_E i32 5 
  br i32 %9 label %10 label %11 

%7:
  %12 = load ptr %1 
  ret i32 %12 

%10:
  store i32 25 ptr %1 
  br label %13 

%13:
  %14 = load ptr %2 
  %15 = i32 %14 Op_Add i32 1 
  store i32 %15 ptr %2 
  br label %3 

%11:
  %16 = load ptr %2 
  %17 = i32 %16 Op_Mul i32 2 
  store i32 %17 ptr %1 
  br label %13 
}

define dso_local i32 @main{
%0:
  %1 = call i32 @whileIf 
  ret i32 %1 
}