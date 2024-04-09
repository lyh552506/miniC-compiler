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

int myFunc(int a, int b, int c) {
	a = 2;
	{
		int c;
		c = 0;
		if (c != 0) {
			return 0;
		}
	}
	while (b > 0) {
		b = b - 1;
	}
	return (a)+(b);
}

int main() {
	a = (3);
	int b;
	b = myFunc(1, 2, 1);
	return ((a+b));
}