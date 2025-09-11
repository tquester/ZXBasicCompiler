1000 restore 2000
1010 dim b(10)
1020 dim c(10)
1030 LET PROCreadudg0=10:GO SUB 1470
1040 GO SUB 1550
1050 GO SUB 1080
1060 print "\144\145\146\147\148\149\150\151\152"
1070 pause 0
1080 REM SUB game
1090 REM ---------
1100 paper 1
1110 ink 7
1120 LET playerx=0
1130 LET playery=17
1140 cls
1150 print at playery,playerx;"\145";
1160 GO SUB 1580
1170 GO SUB 1350
1180 if playermoved then print at playeryold, playerxold;" ";at playery,playerx;"\145";
1190 LET col = rnd*32+1
1200 LET PROCshoot0=col:GO SUB 1230
1210 GOTO 1160
1220 return
1230 REM SUB shoot(0=column)
1240 REM --------------------
1250 LET i=1
1260 IF NOT(i < 11 ) THEN GOTO 1340
1270 IF NOT(b(i) = 0 ) THEN GOTO 1320
1280 print at 0,0;"bullet #";i; " ";
1290 LET b(i)=PROCshoot0
1300 LET c(i)=17
1310 return
1320 LET i=i+1
1330 GOTO 1260
1340 return
1350 REM SUB movebullets
1360 REM ----------------
1370 LET i = 1
1380 IF NOT(i < 11) THEN GOTO 1450
1390 IF NOT(b(i) <> 0 ) THEN GOTO 1430
1400 print at c(i),b(i);" ";at c(i)-1,b(i);"\144";
1410 LET c(i)=c(i)-1
1420 if c(i) = 1 then LET b(i)=0: print at c(i),b(i);" ";
1430 LET i=i+1
1440 GOTO 1380
1450 return
1460 rem graphics library
1470 REM SUB readudg(0=count)
1480 REM ---------------------
1490 LET a = USR "A"
1500 LET last=a+PROCreadudg0*8
1510 IF NOT(a < last) THEN GOTO 1540
1520 READ b:POKE a,b:LET a = a + 1
1530 GOTO 1510
1540 return
1550 REM SUB initmovement
1560 REM -----------------
1570 LET playerx = 0:LET playery = 0:LET playerxold = 0:LET playeryold = 0:LET playerfire = 0:LET playerstep=2:LET playermoved=0:LET singleKey=0:LET playerleft=0:LET playerright=31:LET playerup=0:LET playerdown=21:LET playerKeyMoveLeft = 111:LET playerKeyMoveRight = 112:LET playerKeyMoveUp = 113:LET playerKeyMoveDown = 97:LET playerKeyFire = 13:LET playerKeyFire2 = 32:LET playerInputSelect=2:LET playerWaitKeyRelease=0:LET playerWaitKeyPause=13:return
1580 REM SUB playermovement
1590 REM -------------------
1600 IF playerInputSelect > 0 AND playerInputSelect < 4 THEN GOTO 1620+10*playerInputSelect
1610 RETURN
1620 PRINT "Error"
1630 GO SUB 1780: RETURN
1640 GO SUB 1670: RETURN
1650 GO SUB 1730: RETURN
1660 return
1670 REM SUB kempstonjoystick
1680 REM ---------------------
1690 LET playerfire = 0:LET playermoved=0:LET singleKey = CODE inkey$:LET port1=IN 31:if port1=0 then return
1700 IF port1 > 15 THEN LET playerfire=1: LET port1=port1-16
1710 LET playerxold = playerx:LET playeryold = playery:LET playerx = playerx - ((port1=2 OR port1=10 OR port1=6)  AND playerx > playerleft) + ((port1=1 OR port1=5 OR port1=9) AND playerx <playerright):LET playery = playery - ((port1=8 OR port1=9 OR port1=10) AND playery > playerup ) + ((port1=4 OR port1=5 OR port1=6)  AND playery <playerdown ):LET playermoved=1
1720 return
1730 REM SUB sinclairjoystick
1740 REM ---------------------
1750 LET playerfire = 0:LET playermoved=0:LET singleKey = CODE inkey$:LET playerxold = playerx:LET playeryold = playery:LET port1 = IN 61438:if port1 = 191 then return
1760 LET p1 = INT(port1 / 2):LET playerfire = (port1 - p1*2) = 0:LET playerx = playerx - ((p1=85 OR p1=86 OR p1=87)  AND playerx > playerleft) + ((p1=89 OR p1=90 OR p1=91) AND playerx <playerright):LET playery = playery - ((p1=86 OR p1=90 OR p1=94) AND playery > playerup) + ((p1=85 OR p1=93 OR p1=89) AND playery <playerdown):IF playerxold <> playerx OR playeryold <> playery THEN LET playermoved=1
1770 return
1780 REM SUB keyboard
1790 REM -------------
1800 LET singleKey = 0
1810 LET PROCkeyboarda = CODE inkey$
1820 LET playermoved=0
1830 IF PROCkeyboarda=0 THEN RETURN
1840 LET singleKey = PROCkeyboarda
1850 LET playerxold = playerx
1860 LET playeryold = playery
1870 LET playermoved=1
1880 LET playerx = playerx + ((PROCkeyboarda=playerKeyMoveRight OR PROCkeyboarda=9) AND playerx <playerright) - ((PROCkeyboarda=playerKeyMoveLeft OR PROCkeyboarda=8) AND playerx > playerleft)
1890 LET playery = playery + ((PROCkeyboarda=playerKeyMoveDown OR PROCkeyboarda=10) AND playery <playerdown) - ((PROCkeyboarda=playerKeyMoveUp OR PROCkeyboarda=11) AND playery > playerup)
1900 IF playerxold <> playerx OR playeryold <> playery THEN LET playermoved=1
1910 IF playerWaitKeyRelease=1 THEN GO SUB 1940
1920 IF playerWaitKeyPause>0 THEN PAUSE playerWaitKeyPause
1930 return
1940 REM SUB waitkeyrelease
1950 REM -------------------
1960 LET PROCwaitkeyreleasea = CODE inkey$
1970 IF PROCwaitkeyreleasea = 0 THEN GOTO 1990
1980 GOTO 1960
1990 return
2000 DATA 16, 56, 56, 56, 56, 56, 56, 0
2010 DATA 0, 24, 24, 60, 60, 126, 255, 219
2020 DATA 0, 0, 153, 153, 153, 126, 60, 24
2030 DATA 0, 24, 24, 24, 90, 60, 24, 0
2040 DATA 24, 60, 102, 219, 255, 126, 0, 0
2050 DATA 0, 0, 0, 0, 255, 255, 255, 255
2060 DATA 0, 0, 0, 0, 239, 187, 247, 223
2070 DATA 0, 0, 0, 0, 223, 205, 185, 255
2080 DATA 0, 0, 0, 0, 171, 150, 197, 125
2090 DATA 0, 0, 0, 0, 0, 66, 40, 129
2100 DATA 0, 0, 0, 0, 0, 0, 0, 0
2110 DATA 0, 0, 0, 0, 0, 0, 0, 0
2120 DATA 0, 0, 0, 0, 0, 0, 0, 0
2130 DATA 0, 0, 0, 0, 0, 0, 0, 0
2140 stop
