#!/usr/bin/env python
#-*- coding:utf-8 -*-
# Taha Dogan Gunes
# tdgunes@gmail.com


import serial, math, time,datetime
ser = serial.Serial("/dev/tty.usbmodem621", 9600, timeout=1)


def getTemp():
	returner = ""
	
	while True:
		mstring = "-showtemp-"
		#print mstring
		ser.write(mstring)
		#time.sleep(0.6)
		data = ser.readlines()
		#print data
		try:
			if data[0] is not None:
				returner = data[0]
				break;
		except:
			pass
	return returner
			

def getDate():
    draft = ""
    now = datetime.datetime.now()
    if len(str(now.second)) == 1:
        seconds = "0" + str(now.second)
    else:
        seconds = now.second
    mytext = now.strftime("%H:%M:{0}".format(seconds))
    return mytext

if True:
	print "-TDG Serial Temperature Tracker-"
	print "Service Started at " + getDate()
	print "Interval: 5 minutes"
	print "---------------------------------"
	while True:

		f = open("./data.txt","r")
		mtext = f.read()
		mtext += getDate()+" - "+ getTemp()+"\n"
		#print mtext
		f.close()
		f = open("./data.txt","w")
		f.write(mtext)
		f.close()
		time.sleep(5*60)
	print "unexpectable happened"
		
