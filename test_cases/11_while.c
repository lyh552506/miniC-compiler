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
int b;
int main(){
	b=0;
	a=3;
	while(a>0){	
		b = b+a;
		a = a-1;
	}
	return b;
}	
