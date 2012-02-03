#!/usr/bin/env python
#-*- coding:utf-8 -*-
# Taha Dogan Gunes
# tdgunes@gmail.com

import serial, math
def getAverage():
	ser = serial.Serial("/dev/tty.usbmodem411", 9600, timeout=1)
	myList = (ser.readline()).split()

	brightness = ""
	if len(myList) > 0:
		#finding the average length of the value
		selectlist = {"1":0,"2":0,"3":0,"4":0}
		maxlist = []
		whichvalue = 0
		oldvalue = 0
		print myList
		for i in myList:
		     if len(i)<=4:
		     	oldvalue = selectlist.get(str(len(i)))
		     	selectlist[str(len(i))] = oldvalue + 1
		for i in ("1","2","3","4"):
			maxlist.append(selectlist.get(i))
  	 
		for i in ("1","2","3","4"):
			if max(maxlist)==selectlist.get(i):
				whichvalue = int(i)
		allsamelens = []
		for i in myList:
			if len(i)==whichvalue:
				allsamelens.append(int(i))
		x = 0.0
		for i in allsamelens:
			x = x + i
		a = x/len(allsamelens)
		#print whichvalue,"-",max(maxlist)
		#print str(a)[:(whichvalue+4)]
		returnvalue = str(a)[:(whichvalue+4)]
		
		return returnvalue
		
print getAverage()
	
		
		