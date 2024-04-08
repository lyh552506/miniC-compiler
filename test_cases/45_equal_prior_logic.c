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
// Equal is prior to logic operator
int main () {
    int a;
    int b;
    int c;
    int d;
    a = 10;
    b = 6;
    c = 4;
    d = 5;
    int t;
    if (b + c == a && d != a / 2) {
        t = b + c / d * 2;
        putint(t);
    }
    if (c < 0 || a - c == b && a != d * 2) {
        t = 1;
        putint(t);
    }
    return 0;
}
