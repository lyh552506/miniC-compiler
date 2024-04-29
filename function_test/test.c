int def_a=1;
float def_b=3.11;
int undef_a;
float undef_b;
int def_arr[3][2][2]={1,3};
float def_arrf[2][2][3][3] = {3.222};
int main() {
    if(def_a < def_b) {
        def_a=def_a+3;
    }
    else {
        def_arr[2][1][1]=5;
        def_arrf[1][1][1][1]=3.333;
    }
    return 0;
}