int h =5;
int n;
int array[100] = {5};
int insertsort(int a[])
{
    int i;
    i = 1;
    while(i<n)     
    {
        int temp;
        temp=a[i]; 
        int j;
        j=i-1;
        while(j>-1&&temp<a[j])
        {
            a[j+1]=a[j];  
            j = j - 1;
        }
        array[10] = 19;
        a[j+1]=temp; 
        i = i + 1;
        h=6;
    }
    return 0;
}
int swap(int a , int b )
{
  int c  = a;
  a = b;
  b = c;
  return a; 
}
int main(){
  int w =10;
    n = 10+h;
    int a[10];
    a[0]=4;a[1]=3;a[2]=9;a[3]=2;a[4]=0;
    a[5]=1;a[6]=6;a[7]=5;a[8]=7;a[9]=8;
    int i;
    i = insertsort(array);
    swap(h, n);
    while (i < n) {
        int tmp;
        tmp = a[i];
        tmp = 10;
        i = i + 1;
    }
    h = h+1;
    return 0;
}