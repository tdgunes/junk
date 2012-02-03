#!/usr/bin/env python
#-*- coding:utf-8 -*-
# Taha Dogan Gunes
# tdgunes@gmail.com

f = open("./data.txt","r")
newlines = []
newlines.append("Date,Temperature\n")
for i in f.readlines():
	mline = i.strip()
	if len(mline)>0:
		newline = ""
		tempvalue = mline.split("-")[1]
		mydate = mline.split("-")[0]
		newline = mydate +","+tempvalue+"\n"
		newlines.append(newline)

f.close()
f = open("./data.csv","w")
f.writelines(newlines)
f.close()