# Move to work space
import os
import sys
import subprocess
from contextlib import contextmanager
import signal
import filecmp
import difflib
import shutil

test_folder="./testcases"
temp_path = "./function_test"
test_list = []
WA_list = []
# grab all the testcases
# find files recursively
def GrabFile():
    for root, dirs, files in os.walk(test_folder):
        for file in files:
            if file.endswith(".sy"):
                test_list.append(os.path.join(root, file))

def CopyFileToTemp(test):
    # No Bad Test Now
    basename = os.path.basename(test)
    shutil.copy(test,temp_path+"/"+basename)
    if os.path.exists(test[:-2]+"in"):
        shutil.copy(test[:-2]+"in",temp_path+"/"+basename[:-2]+"in")
    if os.path.exists(test[:-2]+"out"):
        shutil.copy(test[:-2]+"out",temp_path+"/"+basename[:-2]+"out")

GrabFile()

for testcase in test_list:
    CopyFileToTemp(testcase)
