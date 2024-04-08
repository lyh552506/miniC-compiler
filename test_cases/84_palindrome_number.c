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
int palindrome(int n)
{
    int a[4];
    int j;
    int flag;
    j=0;
    while(j<4)
    {
        a[j]=n%10;
        n=n/10;
        j=j+1;
    }

    if(a[0]==a[3] && a[1]==a[2])
	{
		flag=1;
	}else{
		flag=0;
	}
	return flag;
}

int main()
{
    int test;
    test=1221;
    int flag;
    flag=palindrome(test);
    if(flag==1)
        putint(test);
    else
    {
        flag = 0;
        putint(flag);
    }

    flag = 10;
    putch(flag);

    return 0;
    
}
