// int main() {
//     int a, b;
//     a = 070;
//     b = 0x4;
//     a = a - - 4 + + b;
//     if (+-!!!a) {
//         a = - - -1;
//     }
//     else {
//         a = 0 + + b;
//     }
//     putint(a);
//     return 0;
// }
// int main(float b) {
//     int a;
//     float c=0.6;
//     a=b+c;
//     return a;
// }
// int main() {
//     int x, cond = 1;
//     if (cond > 0)
//         x = 1;
//     else
//         x = -1;
//     return x;

// int func2(int x){
//   return x+2;
// }

// int func(int b,int c,int x) {
//     int a;
//     a=1;
//     int z=func2(2);
//     int y=func2(2);
//     a=b+y;
//     c=b+z;
//     return a;
// }


// int FullRedundancy2 () {
//      int v1,a=3,b=5;
//      if (a >= 0) {
//           v1 = a + b; // BB1
//      } else {
//           a = -a; // BB2
//           v1 = a + b;
//      }
     
//      int v2 = a + b; // BB3
//      return v1 + v2;
// }

int FullRedundancy2 () {
     int x[20],a,b;
     a=5;
     b=6;
     int t=a+b;
     x[t]=1;
     return x[t];
}

// int FullRedundancy2 () {
//      int x[20],a,b;
//      a=5;
//      b=6;
//      int t=a+b;
//      x[t]=1;
//      return x[t];
// }
// int at(int b[])
// {
//     b[1] = 3;
//     return 1;
// }
// int FullRedundancy2 () {
//      int x[20],a,b;
//      a=5;
//      b=6; 
//      int t=a+b;
//      x[t]=1;
//      at(x);
//      return x[t];
// }