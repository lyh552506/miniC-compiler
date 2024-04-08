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
// Check the priority between time and plus
int main() {
    int a;
    a = 20;
    int b;
    b = 5;
    int c;
    c = 6;
    int d;
    d = -4;
    a = a + c * d - b % (a + d) / a;
    putint(a);
    return 0;
}
