
import os
import sys
import subprocess
from contextlib import contextmanager
import signal
import filecmp
import difflib

old_stdout = sys.stdout
TestResult_path = "BackendTest/TestResult.txt"
sys.stdout = open(TestResult_path, 'w')

compiler_path = "./build/SYSY-compiler"
# test_folder="./testcases"
test_folder="testcases/hidden_functional"
output_folder = "testcases/output"
sylib_path = "BackendTest/sylib.o"
pass_args=[] # "--mem2reg","--dce","--reassociate","--constprop","--ece","--simplifycfg","--loops","--lcssa"
CE_list = [] # Compile Error
AE_list = [] # Assembler Error
LE_list = [] # Linker Error

Time_Out = []
WA_list = []
TLE_list = []
AC_list = []
BadTest_list = []
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
        objname = test.replace(test_folder, output_folder)
        objname = objname.replace(".s", ".o")
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
for root, dirs, files in os.walk(output_folder):
    for file in files:
        if file.endswith(".o"):
            AC_Assembler_list.append(os.path.join(root, file))

for objfile in AC_Assembler_list:
    target = objfile.replace(test_folder, output_folder)
    target = target.replace(".o", "")
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
Try_run_list = []
for root, dirs, files in os.walk(output_folder):
    for file in files:
        if '.' not in file:
            Try_run_list.append(os.path.join(root, file))
for test in Try_run_list:
    compile_args=["qemu-riscv64", test]
    source = test.replace(output_folder, test_folder)
    try:
        if not os.path.exists(source+".in"):
            ret = subprocess.run(compile_args,stdout=subprocess.PIPE,stderr=subprocess.PIPE,timeout=10)
        else:
            ret = subprocess.run(compile_args,stdin=open(source+".in"),stdout=subprocess.PIPE,stderr=subprocess.PIPE,timeout=60)
    except subprocess.TimeoutExpired:
        print("TIMEOUT ERROR: "+test)
        TLE_list.append(test)

    if not os.path.exists(source+".out"):
        BadTest_list.append(test)
    else:
        out_file=source + ".out"

    dump_str=ret.stdout.decode()
    if dump_str and not dump_str.endswith('\n'):
        dump_str += "\n"
    dump_str += str(ret.returncode) + "\n"
    std_output=open(out_file).read()
    diff = difflib.unified_diff(dump_str.splitlines(), std_output.splitlines(), lineterm='')
    if(len(list(diff))!=0):
        print("Wrong Answer: "+test)
        WA_list.append(test)
    else:
        AC_list.append(test)


print("Compiler Error: Total: "+str(len(CE_list)))
print("Assembler Error: Total: "+str(len(AE_list)))
print("Linker Error: Total: "+str(len(LE_list)))
print("TimeOut Function:"+str(len(Time_Out)))
print("Wrong Answer: Total: "+str(len(WA_list)))
print("Accecpt : Total: "+str(len(AC_list)))

for test in CE_list:
    print("CE: " + test)
for test in AE_list:
    print("AE: " + test)
for test in LE_list:
    print("LE: " + test)
sys.stdout = old_stdout