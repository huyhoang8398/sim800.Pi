#!/bin/bash
# first delete the single quote from message 
sed "s/['\"]//g" changeDPI.txt > nChangeDPI.txt
### then delete the first word "change"
echo "$(cut -d" " -f2- nChangeDPI.txt)" > nChangeDPI.txt
DPI=$(cat nChangeDPI.txt)
infoDPI=$(crontab -l > fileTmp.txt; < fileTmp.txt grep java | awk '{print $(NF-2)}')
#echo "$DPI"
#echo "$infoDPI"
< fileTmp.txt sed -e "s|$infoDPI|$DPI|" | crontab -

