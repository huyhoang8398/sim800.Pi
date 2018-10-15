#!/bin/bash
###########
### string should be #####
### 'change *2/ * * * *' ######

# first delete the single quote from message 
sed "s/['\"]//g" ChangeTime.txt | tee nChangeTime.txt
### then delete the first word "change"
cut -d" " -f2- nChangeTime.txt | tee nChangeTime.txt

crontab -l > cron.txt 
cat cron.txt | grep scan-lib | head -n1 


