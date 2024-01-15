int fib(int x){
  if(x<=2)return 1;
  else return fib(x-1)+fib(x-2);
}
int main(){
  int a;
  int b;
  return fib(14)*fib(3);
}