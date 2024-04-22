int a=343;
float b=141.2;
int arr_int_undef[3][2][2];
float arr_float_undef[4][2]={{1.2, 3.4}, {2.0, 3.3}};
int function(int a, int b) {
  int c = a+b;
  return c;
}
int main() {
  // int arr_inner[10][10000];
  // arr_inner[0][1]=0;
  // arr_int_undef[0][0][2] = 1;
  // float a=3.1;
  // float b=3.1;
  // float c=a+b;
  // arr_float_undef[0][1] = c;
  // int d =  3;
  // int func = function(a, b);
  // return 0;
  int a=3;
  while (a>0) {
    a = a-1;
  }
  if (a>0) {
    a = a-1;
  }
  else {
    a = a+1;
  }
  return 0;
}