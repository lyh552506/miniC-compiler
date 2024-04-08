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
    //newline=10;
    int i;
    int sum;
    sum=0;
    //m = 1478;
    //int t;
    i=0;
    while(i<21)
    {
        sum=sum*i;
        i=i+1;
    }
    
    putint(sum);

    return 0;
}
