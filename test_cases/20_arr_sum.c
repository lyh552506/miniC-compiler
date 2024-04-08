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
int a[5];
int main(){
	a[0] = getint();
	a[1] = getint();
	a[2] = getint();
	a[3] = getint();
	a[4] = getint();
	int cnt;
	cnt = 4;
	int sum;
	sum = 0;
	while( cnt > 1 ){
		sum = sum + a[cnt];
		cnt = cnt - 1;
	}
	return sum;
}
