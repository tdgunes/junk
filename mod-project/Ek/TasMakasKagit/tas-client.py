#!/usr/bin/env python
# -*- coding: utf-8 -*-
# 
# Taha Doğan Güneş
#  tas-client.py
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
import sys, time
from PyQt4.QtCore import *
from PyQt4.QtGui import *
from PyQt4.QtNetwork import *

MAC = True

try:
    from PyQt4.QtGui import qt_mac_set_native_menubar
except ImportError:
    MAC = False

IP = raw_input("İstemcinin bağlanacağı ana makinanın sadece IP'si ya da sadece makina adını giriniz:\n(Boş bırakırsanız 'localhost' olarak geçecektir.)\n(Port öntanımlı:9407(değiştirilmez)\n")
if IP == "":
    IP = "localhost"
USERNAME = raw_input("Kullanıcı Adınız:")
PORT = 9407
SIZEOF_UINT16 = 2

class Saat():
   def __init__(self):
        self.zaman = list(time.localtime())
	self.saat = self.zaman[3]
	self.dakika = self.zaman[4]
	self.saniye = self.zaman[5]
        self.tamcikti = "%s:%s:%s" % (self.saat, self.dakika, self.saniye)
   def goster(self):
        return self.tamcikti

class TasMakasKagitClient(QWidget):
      
    def __init__(self, parent = None):
	super(TasMakasKagitClient, self).__init__(parent)
	
	self.socket = QTcpSocket()
	self.nextBlockSize = 0
	self.request = None
	self.rkagit = QPixmap("./data/kagit.png")
	self.rmakas = QPixmap("./data/makas.png")
	self.rtas = QPixmap("./data/tas.png")
	self.rcarpi = QPixmap("./data/carpi.png")
	
	self.elemanlar = [ u"Taş", u"Makas", u"Kağıt"]

	self.baglan = QPushButton(u"Başlat")

	self.secimler = QComboBox()
	
        self.senresim = QLabel(u"SenResim")
	self.senresim.setPixmap(self.rcarpi)
        self.rakipresim = QLabel(u"RakipResim")
	self.rakipresim.setPixmap(self.rcarpi)

	self.sen = QLabel("Secimin:")
        self.senpuan = QLabel("Senin Puanın:")
        self.senb = 0
	self.rakip = QLabel("Rakibin:")
	self.rakippuan = QLabel("Sunucunun Puanı:")
        self.rakipb = 0

	self.durum = QLabel("Durum :")
	self.mesaj = QLabel("Mesaj: Hoş geldiniz.")
	self.rakipsecim = ""
	self.secimler.addItems(self.elemanlar)
	
	self.eminim = QPushButton(u"Eminim")
	self.eminim.setEnabled(False)
	self.secimler.setEnabled(False)
	grid = QGridLayout()
	grid.addWidget(self.baglan, 0, 0)
	grid.addWidget(self.sen, 1, 0)
        grid.addWidget(self.senresim, 2, 0 )
        grid.addWidget(self.rakipresim, 2, 1)
	grid.addWidget(self.rakip, 1, 1)
        grid.addWidget(self.senpuan, 3, 0)
        grid.addWidget(self.rakippuan, 3, 1)
	grid.addWidget(self.secimler, 4, 0)
	grid.addWidget(self.eminim, 4, 1)
	grid.addWidget(self.durum, 5,0)
	grid.addWidget(self.mesaj, 6,0)
	self.setLayout(grid)
	self.setWindowTitle(u"Taş İstemci")
	self.connect(self.baglan, SIGNAL("clicked()"), self.baslama)
        self.connect(self.socket, SIGNAL("connected()"), self.sendRequest)
        self.connect(self.socket, SIGNAL("readyRead()"), self.readResponse)
	self.connect(self.secimler, SIGNAL("currentIndexChanged(int)"), self.secimle)
        self.connect(self.socket, SIGNAL("disconnected()"),
                     self.serverHasStopped)
        self.connect(self.socket,
                     SIGNAL("error(QAbstractSocket::SocketError)"),
                     self.serverHasError)
	self.connect(self.eminim, SIGNAL("clicked()"), self.gonder)
    def baslama(self):
	self.eminim.setEnabled(True)
	self.secimler.setEnabled(True)
	a = Saat()
        msg = unicode("%s'inde %s adlı kullanıcı giriş yaptı." % (a.goster(), USERNAME))
	self.issueRequest(QString("GIRIS"), QString(msg))
        self.durum.setText("Durum: Sunucuya merhaba dendi.")
	self.baglan.setEnabled(False)
    def secimle(self):
        secim = self.secimler.currentText()
	if secim == u"Makas":
	    self.senresim.setPixmap(self.rmakas)
	elif secim == u"Taş":
	    self.senresim.setPixmap(self.rtas)
	elif secim == u"Kağıt":
	    self.senresim.setPixmap(self.rkagit)
	self.sen.setText(u"Sen: %s" % secim)
    def gonder(self):
	self.issueRequest(QString("HAMLE"), self.secimler.currentText())
        
    def issueRequest(self, action, move):
	self.request = QByteArray()
	stream = QDataStream(self.request, QIODevice.WriteOnly)
	stream.setVersion(QDataStream.Qt_4_2)
	stream.writeUInt16(0)
	stream << action << move
	stream.writeUInt16(self.request.size() - SIZEOF_UINT16)
	self.durum.setText(u"Sunucuya bağlanılıyor...")
	if self.socket.isOpen():
	    self.socket.close()
	self.socket.connectToHost(IP, PORT)
    
    def sendRequest(self):
	self.durum.setText(u"Durum: Sunucuya merhaba dendi.")
	self.nextBlockSize = 0
	self.socket.write(self.request)
	self.request = None

    def readResponse(self):
	stream = QDataStream(self.socket)
	stream.setVersion(QDataStream.Qt_4_2)
	
	while True:
	    if self.nextBlockSize == 0:
		if self.socket.bytesAvailable() < SIZEOF_UINT16:
		      break
		self.nextBlockSize = stream.readUInt16()
	    if self.socket.bytesAvailable() < self.nextBlockSize:
		break
	    action = QString()
	    move = QString()
	    stream >> action >> move
	    
	    if action == "ERROR":
		msg = QString(u"Hata: %1").arg(move)
		self.durum.setText(msg)
	    elif action == "HAMLE":
		msg = QString(u"Rakip: %1").arg(move)
                self.rakipsecim = move
		self.rakip.setText(msg)
		self.durum.setText("Rakip bir hamle yaptı.")
		self.yazdir()
	    elif action == "MESAJ":
		msg = QString(u"Mesaj: %1").arg(move)
		self.mesaj.setText(msg)
	    self.nextBlockSize = 0
    def serverHasStopped(self):
	self.durum.setText(u"Hata, Bağlantı sunucu tarafından kapatıldı.")
	self.socket.close()
    def serverHasError(self, error):
	if QString(u"%1").arg(self.socket.errorString()) == "Connection refused":
	    self.durum.setText("Hata, sunucu bulunamadı.")
	self.socket.close()
    def yazdir(self):
        makina = self.rakipsecim
        ben = self.secimler.currentText()
	print ("Makina : %s Ben : %s" % (makina, ben))
        if makina == u"Makas":
	      self.rakipresim.setPixmap(self.rmakas)
	elif makina == u"Taş":
	      self.rakipresim.setPixmap(self.rtas)
	elif makina == u"Kağıt":
	      self.rakipresim.setPixmap(self.rkagit)
	if ben == makina:
	      mesaj = "Olmadı! Bilgisayar ile aynısını seçmişsiniz."
	      QMessageBox.information(self, u"Ve sonuç!", unicode(mesaj))
	elif ben == u"Taş" and makina == u"Kağıt":
	      mesaj =  u"Bilgisayar taşını kağıdıyla güzelce sardı."
	      QMessageBox.critical(self, u"Ve sonuç!", unicode(mesaj))
              self.rakipb += 1
	elif ben == u"Taş" and makina == u"Makas":
	      mesaj =  u"Bilgisayar'ın makası, senin taşını görmesiyle, dağılması bir oldu."
	      QMessageBox.information(self, u"Ve sonuç!", unicode(mesaj))
	      self.senb += 1
	elif ben == u"Makas" and makina == u"Kağıt":
	      mesaj =  u"Bilgisayarı makasınla alt ettin."
	      QMessageBox.information(self, u"Ve sonuç!", unicode(mesaj))
	      self.senb += 1
	elif ben == u"Makas" and makina == u"Taş":
	      mesaj =  u"Bilgisayar, taşıyla makasını paramparça ediyor."
	      QMessageBox.critical(self, u"Ve sonuç!", unicode(mesaj))
	      self.rakipb += 1
	elif ben == u"Kağıt" and makina == u"Taş":
	      mesaj =  u"Bilgisayar'ın taşı, seçtiğin kağıdın içinde kayboluyor." 
	      QMessageBox.information(self, u"Ve sonuç!", unicode(mesaj))
	      self.senb += 1
	elif ben == u"Kağıt" and makina == u"Makas":
	      mesaj =  u"Bilgisayar kağıdını paramparça etti."
	      QMessageBox.critical(self, u"Ve sonuç!", unicode(mesaj))
	      self.rakipb += 1
	self.puanla()
    def puanla(self):
        self.senpuan.setText("Senin Puanın: %s" % str(self.senb))
	self.rakippuan.setText("Senin Puanın: %s" % str(self.rakipb))
    def closeEvent(self, event):
	
        reply = QMessageBox.question(self, u'Uyarı',
            u"Oyunu kapatmak istiyor musunuz ?",QMessageBox.Yes, QMessageBox.No)
        if reply == QMessageBox.Yes:
	    self.issueRequest(QString("KAPATMA"), QString("çıktı."))
	    QMessageBox.information(self, u"Görüşürüz", u"         :D        ")
            event.accept()
        else:
            event.ignore()

	print ("Kapatıldım.")

app = QApplication(sys.argv)
form = TasMakasKagitClient()
form.show()
app.exec_()