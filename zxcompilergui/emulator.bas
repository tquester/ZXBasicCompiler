1000 CLS
1010 PRINT "Miner Demo"
1020 LET playerx=10
1030 LET playery=5
1040 LET playerr=0
1050 PRINT "reading DATA"
1060 GO SUB 1660
1070 GO SUB 1240
1080 PRINT "ready TO show miner"
1090 FOR i=1 TO 4
1100 PRINT AT 1,20;"miner ";i
1110 LET oldplayerx = playerx
1120 LET oldplayery = playery
1130 LET PROCshowminer0=playerx:LET PROCshowminer1= playery:LET PROCshowminer2= playerr:LET PROCshowminer3= i:GO SUB 2190
1140 LET key = CODE inkey$
1150 PAUSE 10
1160 PRINT AT 0,0;key;"  ";
1170 LET playerx = playerx+(key = 9) - (key=8)
1180 LET playery = playery+(key = 10) - (key = 11)
1190 IF key=9 THEN LET playerr=0
1200 IF key=8 THEN LET playerr=1
1210 IF (playerx <> oldplayerx) OR (playery <> oldplayery) THEN LET PROCclearminer0=oldplayerx:LET PROCclearminer1= oldplayery:GO SUB 2230
1220 NEXT i
1230 GOTO  1090
1240 CLS
1250 LET PROCsetudg0=udgMiner:GO SUB 2070
1260 LET PROCintpoke0=23675:LET PROCintpoke1=udgMiner:GO SUB 2100
1270 PRINT "All Miners"
1280 LET PROCshowallminersi=1
1290 LET p=0
1300 IF NOT(PROCshowallminersi < 8) THEN GOTO 1360
1310 PRINT AT 2,p;"!";m$(PROCshowallminersi);
1320 PRINT AT 3,p;"!";m$(PROCshowallminersi+1);
1330 LET PROCshowallminersi = PROCshowallminersi + 2
1340 LET p = p + 3
1350 GOTO 1300
1360 LET p = 0
1370 IF NOT(PROCshowallminersi < 16) THEN GOTO 1430
1380 PRINT AT 4,p;"!";m$(PROCshowallminersi);
1390 PRINT AT 5,p;"!";m$(PROCshowallminersi+1);
1400 LET PROCshowallminersi = PROCshowallminersi + 2
1410 LET p = p + 3
1420 GOTO 1370
1430 print at 6,0
1440 LET PROCshowallminersi = 144
1450 LET p = 6
1460 LET c = 1
1470 PRINT
1480 IF NOT(PROCshowallminersi < 164) THEN GOTO 1540
1490 PRINT at p,c;PROCshowallminersi;"=";chr$(PROCshowallminersi)
1500 LET PROCshowallminersi=PROCshowallminersi+1
1510 LET p=p+1
1520 if p = 20 then LET c = 15: LET p = 6
1530 GOTO 1480
1540 print at 19,0;
1550 LET PROCsetudg0=udgFrame:GO SUB 2070
1560 LET PROCintpoke0=23675:LET PROCintpoke1=udgFrame:GO SUB 2100
1570 print "Frame udg:";
1580 let PROCshowallminersi=144
1590 IF NOT(PROCshowallminersi < 155) THEN GOTO 1630
1600 print chr$(PROCshowallminersi);
1610 LET PROCshowallminersi=PROCshowallminersi+1
1620 GOTO 1590
1630 print
1640 PAUSE 0
1650 return
1660 let udgMiner = usr "A"
1670 GO SUB 2150
1680 let udgFrame = ramtop
1690 print "udg miner = ";udgMiner
1700 print "udg Frame = ";udgFrame
1710 pause 0
1720 LET PROCreadudg0=udgMiner:LET PROCreadudg1=19:LET PROCreadudg2= 2360:GO SUB 1920
1730 LET PROCreadudg0=udgFrame:LET PROCreadudg1=10:LET PROCreadudg2= 2260:GO SUB 1920
1740 DIM m$(16,2)
1750 LET m$(1) = "\144\145"
1760 LET m$(2) = "\146\147"
1770 LET m$(3) = "\144\145"
1780 LET m$(4) = "\148\145"
1790 LET m$(5) = "\144\145"
1800 LET m$(6) = "\149\147"
1810 LET m$(7) = "\144\145"
1820 LET m$(8) = "\151\152"
1830 LET m$(9)  = "\153\145"
1840 LET m$(10) = "\154\155"
1850 LET m$(11) = "\156\145"
1860 LET m$(12) = "\157\145"
1870 LET m$(13) = "\158\145"
1880 LET m$(14) = "\159\145"
1890 LET m$(15) = "\160\161"
1900 LET m$(16) = "\162\163"
1910 return
1920 REM PROCEDURE readudg(0=adr, 1=count, 2=label)
1930 RESTORE PROCreadudg2
1940 LET PROCreadudgende=PROCreadudg0+PROCreadudg1*8
1950 IF NOT(PROCreadudg0<PROCreadudgende) THEN GOTO 2000
1960 READ PROCreadudgbyte
1970 POKE PROCreadudg0,PROCreadudgbyte
1980 LET PROCreadudg0 = PROCreadudg0+1
1990 GOTO 1950
2000 return
2010 let ramtop = peek 23730 + 256 * peek 23731
2020 print "ramtop =";ramtop
2030 return
2040 REM PROCEDURE setramtop(0=ramtop)
2050 LET PROCintpoke0=23730:LET PROCintpoke1=ramtop:GO SUB 2100
2060 return
2070 REM PROCEDURE setudg(0=udgadr)
2080 LET PROCintpoke0=23675:LET PROCintpoke1=udgadr:GO SUB 2100
2090 return
2100 REM PROCEDURE intpoke(0=adr, 1=value)
2110 LET PROCintpokeh = int(PROCintpoke1/256)
2120 LET PROCintpokel = PROCintpoke1 - 256*PROCintpokeh
2130 poke PROCintpoke0,PROCintpokel: poke PROCintpoke0+1,PROCintpokeh
2140 return
2150 GO SUB 2010
2160 LET ramtop = ramtop - 168
2170 LET PROCsetramtop0=ramtop:GO SUB 2040
2180 return
2190 REM PROCEDURE showminer(0=x, 1=y, 2=r, 3=id)
2200 LET PROCshowmineridminer=PROCshowminer3*2-1+PROCshowminer2*8
2210 PRINT AT PROCshowminer1, PROCshowminer0;m$(PROCshowmineridminer); AT PROCshowminer1+1, PROCshowminer0;m$(PROCshowmineridminer+1);
2220 return
2230 REM PROCEDURE clearminer(0=x, 1=y)
2240 PRINT AT PROCclearminer1,PROCclearminer0,"  ";AT PROCclearminer1+1,PROCclearminer0;"  ";
2250 return
2260 DATA 255, 255, 85, 170, 85, 170, 85, 170
2270 DATA 255, 195, 165, 153, 153, 165, 195, 255
2280 DATA 170, 85, 170, 85, 170, 85, 170, 85
2290 DATA 0, 0, 170, 85, 170, 85, 170, 85
2300 DATA 0, 0, 0, 0, 170, 85, 170, 85
2310 DATA 0, 0, 0, 0, 0, 0, 170, 85
2320 DATA 0, 0, 0, 0, 0, 0, 0, 0
2330 DATA 67, 167, 191, 160, 64, 0, 0, 0
2340 DATA 0, 0, 16, 16, 146, 84, 56, 56
2350 DATA 8, 20, 34, 65, 130, 68, 40, 16
2360 DATA 3, 31, 62, 26, 31, 30, 12, 30
2370 DATA 0, 0, 0, 0, 0, 0, 0, 0
2380 DATA 63, 63, 123, 125, 26, 59, 55, 59
2390 DATA 0, 0, 128, 128, 0, 0, 0, 128
2400 DATA 55, 55, 55, 59, 30, 12, 12, 14
2410 DATA 63, 63, 119, 123, 30, 59, 55, 57
2420 DATA 0, 0, 128, 128, 0, 0, 0, 128
2430 DATA 63, 127, 255, 222, 30, 59, 99, 113
2440 DATA 0, 128, 192, 192, 0, 64, 192, 128
2450 DATA 48, 62, 31, 22, 62, 30, 12, 30
2460 DATA 63, 63, 119, 111, 22, 55, 59, 119
2470 DATA 0, 0, 128, 128, 0, 0, 0, 0
2480 DATA 96, 124, 62, 44, 124, 60, 24, 60
2490 DATA 118, 118, 118, 110, 60, 24, 24, 56
2500 DATA 48, 62, 31, 22, 62, 30, 12, 30
2510 DATA 63, 63, 123, 119, 30, 55, 59, 103
2520 DATA 24, 31, 15, 11, 31, 15, 6, 15
2530 DATA 0, 0, 128, 0, 0, 0, 0, 0
2540 DATA 31, 63, 127, 111, 15, 91, 120, 49
2550 DATA 128, 192, 224, 96, 0, 128, 192, 192
2560 stop
