#!/bin/sh
crontab -l > file.txt; < file.txt sed -e 's#200#300#g' | crontab -
echo done