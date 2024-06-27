int func(int a, float b, int c, float d,
        int e, float f, int g, float h,
        int i, float j, int k, float l,
        int m, float n, int o, float p,
        int q, float r, int s, float t,
        int u, float v, int w, float x) {
    a = 1;
    b = 2;
    c = 3;
    d = 4;
    e = 5;
    f = 6;
    g = 7;
    h = 8;
    i = 9;
    j = 10;
    k = 11;
    l = 12;
    m = 13;
    n = 14;
    o = 15;
    p = 16;
    q = r + s + t + u + v + w + x;
    return q;
}

int main () {
    return func(1, 2.123456, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24);
}