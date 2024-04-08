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
// test if-if-else
int ififElse() {
  int a;
  a = 5;
  int b;
  b = 10;
  if(a == 5)
    if (b == 10) 
      a = 25;
    else 
      a = a + 15;
    
  return (a);
}

int main(){
  return (ififElse());
}
