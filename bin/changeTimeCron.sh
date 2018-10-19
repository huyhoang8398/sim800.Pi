#!/bin/bash
###########
### string should be #####
### 'change *2/ * * * *' ######

# first delete the single quote from message 
sed "s/['\"]//g" changeTime.txt > nChangeTime.txt
### then delete the first word "change"
echo "$(cut -d" " -f2- nChangeTime.txt)" > nChangeTime.txt
#after that, we have something like "*/2 * * * *" in nChangeTime.txt
###### Each entry in a crontab file consists of six fields, specifying in the following order: ###
##   minute(s) hour(s) day(s) month(s) weekday(s) command(s) ##
# now we assign value from nChangeTime.txt ##

### minutes
minut=$(cat nChangeTime.txt | head -n1 | awk '{print $1}')
## hour
echo minut is "$minut"
hour=$(cat nChangeTime.txt | head -n1 | awk '{print $2}')
# days 
echo hour is "$hour"
days=$(cat nChangeTime.txt | head -n1 | awk '{print $3}')
# month 
echo day is "$days"
month=$(cat nChangeTime.txt | head -n1 | awk '{print $4}')
# weekdays
echo month is "$month"
weekday=$(cat nChangeTime.txt | head -n1 | awk '{print $5}')
echo week is "$weekday"


## delte that line 
#del=$(grep "scan-lib" cron.txt)

### we check the cronjob, then export it to the 
crontab -l > cron.txt  #### Check current scheduled cron:

#echo "$(cat cron.txt | grep scan-lib | head -n1)" > cron.txt # grep scanner job

## same thing with nChangeTime.txt#
#minutOrig=$(cat cron.txt | awk '{print $1}')
#hourOrig=$(cat cron.txt | awk '{print $2}')
#daysOrig=$(cat cron.txt | awk '{print $3}')
#monthOrig=$(cat cron.txt | awk '{print $4}')
#weakdayOrig=$(cat cron.txt | awk '{print $5}')

###### Now we sawp minut to minut Original 
#sed -i -e "s|$minutOrig|$minut|; s|$hourOrig|$hour|; s|$daysOrig|$days|; s|$monthOrig|$month|; s|$weakdayOrig|$weekday|" cron.txt 
#sed -e "s|$minutOrig|$minut|" cron.txt
#sed -e "s|$hourOrig|$hour|" cron.txt
#sed -e "s|$daysOrig|$days|3" cron.txt
#sed -e "s|$monthOrig|$month|4" cron.txt
#sed -e "s|$weakdayOrig|$weekday|5" cron.txt

#sed -i '/scan-lib/d' cron.txt ## linux 

sed -i '' '/scan-lib/d' cron.txt ## macOS and freeBSD

echo -e "$minut" "$hour" "$days" "$month" "$weekday"  "java -jar /home/pi/scannn/scan-lib.jar 300 > /dev/null" >> cron.txt






