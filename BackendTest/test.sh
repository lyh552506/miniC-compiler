option=$1
input_dir="../testcases_c"
output_dir="../testcases_output"
lib_dir="../RISCVLib/sylib.o"

if [ "$option" == "-run" ]; then    
    echo "running: $file"
    #./SYSY-compiler $output_dir/$file

elif [ "$option" == "-testall" ]; then
    for file in $input_dir/*.c; do
        base=$(basename $file)
        base=${base%.*}
        riscv64-unknown-elf-gcc -S -o $output_dir/$base.s $input_dir/$file
        echo $base.s
    done

elif [ "$option" == "-test" ]; then 
    file="../function_test/test.c"
    base=$(basename $file)
    base=${base%.*}
    riscv64-unknown-elf-gcc -S -o $output_dir/$base.s $input_dir/$file -O0
    riscv64-unknown-elf-as -o $output_dir/$base.o $output_dir/$base.s 
    riscv64-unknown-elf-gcc -o $output_dir/$base $output_dir/$base.o $lib_dir
    echo "running: $file"
    qemu-riscv64 $output_dir/$base
    echo
    echo "----------------$base.s-------------------"
    cat $output_dir/$base.s
    echo "------------------------------------------"
    echo "Test finished"
else 
    echo "No used!"
fi