#!/usr/bin/python
#-*- coding: utf-8 -*-

#Mod'un adasının Qt sürümü
#XML ile alakası yoktur.


import sys
from PyQt4.QtCore import *
from PyQt4.QtGui import *


class Form(QDialog):
	def __init__(self, parent=None):
		super(Form, self).__init__(parent)
                self.x = 2
		self.rbosluk = QPixmap("./data/bosluk.png")
                self.rsaga = QPixmap("./data/saga.png")
		self.rsagy = QPixmap("./data/sagy.png")
		self.rsola = QPixmap("./data/sola.png")
		self.rsoly = QPixmap("./data/soly.png")
		self.rxbosluk = QPixmap("./data/xbosluk.png")
		self.rxsaga = QPixmap("./data/xsaga.png")
		self.rxsagy = QPixmap("./data/xsagy.png")
		self.rxsola = QPixmap("./data/xsola.png")
		self.rxsoly = QPixmap("./data/xsoly.png")
                self.rlogo = QPixmap("./data/modlogo.jpg")
		self.kare1 = QLabel("kare1")
                self.kare1.setPixmap(self.rsoly)
		self.kare2 = QLabel("kare2")
		self.kare2.setPixmap(self.rbosluk)
		self.kare3 = QLabel("kare3")
		self.kare3.setPixmap(self.rbosluk)
		self.kare4 = QLabel("kare4")
		self.kare4.setPixmap(self.rsagy)
		self.kare5 = QLabel("kare5")
		self.kare5.setPixmap(self.rbosluk)
		self.kare6 = QLabel("kare6")
		self.kare6.setPixmap(self.rbosluk)
		self.kare7 = QLabel("kare7")
		self.kare7.setPixmap(self.rbosluk)
		self.kare8 = QLabel("kare8")
		self.kare8.setPixmap(self.rbosluk)
		self.kare9 = QLabel("kare9")
		self.kare9.setPixmap(self.rbosluk)
		self.kare10 = QLabel("kare10")
		self.kare10.setPixmap(self.rbosluk)
		self.kare11 = QLabel("kare11")
		self.kare11.setPixmap(self.rbosluk)
		self.kare12 = QLabel("kare12")
		self.kare12.setPixmap(self.rbosluk)
		self.kare13 = QLabel("kare13")
		self.kare13.setPixmap(self.rsola)
		self.kare14 = QLabel("kare14")
		self.kare14.setPixmap(self.rbosluk)
		self.kare15 = QLabel("kare15")
		self.kare15.setPixmap(self.rbosluk)
		self.kare16 = QLabel("kare16")
		self.kare16.setPixmap(self.rsaga)
		self.ileri = QPushButton(" /\ ")
		self.geri = QPushButton(" V ")
		self.sola = QPushButton(" < ")
		self.saga = QPushButton(" > ")
		self.bilgi = QLabel(u" Ada'ya hoş geldiniz! ")
                self.bilgi2 = QLabel(u"Konum: X: %s" % self.x)
                self.bilgi3 = QLabel(u"")
                self.bilgi4 = QLabel(u"Sağlık: İyi İyi")
                self.logo = QLabel(u"Logo")
                self.logo.setPixmap(self.rlogo)
		grid = QGridLayout()
		grid.addWidget(self.kare1, 0, 0)
		grid.addWidget(self.kare2, 0, 1)
		grid.addWidget(self.kare3, 0, 2)
		grid.addWidget(self.kare4, 0, 3)
                grid.addWidget(self.logo, 0, 5)
                grid.addWidget(self.bilgi, 0, 4)
		grid.addWidget(self.kare5, 1, 0)
		grid.addWidget(self.kare6, 1, 1)
		grid.addWidget(self.kare7, 1, 2)
		grid.addWidget(self.kare8, 1, 3)
                grid.addWidget(self.bilgi2, 1, 4)
		grid.addWidget(self.kare9, 2, 0)
		grid.addWidget(self.kare10, 2, 1)
		grid.addWidget(self.kare11, 2, 2)
		grid.addWidget(self.kare12, 2, 3)
		grid.addWidget(self.bilgi4, 2, 4)
		grid.addWidget(self.kare13, 3, 0)
		grid.addWidget(self.kare14, 3, 1)
		grid.addWidget(self.kare15, 3, 2)
		grid.addWidget(self.kare16, 3, 3)
                grid.addWidget(self.ileri, 4, 0)
                grid.addWidget(self.geri, 4, 1)
                grid.addWidget(self.sola, 4, 2)
                grid.addWidget(self.saga, 4, 3)
                grid.addWidget(self.bilgi3, 4, 4)
		self.setLayout(grid)
		self.icon = QIcon("./data/modlogo.jpg")
		self.setWindowIcon(self.icon)
		self.setWindowTitle(u"MOD'un Adası")
                self.guncelle()
                self.connect(self.ileri, SIGNAL("clicked()"), self.ilerle)
                self.connect(self.geri, SIGNAL("clicked()"), self.gerile)
                self.connect(self.sola, SIGNAL("clicked()"), self.solla)
                self.connect(self.saga, SIGNAL("clicked()"), self.sagla)

	def gerile(self):
                try:
		    self.x += 4
		    self.guncelle()
		    self.bilgi3.setText(u"Geri gittiniz.")
		    self.bilgi2.setText(u"Konum: X: %s" % self.x)
		except AttributeError:
		    self.bilgi3.setText(u"Denizde yüzmek mi ?")
		    self.x -= 4
                    self.guncelle()
        def sagla(self):
                try:
		    if self.x in [4,8,12,16]:
			self.x += 1
			raise AttributeError
		    else:
			self.x += 1
			self.guncelle()
			self.bilgi3.setText(u"Sağa gittiniz.")
			self.bilgi2.setText(u"Konum: X: %s" % self.x)
		except AttributeError:
		    self.bilgi3.setText(u"Denizde yüzmek mi ?")
	            self.x -= 1
		    self.guncelle()
	def solla(self):
                try:
                    if self.x in [1,5,9,13]:
                        self.x -= 1
			raise AttributeError
		    else:
			self.x -= 1
			self.guncelle()
			self.bilgi3.setText(u"Sola gittiniz.")
			self.bilgi2.setText(u"Konum: X: %s" % self.x)
		except AttributeError:
		    self.bilgi3.setText(u"Denizde yüzmek mi ?")
                    self.x += 1
		    self.guncelle()
	def ilerle(self):
		try:
		    self.x -= 4
		    self.guncelle()
		    self.bilgi3.setText(u"İleri gittiniz.")
		    self.bilgi2.setText(u"Konum: X: %s" % self.x)
                except AttributeError:
		    self.bilgi3.setText(u"Denizde yüzmek mi ?")
                    self.x += 4
		    self.guncelle()
	def guncelle(self):
                self.kare1.setPixmap(self.rsoly)
		self.kare2.setPixmap(self.rbosluk)
		self.kare3.setPixmap(self.rbosluk)
		self.kare4.setPixmap(self.rsagy)
		self.kare5.setPixmap(self.rbosluk)
		self.kare6.setPixmap(self.rbosluk)
		self.kare7.setPixmap(self.rbosluk)
		self.kare8.setPixmap(self.rbosluk)
		self.kare9.setPixmap(self.rbosluk)
		self.kare10.setPixmap(self.rbosluk)
		self.kare11.setPixmap(self.rbosluk)
		self.kare12.setPixmap(self.rbosluk)
		self.kare13.setPixmap(self.rsola)
		self.kare14.setPixmap(self.rbosluk)
		self.kare15.setPixmap(self.rbosluk)
		self.kare16.setPixmap(self.rsaga)
		koseresima = {self.kare1:self.rsoly, self.kare4: self.rsagy, self.kare13:self.rsola, self.kare16:self.rsaga}
		bosluklar = {"2":self.kare2,"3":self.kare3,"5":self.kare5, "6":self.kare6, "7":self.kare7, "8":self.kare8, 
		"9":self.kare9, "10":self.kare10, "11":self.kare11, "12":self.kare12, "14":self.kare14, "15":self.kare15}

		resim = bosluklar.get(str(self.x))

                if resim == None:
		    koseler = {"1":self.kare1, "4":self.kare4, "13":self.kare13, "16":self.kare16}
                    resim = koseler.get(str(self.x))

                    koseresimb = {self.kare1:self.rxsoly, self.kare4: self.rxsagy, self.kare13: self.rxsola, self.kare16: self.rxsaga}

                    eklenecek = koseresimb.get(resim)

		    resim.setPixmap(eklenecek)

                else:
		    resim.setPixmap(self.rxbosluk)

	      

app = QApplication(sys.argv)
form = Form()
form.show()
app.exec_()
