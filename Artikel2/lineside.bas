; ---------------------------------------
; Teste Float-Konversation
; ---------------------------------------
  	rem float xpi
   	let xpi=3.14159
   	cls
   	ink 2
   	print "PI=";pi; " my pi = ";xpi

	over 1: ink 4

; ---------------------------------------
; Teste while mit exit
; ---------------------------------------
   let i=1
   while i < 10
     print i
     if i >= 5 then exit
     let i=i+1
   wend
   let i=0

	GO SUB #setTime: 
		LET x=1: 
		LET y=21: 
		LET dx=1: 
		LET dy=1
		let i=0
; ---------------------------------------
; Zeichne 5000 Punkte
; ---------------------------------------

 while i < 15000
	PLOT x,y
	LET x=x+dx:
	LET y=y+dy
	IF x<=1 OR x>=250 THEN LET dx=0-dx
	IF y<=20 OR y>=160 THEN LET dy=0-dy
	let i=i+1:
 wend
; ---------------------------------------
; Zeit ausgeben
; ---------------------------------------

	LET ticks=PEEK 23672+PEEK 23673*256: 
		LET tsec=INT (ticks/50): 
		LET min=INT (tsec/60): 
		LET sec=tsec-min*60
	PRINT AT 21,0;ticks;" ticks ";min;":";sec;" Press a key";:
		PAUSE 0
	RETURN

; ---------------------------------------
; Zeit setzen
; ---------------------------------------

#setTime
POKE 23672,0: POKE 23673,0: POKE 23674,0: RETURN
stop
9000 Data 1,2,3
9998 stop
9999 save "lines.bas"

