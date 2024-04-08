# for each testcases add or del the syslib functions;
option=$1
if [ $1 = "-add" ]; then
    for file in ../testcases_c/*.c
    do 
        sed -i '1i extern void putint(int a);' "$file"
        sed -i '2i extern void putch(int a);' "$file"
        sed -i '3i extern void putarray(int n,int a[]);' "$file"
        sed -i '4i extern void putfloat(float a);' "$file"
        sed -i '5i extern void putfarray(int n, float a[]);' "$file"
        sed -i '6i extern void putf(char a[], ...);' "$file"
        sed -i '7i extern int getint();' "$file"
        sed -i '8i extern int getch();' "$file"
        sed -i '9i extern int getarray(int a[]);' "$file"
        sed -i '10i extern float getfloat();' "$file"
        sed -i '11i extern int getfarray(float a[]);' "$file"
        sed -i '12i #define starttime() _sysy_starttime(__LINE__);' "$file"
        sed -i '13i #define stoptime()  _sysy_stoptime(__LINE__);' "$file"
        sed -i '14i #define _SYSY_N 1024' "$file"
        sed -i '15i extern void before_main();' "$file"
        sed -i '16i extern void after_main();' "$file"
        sed -i '17i extern void _sysy_starttime(int lineno);' "$file"
        sed -i '18i extern void _sysy_stoptime(int lineno);' "$file"
    done
elif [ $1 = "-del" ]; then
    for file in ../testcases_c/*.c
    do
            sed -i '1,18d' "$file"
    done

elif [ $1 = "-rename" ]; then
    for file in ../testcases_c/*.sy
    do
        base=$(basename $file)
        base=${base%.*}
        mv $file ../testcases_c/$base.c
    done

else 
    echo "Invalid option"
fi