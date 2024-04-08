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
// Count how many alpha in a string
int main() {
    int string[500];
    int temp;
    int i;
    int count;
    count = 0;
    i = 0;
    temp = 0;
    while (temp != 10) {
        temp = getch();
        if (temp > 40 && temp < 91 || temp > 96 && temp < 123) {
            count = count + 1;
        }
        i = i + 1;
    }
    putint(count);
    return 0;
}
