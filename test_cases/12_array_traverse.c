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
int a[3][4];

int main(){
    int i=0;
    int cnt=0;
    while(i<=3+4-2){
        int j=i;
        while(j>=0){
            if(j<4&&i-j<3){
                a[i-j][j]=cnt;
                cnt=1;
            }
            j=j-1;
        }
        i=i+1;
    }
    return 0;
}