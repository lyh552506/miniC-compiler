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
// And is prior to or
int main () {
    int a;
    int b;
    int c;
    int d;
    a = 3;
    b = 8;
    c = -4;
    d = 15;
    int t;
    if (d % (b - a) != 0 && a > 0 || d % 3 == 0 && c > 0) {
        t = d + c - -b;
        putint(t);
    }
    return 0;
}
