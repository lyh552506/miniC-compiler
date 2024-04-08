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
int fact(int n) {
  if (n == 0) {
    return 1;
  }
  int nn;
  nn = n-1;
  return (n * fact(nn));
}

int main() {
  int n;
  n = 4;
  return fact(n);
}
