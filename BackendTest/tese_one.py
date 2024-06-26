import os
import sys
import subprocess

compiler_path = "build/SYSY-compiler"
test_path = "BackendTest/test.sy"
sylib_path = "BackendTest/sylib.o"
pass_args=[] # "--mem2reg","--constprop","--reassociate","--simplifycfg"



# # gcc test
# # riscv64-unknown-elf-gcc -S 
# os.rename(test_path,test_path.replace(".sy", ".c"))
# compile_args=["riscv64-unknown-elf-gcc", "-S", "-o", test_path.replace(".sy", ".gcc.s"), test_path.replace(".sy", ".c")]
# ret = subprocess.run(compile_args)
# os.rename(test_path.replace(".sy", ".c"),test_path)


# compiler test
compile_args=[compiler_path, test_path]
for arg in pass_args:
            compile_args.append(arg)
try:
    ret = subprocess.run(compile_args,timeout=10)
except subprocess.TimeoutExpired:
    print("TimeOut!")
if ret.returncode != 0:
    print("Compiler Error:"+test_path)
    sys.exit(1)

# riscv64-unknown-elf-as test
asmfile = test_path.replace(".sy", ".s")
objname = test_path.replace(".sy", ".o")
compile_args=["riscv64-unknown-elf-as", asmfile, "-o", objname]
try:
    ret = subprocess.run(compile_args,timeout=10)
except subprocess.TimeoutExpired:
    print("TimeOut!")
if ret.returncode != 0:
    print("Assembler Error:"+objname)
    sys.exit(1)


# riscv64-unknown-elf-gcc -o test test.o sylib.o -lm

target = test_path.replace(".sy", "")
compile_args=["riscv64-unknown-elf-gcc", "-o", target, objname, sylib_path, "-lm"]
try:
    ret = subprocess.run(compile_args,timeout=10)
except subprocess.TimeoutExpired:
     print("TimeOut!")
if ret.returncode != 0:
    print("Linker Error:"+target)
    sys.exit(1)



