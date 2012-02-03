#!/usr/bin/env python
#-*- coding:utf-8 -*-
# Taha Dogan Gunes
# tdgunes@gmail.com
#
# MyScript.py 18.09.2011 (new update, serialPort support)
#
# This script works with AutoMessageChanger(Automator based) and AutoStatusChanger(AppleScript based)
#
# -2012
# -Lots of bugs solved so far
#
# Requirements:
# - Python 2.6+
# - 15 MB RAM space on your RAM :)
# - iChat 6.0 (Tested on Lion, may compatible with SL's and L's iChat)
# - 6 kb writing to the disk per interval (short intervals may cause hard disk problems after a long usage.)
# - a Mac OS X 10.5+ (Tested on Lion)

import os, time, datetime, sys, serialReader



applescript = """
tell application "iChat"
	set theName to ":.temp_iChat_status"
	set thePlace to path to preferences folder as string
	set theFile to (thePlace & theName)
	set theMessage to "*-*"
	
	
	
	set hereStatus to (get status message)
	try
		set open_file to ¬
			open for access file theFile with write permission
		set eof of open_file to 0
		write hereStatus to open_file starting at eof
		close access open_file
	on error
		try
			close access file theFile
		end try
	end try"""
statuspart ="""
	set status to "aaa"
	set status message to theMessage
	
end tell
"""

def scriptEdit(message, status):
    draft = ""
    now = datetime.datetime.now()
    draft2 = statuspart.replace("\"aaa\"",status)
    if len(str(now.second)) == 1:
        seconds = "0" + str(now.second)
    else:
        seconds = now.second

    myserial = serialReader.getAverage()
    message = message.replace("_"," ")
    message = message.replace("*serial*",str(myserial))
    mytext = now.strftime("%H:%M:{0}".format(seconds))
    message = message.replace("*time*",mytext)
    draft3 = applescript.replace("*-*",message)
    draft = draft3  + draft2
    return draft

def runAppleScript(scriptText):
    draft = os.environ["HOME"]+"/Documents/draft.txt"
    compiled = os.environ["HOME"]+"/Documents/compiled.txt"
    f = open(draft,"w")
    f.write(scriptText)
    f.close()
    os.system("osacompile -o %s %s" % (compiled, draft))
    os.remove(draft)
    os.system("osascript %s" % compiled)
    os.remove(compiled)

def startConsoleApp():
    x = 0
    print "Welcome to the Auto Status Message Changer for iChat"
    howMany = int(raw_input("How many messages: "))
    messages = []
    print "Use '(time)' in order to include system time in your messages!"
    while x<howMany:
        messages.append(raw_input("%s. Message: " % str(x+1)))
        x += 1
    interval = int(raw_input("Interval between message changes(1=one second): "))
    mystatus = raw_input("Your status(Available(1)-Away(2))\n: ")

    if mystatus == "1": mystatus="available"
    elif mystatus == "2": mystatus="away"
    
    startService(messages, mystatus, interval)

def startService(messageList, mystatus, interval):
    print "Starting loop..."
    now = datetime.datetime.now()
    print "Service was started at "+now.strftime("%Y-%m-%d %H:%M")
    print "CTRL-C to stop loop!"
    x = 0
    try:
        while True:
            runAppleScript(scriptEdit(messageList[x],mystatus))
            time.sleep(interval)
            x += 1
            if x == len(messageList):
                x = 0
            try:
                f = open(os.environ["HOME"]+"/Documents/close.txt",'r')
                if f.read() == "0":
                    runAppleScript(scriptEdit("","available"))
                    try: 
                       os.remove(os.environ["HOME"]+"/Documents/close.txt")
                    except:
                       pass

                    break
            except:
                pass
    except KeyboardInterrupt:
        now2 = datetime.datetime.now()
        print "\nReturning to the \"Available\" mode, cleaning status message..."
        runAppleScript(scriptEdit("","available"))
        print "Exiting..."
        print "Service was stopped at "+now2.strftime("%Y-%m-%d %H:%M")
        print "Thanks for using Auto Status Message Changer!"

    

if len(sys.argv[1:]) != 0:
    try: 
        os.remove(os.environ["HOME"]+"/Documents/close.txt")
    except:
        pass
    if sys.argv[1] == "close":
        f = open(os.environ["HOME"]+"/Documents/close.txt","w")
        f.write("0")
        f.close()
    else:
        os.system("touch %s/Documents/close.txt"% os.environ["HOME"])
        startService(sys.argv[1].split("-"), sys.argv[2], int(sys.argv[3])) 
else:
    startConsoleApp()

