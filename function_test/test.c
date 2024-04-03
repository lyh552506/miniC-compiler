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
// }
// int func2(){
//   int x=1,c;
//   float y=3.6;
//   c=(x<y);
//   return c;
// }

// int func(int b,int c,int x) {
//     int a,m[2];
//     if(x>1){
//         b=a+c;
//         m[1]=9;
//         c=m[1];
//     }
//     else{
//         b=3;
//     }
//     return b;
// }
// // int func(int b,int c) {
// //     int a,x=5;
// //     a=b+c;
// //     while(x<10){
// //         x=1+x;
// //         a=c+x;
// //         if(x>7)
// //           while(x<9)
// //             b=b+1;
// //         else if(x<4)
// //           a=3;
// //     };
// //     return a;
// // }
// // int func(int dst[],int src[]){
// //   int i=0,j=0;
// //   while(i<5){
// //     while(j<5){
// //       dst[j]=dst[i]+src[i];
// //       j=j+1;
// //       i=i+1;
// //     }
// //   }
// //   return 1;}
// // }
// int func(int i,int j,int b){
//   int a=0;
//   while(i<5){
//     while(j<5){
//       a=b+1;
//     }
//   }
//   return a;
// }
// int func(int b){
//   int a=3;
//   while(a<5){
//     if(a>0)
//       break;
//   }
// }
int func(int a){
    int x;
    if(x>1)
      a=x;
    return a;
}
// void reverse(int n) {
//     int next;
//     if (n <= 1) {
//         next=getint();
//         putint(next);
//     }
//     else {
//         next=getint();
//         reverse(n-1);
//         putint(next);
//     }
// }

// int main() {
//     int i=200;
//     reverse(i);
//     return 0;
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
// int main(int a,int b,int c,int d){
// //     if(a>10){
// //      c=a+b;
// //     }else{
// //      d=5;
// //     }
// //     c=a+b;
// //     return c;
//        while(a<10){
//           c=d+b;
//           a=a+1;
//        }
//        return c;
//     c=a+b;
//     if(a>10){
//      d=a;
//     }
//     c=a+b;
//     return c;
  
// }

// int func(int dst[],int src[]){
//   int i=0,j=0;
//   while(i<5){
//     while(j<5){
//       dst[j]=dst[i]+src[i];
//       j=j+1;
//       i=i+1;
//     }
//   }
//   return 1;
// }
int func(int dst[],int src[]){
  int i=0,j=0;
  while(i<5){
    while(j<5){
      dst[j]=dst[i]+src[i];
      j=j+1;
      i=i+1;
    }
  }
  return 1;
}
// int func(int a, int b)
// {
//   int c;
//   int d;
//   a =100;
//   b = 50;
//   if(c > 10)
//     d = a+b;
//   else
//   {
//     c = a;
//     d=c+b;
//   }

//   // d = 100;
//   return d;
// }