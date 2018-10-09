#!/bin/bash
str1="Images JPG:"
str2="Images PNG:" 
str3="Free storage:" # your storage available
str4="DPI:" ## your DPI 

#Linux command line 
avaiMem=$(df -h /tmp | tail -1 | awk '{print $4}')
infoPng=$(find /home/pi/scann/pictures | grep .png | wc -l)
infoJpg=$(find /home/pi/pictures | grep .jpg | wc -l)
infoDPI=$(crontab -l && cat fileTmp.txt | grep java | awk '{print $(NF-2)}')

function GET_MEM()
{
    echo -e "$str3 $avaiMem\n";  
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
	echo -e "$str4 $infoDPI"
}

# Write date, time > overwrite all files data
date > /home/pi/scann/dailyLog.txt


# Echo output to textfile without overwrite date time 
echo $(GET_JPG) >> /home/pi/scann/log/dailyLog.txt
echo $(GET_PNG) >> /home/pi/scann/log/dailyLog.txt 
echo $(GET_MEM) >> /home/pi/scann/log/dailyLog.txt 
echo $(GetDPI) >> /home/pi/scann/log/dailyLog.txt 



