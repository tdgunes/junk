#!/usr/bin/env python
# -*- coding: utf-8 -*-
# 
# Taha Doğan Güneş
#  tas-server.py
# 
# This program or module is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 2 of the License, or
# version 3 of the License, or (at your option) any later version. It is
# provided for educational purposes and is distributed in the hope that
# it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
# the GNU General Public License for more details

from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals
from future_builtins import *

import sys, bisect, collections, random, time

from PyQt4.QtCore import *
from PyQt4.QtGui import *
from PyQt4.QtNetwork import *


PORT = 9407
SIZEOF_UINT16 = 2 

class Socket(QTcpSocket):
   def __init__(self, parent=None):
        super(Socket, self).__init__(parent)
        self.connect(self, SIGNAL("readyRead()"), self.readRequest)
        self.connect(self, SIGNAL("disconnected()"), self.deleteLater)
        self.nextBlockSize = 0
	self.clienthamle = None
	self.elemanlar = [ u"Taş", u"Makas", u"Kağıt"]
   def readRequest(self):
        stream = QDataStream(self)
        stream.setVersion(QDataStream.Qt_4_2)

        if self.nextBlockSize == 0:
            if self.bytesAvailable() < SIZEOF_UINT16:
                return
            self.nextBlockSize = stream.readUInt16()
        if self.bytesAvailable() < self.nextBlockSize:
            return
	
	action = QString()
	move = QString()
	stream >> action >> move
	if action in ["HAMLE"]:
	    self.clienthamle = QString("%1").arg(move)
            #oyna = random.choice(self.elemanlar)
            print (": %s" % move)
	    oyna = raw_input("Hamlen :")
            b = "HAMLE"
            c = "MESAJ"
            oyna = oyna.split("*")
            oyna1 = oyna[1]
	    self.sendError(unicode(oyna[0]),b)
            try:
		self.sendError(unicode(oyna[1]),c)
	    except:
		pass
	    print ("İstemci Hamlesi: %s, Sunucu Hamlesi: %s" % (self.clienthamle, oyna[0]))
	elif action in ["GIRIS"]:
	    print ("olan kullanıcının bilgileri:\n %s\n---------------------------------" % move)
	elif action in ["KAPATMA"]:
	    print ("olan kullanıcı %s\n---------------------------------" % move)
	else:
	    self.sendError(u"Bilinmeyen bir istek", "HATA")

   def sendError(self, msg, baslik):
        print ("Başlık: %s Mesaj: %s Gönderildi." % (baslik, msg))
	reply = QByteArray()
        stream = QDataStream(reply, QIODevice.WriteOnly)
        stream.setVersion(QDataStream.Qt_4_2)
        stream.writeUInt16(0)
        stream << QString(baslik) << QString(msg)
        stream.device().seek(0)
        stream.writeUInt16(reply.size() - SIZEOF_UINT16)
        self.write(reply)



class TcpServer(QTcpServer):

    def __init__(self, parent=None):
        super(TcpServer, self).__init__(parent)
	#self.gelenid = ""

    def incomingConnection(self, socketId):
        socket = Socket(self)
        socket.setSocketDescriptor(socketId)
        print (u"********** | Kullanıcı ID: %s | **********" % socketId)
	#self.gelenid = int(socketId)
    #def sendReplyUi(self, baslik, mesaj):
	#socket = Socket(self)
	#socket.setSocketDescriptor(self.gelenid)
        #socket.sendError(QString(mesaj), QString(baslik)) 
        
class TasMakasKagitServer(QWidget):
      
    def __init__(self, parent = None):
	super(TasMakasKagitServer, self).__init__(parent)

	self.tcpServer = TcpServer(self)

        if not self.tcpServer.listen(QHostAddress("0.0.0.0"), PORT):
            QMessageBox.critical(self, u"Taş Sunucusu",
                    QString("Sunucu başlatılırken hata: %1")
                    .arg(self.tcpServer.errorString()))
            self.close()
            return
	

	
	self.tarayici = QTextBrowser()
	self.kapat = QPushButton("Sunucuyu kapatmak için tıklayın.")
	#self.mesaj = QLineEdit()
	#self.mesajgonder = QPushButton("Gönder")
	#self.baglan = QPushButton(u"Başlat")

	#self.secimler = QComboBox()
	
	#self.sen = QLabel("Secimin :")
	#self.rakip = QLabel("Rakibin :")
	#self.durum = QLabel("Durum :")
	#self.secimler.addItems(self.elemanlar)
	
	grid = QGridLayout()
	grid.addWidget(self.kapat, 0, 0)
	grid.addWidget(self.tarayici, 1,0)
        self.tarayici.append(unicode("<font color=red>Taş Sunucusu Başlatıldı.</font>"))
        #grid.addWidget(self.mesaj, 1, 0)
        #grid.addWidget(self.mesajgonder, 1,1)
	#grid.addWidget(self.baglan, 0, 0)
	#grid.addWidget(self.sen, 1, 0)
	#grid.addWidget(self.rakip, 1, 1)
	#grid.addWidget(self.secimler, 2, 0)
	#grid.addWidget(self.eminim, 2, 1)
	#grid.addWidget(self.durum, 3,0)
	self.setLayout(grid)
	self.setWindowTitle(u"Taş Sunucusu")

	self.connect(self.kapat, SIGNAL("clicked()"), self.close)
   
	#self.connect(self.mesajgonder, SIGNAL("clicked()"), self.gonder)
    #def gonder(self):
	#self.tcpServer.sendReplyUi(QString(unicode(self.mesaj.text())),QString("MESAJ"))
   # def gonder(self):
	#self.tcpServer.sendReplyUi(QString(self.secimler.currentText()))

app = QApplication(sys.argv)
form = TasMakasKagitServer()
form.show()
app.exec_()
