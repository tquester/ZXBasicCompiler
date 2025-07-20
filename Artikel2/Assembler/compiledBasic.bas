10  REM *** ZAP ***
20  GOSUB 560:
     REM UDG
30  PAPER 0:
     BORDER 0:
     CLS 
40  LET hs=0
50  GOSUB 700
170  REM *** GAME LOOP ***
180  LET k= IN 57342:
     LET j= IN 31
185  IF j>16 THEN  LET j=j-16:
     GOSUB f
190  INK 0
200   LET a$=a$(32)+a$( TO 31)
202  REM PRINT AT 2,0; INK 3;a$;
203  
205   IF l >= 4 THEN  LET e$=e$(32)+e$( TO 31)
210  IF a>18 THEN  LET a=2:
     LET b=0:
     PRINT  AT 18,0; PAPER 0;,,:
     LET i= INT ( RND *7)+1:
     LET h=h+5:
     PLOT 255,3:
     DRAW  INK 2;-h,0:
     BEEP 0.05,-20.0
230  LET x=x-(k=189 OR j=2)+(k=190 OR j=1)
240  IF x<0 THEN  LET x=31
250  IF x>31 THEN  LET x=1
260  PRINT  AT a-1,b;d$;
265  IF l >= 4 THEN  LET sp=1:
     PRINT  AT 0,0; BRIGHT 1; INK 6;e$; BRIGHT 0
270  PRINT  AT a,b; INK i;a$; AT y,z;" " AND z <> x; AT y,x; INK 7;c$;
280  IF ( IN 32766=187 OR j=16) THEN  GOSUB f
290  LET z=x:
     LET a=a+0.725
300  IF p/3= INT (p/3) THEN  GOSUB 440
310  PRINT  AT pp,p1;"   " AND (p1 <> p); AT pp,p; INK 5;f$;
320  LET p1=p:
     LET p=p+iv
330  LET iv=iv+(p<2)-(p>28)
348  GOTO 180
350  REM *** SHOOT ***
360  IF a$(x+1)="\148" THEN  FOR u=1 TO 4:
     BEEP 0.002,35-u:
     NEXT u:
     LET sc=sc+5:
     LET l=l+1
365  IF e$(x+1)="\144" THEN  FOR u=1 TO 4:
     BEEP 0.02,35+u:
     NEXT u:
     LET sc=sc+20:
     LET sh=sh+1
366  IF sh=6 AND h >= 175 THEN  BEEP 0.2,25:
     PLOT 50,3:
     DRAW  INK 4;75,0:
     LET sh=0:
     LET h=120
370  PLOT x*8+4,49:
     DRAW  OVER 1; INK 4;0,125:
     DRAW  OVER 1; INK 0;0,-125
375  IF  ATTR (pp,p1+1)=0 OR  ATTR (pp,p1)=0 OR  ATTR (pp,p1+2)=0 THEN  FOR w=1 TO 2:
     LET i= INT ( RND *7)+1:
     BEEP 0.01,45-w:
     NEXT w:
     LET sc=sc+15:
     LET sh=sh+1
380  LET a$(x+1)=" "
385  LET e$(x+1)=" "
390  PRINT  AT 20,6; INK 6; BRIGHT 1; PAPER 2;sc;
400  BEEP 0.002,10
405  PRINT  INK 3; AT 0,20;"L=";l
410  IF l<6 THEN  RETURN 
420  FOR t=30 TO 40:
     BEEP 0.004,t:
     NEXT t:
     LET a=2:
     FOR c=0 TO 17:
     PRINT  AT c,0; PAPER 0;,,,,:
     NEXT c:
     BEEP 0.03,35:
     LET sc=sc+50:
     GOSUB 780
430  RETURN 
440  PLOT p1*8+12,159:
     DRAW  OVER 1; INK 2;0,-141:
     DRAW  OVER 1; INK 2;0,141
450  OUT 254,16:
     OUT 254,8
455  IF l>0 THEN  IF  ATTR (y,x)=2 THEN  FOR d=10.0 TO 20.0:
      BEEP 0.025,0-d:
     NEXT d:
     LET h=h+25:
     PLOT 255,3:
     DRAW  INK 2;-h,0
