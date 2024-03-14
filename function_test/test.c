int ifElse() {
  int a;
  a = 5;
  if (a == 5) {
    a = 25;
  }
  else if ( a != 2) {
    a = 0;
  }
  else if ( a <= 2 ){
    a = a * 2;
  }
  else if (a >= 10) {
    a = a * 3;
  }
  else if (a < 7) {
    a = a * 4;
  }
  else if ( a > 7 ) {

  }

  else {
    a = 0;
  }
  return (a);
}

// int FullRedundancy2 () {
//      int x[20],a,b;
//      a=5;
//      b=6;
//      int t=a+b;
//      x[t]=1;
//      return x[t];
// }

// int FullRedundancy2 () {
//      int x[20],a,b;
//      a=5;
//      b=6;
//      int t=a+b;
//      x[t]=1;
//      return x[t];
// }
int at(int b[])
{
    b[1] = 3;
    b[2] = 4;
    return 1;
}
int FullRedundancy2 () {
     int x[20],a,b;
     a=5;
     b=6; 
     int t=a+b;
     x[t]=1;
     at(x);
     return x[1];
}