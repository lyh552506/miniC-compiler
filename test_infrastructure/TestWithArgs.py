import os
import sys
import subprocess
import filecmp
import difflib
from tqdm import tqdm

compiler_path = "./build/SYSY-compiler"
test_folder="./testcases"

# pass_args=["--mem2reg"]

# grab all the testcases

# find files recursively
test_list = []
for root, dirs, files in os.walk(test_folder):
    for file in files:
        if file.endswith(".sy"):
            test_list.append(os.path.join(root, file))

def TestWithArg(pass_args:list):
    print("Start Testing With",end=" ")
    for arg in pass_args:
        print(arg,end=" ")
    print('\n')
    CE_list = []
    WA_list = []
    AC_list = []
    TLE_list = []
    Bad_test = []

    for test in test_list:
        if test.endswith(".sy"):
            # add test_args to list
            compile_args=[compiler_path, test]
            for arg in pass_args:
                compile_args.append(arg)
            ret = subprocess.run(compile_args)
            if ret.returncode != 0:
                CE_list.append(test)
                print("CE: ",test)
                continue
            # run lli
            ll_file = test+".ll"
            out_file = test[:-2]+"out"
            # maybe theres no input file

            if not os.path.exists(test[:-2]+"in") and not os.path.exists(out_file):
                Bad_test.append(test)
                continue
            
            # Kill program run over 5s, give it a TLE
            try:
                if not os.path.exists(test[:-2]+"in"):
                    ret = subprocess.run(["lli","-opaque-pointers",ll_file], stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=10)
                else:
                    ret = subprocess.run(["lli","-opaque-pointers",ll_file], stdout=subprocess.PIPE, stderr=subprocess.PIPE, input=open(test[:-2]+"in").read().encode(), timeout=10)
            except subprocess.TimeoutExpired:
                # print("Timeout Error")
                TLE_list.append(test)
                print("TLE: ",test)
                continue

            # compare the output
            # Merge The reture Value and stdout

            dump_str=ret.stdout.decode()
            # remove whitesspace in the end
            # dump_str=dump_str.rstrip()
            if dump_str and not dump_str.endswith('\n'):
                dump_str += "\n"
            dump_str += str(ret.returncode) + "\n"
            std_output=open(out_file).read()
            diff = difflib.unified_diff(dump_str.splitlines(), std_output.splitlines(), lineterm='')
            if(len(list(diff))!=0):
                # print("Wrong Answer")
                WA_list.append(test)
                print("WA: ",test)
                continue
            # print("Accepted")
            AC_list.append(test)
            print("AC: ",test)

    if len(CE_list)!=0 or len(WA_list)!=0 or len(TLE_list)!=0:
        return 1
    else:
        return 0
