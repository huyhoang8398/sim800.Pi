#!/bin/sh
crontab -l > file.txt; < file.txt sed -e 's#300#200#g' | crontab -
echo done
