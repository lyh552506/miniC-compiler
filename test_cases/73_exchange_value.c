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

int main()
{
    //newline=10;
    int i;
    int j;
    //m = 1478;
    //int t;
    i=getint();
    j=getint();
    int temp;
    temp=i;
    i=j;
    j=temp;

    putint(i);
    temp = 10;
    putch(temp);
    putint(j);
    temp = 10;
    putch(temp);
    
    return 0;
}
