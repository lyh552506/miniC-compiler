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
int main()
{
    int i;
    int j;
    int k;
    int t;
    i=0;j=0;k=0;
    while(i<21)
    {
        while(j<101-i)
        {
            k=100-i-j;
            if(5*i+1*j+k/2==100)
            {
                putint(i);
                putint(j);
                putint(k);
                t=10;
                putch(t);
            }
            j=j+1;
        }
        i=i+1;
    }

    return 0;
}
