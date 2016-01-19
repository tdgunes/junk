# -*- coding: utf-8 -*-
# Made by ookurogullari.  

import random, sys, time, os

sans = random.randint(1,10)

class Rulet:
        def __init__(self, vurulma):
                self.vurulma = vurulma
                self.baslama = True
                z = True
                self.senp = 0
                while self.baslama:
                        if z:
                                self.baslangic()
                        self.istek = raw_input('?- Artık baslayalim mi ? (e/h)\n:')
                        if self.istek in ['evet','nevet', 'e']:
                                print 'Su an ki puanin : %s' % str(self.senp)
                                self.savas()
                                yeniden = raw_input('Yeniden?')
                                if yeniden == 'nayir':
                                        print 'Korkak'
                                        sys.exit()
                                print 'Su an ki puanin : %s' % str(self.senp)
                                self.vurulma = random.randint(1,20)
                                z = False
                        elif self.istek in ['nayir','hayir', 'h']:
                                print 'Korkak!'
                                sys.exit()
        def baslangic(self):
                print "Bu oyunu oynamaya karar verdigine göre cesur olmalısın."
                time.sleep(2)
                os.system("clear")
                print "Ama cesur olmak yetmez..."
                time.sleep(2)
                os.system("clear")
                print "Iyi düsün..."
                time.sleep(2)
                os.system("clear")
                print "Hayatta bazı seylerin telafisi yoktur..."
                time.sleep(2)
                os.system("clear")
                print "Rulet de bunlardan biri..."
        def savas(self):
                a= raw_input('?- Bilgisayar yazi mi tura mi diye sordu?(Bilirsen karsi taraf baslar)\n:')
                el = random.choice(['Tura','Yazi'])
                if a == el:
                        time.sleep(2)
                        print 'Silahi gülerek bilgisayara verdin.'
                        x = self.vurulma
                        y = 0
                        while x>0:
                                time.sleep(2)
                                print '- Bilgisayar silahi eline aldı.'
                                if y == self.vurulma:
                                        time.sleep(2)
                                        print '- Bilgisayar vuruldu.'
                                        break
                                        y += 1
                                        self.senp += 1
                                else:
                                        time.sleep(2)
                                        print '- Bilgisayar bundan kurtuldu.'
                                        y += 1
                                        
                                time.sleep(2)
                                print '- Silahı eline aldın.'
                                if y == self.vurulma:
                                        time.sleep(2)
                                        print '- Vuruldun!'
                                        break
                                        y += 1
                                else:
                                        time.sleep(2)
                                        print '- Bundan kurtuldun.'
                                        y = y + 1
                                x = x - 1
                if a != el:
                        time.sleep(2)
                        print '- Bilgisayar pis bakarak silahi eline veriyor.'
                        x = self.vurulma
                        y = 0
                        while x>0:
                                time.sleep(2)
                                print '- Silahı eline aldın.'
                                time.sleep(5)
                                print '- Tetigi çektin!'
                                if y == self.vurulma:
                                        print '...'
                                        time.sleep(5)
                                        print '- Vuruldun!'
                                        break
                                        y += 1
                                else:
                                        print '...'
                                        time.sleep(2)
                                        print '- Bundan kurtuldun.'
                                        y = y + 1
                                time.sleep(2)
                                print '- Bilgisayar silahi eline aldı.'
                                if y == self.vurulma:
                                        print '...'
                                        time.sleep(5)
                                        print '- Bilgisayar vuruldu.'
                                        break
                                        y += 1
                                        self.senp += 1
                                else:
                                        print'...'
                                        time.sleep(2)
                                        print '- Bilgisayar bundan kurtuldu.'
                                        y += 1
                                x = x + 1
        

                
if __name__ == '__main__':
        Rulet(sans)
