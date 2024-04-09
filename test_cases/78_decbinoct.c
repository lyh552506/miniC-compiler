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
int dec2bin(int a)
{
    int res;
    int k;
    int i;
    int temp;
    res=0;
    k=1;
    temp=a;
    while(temp!=0)
    {
        i=temp%2;
        res=k*i+res;
        k=k*10;
        temp=temp/2;
    }
   return res;

}

int main()
{
    int a;
    a=400;
    int res;
    res=dec2bin(a);
    putint(res);
    res = 10;
    putch(res);
    return 0;
}
