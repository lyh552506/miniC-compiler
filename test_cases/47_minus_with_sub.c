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
// Use minus with sub in one expr
int main () {
    int a;
    int b;
    a = -2;
    b = 1;
    a = a - -b + -(a + b) % -(a - b);
    putint(a);
    return 0;
}
