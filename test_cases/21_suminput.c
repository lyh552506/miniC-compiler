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
//sample:input n numbers,then print the sum of them;
int n;
int a[10];
int main()
{
	n = getint();
	if (n > 10) 
		return 1;
	int s;
	int i;
	i = 0;
	s = i;
	while (i < n) { 
	  a[i] = getint();
	  s = s + a[i]; 
	  i=i+1;
	} 
	putint(s);
	int newline;
	newline = 10;
	putch(newline);
	return s;
}
