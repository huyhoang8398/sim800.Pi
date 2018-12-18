#!/bin/bash
str1="Images JPG:"
str2="Images PNG:" 
str3="Free storage:" # your storage available
str4="DPI:" ## your DPI 
str6="Time to take Picture:"
str5="Number of Picture can take:"
delimiter=' '
#Linux command line 
avaiMemG=$(df -h /home | tail -1 | awk '{print $4}')
infoPng=$(find /home/pi/scannn/pictures/ | grep .png | wc -l)
infoJpg=$(find /home/pi/scannn/pictures/ | grep .jpg | wc -l)
#infoDPI=$(crontab -l > fileTmp.txt; < fileTmp.txt grep java | awk '{print $(NF-2)}')
infoDPI=$(crontab -u pi -l > cron.txt; < fileTmp.txt grep java | awk '{print $(NF-2)}')
crontab -u pi -l | grep java > cron.txt
cut -d"$delimiter" -f1-5 cron.txt > cron2.txt
infoTime=$(cat -A cron2.txt)
### image size
## 1GiB = 1024 MB = 1048576 KB
# df -h will output as gigabyte if posible, but we need KB and MB 
# using kb as default parameter

#400 DPI
# declare -i I = 
# Write date, time > overwrite all files data
date > /home/pi/scannn/log/dailyLog.txt


function GET_MEM()
{
    echo -e "$str3 $avaiMemG\n";  
}

function GET_PNG()
{
    echo -e "$str2 $infoPng\n";
}

function GET_JPG()
{
    echo -e "$str1 $infoJpg\n";
}
function GetDPI()
{
	echo -e "$str4 $infoDPI\n"
}
function GetTime()
{
	echo -e "${str6}" "${infoTime}"
}
# Echo output to textfile without overwrite date time 
echo $(GET_JPG) >> /home/pi/scannn/log/dailyLog.txt
echo $(GET_PNG) >> /home/pi/scannn/log/dailyLog.txt
echo $(GET_MEM) >> /home/pi/scannn/log/dailyLog.txt
echo $(GetDPI) >> /home/pi/scannn/log/dailyLog.txt
echo -e "$str6" "$infoTime""\n" >> /home/pi/scannn/log/dailyLog.txt



