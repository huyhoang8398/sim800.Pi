#!/bin/bash
# grep only line that contain time 
for f in $(find . -name "output.txt")
do
  grep time $f | tail -1 > timeChange.txt
done
# del the first word
echo "$(cut -d" " -f2- timeChange.txt)" > timeChange.txt

infoDPI=$(crontab -l > cron.txt; < cron.txt grep java | awk '{print $(NF-2)}')
basic="java -jar /home/pi/scann/scan-lib.jar"
basic2=">"
basic3="/dev/null"
timeChange=$(cat timeChange.txt)
#crontab -l > cron.txt
sed -i '/scan-lib/d' cron.txt
echo  "$timeChange""$basic""$infoDPI""$basidc2""$basic3" >> cron.txt
crontab cron.txt

