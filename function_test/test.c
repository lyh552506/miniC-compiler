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
// int main() {
//     int a;
//     float b ;
//     float c=0.6;
//     a=b+c;
//     return a;
// }
// int main() {
//     int x, cond = 1;
//     float b;
//     if (cond > 0)
//         x = 1/-1;
//     else
//         x = -1/1;
//     return b;
// }
// int main() {
//     int x, cond = 1;
//     float b;
//     if (cond > 0)
//     {
//         int c = 1;
//         int d = -1;
//         x = c / b ;
//     }

//     else
//     {
//         int e = -1;
//         int f = 1;
//         x = e / f;
//     }
//     return x;
// }
// int func2(int k)
// {
//     k=1000 ;
//     int y = 3;
//     return y;
// }
// int func(int m)
// {   
//     m =2;
//     int u = func2(m);
//     return u;
// }
// int main() {
//     int x, cond = 1;
//     float b;
//     if (cond > 0)
//     {
//         int c = 1;
//         int d = -1;
//         x = c / b ;
//     }

//     else
//     {
//         int e = -1;
//         int f = 1;
//         x = e / f;
//     }
//     x = 1;
//     x = func(x);
//     return x;
// }
// int main() {
//     int x, cond = 1;
//     if (cond > 0)
//         x = 1;
//     else
//         x = -1;
//     return x;
// }
// int main() {
//     int x, cond = 1;
//     float b;
//     if (cond > 0)
//         x = 1/b;
//     else
//         x = -1/0;
//     return b;
// }
// int main() {
//     int x, cond = 1,b;
//     if (cond > 0)
//         x = 1/b;
//     else
//         x = -1/0;
//     return b;
// }
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
//     b[2] = 4;
//     return 1;
// }
// int FullRedundancy2 () {
//      int x[20],a,b;
//      a=5;
//      b=6; 
//      int t=a+b;
//      x[t]=1;
//      at(x);
//      return x[1];
// }