#!/bin/bash
str1="Images JPG:"
str2="Images PNG:" 
str3="Free storage:" # your storage available
str4="DPI:" ## your DPI 

#Linux command line 
avaiMemG=$(df -h / | tail -1 | awk '{print $4}')
#infoPng=$(find /home/pi/scann/pictures | grep .png | wc -l)
#infoJpg=$(find /home/pi/scann/pictures | grep .jpg | wc -l)
infoDPI=$(crontab -l > fileTmp.txt; < fileTmp.txt grep java | awk '{print $(NF-2)}')

declare -i avaiMemK=$(df -k / | tail -1 | awk '{print $4}')
# declare -i numIMG=0
### image size
## 1GiB = 1024 MB = 1048576 KB
# df -h will output as gigabyte if posible, but we need KB and MB 
# using kb as default parameter
declare -i z=6144


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
function availIMG()
{
	if [ $infoDPI = "300" ]
	then
		numIMG=$((avaiMemK / z))
		echo "$numIMG" >> /Users/huyhoang8398/sim800.Pi/scann/log/dailyLog.txt
	fi
}

# imgLeft $infoDPI $avaiMemK $z $numIMG

# Write date, time > overwrite all files data
date > /Users/huyhoang8398/sim800.Pi/scann/log/dailyLog.txt

# Echo output to textfile without overwrite date time 
echo $(GET_JPG) >> /Users/huyhoang8398/sim800.Pi/scann/log/dailyLog.txt
echo $(GET_PNG) >> /Users/huyhoang8398/sim800.Pi/scann/log/dailyLog.txt 
echo $(GET_MEM) >> /Users/huyhoang8398/sim800.Pi/scann/log/dailyLog.txt 
echo $(GetDPI) >> /Users/huyhoang8398/sim800.Pi/scann/log/dailyLog.txt 



