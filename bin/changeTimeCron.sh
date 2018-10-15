#!/bin/bash
###########
### string should be #####
### 'change *2/ * * * *' ######

# first delete the single quote from message 
sed "s/['\"]//g" changeTime.txt > nChangeTime.txt
### then delete the first word "change"
echo $(cut -d" " -f2- nChangeTime.txt) > nChangeTime.txt
#after that, we have something like "*/2 * * * *" in nChangeTime.txt
###### Each entry in a crontab file consists of six fields, specifying in the following order: ###
##   minute(s) hour(s) day(s) month(s) weekday(s) command(s) ##
# now we assign value from nChangeTime.txt ##

### minutes
minut=$(cat nChangeTime.txt | head -n1 | awk '{print $1;}')
## hour
hour=$(cat nChangeTime.txt | head -n1 | awk '{print $2;}')
# days 
days=$(cat nChangeTime.txt | head -n1 | awk '{print $3;}')
# month 
month=$(cat nChangeTime.txt | head -n1 | awk '{print $4;}')
# weekdays
weekday=$(cat nChangeTime.txt | head -n1 | awk '{print $5;}')

### we check the cronjob, then export it to the 
crontab -l > cron.txt  #### Check current scheduled cron:

echo $(cat cron.txt | grep scan-lib | head -n1) > cron.txt # grep scanner job

## same thing with nChangeTime.txt#
minutOrig=$(cat cron.txt | awk '{print $1}')
hourOrig=$(cat cron.txt | awk '{print $2}')
daysOrig=$(cat cron.txt | awk '{print $3}')
monthOrig=$(cat cron.txt | awk '{print $4}')
weakdayOrig=$(cat cron.txt | awk '{print $5}')

###### Now we sawp minut to minut Original 
sed -i -e "s|$minutOrig|$minut|g" cron.txt 
sed -i -e "s|$hourOrig|$hour|g" cron.txt 
sed -i -e "s|$daysOrig|$days|g" cron.txt
sed -i -e "s|$monthOrig|$month|g" cron.txt 
sed -i -e "s|$weakdayOrig|$weekday|g" cron.txt 




