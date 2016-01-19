# -*- coding: utf-8 -*-
#Deneysel xml tabanlı mod'un adası
import mainxml, os, time, sys
from obtainer import *

class Oyun:
    def __init__(self):
        self.oldmap = ""
	self.x = mainxml.getx()
	self.y = mainxml.gety()
        self.kordinat = "3,3"
	self.harita = mainxml.getNormalMap()
        self.basla = True
	self.komut = ""
        self.git()
        self.satiru = len(self.harita[0])
        self.envanter = ["kimlik"]
        #print self.satiru
        print " |XML tabanlı Mod Projesi| v2 (2. Deneme)"
        self.saat = time.strftime("%H:%M:%S", time.gmtime())
        self.sonsaat = ""
        print " - Yardım"
	while self.basla:
              
	      self.komut = getch()
              print "a"
              if os.name == "nt":
                  os.system("CLS")
              elif os.name == "posix":
                  os.system("clear")
	      if self.komut in ["ileri","w"]:
                    self.ileri()
                    if self.git() == False:
                         self.geri()
                    #print self.x, self.y
              elif self.komut in ["geri","s"]:
                    self.geri()
                    if self.git() == False:
                         self.ileri()
                    #print self.x, self.y
              elif self.komut in ["sag","d"]:
                    self.sag()
                    if self.git() == False:
                         self.sol()
                    #print self.x, self.y
              elif self.komut in ["sol","a"]:
                    self.sol()
                    if self.git() == False:
                         self.sag()
                    #print self.x, self.y
              elif self.komut == "e":
                    print self.oldmap
                    print "Envaterin:"
                    for i in self.envanter:
                        print "--> " + i
              elif self.komut in ["q"]:
                    exit()
              else:
                    print self.oldmap
						
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
        gen = True #map can be generated ok"
        for satir in self.harita:
              yk += 1
	      for karakter in satir:
                  xk += 1
		  if (xk == self.x and yk == self.y):
	              if karakter in ["-","/","|","\ "]:
                          gen = False
	                 #print "!! - Gidilemeyen Kordinat\nx:%s y:%s" % (xk, yk)
                          xk -= 1
                          yk -= 1
                          
                          sondurum += "-"
		      elif karakter in ["E"]:
                          if "Anahtar" and "Kart" in self.envanter:
                              if os.name == "nt":
                                  os.system("CLS")
                              elif os.name == "posix":
                                  os.system("clear")
                              self.sonsaat = time.strftime("%H:%M:%S", time.gmtime())
                              sonsaniye = int(self.sonsaat.split(":")[0])*3600 + int(self.sonsaat.split(":")[1])*60 + int(self.sonsaat.split(":")[2])
                              ilksaniye = int(self.saat.split(":")[0])*3600+ int(self.saat.split(":")[1])*60 + int(self.saat.split(":")[2])
                              ensonsaniye = sonsaniye - ilksaniye
                              saniye = ensonsaniye - 60*(ensonsaniye/60)
                              cikti = "%s:%s" % (str(ensonsaniye/60), str(saniye))
                              print "..."
                              time.sleep(5)
                              print "- Birakildigin o yerden kurtulmayi basardin!"
                              time.sleep(3)
                              print "- Ama ciktiginiz oda daha yolun basiydi!"
                              time.sleep(3)
                              print "- Devam Edecek ..."
                              time.sleep(3)
                              print "---------------------"
                              print "- Taha Dogan Gunes  -"
                              print "- Okan Okurogullari -"
                              print "---------------------"
                              print cikti + " zamanda bitirdin!"
                              sys.exit(0)
                          else:
                              gen = False
                              xk -= 1
                              yk -= 1
                      elif karakter in ["S"]:
                          print "- Sıradan bir sandalye"
                          sondurum +="X"
						  
                      elif karakter in ["M"]:
                          print "- Masa buldun!"
                          if "Tornavida" in self.envanter:
                              print "- Buradan tornavida almistin."
                          else:
                              sor = raw_input("- Masanin altina bakmak ister misin?(e/h)\n>>> ")
                              if sor in ["e"]:
                                  print "- Tornavida buldun. Envantere eklendi." 
                                  self.envanter.append("Tornavida")
                              else:
                                  print "- Bakmayı bıraktın."
                          sondurum +="X"
						  
                      elif karakter in ["T"]:
                          print "- Tuvalettesin. Cikarken ellerini yikamayi unutma! (Lavabo yaninda!)"
                          if "Civi" in self.envanter:
                              print "- Burada pis koku disinda hicbir sey yok."
                          else:
                              if "Tornavida" in self.envanter:
                                  sor = raw_input("- Gordugum kadari ile elinde tornavida var, tuvaletin arkasini acmak ister misin ? (e/h)\n>>> ")
                                  if sor in ["e"]:
                                      raw_input("- dondur(enter'a bas)")
                                      raw_input("- dondur")
                                      raw_input("- zorla")
                                      raw_input("- zorla(az kaldi)")
                                      self.envanter.append("Civi")
                                      print "!! Orada bir civi buldun. Aferin. !!"
                          sondurum +="X"
						  
                      elif karakter in ["K"]:
                          print "Kasa buldun."
                          x = 0						  
                          while x < 4:
                              x += 1
                              sor = raw_input("- Kasanin sifresini giriniz:(sayi/kasayi dinle)\n>>> ")
                              if sor in ["198237"]:
                                  print "- Kasa acildi. Koca kasadan aptal bir kart cikti. Karti aldin."
                                  self.envanter.append("Kart")
                                  break
                              elif sor == "kasayi dinle":
                                  print "- Yeni model olsa gerek, mekanizmayi duyamadin."
                              else:
                                  print "- Yanlis sifre girdiniz! Kalan deneme sayiniz:" + str(3-x)
                          sondurum +="X"
						  
                      elif karakter in ["Y"]:
                          print "- O da ne ? Yatagin orda bir kutu var. Acmak icin tornavida ve civiye ihtiyacin olacak."
                          if "Tornavida" and "Civi" in self.envanter:
                              sor = raw_input("- Kutuyu acacak misin?(e/h)\n>>> ")
                              if sor == "e":
                                  print "- Bir kagit buldun. Ustunde 198237 yaziyor. Yanina aldin."
                                  self.envanter.append("""Uzerinde "198237" yazan bir kagit""")
                              else:
                                  print "Kagidi yerine biraktin."
                          else:
                              print "Buraya yatmaya mi geldin? Git tornavida ve civiyi bul gel!"
							  
                      elif karakter in ["L"]:
                          if "Anahtar" in self.envanter:
                              print "- Lavabonun ici bos. Anahtari almissin."
                          else:
                              print "- Lavaboda bir anahtar var!"
                              sor = raw_input("Anahtari alacak misin? (e/h)\n>>> ")
                              if sor == "e":
                                  self.envanter.append("Anahtar")
                                  print "- Anahtari aldin."
							  
	              else:
		          #print "OK - Gidilebilen Kordinat\nx:%s y:%s" % (xk, yk)
		          sondurum +="X"
                  else:
                      sondurum +=karakter
              sondurum += "\n"
        if gen:
            self.oldmap = sondurum
            print sondurum
            return True
        else:
            print self.oldmap
            return False
             
	    	               

if __name__ == "__main__":
    Oyun()

