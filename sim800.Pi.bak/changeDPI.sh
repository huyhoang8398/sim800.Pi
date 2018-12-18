#!/bin/bash
crontab -u pi -l > cron.txt
sed -i -e 's/\r//g' outputDPI.txt
DPI=$(cat -A outputDPI.txt)
infoDPI=$(grep java cron.txt| awk '{print $(NF-2)}')
sed -i "s|$infoDPI|$DPI|" cron.txt
crontab -u pi cron.txt
