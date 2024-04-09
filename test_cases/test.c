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
extern void putint(int a);
extern void putch(int a);
extern void putarray(int n,int a[]);
extern void putfloat(float a);
extern void putfarray(int n, float a[]);
extern void putf(char a[], ...);
extern void putint(int x);

int whileIf(){
int i = 100;
  int a;
  a = i;
  int b;
  b = 0;
  while (a == 100) {
    if (a == 5) {
      b = 25;
    }
    else {
      b = a * 124;
    }
    a = a + 1;
  }
  return (b);
}

int main(){
  putint(whileIf());
  return (whileIf());
}
