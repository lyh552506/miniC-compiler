file=$1
option=$2
base=$(basename $file)
base=${base%.*}
input_dir="../test_cases"
output_dir="../test_cases_output"
lib_dir="../RISCVLib/sylib.o"
#SYSY-compiler = "../build/SYSY-compiler"
if [ "$option" == "-run" ]; then    
    echo "running: $file"
    #./SYSY-compiler $output_dir/$file
elif [ "$option" == "-test" ]; then
    riscv64-unknown-elf-gcc -S -o $output_dir/$base.s $input_dir/$file
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
    echo "Invalid option"
fi