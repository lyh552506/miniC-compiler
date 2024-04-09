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
int a,b,c;

void add(int a,int b){
    c=a+b;
    return;
}

int main(){
    a=3;
    b=2;
    add(a,b);
    return c;
}