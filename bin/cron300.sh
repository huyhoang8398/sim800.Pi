#!/bin/sh
crontab -l > file.tmp; < file.tmp sed -e 's#200#300#g' | crontab -


