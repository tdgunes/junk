# -*- coding: utf-8 -*-
import xml.dom.minidom

def getText(nodelist):
    rc = ""
    for node in nodelist:
        if node.nodeType == node.TEXT_NODE:
            rc = rc + node.data
    return rc

#sor = raw_input("Bir harita yazın(ör:traning.xml):\n")
#dosya = open(sor)

dosya = open("traningmap.xml")
oku = dosya.read()
dom = xml.dom.minidom.parseString(oku)

haritadi = dom.getElementsByTagName("ad")[0]
tanim = dom.getElementsByTagName("tanim")[0]
websayfasi= dom.getElementsByTagName("websayfasi")[0]
yapimci = dom.getElementsByTagName("yapimci")[0]
bicim = dom.getElementsByTagName("bicim")
basx = dom.getElementsByTagName("x")[0]
basy = dom.getElementsByTagName("y")[0]

#print "------------------------------------------------"
#print "Harita Adi: %s " % getText(haritadi.childNodes)
#print "Tanim: %s " % getText(tanim.childNodes)
#print "Web Sayfasi: %s " % getText(websayfasi.childNodes)
#print "Yapimci: %s " % getText(yapimci.childNodes)

#print "Görünümü:"
def getx():
    return int(getText(basx.childNodes))
def gety():
    return int(getText(basy.childNodes))

def getNormalMap():
    liste = []
    for i in bicim:
      
        liste.append(getText(i.childNodes))
    return liste

for i in getNormalMap():
    print i

#print "----------------------------------------------"
#for x in son:
#  print x
#

