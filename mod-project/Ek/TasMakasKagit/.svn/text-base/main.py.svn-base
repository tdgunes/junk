#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys,random

from PyQt4.QtGui import *
from PyQt4.QtCore import *

class Pencere(QDialog):
      def __init__(self, parent=None):
	  super(Pencere, self).__init__(parent)
	  #Resimler
	  self.rkagit = QPixmap("./data/kagit.png")
	  self.rmakas = QPixmap("./data/makas.png")
	  self.rtas = QPixmap("./data/tas.png")
	  self.rcarpi = QPixmap("./data/carpi.png")
	  #Elementler
	  self.elemanlar = [u"Taş",u"Makas",u"Kağıt"]
	  

	  self.secim = QComboBox()
	  self.secim.addItems(self.elemanlar)
	  
	  self.baslat = QPushButton(u"Başlamaya Hazırım!")
	  self.kapat = QPushButton(u"Kapatmak mı ?")
	  self.eminim = QPushButton(u"Ben hazırım, sen ?")
	  
	  self.sen  = QLabel(u"Sen :")
          self.rakip = QLabel(u"Bilgisayar :")
          
          self.senresim = QLabel(u"SenResim")
	  self.senresim.setPixmap(self.rcarpi)
          self.rakipresim = QLabel(u"RakipResim")
	  self.rakipresim.setPixmap(self.rcarpi)

	  grid = QGridLayout()
	  grid.addWidget(self.sen, 1, 0)
	  grid.addWidget(self.rakip, 1, 1)
          grid.addWidget(self.senresim, 2, 0)
          grid.addWidget(self.baslat, 0, 0)
          grid.addWidget(self.kapat, 0, 1)
          grid.addWidget(self.rakipresim, 2, 1)
          grid.addWidget(self.secim, 3, 0)
          grid.addWidget(self.eminim, 3, 1)
          
	  self.setLayout(grid)
	  self.logo = QIcon("./data/makas.png")
	  self.setWindowIcon(self.logo)
	  self.setWindowTitle(u"Taş Makas Kağıt!")
	  self.connect(self.kapat, SIGNAL("clicked()"), self.close)
	  self.connect(self.secim, SIGNAL("currentIndexChanged(int)"), self.secimle)
	  self.connect(self.baslat, SIGNAL("clicked()"), self.baslama)
	  self.connect(self.eminim, SIGNAL("clicked()"), self.eminimbasla)
	  self.eminim.setEnabled(False)
	  self.secim.setEnabled(False)
      def secimle(self):
	  self.eminim.setEnabled(True)
	  secim = self.secim.currentText()
	  if secim == u"Makas":
	      self.senresim.setPixmap(self.rmakas)
	  elif secim == u"Taş":
	      self.senresim.setPixmap(self.rtas)
	  elif secim == u"Kağıt":
	      self.senresim.setPixmap(self.rkagit)
	  self.sen.setText(u"Sen : %s" % secim)
      def baslama(self):
	  self.sen.setText("Sen :")
	  self.rakip.setText("Bilgisayar :")
	  self.senresim.setPixmap(self.rcarpi)
	  self.rakipresim.setPixmap(self.rcarpi)
	  self.baslat.setEnabled(True)
	  self.secim.setEnabled(True)
      def eminimbasla(self):
          while True:
		makina = random.choice(self.elemanlar)
                if makina != self.secim.currentText():
		    break
		else:
		    continue
	  ben = self.secim.currentText() 
          mesaj = ""
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

	  elif ben == u"Taş" and makina == u"Makas":
	      mesaj =  u"Bilgisayar'ın makası, senin taşını görmesiyle, dağılması bir oldu."
	      QMessageBox.information(self, u"Ve sonuç!", unicode(mesaj))
	      
	  elif ben == u"Makas" and makina == u"Kağıt":
	      mesaj =  u"Bilgisayarı makasınla alt ettin."
	      QMessageBox.information(self, u"Ve sonuç!", unicode(mesaj))

	  elif ben == u"Makas" and makina == u"Taş":
	      mesaj =  u"Bilgisayar, taşıyla makasını paramparça ediyor."
	      QMessageBox.critical(self, u"Ve sonuç!", unicode(mesaj))

	  elif ben == u"Kağıt" and makina == u"Taş":
	      mesaj =  u"Bilgisayar'ın taşı, seçtiğin kağıdın içinde kayboluyor." 
	      QMessageBox.information(self, u"Ve sonuç!", unicode(mesaj))

	  elif ben == u"Kağıt" and makina == u"Makas":
	      mesaj =  u"Bilgisayar kağıdını paramparça etti."
	      QMessageBox.critical(self, u"Ve sonuç!", unicode(mesaj))



	  self.rakip.setText(u"Bilgisayar : %s" % makina)


	  self.baslat.setEnabled(True)
	  self.secim.setEnabled(False)
	  self.eminim.setEnabled(False)

app = QApplication(sys.argv)
pencere = Pencere()
pencere.show()
app.exec_()