470  RETURN 
480  REM ** GAME OVER **
490  PRINT  AT 10,8; FLASH 1; INK 2;"G A M E  O V E R"\020\001
495  PRINT  AT 21,0; FLASH 1; PAPER 2; INK 0;"SHIELD"; FLASH 0
500  FOR t=1 TO 5
510  FOR o=-30.0 TO -20.0:
     BEEP 0.015,o:
     NEXT o
520  NEXT t
530  IF sc >= hs THEN  LET hs=sc
540  FOR a=1 TO 320:
     NEXT a:
     CLS :
     GOTO 50
550  REM ** UDG **
560  RESTORE 900:
     FOR g=0 TO 95
570  READ dat
580  POKE  USR "a"+g,dat
590  NEXT g
600  RETURN 
700  REM ** SCREEN SET UP **
705  PRINT  AT 5,8; INK 6;"\143\143\143\143   \143\143   \143\143\143\143                   \143  \143  \143  \143   \143                 \143   \143  \143  \143   \143                \143    \143\143\143\143  \143\143\143\143                \143     \143  \143  \143                   \143\143\143\143  \143  \143  \143 "
710  PRINT  AT 12,4; INK 2;"KEYS:
    O,P & M or KEMPSTON"; AT 14,10; FLASH 1; INK 1;"PRESS A KEY"; FLASH 0; INK 3; AT 21,8;"By Animated ALex"
715  IF  INKEY$  <> "" OR  IN 31=16 THEN  CLS :
     GOTO 718
717  GOTO 715
718  PRINT  AT 20,0; BRIGHT 1; PAPER 2;,,
720  PRINT  AT 19,0; PAPER 0; INK 2; BRIGHT 0;"\149\150\151\155\149\150\155\154\155\149\150\153\149\155\153\154\153\152\154\152\151\155\149\153\155\155\149\150\149\152\153\154";
725  FOR d=1 TO 5:
     PLOT 0,d:
     DRAW  INK 4;255,0:
     NEXT d
730  PRINT  AT 21,0; INK 4; INVERSE 1;"SHIELD"
740  REM ** VARIABLES **
750  LET iv=1:
     LET pp=1:
     LET p=7:
     LET p1=p:
     LET i=2:
     LET f=350:
     LET sc=0:
     LET y=16:
     LET x=10:
     LET z=x:
     LET a=2:
     LET b=0
760  DIM a$(32):
     DIM d$(32):
     DIM e$(32)
765  PRINT  AT 20,0; BRIGHT 1; PAPER 2; INK 6;"SCORE:
    ";sc; AT 20,15;"HI-SCORE:
    ";hs
770  LET h=10
780  LET a$=" \148   \148   \148   \148   \148   \148          " 
790  LET sh=0:
     LET ii=6:
     LET l=0
795  LET f$="\147\144\146"
800  LET c$="\145":
     LET d$=" "
805  LET e$="    \144          \144         \144      "
850  RETURN 
900  DATA 126,219,153,255,195,189,90,165
910  DATA 24,24,153,153,219,255,255,102
920  DATA 140,198,194,255,255,130,134,140
930  DATA 49,99,67,255,255,65,97,49
950  DATA 126,219,153,255,195,126,60,102
960  DATA 0,0,1,7,15,59,119,223
970  DATA 0,0,128,224,252,255,239,251
980  DATA 0,34,22,12,30,55,7,255
990  DATA 0,0,128,224,120,236,222,255
1000  DATA 60,60,102,255,211,255,153,255
1010  DATA 8,8,12,255,247,255,187,255
1020  DATA 4,4,4,132,236,254,183,255
1030  REM END OF PROGRAM
1040  RETURN 
9000  PRINT  PAPER 7; INK 0; AT 1,0;"a$=(";a$;")"
9010  PRINT  PAPER 7; INK 0;"e$=(";e$;")"
9020  PRINT  PAPER 7; INK 0;"l=";l;" h=";h;" a=";a
9500  RETURN 
9998  STOP 

