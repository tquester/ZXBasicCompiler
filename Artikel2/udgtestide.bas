go sub #loadudg
cls
print chr$(144)
pause 0
return

#loadudg
restore #rockets
let adr=usr "A"
for i=0 to 7
  read b
  poke adr+i,b
next i
return



#udg:rockets
data 255,129,129,129,129,129,129,255