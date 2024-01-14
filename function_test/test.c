int x;
int fib(int x){
  if(x<=2)return 1;
  else return fib(x-1)+fib(x-2);
}
int main(){
  starttime();
  x=getint();
  stoptime();
  return fib(x+14)*fib(x+3);
}