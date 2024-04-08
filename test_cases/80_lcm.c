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

int gcd(int m,int n)
{ 
    int a;
    int b;
    a=m;
    b=n;

    int t;
    int r;

    if(m<n) { t=m;m=n;n=t; }

    r=m%n;

    while(r!=0)

    {m=n;   n=r;   r=m%n;  }

   return (a*b)/n;
}

int main()
{
    //newline=10;
    int i;
    int m;
    //m = 1478;
    //int t;
    i=getint();
    m=getint();
    
    return gcd(i,m);
}