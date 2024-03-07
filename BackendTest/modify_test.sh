# for each testcases add or del the syslib functions;
option=$1
if [ $1 = "-add" ]; then
    for file in ../test_cases/*.c
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

    done
elif [ $1 = "-del" ]; then
    for file in ../test_cases/*.c
    do
            sed -i '1,11d' "$file"
    done
else 
    echo "Invalid option"
fi