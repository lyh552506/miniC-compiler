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
int N;

int newline;

int factor(int n )
{
    int i;
    int sum;
    sum=0;
    i=1;
    while(i<n+1)
    {
        if(n%i == 0)
        {
            sum=sum+i;
        }
        i=i+1;
    }

    return sum;
}

int main()
{
    N=4;
    newline=10;
    int i;
    int m;
    m = 1478;
    int t;
    
    return factor(m);
}