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
int n;
int fib(int p){
	int a;
	int b;
	int c;
	a = 0;
	b = 1;
	if ( p == 0 ){
		return 0;
	}
	if ( p == 1 ){
		return 1;
	}
	while ( p > 1 ){
		c = a + b;
		a = b;
		b = c;
		p = p - 1;
	}
	return c;
}
int main(){
	n = getint();
	int res;
	res = fib( n );
	return res;
}
