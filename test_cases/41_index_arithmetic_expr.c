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
// Use arithmetic expression as array's index
int main() {
    int a;
    int b;
    int result[3];
    a = 56;
    b = 12;
    result[0] = 1;
    result[1] = 2;
    result[2] = 3;
    int t;
    t = result[(a % b + b) / 5 - 2];
    putint(t);
    return 0;
}
