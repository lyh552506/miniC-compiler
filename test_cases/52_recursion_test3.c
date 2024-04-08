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
// factorial number
int a;
int r;
int fac(int x)
{
  if (x <2) 
  	return 1;
  a = x - 1;
  r = fac(a);
  r = x * r;
  return r;
}

int main(){
	int a;
	a = 5;
	return fac(a);
}