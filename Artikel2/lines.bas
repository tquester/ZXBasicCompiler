
1000 GO SUB 3700: LET x=1: LET y=21: LET dx=1: LET dy=1
1005 let i=0
1010 PLOT OVER 1; INK 3;x,y
1020 LET x=x+dx
1030 LET y=y+dy
1040 IF x<=1 OR x>=250 THEN LET dx=0-dx
1050 IF y<=20 OR y>=160 THEN LET dy=0-dy
1060 let i=i+1
1075 if i < 5000 then goto 1010
1070 LET ticks=PEEK 23672+PEEK 23673*256: LET tsec=INT (ticks/50): LET min=INT (tsec/60): LET sec=tsec-min*60
1080 PRINT AT 21,0;ticks;" ticks ";min;":";sec;" Press a key";
1090 PAUSE 0
1100 RETURN
3700 POKE 23672,0: POKE 23673,0: POKE 23674,0: RETURN
