10  REM Sokoban
20  REM Simon Ferre'
30  REM 
40  REM A- B- C- D- E- F- G-
50  REM 
60  BORDER 7: PAPER 7: INK 0: CLS 
70  GOSUB 1000
80  LET u$="k": LET d$="m": LET l$="z": LET r$="x": LET s$="q": LET q$="u": REM set keys
90  LET l=0: GOSUB 2000: REM level
100  PRINT  AT 19,0;"Sokoban in BASIC by Simon Ferre'"; AT 20,0;"ENTER-play, SPACE-redefine keys"
110  PRINT  AT 21,0;"(lrud)=";l$;r$;u$;d$;", restart=";s$;", undo=";q$;"."
120  GOSUB 630
130  GOSUB 500: REM game loop
140  IF k$ <>  CHR 13 AND k$ <> " " THEN  GOTO 130
150  IF k$= CHR 13 THEN  GOTO 300
160  LET k$= INKEY : IF k$ <> "" THEN  GOTO 160
170  PRINT #0; AT 1,0;"key for left?"
180  LET l$= INKEY : IF l$="" OR  CODE l$<97 THEN  GOTO 180
190  PRINT #0; AT 1,0;"key for right?"
200  LET r$= INKEY : IF r$="" OR r$=l$ OR  CODE r$<97 THEN  GOTO 200
210  PRINT #0; AT 1,0;"key for up?   "
220  LET u$= INKEY : IF u$="" OR u$=l$ OR u$=r$ OR  CODE u$<97 THEN  GOTO 220
230  PRINT #0; AT 1,0;"key for down?"
240  LET d$= INKEY : IF d$="" OR d$=l$ OR d$=r$ OR d$=u$ OR  CODE d$<97 THEN  GOTO 240
250  PRINT #0; AT 1,0;"key to restart level?"
260  LET s$= INKEY : IF s$="" OR s$=l$ OR s$=r$ OR s$=u$ OR s$=d$ THEN  GOTO 260
262  PRINT #0; AT 1,0;"key to undo move?    "
264  LET q$= INKEY : IF q$="" OR q$=l$ OR q$=r$ OR q$=u$ OR q$=d$ OR q$=s$ THEN  GOTO 264
270  PRINT #0; AT 1,0,,;
280  GOTO 110
290  PAUSE 0
300  REM main game
310  FOR l=1 TO 50
320  GOSUB 2000: IF l=0 THEN  FOR b=0 TO 7: BORDER b: NEXT b: PRINT  AT 20,1;"G A M E   O V E R ! ! ! ! ! !": PAUSE 0: GOTO 170: REM end of levels
330  PRINT  AT 0,2;"SOKOBAN Level: ";l: PRINT  AT 19,1;"Keys (UDLR)=";u$;d$;l$;r$;", UNDO=";q$;","'"Restart=";s$
335  GOSUB 630
340  REM game loop
350  GOSUB 500
355  IF k$="<" AND l>1 THEN  LET l=l-1: GOTO 320
356  IF k$=">" AND l<50 THEN  LET l=l+1: GOTO 320
358  IF k$=q$ THEN  GOSUB 430
360  IF k$ <> s$ THEN  GOTO 370: REM restart level pressed
364  PRINT #0; AT 1,3;"Restart level. Sure? (y/n)"
365  LET i$= INKEY : IF i$="y" THEN  GOTO 320
366  IF i$ <> "n" THEN  GOTO 365
367  PRINT #0; AT 1,0,,;
370  IF cont<targets THEN  GOTO 350
380  LET k$= INKEY : IF k$ <> "" THEN  GOTO 390
390  FOR n=1 TO 10: FOR b=0 TO 7: BORDER b: NEXT b: NEXT n: PRINT #0; AT 1,0;"W E L L   D O N E ! ! ! ! ! ! !"
400  LET k$= INKEY : IF k$ <> "" THEN  GOTO 400
410  PAUSE 0
420  NEXT l
425  PRINT #0; AT 1,0;"WELL DONE - ALL LEVELS COMPLETED";: PAUSE 0: GOTO 90
429  GOTO 9998
430  REM UNDO routine
435  IF moves=0 THEN  RETURN 
440  LET pull=0: LET k$=h$(moves): LET h$(moves)=" ": IF  CODE k$<97 THEN  LET pull=1: LET k$= CHR ( CODE k$+32)
441  LET o(1)=s(1): LET o(2)=s(2): LET vm=(1 AND k$=u$)+(-1 AND k$=d$): LET hm=(1 AND k$=l$)+(-1 AND k$=r$): REM reversed direction indicators
445  IF  NOT pull THEN  GOTO 489
446  LET pushes=pushes-1
450  IF m$(s(1)-vm,s(2)-hm)="" THEN  LET m$(s(1)-vm,s(2)-hm)="": LET r=s(1)-vm: LET c=s(2)-hm: GOSUB 3000: GOTO 460
451  IF m$(s(1)-vm,s(2)-hm)="" THEN  LET m$(s(1)-vm,s(2)-hm)="": LET r=s(1)-vm: LET c=s(2)-hm: GOSUB 3000: LET cont=cont-1
460  IF m$(s(1),s(2))="" THEN  LET m$(s(1),s(2))="": LET r=s(1): LET c=s(2): GOSUB 3000: GOTO 489
461  IF m$(s(1),s(2))="" THEN  LET m$(s(1),s(2))="": LET r=s(1): LET c=s(2): GOSUB 3000: LET cont=cont+1
489  LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: REM direction indicators
490  LET moves=moves-1: GOTO 605
499  RETURN 
500  REM Game Loop
510  LET k$= INKEY : IF k$ <> d$ AND k$ <> u$ AND k$ <> l$ AND k$ <> r$ THEN  RETURN 
520  LET o(1)=s(1): LET o(2)=s(2): LET o(3)=pushes: REM old player position/pushes
530  LET vm=0+(-1 AND k$=u$)+(1 AND k$=d$): LET hm=0+(-1 AND k$=l$)+(1 AND k$=r$): REM direction indicators
540  IF m$(s(1)+vm,s(2)+hm)="" THEN  LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: GOTO 600: REM walk into blank space
550  IF m$(s(1)+vm,s(2)+hm)="" THEN  LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: GOTO 600: REM walk into empty target
560  IF m$(s(1)+vm,s(2)+hm)="" THEN  IF m$(s(1)+vm+vm,s(2)+hm+hm)="" THEN  LET m$(s(1)+vm+vm,s(2)+hm+hm)=m$(s(1)+vm,s(2)+hm): LET m$(s(1)+vm,s(2)+hm)="": LET r=s(1)+vm+vm: LET c=s(2)+hm+hm: GOSUB 3000: LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: LET pushes=pushes+1: GOTO 600: REM push crate into blank space
570  IF m$(s(1)+vm,s(2)+hm)="" THEN  IF m$(s(1)+vm+vm,s(2)+hm+hm)="" THEN  LET m$(s(1)+vm+vm,s(2)+hm+hm)="": LET m$(s(1)+vm,s(2)+hm)="": LET r=s(1)+vm+vm: LET c=s(2)+hm+hm: GOSUB 3000: LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: LET pushes=pushes+1: LET cont=cont+1: GOTO 600: REM push crate into target
580  IF m$(s(1)+vm,s(2)+hm)="" THEN  IF m$(s(1)+vm+vm,s(2)+hm+hm)="" THEN  LET m$(s(1)+vm+vm,s(2)+hm+hm)="": LET m$(s(1)+vm,s(2)+hm)="": LET r=s(1)+vm+vm: LET c=s(2)+hm+hm: GOSUB 3000: LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: LET pushes=pushes+1: LET cont=cont-1: GOTO 600: REM targeted crate into blank space
590  IF m$(s(1)+vm,s(2)+hm)="" THEN  IF m$(s(1)+vm+vm,s(2)+hm+hm)="" THEN  LET m$(s(1)+vm+vm,s(2)+hm+hm)="": LET m$(s(1)+vm,s(2)+hm)="": LET r=s(1)+vm+vm: LET c=s(2)+hm+hm: GOSUB 3000: LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: LET pushes=pushes+1: GOTO 600: REM targeted crate into target
595  RETURN 
600  IF o(3) <> pushes THEN  LET k$= CHR ( CODE k$-32)
601  LET h$(moves)=k$: REM store last move made
605  IF s(1) <> o(1) OR s(2) <> o(2) THEN  LET r=o(1): LET c=o(2): GOSUB 3000: REM redraw character at old player position
610  IF m$(s(1),s(2))="" THEN  PRINT  AT s(1),s(2); INK 2; PAPER 5;""
620  IF m$(s(1),s(2))="" THEN  PRINT  AT s(1),s(2); INK 0; PAPER 2;""
630  INK 0: PAPER 7: PRINT  AT 2,21;cont; AT 5,21;moves; AT 8,21;pushes
650  RETURN 
1000  RESTORE 1010: FOR n= USR "a" TO  USR "h"-1: READ a: POKE n,a: NEXT n: RETURN 
1010  DATA 85,129,1,129,1,129,1,255,0,0,8,56,28,16,0,0,0,42,124,70,68,70,124,0,255,255,247,199,227,239,255,255,24,60,90,255,219,102,60,24,231,195,165,0,36,153,195,231,255,213,131,185,187,185,131,255
2000  REM Quick draw the level
2010  GOSUB 4000: IF s(1)=0 AND s(2)=0 THEN  LET l=0: RETURN 
2020  LET i=1: PAPER 7: INK 0: CLS : FOR r=1 TO 17: FOR c=1 TO 19: REM fast
2030  GOSUB 3000
2040  NEXT c: NEXT r: LET i=0
2050  IF m$(s(1),s(2))="" THEN  PRINT  AT s(1),s(2); INK 2; PAPER 5;""
2060  IF m$(s(1),s(2))="" THEN  PRINT  AT s(1),s(2); INK 0; PAPER 2;""
2070  INK 1: PAPER 7: REM slow
2080  PRINT  AT 1,21;"Crates 'on'"; AT 4,21;"Moves: "; AT 7,21;"Pushes:"
2090  INK 0: RETURN 
3000  REM choose ink and paper colour
3010  IF m$(r,c)="" THEN  PAPER 7: INK 0: IF i THEN  LET targets=targets+1
3020  IF m$(r,c)="" THEN  PAPER 5: INK 0
3030  IF m$(r,c)="" THEN  PAPER 5: INK 2
3040  IF m$(r,c)="" THEN  PAPER 2: INK 0: IF i THEN  LET targets=targets+1: LET cont=cont+1
3050  IF m$(r,c)="" THEN  PAPER 6: INK 1
3060  PRINT  AT r,c;m$(r,c): RETURN 
4000  REM Level data
4010  REM fast
4020  DIM o(3): DIM m$(17,19): DIM h$(5000): LET moves=0: LET pushes=0: LET targets=0: LET cont=0: REM cont=crates on targets
4030  LET b$=""
4040  IF l<0 OR l>50 THEN  STOP 
4050  RESTORE 5000+l*10
4060  FOR y=1 TO 17: LET m$(y)=b$: NEXT y: REM blank level
4070  READ index: DIM s(2): IF index=-1 THEN  RETURN 
4080  READ y,x: LET s(1)=y: LET s(2)=x: FOR n=1 TO index: READ y$: LET y= CODE y$(1)-96: LET f= CODE y$(2)-96: LET y$=y$(3 TO ): LET m$(y,f TO f+ LEN y$-1)=y$: NEXT n
4090  REM slow
4100  RETURN 
5000  DATA 26,2,2,"bb","ib","pb","cb","cf","cj","cr","db","eb","ef","fb","gb","hb","hf","hj","hr","jb","jf","kb","lb","lf","ll","mb","nb","ob","of"
5010  DATA 10,11,12,"df","ef","ff","gd","hd","ib","io","jb","kf","lf"
5020  DATA 8,8,11,"ee","fe","ge","he","ie","jj","kg","lg"
5030  DATA 9,5,16,"ek","fk","gk","hl","ik","jc","jk","kd","lc"
5040  DATA 12,13,11,"cm","dm","eb","fb","gb","hb","ib","jc","kb","lb","mb","nb"
5050  DATA 11,10,16,"dk","ek","fk","gk","hc","ic","jc","kk","lk","mm","nm"
5060  DATA 12,5,13,"ee","em","fe","fl","ge","he","ie","ij","jh","kh","lh","mh"
5070  DATA 15,5,9,"dl","ef","fe","ge","gm","hg","hm","ie","il","je","ke","kl","le","ll","me"
5080  DATA 15,7,3,"be","ce","de","ee","fe","fp","gc","hc","ic","jg","ke","le","me","ne","oe"
5090  DATA 12,12,3,"cm","dm","ei","fi","gj","hj","ih","jh","kd","lc","mh","nh"
5100  DATA 18,2,3,"bc","bh","cb","db","eb","fd","gb","hb","hl","hp","ic","jb","kb","lb","mf","nf","np","of"
5110  DATA 15,4,8,"cl","dg","dl","ee","fd","gc","hc","ic","je","ke","lb","lj","mb","nb","ob"
5120  DATA 14,7,9,"dc","ec","el","fc","gc","hc","ho","ic","jc","jg","kc","lg","mk","nk"
5130  DATA 12,7,7,"de","ed","fb","gb","hb","ib","jb","kb","lc","mc","mk","nc"
5140  DATA 20,3,11,"bi","cc","dc","ec","eg","fc","gc","gg","hc","hj","hn","ib","jb","kb","kl","lf","mh","ml","nh","oo"
5150  DATA 16,6,8,"bf","cf","df","ed","fd","gd","he","hj","id","jd","kd","lc","lh","mc","nc","oh"
5160  DATA 14,7,7,"ce","de","ee","em","fe","gg","hf","if","jf","kh","lg","mg","ng","og"
5170  DATA 14,12,5,"cg","dg","eg","fl","gf","hf","ig","ip","jd","jn","kd","ld","mg","ng"
5180  DATA 13,5,14,"dg","eg","fg","gc","gl","hb","ib","je","ke","ld","md","nd","nq"
5190  DATA 18,2,7,"bd","cf","db","eb","fb","fm","gc","hc","hk","ic","jc","kc","kg","lb","lk","mb","ne","ob"
5200  DATA 21,3,15,"bf","cb","db","dj","do","eb","fb","gb","hb","hi","ib","if","jb","jo","kb","lb","me","mj","ne","no","oe"
5210  DATA 14,6,7,"cd","dd","ee","ej","fe","gd","hd","id","jg","ke","le","me","ni","oj"
5220  DATA 21,5,11,"bb","bm","cb","db","ec","fb","fq","gb","hb","ib","jb","kb","kk","kp","lb","lj","mb","nc","nj","nr","ob"
5230  DATA 14,9,4,"cf","df","eb","fb","gb","hb","ib","jb","kb","lb","mb","nc","ni","np"
5240  DATA 19,15,4,"bb","cb","dl","eb","fc","fh","gb","hb","hq","ib","ij","iq","jd","jq","kd","lc","mc","nc","oc"
5250  DATA 22,7,17,"bb","cb","db","dm","ec","fb","fn","gb","gq","hc","hq","ib","jb","kb","kg","lb","mb","nb","ni","np","ob","op"
5260  DATA 10,12,16,"de","ee","fd","gd","hd","id","je","ke","lj","mj"
5270  DATA 12,14,11,"dc","ec","fb","gb","hj","id","jd","kc","kk","lc","mc","ni"
5280  DATA 16,10,3,"cl","dh","eg","fc","gc","gk","go","hd","ic","jc","jo","kf","lg","mg","ng","ol"
5290  DATA 14,7,12,"db","eb","fc","gc","hb","ib","ig","iq","jb","kc","lb","ln","mb","nb"
5300  DATA 18,7,6,"ci","di","eb","ej","fb","gb","hc","hg","ic","ik","iq","jc","kb","kg","lb","mb","nf","no"
5310  DATA 16,4,9,"bd","cd","dc","ec","fc","gb","hb","ib","jc","jh","jm","kc","lf","me","ne","oe"
5320  DATA 13,6,5,"ck","dg","ef","fe","gh","hf","if","jf","kf","lk","mk","nk","ok"
5330  DATA 13,12,14,"cf","df","eh","fe","ge","he","ie","je","ke","lh","me","nf","og"
5340  DATA 15,5,14,"cf","df","ef","fe","ge","hf","hj","if","jf","kf","kk","lf","mf","nh","oh"
5350  DATA 20,3,11,"bb","bo","cb","db","dj","ec","ej","fc","gc","he","hm","ib","jb","kb","lb","mb","nc","nj","oc","oj"
5360  DATA 21,8,11,"bn","cb","ci","db","eb","fd","gd","gj","gp","hd","hj","ic","ij","in","jc","jn","kc","lc","mi","nf","of"
5370  DATA 15,15,10,"cb","db","eb","eg","fb","gb","gl","hd","id","jd","kf","le","me","nf","oj"
5380  DATA 9,5,13,"el","ff","gf","hg","ig","jg","kg","lg","mg"
5390  DATA 19,4,12,"bo","cc","db","eb","fb","gb","hc","hi","hm","ic","jb","jg","jp","kb","lb","lo","mb","nb","og"
5400  DATA 14,4,17,"bg","cg","dg","eg","ff","gf","hg","if","jf","kh","lc","mc","nc","oc"
5410  DATA 16,10,18,"cm","dl","ek","fj","gi","hi","ib","il","jb","kb","kl","lb","ll","mb","no","op"
5420  DATA 13,5,17,"dg","ed","fd","gd","hb","ib","jb","kb","kh","kl","ld","md","ni"
5430  DATA 12,11,10,"ej","ff","gf","hc","ib","ig","jb","kb","kq","lb","lk","ml"
5440  DATA 19,5,10,"cc","dc","ec","fc","fm","gc","gh","hc","hi","ic","ii","jb","kb","lg","ll","ml","nl","np","ol"
5450  DATA 16,12,7,"dc","di","ec","ei","fc","gd","he","ic","jc","jm","kc","lc","mc","nc","nk","oc"
5460  DATA 16,8,14,"bd","cd","ck","dd","ed","ff","gf","hg","ig","jg","kg","lg","ln","mf","nf","of"
5470  DATA 10,9,8,"ek","fc","gb","hb","ib","jb","jj","kb","ld","md"
5480  DATA 15,14,10,"bg","cg","dg","eg","fg","gi","hi","ij","je","ke","lf","mf","nf","of","om"
5490  DATA 16,13,9,"cj","dj","ej","fj","gh","he","hn","ic","jc","kc","le","lk","lo","mh","nj","oj"
5500  DATA 19,8,3,"bh","cg","df","ee","fe","gb","hb","hk","ib","jd","kd","ld","lm","md","mm","nd","od","nn","on"
9998  STOP 

