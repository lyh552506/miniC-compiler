int add (int a,int b) {
    return a + b;
}
int main() {
    int a,b;
    a = 1;
    b = 2;
    if ( a == 0) {
        a = add(a, b);
    }
    return a;
}