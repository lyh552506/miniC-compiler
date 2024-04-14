float a=10.342432;
int b=1;
float c;
int d;
int arri[2][2][3] = {1, 3 ,4};
float arrf[3][3][3] = {1.2};
int arri_un[19];
float arrf_un[4][3];
int main () {
    int arr_in_def[10000] = {1, 2};
    int i=0;
    while(i<10000) {
        arr_in_def[i] = i;
        i = i+1;
    }
    arr_in_def[9999] = 9999;
    a = a+2.0;
    b = b+1;
    c = 1.0;
    d = arr_in_def[13];
    arri[0][1][0] = 0;
    arrf[0][1][0] = 0.0;
    arri_un[1] = 0;
    arrf_un[1][0] = 0.0;
    return 0;
}

