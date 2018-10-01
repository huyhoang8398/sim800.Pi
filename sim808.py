#!/usr/bin/env python3
# -*- coding:utf-8 -*-


# RPI Sim808 	|| 		Raspberry Pi
# 	  C_PW		||			GPIO 27
# 	   PWK		|| 			GPIO 17 
#	   TxD 		|| 			RxD (GPIO 15)
# 	   RxD 		|| 			TxD (GPIO 14)

# sudo python sim808.py
import os
import time 
import serial
import RPi.GPIO as GPIO
from time import sleep
import datetime

#Setup gpio pin thuc hien mot so chuc nang dac biet
C_PWpin = 27		# chan C_PW dieu khien nguon cap cho RPI Sim808 Shield
PWKpin  = 17 		# chan PWK : bat/tat RPI Sim808 Shield

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
        ser.write(b'ATE0\r\n') 				# Tat che do phan hoi (Echo mode)
        time.sleep(2)
        ser.write(b'AT+IPR=9600\r\n') 		# Dat toc do truyen nhan du lieu 9600bps
        time.sleep(2)
        ser.write(b'AT+CMGF=1\r\n')			# Chon che do text mode
        time.sleep(2)
        ser.write(b'AT+CLIP=1\r\n') 		# Hien thi thong tin nguoi goi den
        time.sleep(2)
        ser.write(b'AT+CNMI=2,2\r\n') 		# Hien thi truc tiep noi dung tin nhan
        time.sleep(2)
        return

#********************************************************************
# @GSM_MakeCall() tao cuoc goi
#********************************************************************
def GSM_MakeCall():
    print "Goi dien...\n"
        ser.write(b'ATD012345678;\r\n')  # Goi dien toi sdt 012345678
        time.sleep(20)
        ser.write(b'ATH\r\n')
        time.sleep(2)
        return


#********************************************************************
# @GSM_MakeSMS() tao cuoc goi
#********************************************************************
def GSM_MakeSMS(data):
    print "Nhan tin...\n"
        ser.write(b'AT+CMGS=\"01679792379\"\r\n') 	# nhan tin toi sdt 012345678
        time.sleep(5)
        ser.write(data)
        ser.write(b'\x1A')		# Gui Ctrl Z hay 26, 0x1A de ket thuc noi dung tin nhan va gui di
        time.sleep(5)
        return


# Simple example :
try:
    print "\n\nBat dau test module Sim808 voi Raspberry Pi ... \n"
        print "Bat nguon cho module Sim808...\n"
        GSM_Power()			# Bat nguon cho module 
        GSM_Init() 			# Khoi dong module 
        #GSM_MakeCall() 		# Tao cuoc goi
        #GSM_MakeSMS() 		# Tao tin nhan 
        dataserial=''
        while (1):
            dataserial=dataserial+ser.read().decode('utf-8')

            if(len(dataserial)>0):
                if(dataserial.find("GUISMS")>0):
                    print dataserial
                    datalog = ''
                    myfile= open('/home/pi/log1.txt', 'r') 
                    datalog = myfile.read()
                    print 'da nhan dung sms'
                    GSM_MakeSMS(datalog)
                    #datalog=''
                    dataserial=''
               #change DPI 
                if(dataserial.find("200 to 300")>0);
                    print dataserial
                    os.system('cd ~/sim800.pi/bin | ./cron300.sh')
                    dataserial=''
                
                if(dataserial.find("300 to 200")>0);
                    print dataserial
                    os.system('cd ~/sim800.pi/bin | ./cron200.sh')
                    dataserial='' 
                    
            timecheck=datetime.datetime.now()
            if timecheck.hour==22 and timecheck.minute==35 and timecheck.second<5:
                #read file log 1 va gui sms =)))

                    myfile=open('/home/pi/log1.txt','r')
                    mydatalog1=myfile.read()
                    print(mydatalog1)
                    #GSM_makeSMS(datalog1)

            time.sleep(0.1)

        print "Tat nguon cho module Sim808!\n"
        GSM_Power()			# Tat nguon cho module
except KeyboardInterrupt: 
    ser.close()  
finally:
    print "End!\n"
        ser.close()
        GPIO.cleanup() 		# cn up all port


