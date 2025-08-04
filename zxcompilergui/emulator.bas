1000 rem float af bc
1010 rem int16 ai bi
1020 dim a$(8)
1030 dim b$(8)
1040 cls
1050 print "Float: Compare"
1060 let af=1: let bf=2:go sub 1360
1070 let af=2: let bf=1:go sub 1360
1080 let af=2: let bf=2:go sub 1360
1090 pause 0
1100 cls
1110 print "Int16: Compare"
1120 let ai=1: let bi=2: go sub 1510
1130 let ai=2: let bi=1: go sub 1510
1140 let ai=1: let bi=1: go sub 1510
1150 pause 0
1160 cls
1170 print "Float: Math"
1180 let af=10: let bf=3:go sub 1440
1190 let af=20: let bf=1:go sub 1440
1200 let af=2: let bf=10:go sub 1440
1210 let af=20: let bf=20:go sub 1440
1220 pause 0
1230 cls
1240 print "Int16: Math"
1250 let ai=10: let bi=3: go sub 1590
1260 let ai=20: let bi=1: go sub 1590
1270 let ai=2: let bi=10: go sub 1590
1280 let ai=10: let bi=10: go sub 1590
1290 pause 0
1300 cls
1310 print "Fix String: compare"
1320 let a$="A": let b$="B": go sub 1660
1330 let a$="B": let b$="A": go sub 1660
1340 let a$="A": let b$="": go sub 1660
1350 return
1360 print "--------"
1370 print af;"> ";bf;" -> ";af>bf
1380 print af;">=";bf;" -> ";af>=bf
1390 print af;"< ";bf;" -> ";af<bf
1400 print af;"<=";bf;" -> ";af<=bf
1410 print af;"<>";bf;" -> ";af<>bf
1420 print af;"= ";bf;" -> ";af=bf
1430 return
1440 print "--------"
1450 print af;"+";bf;" -> ";af+bf
1460 print af;"-";bf;" -> ";af-bf
1470 print af;"*";bf;" -> ";af*bf
1480 print af;"/";bf;" -> ";af/bf
1490 print af;"^";bf;" -> ";af^bf
1500 return
1510 print "--------"
1520 print ai ;"> ";bi;" -> ";ai >bi
1530 print ai ;">=";bi;" -> ";ai >=bi
1540 print ai ;"< ";bi;" -> ";ai <bi
1550 print ai ;"<=";bi;" -> ";ai <=bi
1560 print ai ;"<>";bi;" -> ";ai <>bi
1570 print ai ;"= ";bi;" -> ";ai =bi
1580 return
1590 print "--------"
1600 print ai;"+";bi;" -> ";ai+bi
1610 print ai;"-";bi;" -> ";ai-bi
1620 print ai;"*";bi;" -> ";ai*bi
1630 print ai;"/";bi;" -> ";ai/bi
1640 print ai;"^";bi;" -> ";ai^bi
1650 return
1660 print a$;"> ";b$;" -> ";a$>b$
1670 print a$;"< ";b$;" -> ";a$<b$
1680 print a$;">=";b$;" -> ";a$>=b$
1690 print a$;"<=";b$;" -> ";a$<=b$
1700 print a$;"<>";b$;" -> ";a$<>b$
1710 print a$;"= ";b$;" -> ";a$=b$
1720 return
1730 stop
9998 stop
