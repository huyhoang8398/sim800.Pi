#!bin/bash
inotifywait -e delete,create -m -r --exclude .\(tmp\|swp\|swx\) --timefmt '%F-%T' --format '%:e | %f
| %T' /home/pi/scann -o /home/pi/scann/inotiwait.txt

