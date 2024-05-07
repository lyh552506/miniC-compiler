
int a;
int main(int x){
  
  return a;
}
// int def_a=1;
// float def_b=3.11;
// int undef_a;
// float undef_b;
// int def_arr[3][2][2]={1,3};
float def_arrf[2][2][3][3] = {3.222};
// int func1(int a, int b, int c, int d, int e, int f, int g, int h, int i) {
//     return a+b;
// }
// int func2(int a, int b, int c, int d, int e, int f, int g, int h, int i, int j, int k, int l) {
//     return a+b;
// }
//20
// float func3(float a, float b, float c, float d, float e, \
// float f, float g, float h, float i, float j, float k, \
// float l,float m, float n, float o, float p, float q, \
// float r, float s, float t) {
    // return s+t;
//     return a+b;
// }
int main() {
    // if(def_a > def_b) {
    //     def_a=def_a+3;
    // }
    // else {
    //     def_arr[2][1][1]=5;
    //     def_arrf[1][1][1][1]=3.333;
    // }
    // func1(0,1,2,3,4,5,6,7,8);
    // func2(0,1,2,3,4,5,6,7,8,9,10,11);
    // func3(0.1,1.2,2.3,3.4,4.5,5.6,6.7,7.8,8.9,9.0,10.1,\
    // 11.2,12.3,13.4,14.5,15.6,16.7,17.8,18.9,19.0);
    // float a=6;
    float d=3.22;
    def_arrf[1][1][1][1]=d;
    // int c;
    // if (a<d) {
    //     c=a;

    // }
    // else {
    //     c=a;
    // }
    // if(a<=d) {
    //     c=a;

    // }
    // if(a==d) {
    //     c=a;

    // }
    // if (a!=d) {
    //     // printf("a!=d\n");
    //     c=a;
    // }
    // if(a>d) {
    //     // printf("a>d\n");
    //     c=a;
    // }
    // if (a>=d) {
    //     // printf("a>=d\n");
    //     c=a;
    // }

    return 0;
}
=======
// reference: https://zhuanlan.zhihu.com/p/30748318

const int W = 192, H = 192, N = 24;

const float PI = 3.14159265359, TWO_PI = 6.28318530718;
const int MAX_STEP = 10;
const float MAX_DISTANCE = 2.0;
const float EPSILON = 1e-6;

const int RAND_MAX = 100000007 - 1;
int seed = 0;

int rand() {
  seed = (seed * 19980130 + 23333) % 100000007;
  if (seed < 0) seed = seed + 100000007;
  return seed;
}

float my_fabs(float x) {
  if (x > 0) return x;
  return -x;
}

float my_sqrt(float x) {
  float t = x / 8 + 0.5 + 2 * x / (4 + x);
  int c = 10;
  while (c) {
    t = (t + x / t) / 2;
    c = c - 1;
  }
  return t;
}

float p(float x) { return 3 * x - 4 * x * x * x; }

float my_sin_impl(float x) {
  if (my_fabs(x) <= EPSILON) return x;
  return p(my_sin_impl(x / 3.0));
}

float my_sin(float x) {
  if (x > TWO_PI || x < -TWO_PI) {
    int xx = x / TWO_PI;
    x = x - xx * TWO_PI;
  }
  if (x > PI) x = x - TWO_PI;
  if (x < -PI) x = x + TWO_PI;
  return my_sin_impl(x);
}

float my_cos(float x) { return my_sin(x + PI / 2); }

float circle_sdf(float x, float y, float cx, float cy, float r) {
  float ux = x - cx, uy = y - cy;
  return my_sqrt(ux * ux + uy * uy) - r;
}

void scene(float x, float y, float ret[]) {
  float sd0 = circle_sdf(x, y, 0.4, 0.4, 0.10),
        sd1 = circle_sdf(x, y, 0.6, 0.6, 0.05);
  if (sd0 < sd1) {
    ret[0] = sd0;
    ret[1] = 3.0;
  } else {
    ret[0] = sd1;
    ret[1] = 0.0;
  }
}

float trace(float ox, float oy, float dx, float dy) {
  float t = 0.0;
  int i = 0;
  while (i < MAX_STEP && t < MAX_DISTANCE) {
    float ret[2];
    scene(ox + dx * t, oy + dy * t, ret);
    if (ret[0] < EPSILON) return ret[1];
    t = t + ret[0];
    i = i + 1;
  }
  return 0.0;
}

float sample(float x, float y) {
  float sum = 0.0;
  int i = 0;
  while (i < N) {
    float rnd = rand();
    float a = TWO_PI * (i + rnd / RAND_MAX) / N;
    sum = sum + trace(x, y, my_cos(a), my_sin(a));
    i = i + 1;
  }
  return sum / N;
}

void write_pgm() {
  putch(80); putch(50); putch(10); // P2
  putint(W); putch(32); putint(H); putch(32); putint(255); putch(10); // W H 255
  int y = 0;
  while (y < H) {
    int x = 0;
    while (x < W) {
      float xx = x, yy = y;
      int p = sample(xx / W, yy / H) * 255.0;
      if (p > 255) p = 255;
      putint(p);
      putch(32);
      x = x + 1;
    }
    putch(10);
    y = y + 1;
  }
}

int main() {
  write_pgm();
  return 0;
}

