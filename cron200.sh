#!/bin/sh
crontab -l > file.tmp; < file.tmp sed -e 's#300#200#g' | crontab -
echo done