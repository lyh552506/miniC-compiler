extern void putint(int a);
extern void putch(int a);
extern void putarray(int n,int a[]);
extern void putfloat(float a);
extern void putfarray(int n, float a[]);
extern void putf(char a[], ...);
extern int getint();
extern int getch();
extern int getarray(int a[]);
extern float getfloat();
extern int getfarray(float a[]);
int ifWhile() {
  int a;
  a = 0;
  int b;
  b = 3;
  if (a == 5) {
    while(b == 2){
      b = b + 2;
    }
    b = b + 25;
  }
  else 
    while (a < 5) {
      b = b * 2;
      a = a + 1;
    }
  return (b);
}


int main(){
  return (ifWhile());
}
