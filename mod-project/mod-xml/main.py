# -*- coding: utf-8 -*-
#Deneysel xml tabanlı mod'un adası
import mainxml

class Oyun:
    def __init__(self):
	self.x = 75
	self.y = 5
        self.kordinat = "3,3"
	self.harita = mainxml.olustur()
        self.basla = True
	self.komut = ""
        self.git()
        self.satiru = len(self.harita[0])
        print self.satiru
        print " |XML tabanlı Mod'un Adası| "
	while self.basla:
	      self.komut = raw_input(">>> ")
	      if self.komut[:3] == "git":
	            self.kordinat = self.komut[4:]
	            self.kordinat = self.kordinat.split(",")
	            self.x = int(self.kordinat[0])
	            self.y = int(self.kordinat[1])
                    print self.x, self.y
                    self.git()
	      elif self.komut == "ileri":
                    self.ileri()
                    self.git()
                    print self.x, self.y
              elif self.komut == "geri":
                    self.geri()
                    self.git()
                    print self.x, self.y
              elif self.komut == "sağa":
                    self.sag()
                    self.git()
                    print self.x, self.y
              elif self.komut == "sola":
                    self.sol()
                    self.git()
                    print self.x, self.y
    def ileri(self):
        self.y = self.y - 1
        self.x -= self.satiru
    def geri(self):
        self.y = self.y + 1
        self.x += self.satiru
    def sag(self):
        self.x += 1
    def sol(self):
        self.x -= 1
    def git(self):
        xk = 0
        yk = 0
        sondurum = ""
        for satir in self.harita:
              yk += 1
	      for karakter in satir:
                  xk += 1
		  if (xk == self.x and yk == self.y):
		      sondurum +="X"
                  else:
                      sondurum +=karakter
              sondurum += "\n"
        print sondurum
             
	      #for karakter in satir:
              #   xk += 1
	      #   if karakter in ["-","/","|"," \ "]:
	      #       print "!! - Gidilemeyen Kordinat\nx:%s y:%s" % (xk, yk)
	      #  elif karakter in [" "]:
		      # print "OK - Gidilebilen Kordinat\nx:%s y:%s" % (xk, yk)
	               

if __name__ == "__main__":
    Oyun()

