import os
path = "/Users/huyhoang8398"
retval = os.getcwd()
print(retval)
os.chdir(path)

print "%s" % retval

os.system("./test.sh")

retval = os.getcwd()
print "%s" % retval 
