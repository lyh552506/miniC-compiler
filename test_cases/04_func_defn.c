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
int a;
int func(int p){
	p = p - 1;
	return p;
}
int main(){
	int b;
	a = 10;
	b = func(a);
	return b;
}
