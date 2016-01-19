# -*- coding: utf-8 -*-
import xml.dom.minidom

def getText(nodelist):
    rc = ""
    for node in nodelist:
        if node.nodeType == node.TEXT_NODE:
            rc = rc + node.data
    return rc

def haritayap(harita):
    son = harita.split("!")
    hata = ""
    sonliste = []
    for satir in son:
        if satir.find("'") and "b" in satir:
		try:
		    bol = satir.split("'")
		    #print "bol:", bol
		    bol2 = bol[1].split(" ")
		    #print "bol2:", bol2
		    bosluk = int(bol2[0]) * " "
		    satir = "%s%s%s" % (bol[0],bosluk,bol[2])
		except:
		    hata = "b belirtilirken bir hata oluştu."
        elif satir.find("'") and satir.find("-"):
		try:
		    bol = satir.split("'")
		    #print "bol:", bol
		    bol2 = bol[1].split(" ")
		    #print "bol2:", bol2
		    bosluk = int(bol2[0]) * "-"
		    satir = "%s%s%s" % (bol[0],bosluk,bol[2])
		except:
		    hata = "Kodlamada bir hata oluştu."
        sonliste.append(satir)
    return sonliste
    print "Hatalar\n-> %s" % hata
#sor = raw_input("Bir harita yazın(ör:traning.xml):\n")
#dosya = open(sor)
dosya = open("traningmap.xml")
oku = dosya.read()
dom = xml.dom.minidom.parseString(oku)

haritadi = dom.getElementsByTagName("ad")[0]
tanim = dom.getElementsByTagName("tanim")[0]
websayfasi= dom.getElementsByTagName("websayfasi")[0]
yapimci = dom.getElementsByTagName("yapimci")[0]
boyutx = dom.getElementsByTagName("boyutx")[0]
boyuty = dom.getElementsByTagName("boyuty")[0]
bicim = dom.getElementsByTagName("bicim")[0]

#print "Harita Adı: %s " % getText(haritadi.childNodes)
#print "Tanım: %s " % getText(tanim.childNodes)
#print "Web Sayfası: %s " % getText(websayfasi.childNodes)
#print "Yapımcı: %s " % getText(yapimci.childNodes)
#print "Boyutlar X:%s Y:%s " % (getText(boyutx.childNodes), getText(boyuty.childNodes))
#print "Bicim: %s " % getText(bicim.childNodes)
harita = getText(bicim.childNodes)
#print "Görünümü:"
def olustur():
  son = haritayap(harita)
  return son
#for x in son:
#  print x
#

