# -*- coding: utf-8 -*-
import time
class Saat():
   def __init__(self):
        self.zaman = list(time.localtime())
	self.saat = self.zaman[3]
	self.dakika = self.zaman[4]
	self.saniye = self.zaman[5]
        self.tamcikti = "Kol saatime göre şu an saat:\nSaat:%s Dakika:%s Saniye:%s" % (self.saat, self.dakika, self.saniye)
class Karakter():
   def __init__(self,ad,soyad):
        self.ad = ad
        self.soyad = soyad