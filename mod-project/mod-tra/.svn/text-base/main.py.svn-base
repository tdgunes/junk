# -*- coding: utf-8 -*-

import  os, sys, time, random
from traningmap import *
from character import *
from obtainer import *

_version = "pre0.2.0"
_help = "Yardım"
_welcomemessage = "Mod'un Adası Alpha0.2"


class OyunuCalistir():
   def __init__(self):
	self.karakter = Karakter("Semih","Avcı")
        self.keycode = True # Bunu False yaparsanız eski yazi olarak calisir
        self.keydict = {"W":"ileri","S":"geri","A":"sola","D":"sağa","B":"ben","Q":"saat","M":"harita","H":"yardim","C":"degistir","E":"çıkış"}
        self.x = 3 #Başladığı noktalar
        self.y = 6 #Başladığı noktalar
        self.komut = "" # komut
        haritaya = "%s,%s" % (str(self.x), str(self.y))
        self.harita = tramaper(haritaya)
        self.bilmesaj = "" # mesajcı
        self.snokta = "%s,%s" % (str(self.x), str(self.y))
        self.nesne = ""
        os.system("clear")
        print _welcomemessage
        while True:
            if self.keycode:
                 character = getch().upper()
                 self.komut = self.keydict.get(character,"hata")
            else:
		 self.komut = raw_input(">>> ")
            if self.komut in ["help","yardim"]:
                 self.temizle()
                 print _help
            elif self.komut in ["ileri","foward"]:
                 self.ilerigit()
                 print self.bilmesaj
            elif self.komut in ["çıkış","exit","çık","quit"]:
                 print "Kapatıldım!"
                 sys.exit()
            elif self.komut in ["geri","back"]:
                 self.gerigit()
                 print self.bilmesaj
            elif self.komut in ["sağa","right"]:
                 self.sagagit()
                 print self.bilmesaj
            elif self.komut in ["sola","left"]:
                 self.solagit()
                 print self.bilmesaj
            elif self.komut in ["ben","me"]:
                 self.temizle()
                 print "Ben %s, soyadım %s\ndüştüğüm bu adanın adı kim bilir nedir." % (self.karakter.ad, self.karakter.soyad)
            elif self.komut in ["harita","map"]:
                 self.nerdeyim()
                 print self.bilmesaj
            elif self.komut in ["saat", "clock"]:
                 self.temizle()
                 a = Saat()
                 print a.tamcikti
            elif self.komut[:8] in ["degistir"]: #changemap m22
                 self.temizle()
                 duzgunsec = self.secilenharita
                 self.secilenharita = self.komut[9:]
                 haritalar = {"m22":"1,1","m21":"15,5","m12":"13,6","m11":"3,6"}
                 basit = haritalar.get(self.secilenharita)
                 basit = basit.split(",")
                 self.x = int(basit[0])
                 self.y = int(basit[1])
                 haritaya = "%s,%s" % (str(self.x), str(self.y))
                 self.harita = tramaper(haritaya)
                 a = self.harita.showmap()
                 self.gidis()
                 print "X kordinatı:%s\nY kordinatı:%s" % (str(self.x), str(self.y))
            else:
                print "'%s' bilinmeyen bir komut!" % self.komut
   def ilerigit(self):
       self.temizle()
       self.y -= 1
       self.bilmesaj = "Bir adım ileri gittiniz."
       self.gidis()
   def gerigit(self):
       self.temizle()
       self.y += 1
       self.bilmesaj = "Bir adım geriye gittiniz."
       self.gidis()
   def sagagit(self):
       self.temizle()
       self.x += 1
       self.bilmesaj = "Bir adım sağa gittiniz."
       self.gidis()
   def solagit(self):
       self.temizle()
       self.x -= 1
       self.bilmesaj = "Bir adım sola gittinz."
       self.gidis()
   def nerdeyim(self):
       self.temizle()
       self.bilmesaj = "   | Harita |    \nX kordinatı:%s\nY kordinatı:%s" % (str(self.x), str(self.y))
       self.gidis()
   def temizle(self):
       if os.name == "nt":
            os.system("CLS")
       elif os.name == "posix":
            os.system("clear")
   def haritadekorasyon(self):
       if self.nesne == None:
             raise TypeError
       print " " + "|"*16
       x = 0
       while x<len(self.nesne):
	     print self.nesne[x]
             x = x + 1
       print  " " + "|"*16
   def gidis(self):
       try:
	     haritaya = "%s,%s" % (str(self.x), str(self.y))
	     self.harita.guncelle(haritaya)
             print self.harita.kordinatal()
             self.nesne = self.harita.showmap()
	     self.haritadekorasyon()
             self.snokta = haritaya
       except TypeError:
             self.bilmesaj = "Oraya gidemezsiniz."
             basit = self.snokta.split(",")
             self.x = int(basit[0])
             self.y = int(basit[1])
             haritaya = "%s,%s" % (str(self.x), str(self.y))
	     self.harita.guncelle(haritaya)
             self.nesne = self.harita.showmap()
	     self.haritadekorasyon()
             print self.harita.kordinatal()
if __name__ == "__main__":
  if os.name == "nt":
      os.system("pause")
  OyunuCalistir()