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
int fsqrt(int a)
{
    int x0=0;
    int x1;
    x1=a/2;
    while(x0-x1!=0)
    {
        x0=x1;
        x1=(x0+a/x0);
        x1=x1/2;
    }

    return x1;

}

int main()
{
    int a;
    a=400;
    int res;
    res=fsqrt(a);
    putint(res);
    res = 10;
    putch(res);
    return 0;
}
