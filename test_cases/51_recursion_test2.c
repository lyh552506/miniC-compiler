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
int fib(int n) {
	if (n == 0)
		return 0;
	if (n == 1)
		return 1;
	int p;
	p = n - 1;
	int q;
	q = n - 2;
	return fib(p) + fib(q);
}

int main() {
	int tmp;
	tmp = 10;
	return fib(tmp);
}