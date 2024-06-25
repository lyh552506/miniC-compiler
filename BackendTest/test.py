
import os
import sys
import subprocess
import filecmp
import difflib

old_stdout = sys.stdout
sys.stdout = open('./BackendTest/TestResult.txt', 'w')

compiler_path = "./build/SYSY-compiler"
test_folder="./testcases"
pass_args=["--mem2reg","--constprop"] #,"--reassociate","--simplifycfg"

CE_list = []
LLI_FAIL_list = []
WA_list = []
AC_list = []
TLE_list = []
Time_Out = []
Bad_test = []
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
            print("Compiler Error："+test)
            continue


# riscv64-unknown-elf-as test
test_list = []
for root, dirs, files in os.walk(test_folder):
    for file in files:
        if file.endswith(".s"):
            test_list.append(os.path.join(root, file))

for test in test_list:
    if test.endswith(".s"):
        # add test_args to list
        compile_args=["riscv64-unknown-elf-as", test, "-o", "a.out"]
        try:
            ret = subprocess.run(compile_args,timeout=60)
        except subprocess.TimeoutExpired:
            Time_Out.append(test)
            print("Timeout: "+test)
            continue
        if ret.returncode != 0:
            CE_list.append(test)
            print("Compiler Error："+test)
            continue
        AC_list.append(test)
     
print("Compiler Error: Total: "+str(len(CE_list)))
print("Runtime Error: Total: "+str(len(LLI_FAIL_list)))
print("Timeout Error: Total: "+str(len(TLE_list)))
print("Wrong Answer: Total: "+str(len(WA_list)))
print("TimeOut Function:"+str(len(Time_Out)))
print("Bad Test: Total: "+str(len(Bad_test)))
print("Accepted: Total: "+str(len(AC_list)))

for test in CE_list:
    print(test)

sys.stdout = old_stdout
sys.stdout.clost()