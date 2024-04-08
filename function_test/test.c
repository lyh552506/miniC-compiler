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
// int func(int a){
//     int x;
//     if(x>1)
//       a=x;
//     return a;
// }
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
// int main () {
//      int x[20],a,b;
//      a=5;
//      b=6;
//      int t=a+b;
//      x[t]=1;
//      at(x);
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
//      x[2] = 10;
//      at(x);
//      return x[10];
// }
// int test[5] = {1,3,4,5,6};
// void func(int a, int g) {
//     int x, cond = 1;
//     float b;
//     if (cond > 0)
//     {
//         int c = 1;
//         test[3] = 1;
//         int d = -1;
//         x = c / d ;
//     }
//     else
//     {
//         int e = -1;
//         int f = 1;
//         x = e / f+a*g;
//     }

// }

// int main() {
//      int x[20],a,b;
//      a=5;
//      b=6;
//      int t=a+b;
//      x[t]=1;
//      x[2] = 10;
//      test[2] = 0;
//      func(a,b);
//      return x[10];
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
int func(int i, int j) {
    return ((i+j) * (i+j+1) / 2 + i + 1);
}

float Vectordot(float v[], float u[], int n) {
    int i = 0;
    float sum = 0;
    while (i < n) {
        sum =sum+ v[i] * u[i];
        i=i+1;
    }
    return sum;
}

void mult1(float v[], float out[],int n) {
    int i = 0, j = 0;
    float sum = 0;

    while (i < n) {
        while (j < n) {
            sum =sum+ v[j] / func(i,j);
            j=j+1;
        }
        out[i] = sum;
        i=i+1;
     }
}

void mult2(float v[], float out[], int n) {
    int i = 0, j = 0;
    float sum = 0;

    while (i < n) {
        while (j < n) {
            sum =sum+ v[j] / func(j,i);
            j=j+1;
        }
        out[i] = sum;
        i=i+1;
     }
}


void mult_combin(float v[], float out[], int n, float tmp[]) {
    mult1(v, tmp, n);
    mult2(tmp, out, n);
}

float temp = 1;
float my_sqrt(float input) {
    while (temp - input / temp > 1e-6 || temp - input / temp < -1e-6){
        temp = (temp+input/temp)/2;
    }
    return temp;
}

int main() {
    int n = 100000;
    if (n <= 0) {
     n = 2000;
}
    float vectorA[100000], vectorB[100000], Vectortmp[100000];

    int i;
    while(i < n) {
        vectorA[i] = 1;
        i=i+1;
    }
    i = 0;
    while(i < 1000) {
        mult_combin(vectorA, vectorB, n, Vectortmp);
        mult_combin(vectorB, vectorA, n, Vectortmp);
        i=i+1;

    float result = my_sqrt(Vectordot(vectorA,vectorB, n) / Vectordot(vectorB,vectorB,n));
    return 0;
}}