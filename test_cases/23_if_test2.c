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
// test if-else else-if
int ifElseElseIf() {
  int a;
  a = 66;
  int b;
  b = 8923;
  if (a == 5) {
    b = 25;
  }
  else if (a == 10) {
    b = 42;  
  }
  else {
    b = a * 2;
  }
  return (b);
}

int main() {
  return (ifElseElseIf());
}
