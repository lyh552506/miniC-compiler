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
int deepWhileBr(int a, int b) {
  int c;
  c = a + b;
  while (c < 75) {
    int d;
    d = 42;
    if (c < 100) {
      c = c + d;
      if (c > 99) {
        int e;
        e = d * 2;
        if (1 == 1) {
          c = e * 2;
        }
      }
    }
  }
  return (c);
}

int main() {
  int p;
  p = 2;
  return deepWhileBr(p, p);
}
