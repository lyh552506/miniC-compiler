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
int a=5;
int s[10]={9,8,7,6,5,4,3,2,1};

int main(){
    int i=0;
    while(s[i]>=a){
        i=i+1;
    }
    return i;
}