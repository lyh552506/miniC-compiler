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


int main() {
  return (ifElse());
}
