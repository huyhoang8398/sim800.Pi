#!/bin/bash
cat outputDPI.txt | grep change > nChangeDPI.txt

echo $(cut -d" " -f2- nChangeDPI.txt) > nChangeDPI.txt

DPI=$(cat nChangeDPI.txt | sed -E "s/\r//g")
infoDPI=$(crontab -l > fileTmp.txt; < fileTmp.txt grep java | awk '{print $(NF-2)}')

echo "$DPI"
echo "$infoDPI"

crontab -l > fileTmp.txt
sed -i "s|$infoDPI|$DPI|g" fileTmp.txt

crontab fileTmp.txt
