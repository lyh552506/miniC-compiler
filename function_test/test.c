int func2(int x){
  return x+2;
}

int func(int b,int c,int x) {
    int a;
    a=1;
    int z=func2(2);
    if(x>1){
      a=b+c;
    }else{
      a=b-c;  
    }
    return a;
}