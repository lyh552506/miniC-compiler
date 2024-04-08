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
int doubleWhile() {
  int i;
  i = 5;
  int j;
  j = 7;
  while (i < 100) {
    i = i + 30;
    while(j < 100){
      j = j + 6;
    }
    j = j - 100;
  }
  return (j);
}

int main() {
  return doubleWhile();
}
