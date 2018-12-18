#!/bin/bash
crontab -u pi -l > cron.txt
infoDPI=$(grep java cron.txt| awk '{print $(NF-2)}')
sed -i -e 's/\r//g' outputTime.txt
newCron=$(cat -A outputTime.txt)
crontab -u pi -l | grep -v java > cron.txt
echo -e "${newCron}" "java -jar /home/pi/scannn/scan-lib.jar" "${infoDPI}" "> /dev/null" >> cron.txt
#sed -i "s|$oldCron||g" fileTmp.txt
#sed -i "s|$oldCron|$newCron|g" fileTmp.txt
crontab -u pi cron.txt
