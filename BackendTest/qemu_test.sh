
/home/nanqin/compiler/SB-compiler/build/SYSY-compiler /home/nanqin/compiler/SB-compiler/function_test/test.c --mem2reg
riscv64-unknown-elf-as -o test.o test.s
riscv64-unknown-elf-gcc -o test test.o sylib.o -lm

qemu-riscv64 test