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
// Add is prior than equal and not equal
int main () {
    int a;
    int b;
    int c;
    a = 1;
    b = 4;
    c = 28;
    int t;
    if (c + a != b) {
        t = c % -b;
        putint(t);
    }
    if (b - c == a) {
        t = c%b+b;
        putint(t);
    }
    return 0;
}
