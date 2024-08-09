import os
import sys
import subprocess
from contextlib import contextmanager
import signal
import filecmp
import difflib
import shutil
import time
# old_stdout = sys.stdout
TestResult_path = "BackendTest/TestResult.txt"
# sys.stdout = open(TestResult_path, 'w')

outputfile = open(TestResult_path, 'w')
upload_folder = "uploadfolder"
# compiler_path = "./compiler"
compiler_path = "./build/SYSY-compiler"

# test_folder="testcases/functional"
# output_folder = "testcases/output"
test_folder="function_test"
output_folder = "function_test"
sylib_path = "BackendTest/sylib.o"

pass_args=["--O1"] # 
CE_list = [] # Compile Error
AE_list = [] # Assembler Error
LE_list = [] # Linker Error

Time_Out = []
WA_list = []
TLE_list = []
AC_list = []
BadTest_list = []

# No Bad Test Now

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
            print("Running: " + test)
            ret = subprocess.run(compile_args,timeout=60)
        except subprocess.TimeoutExpired:
            Time_Out.append(test)
            outputfile.write("Timeout: "+test+ "\n")
            outputfile.flush()
            continue
        if ret.returncode != 0:
            CE_list.append(test)
        else:
            print("Compiled: " +  test)


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
            ret = subprocess.run(compile_args,timeout=15)
        except subprocess.TimeoutExpired:
            Time_Out.append(test)
            outputfile.write("Timeout: "+test+ "\n")
            outputfile.flush()
            continue
        if ret.returncode != 0:
            AE_list.append(test)
        else:
            print("As: " +  test)

# riscv64-unknown-elf-gcc -o test test.o sylib.o -lm
AC_Assembler_list = []
for root, dirs, files in os.walk(output_folder):
    for file in files:
        if file.endswith(".o"):
            AC_Assembler_list.append(os.path.join(root, file))

for objfile in AC_Assembler_list:
    target = objfile.replace(output_folder, upload_folder)
    target = target.replace(".o", "")
    if objfile.endswith(".o"):
        compile_args=["riscv64-unknown-elf-gcc", "-o", target, objfile, sylib_path, "-lm"]
        try:
            ret = subprocess.run(compile_args,timeout=15)
        except subprocess.TimeoutExpired:
            Time_Out.append(objfile)
            outputfile.write("Timeout: "+objfile+ "\n")
            outputfile.flush()
            continue
        if ret.returncode != 0:
            LE_list.append(objfile)
        else:
            print("Linked: " +  target)

# Run On Qemu
Try_run_list = []
for root, dirs, files in os.walk(upload_folder):
    for file in files:
        if '.' not in file:
            Try_run_list.append(os.path.join(root, file))

start_time = time.time()
ind = 0
for ind in range(0, 1):
    for test in Try_run_list:
        compile_args=["qemu-riscv64", test]
        source = test.replace(upload_folder, test_folder)
        basename = os.path.basename(test)
        try:
            if not os.path.exists(source+".in"):
                ret = subprocess.run(compile_args,stdout=subprocess.PIPE,stderr=subprocess.PIPE,timeout=60)
            else:
                shutil.copy(source+".in",upload_folder+"/"+basename+".in")
                ret = subprocess.run(compile_args,stdin=open(source+".in"),stdout=subprocess.PIPE,stderr=subprocess.PIPE,timeout=60)
        except subprocess.TimeoutExpired:
            outputfile.write("TIMEOUT ERROR: "+test+ "\n")
            outputfile.flush()
            TLE_list.append(test)

        if not os.path.exists(source+".out"):
            BadTest_list.append(test)
        else:
            shutil.copy(source+".out",upload_folder+"/"+basename+".out")
            out_file=source + ".out"

        dump_str=ret.stdout.decode()
        if dump_str and not dump_str.endswith('\n'):
            dump_str += "\n"
        dump_str += str(ret.returncode) + "\n"
        std_output=open(out_file).read()
        diff = difflib.unified_diff(dump_str.splitlines(), std_output.splitlines(), lineterm='')
        if(len(list(diff))!=0):
            outputfile.write("Wrong Answer: "+test+ "\n")
            outputfile.flush()
            WA_list.append(test)
        else:
            print("Accept: "+test)
            AC_list.append(test)

end_time = time.time()
duration = end_time - start_time

outputfile.write("Compiler Error: Total: "+str(len(CE_list)) + "\n")
outputfile.write("Assembler Error: Total: "+str(len(AE_list))+ "\n")
outputfile.write("Linker Error: Total: "+str(len(LE_list))+ "\n")
outputfile.write("TimeOut Function:"+str(len(Time_Out))+ "\n")
outputfile.write("Wrong Answer: Total: "+str(len(WA_list))+ "\n")
outputfile.write("Accecpt : Total: "+str(len(AC_list))+ "\n")
outputfile.write(f"Duration: {duration} seconds\n")
for test in CE_list:
    outputfile.write("CE: " + test+ "\n")
for test in AE_list:
    outputfile.write("AE: " + test+ "\n")
for test in LE_list:
    outputfile.write("LE: " + test+ "\n")

outputfile.close()
# sys.stdout = old_stdout