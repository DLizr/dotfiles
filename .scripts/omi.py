import os
import sys


tests = int(sys.argv[1])

for i in range(tests):
    print("--\nTest #{}:".format(str(i)))
    os.system("./out < input{}".format(str(i)))

