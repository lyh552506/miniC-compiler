int func(int a,int b,int x,int d){
    while(x<10){
        int c=a+b;
        if(c>10){
          d=a+b+x;
          break;
        }
        x=x+1;
    }
    return x;
}