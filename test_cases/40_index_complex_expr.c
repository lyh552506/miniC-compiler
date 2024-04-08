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
// Use complex expression in assign structure
int main () {
    int a;
    int b;
    int c;
    int d;
    int result[5];
    a = 5;
    b = 5;
    c = 1;
    d = -2;
    result[0] = 1;
    result[1] = 2;
    result[2] = 3;
    result[3] = 4;
    result[4] = 5;
    int t;
    t = result[((d * 1 / 2) + 4 + (a - b) - -(c + 3) % 2) % 5];
    putint(t);
    t = result[(((c % 2 + 67) + a - b) - -((c + 2) % 2)) % 5];
    putint(t);
    return 0;
}
