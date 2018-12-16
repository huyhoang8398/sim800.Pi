#!/bin/bash

sed "s/change\s//g" nChangeTime.txt | tee newTime.txt
#oldCron="$(grep -oP "(\*/[0-9] |\* ){5}" <<< $(crontab -l) | sed -E "s/\r//g")"
crontab -l > cron.txt
newCron=$(cat newTime.txt)
sed -i '/scan-lib/d' cron.txt 
infoDPI=$(crontab -l > fileTmp.txt; < fileTmp.txt grep java | awk '{print $(NF-2)}')
echo "${infoDPI}"
echo "${newCron}"
echo -e "${newCron}" "java -jar /home/pi/scannn/scan-lib.jar" "${infoDPI}" "> /dev/null" >> cron.txt
#sed -i "s|$oldCron||g" fileTmp.txt
#sed -i "s|$oldCron|$newCron|g" fileTmp.txt
crontab cron.txt
