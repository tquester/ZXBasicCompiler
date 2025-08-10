go sub #loadudg
cls
let a$=chr$(16)+chr$(3)+"1"
print "a$=";a$
print chr$(144);chr$(145)
print "\144\145\016\003\146"
pause 0
return

#loadudg
restore #rockets
let adr=usr "A"
for i=0 to 23
  read b
  poke adr+i,b
next i
return

#UDG.A:UDG
DATA 255, 1, 2, 3, 4, 5, 6, 7
DATA 0, 255, 0, 0, 0, 0, 0, 0
DATA 0, 0, 255, 0, 0, 0, 0, 0
DATA 0, 0, 0, 255, 0, 0, 0, 0
DATA 0, 0, 0, 0, 255, 0, 0, 0
DATA 0, 0, 0, 0, 0, 255, 0, 0
DATA 0, 0, 0, 0, 0, 0, 255, 0
DATA 0, 0, 0, 0, 0, 0, 0, 255


#udg:rockets
data 255,129,129,129,129,129,129,255
data bin 00011000
data bin 00111100
data bin 01000010
data bin 01000010
data bin 01000010
data bin 01111110
data bin 01100110
data bin 00000000

data bin 00011000
data bin 00111100
data bin 01111110
data bin 01111110
data bin 00111000
data bin 00111000
data bin 00111000
data bin 00111000
