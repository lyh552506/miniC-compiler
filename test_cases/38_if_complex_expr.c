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
// Use complex expression in if structure
int main () {
    int a;
    int b;
    int c;
    int d;
    int result;
    a = 5;
    b = 5;
    c = 1;
    d = -2;
    result = 2;
    if ((d * 1 / 2) < 0 || (a - b) != 0 && (c + 3) % 2 != 0) {
        putint(result);
    }
    if ((d % 2 + 67) < 0 || (a - b) != 0 && (c + 2) % 2 != 0) {
        result = 4;
        putint(result);
    }
    return 0;
}
