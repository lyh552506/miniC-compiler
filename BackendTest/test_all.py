
import os
import sys
import subprocess
import filecmp
import difflib

old_stdout = sys.stdout
TestResult_path = "BackendTest/TestResult.txt"
sys.stdout = open(TestResult_path, 'w')

compiler_path = "./build/SYSY-compiler"
# test_folder="./testcases"
test_folder="testcases/hidden_functional"
sylib_path = "BackendTest/sylib.o"
pass_args=["--mem2reg","--dce","--reassociate","--constprop","--ece","--simplifycfg","--loops","--lcssa"]
CE_list = [] # Compile Error
AE_list = [] # Assembler Error
LE_list = [] # Linker Error

Time_Out = []
WA_list = []

# grab all the testcases
# find files recursively
test_list = []
for root, dirs, files in os.walk(test_folder):
    for file in files:
        if file.endswith(".sy"):
            test_list.append(os.path.join(root, file))

for test in test_list:
    if test.endswith(".sy"):
        # add test_args to list
        compile_args=[compiler_path, test]
        for arg in pass_args:
            compile_args.append(arg)
        try:
            ret = subprocess.run(compile_args,timeout=10)
        except subprocess.TimeoutExpired:
            Time_Out.append(test)
            print("Timeout: "+test)
            continue
        if ret.returncode != 0:
            CE_list.append(test)


# riscv64-unknown-elf-as test
test_list = []
for root, dirs, files in os.walk(test_folder):
    for file in files:
        if file.endswith(".s"):
            test_list.append(os.path.join(root, file))

for test in test_list:
    if test.endswith(".s"):
        objname = test.replace(".s", ".o")
        compile_args=["riscv64-unknown-elf-as", test, "-o", objname]
        try:
            ret = subprocess.run(compile_args,timeout=10)
        except subprocess.TimeoutExpired:
            Time_Out.append(test)
            print("Timeout: "+test)
            continue
        if ret.returncode != 0:
            AE_list.append(test)
  
# riscv64-unknown-elf-gcc -o test test.o sylib.o -lm
AC_Assembler_list = []
for root, dirs, files in os.walk(test_folder):
    for file in files:
        if file.endswith(".o"):
            AC_Assembler_list.append(os.path.join(root, file))

for objfile in AC_Assembler_list:
    target = objfile.replace(".o", "")
    if objfile.endswith(".o"):
        compile_args=["riscv64-unknown-elf-gcc", "-o", target, objfile, sylib_path, "-lm"]
        try:
            ret = subprocess.run(compile_args,timeout=10)
        except subprocess.TimeoutExpired:
            Time_Out.append(objfile)
            print("Timeout: "+objfile)
            continue
        if ret.returncode != 0:
            LE_list.append(objfile)

# Run On Qemu
# Try_run_list = []
# for root, dirs, files in os.walk(test_folder):
#     for file in files:
#         if '.' not in file:
#             Try_run_list.append(os.path.join(root, file))
# for test in Try_run_list:
#     compile_args=["qemu-riscv64", test]
#     try:
#         with open(test+".in", 'r') as fin:
#             input_data = fin.read()
#         process = subprocess.Popen(compile_args, stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True, timeout=10)
#         stdout_data, stderr_data = process.communicate(input=input_data)
#         print("Output:", stdout_data.strip())
#     except subprocess.TimeoutExpired:
#         Time_Out.append(test)

print("Compiler Error: Total: "+str(len(CE_list)))
print("Assembler Error: Total: "+str(len(AE_list)))
print("Linker Error: Total: "+str(len(LE_list)))

print("TimeOut Function:"+str(len(Time_Out)))
print("Wrong Answer: Total: "+str(len(WA_list)))

for test in CE_list:
    print("CE: " + test)
for test in AE_list:
    print("AE: " + test)
for test in LE_list:
    print("LE: " + test)
sys.stdout = old_stdout
