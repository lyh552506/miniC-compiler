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
    int a[10];
    sum=0;
    //m = 1478;
    //int t;
    i=0;
    while(i<10)
    {
        a[i]=i+1;
        i=i+1;
    }
    int x;
    int high;
    int low;
    int mid;
    int n;
    n=10;
    x=getint();
    high=n-1;
    low=0;
    mid=(high+low)/2;
    while(a[mid]!=x && low < high)
    {
        mid=(high+low)/2;
        if(x<a[mid])
            high=mid-1;
            else
            {
                low = mid +1;
            }
       
    }

     if(x==a[mid])
        putint(x);
        else
        {
            x = 0;
            putint(x);
        }
    
    x = 10;
    putch(x);

    return 0;
}