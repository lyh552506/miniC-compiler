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
int FourWhile() {
  int a;
  a = 5;
  int b;
  int c;
  b = 6;
  c = 7;
  int d;
  d = 10;
  while (a < 20) {
    a = a + 3;
    while(b < 10){
      b = b + 1;
      while(c == 7){
        c = c - 1;
        while(d < 20){
          d = d + 3;
        }
        d = d - 1;
      }
      c = c + 1;
    }
    b = b - 2;
  }
  
  return (a + (b + d) + c);
}

int main() {
  return FourWhile();
}
