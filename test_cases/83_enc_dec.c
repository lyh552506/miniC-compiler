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
int enc(int a)
{
   if(a>25)
   a=a+60;
   else
   {
       a=a-15;
   }
   
   return a;

}

int dec(int a)
{
    if (a>85)
    a=a-59;
    else
    {
        a=a+14;
    }

    return a;
    
}

int main()
{
    int a;
    a=400;
    int res;
    res=enc(a);
    res=dec(res);
    putint(res);
    res = 10;
    putch(res);
    return 0;
}
