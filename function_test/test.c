int test (int a, int b) {
    a = a + b;
    return a;
}

int main() {
    int a = 1;
    int b = 2;
    a = test(a, b);
    return a;
}
