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
    int result;
    a = 5;
    b = 5;
    c = 1;
    d = -2;
    result = (d * 1 / 2)  + (a - b) - -(c + 3) % 2;
    putint(result);
    result = ((d % 2 + 67) + -(a - b) - -((c + 2) % 2));
    result = result + 3;
    putint(result);
    return 0;
}