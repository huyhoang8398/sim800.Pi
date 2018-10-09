#!/usr/bin/env python3
# -*- coding:utf-8 -*-


# RPI Sim808    ||      Raspberry Pi
#     C_PW      ||          GPIO 27
#      PWK      ||          GPIO 17
#      TxD      ||          RxD (GPIO 15)
#      RxD      ||          TxD (GPIO 14)

# sudo python sim808.py
import os
import time
import serial
import RPi.GPIO as GPIO
from time import sleep
import datetime
import subprocess 
#Setup gpio pin thuc hien mot so chuc nang dac biet
C_PWpin = 27        # chan C_PW dieu khien nguon cap cho RPI Sim808 Shield
PWKpin  = 17        # chan PWK : bat/tat RPI Sim808 Shield

#data = ''
#with open('home/pi/log1.txt', 'r') as myfile
#    data = myfile.read()

# setup serial
ser = serial.Serial(
    port = '/dev/ttyAMA0',
    baudrate = 9600,
    parity = serial.PARITY_NONE,
    stopbits = serial.STOPBITS_ONE,
    bytesize = serial.EIGHTBITS,
    timeout = 1
)

# setup GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setup(C_PWpin, GPIO.OUT)
GPIO.setup(PWKpin, GPIO.OUT)

# Path to script folder
binPath = "/home/pi/sim800.Pi/bin/"
defPath = "/home/pi/"

#********************************************************************
# @GSM_Power() khoi dong nguon cho module SIM
#********************************************************************
def GSM_Power():
    #print "Bat nguon cho module Sim808...\n"
    GPIO.output(PWKpin, 1)
    time.sleep(2)
    GPIO.output(PWKpin, 0)
    time.sleep(10)
    return


#********************************************************************
# @GSM_Init() thiet lap cho module sim co the gui/nhan tin nhan
#********************************************************************
def GSM_Init():
    print "Khoi tao cho module SIM808... \n"
    ser.write(b'ATE0\r\n')              # Tat che do phan hoi (Echo mode)
    time.sleep(2)
    ser.write(b'AT+IPR=9600\r\n')       # Dat toc do truyen nhan du lieu 9600bps
    time.sleep(2)
    ser.write(b'AT+CMGF=1\r\n')         # Chon che do text mode
    time.sleep(2)
    ser.write(b'AT+CLIP=1\r\n')         # Hien thi thong tin nguoi goi den
    time.sleep(2)
    ser.write(b'AT+CNMI=2,2\r\n')       # Hien thi truc tiep noi dung tin nhan
    time.sleep(2)
    return

#********************************************************************
# @GSM_MakeCall() tao cuoc goi
#********************************************************************
def GSM_MakeCall():
    print "Goi dien...\n"
    ser.write(b'ATD0989612156;\r\n')  # Goi dien toi sdt 012345678
    time.sleep(20)
    ser.write(b'ATH\r\n')
    time.sleep(2)
    return


#********************************************************************
# @GSM_MakeSMS() tao cuoc goi
#********************************************************************
def GSM_MakeSMS(data):
    print "Nhan tin...\n"
    ser.write(b'AT+CMGS=\"0989612156\"\r\n')    # nhan tin toi sdt 012345678
    time.sleep(5)
    ser.write(data)
    ser.write(b'\x1A')      # Gui Ctrl Z hay 26, 0x1A de ket thuc noi dung tin nhan va gui di
    time.sleep(5)
    return
#change DPI##################
def changeDPIto200():
    subprocess.call(['./cron200.sh'])

def changeDPIto300():
    subprocess.call(['./cron300.sh'])

########### kill inotiwait background job ########
def killIno():
    subprocess.call(['./killjob.sh'])

######## run inotiwait again ####
def Inowait():
    subprocess.call(['./inowait.sh'])

# Simple example :
try:
    print "\n\nBat dau test module Sim808 voi Raspberry Pi ... \n"
    print "Bat nguon cho module Sim808...\n"
    GSM_Power()         # Bat nguon cho module
    GSM_Init()      # Khoi dong module
    #GSM_MakeCall()         # Tao cuoc goi
    #GSM_MakeSMS()      # Tao tin nhan
    print "done"
    dataserial=''
    while (1):
        dataserial=dataserial+ser.read().decode('utf-8')
############ Add more function here ##########
        if(len(dataserial)>0):
            ###### Help ######
            if(dataserial.find("help")>0):
                print dataserial
                datalog = ''
                myfile=open('/home/pi/sim800.Pi/help/help.txt', 'r') ## path to your help file 
                datalog = myfile.read()
                GSM_MakeSMS(datalog)
                dataserial=''

            ##### track your file system ###
            if(dataserial.find("log")>0):
                print dataserial
                datalog = ''
                killIno()
                ## read data from log file
                myfile= open('/home/pi/scann/log/inotiwait.txt', 'r') #### Path to your log file 
                datalog = myfile.read()
                GSM_MakeSMS(datalog)
                dataserial=''

                #run inotiwait again
                Inowait()

              #change DPI#########
            if(dataserial.find("200 to 300")>0):
                print dataserial
                changeDPIto300()
                #retval = os.getcwd()
                #print "%s" % retval
                #os.chdir(binPath)
                #os.system("sh cron300.sh")
                #os.chdir(defPath)
                #print "%s" % retval
                dataserial=''

            if(dataserial.find("300 to 200")>0):
                print dataserial
                changeDPIto200()
                #retval = os.getcwd()
                # print "%s" % retval
                # os.chdir(binPath)
                #os.system("sh cron200.sh")
                #os.chdir(defPath)
                # print "%s" % retval
                dataserial=''

            #turn off sim module########
            if(dataserial.find("turn off sim")>0):
                print dataserial
                GSM_Power()
                ser.close()
                GPIO.cleanup()
                dataserial=''
            #### turn off your Pi ####
            if(dataserial.find("turn off")>0):
                print dataserial
                GSM_Power()
                ser.close()
                GPIO.cleanup()
                dataserial=''
                os.system("sudo shutdow now")


            #daily infomation########
            timecheck=datetime.datetime.now()
            if timecheck.hour==22 and timecheck.minute==1 and timecheck.second<5: #### change time that you want to receive your sms
                #read file log 1 va gui sms =)))
                myfile=open('/home/pi/scann/log/dailyLog.txt','r')  #### path to your daily log file 
                dataDaily=myfile.read()
                print(dataDaily)
                GSM_MakeSMS(dataDaily)

            time.sleep(0.1)
except KeyboardInterrupt:
    ser.close()
finally:
    print "End!\n"
    ser.close()
    GPIO.cleanup()      # cn up all port