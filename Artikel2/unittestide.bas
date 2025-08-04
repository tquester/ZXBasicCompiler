rem float af bf
rem int16 ai bi
dim a$(8)
dim b$(8)

let c$="A"
let c$="B"
print c$ > d$


cls
print "Var String: compare"
let c$="A": let d$="": go sub #checkCompareVarStr
let c$="A": let d$="B": go sub #checkCompareVarStr
let c$="B": let d$="": go sub #checkCompareVarStr
pause 0
cls
print "Fix String: compare"
let a$="A": let b$="B": go sub #checkCompareFixStr
let a$="B": let b$="A": go sub #checkCompareFixStr
let a$="A": let b$="": go sub #checkCompareFixStr

pause 0
cls
print "Float: Compare"
let af=1: let bf=2:go sub #checkCompare
let af=2: let bf=1:go sub #checkCompare
let af=2: let bf=2:go sub #checkCompare
pause 0
cls
print "Int16: Compare"
let ai=1: let bi=2: go sub #checkCompareInt
let ai=2: let bi=1: go sub #checkCompareInt
let ai=1: let bi=1: go sub #checkCompareInt
pause 0
cls
print "Float: Math"
let af=10: let bf=3:go sub #checkMath
let af=20: let bf=1:go sub #checkMath
let af=2: let bf=10:go sub #checkMath
let af=20: let bf=20:go sub #checkMath
pause 0
cls
print "Int16: Math"
let ai=10: let bi=3: go sub #checkMathInt
let ai=20: let bi=1: go sub #checkMathInt
let ai=2: let bi=10: go sub #checkMathInt
let ai=10: let bi=10: go sub #checkMathInt
pause 0
cls
print "Var/Fix String: compare"
let c$="A": let b$="B": go sub #checkCompareVarFixStr
let c$="B": let b$="A": go sub #checkCompareVarFixStr
let c$="A": let b$="": go sub #checkCompareVarFixStr
pause 0

cls
print "Fix/Var String: compare"
let a$="A": let d$="B": go sub #checkCompareFixVarStr
let a$="B": let d$="A": go sub #checkCompareFixVarStr
let a$="A": let d$="": go sub #checkCompareFixVarStr
pause 0
return

#checkcompare
print "--------"
print af;"> ";bf;" -> ";af>bf
print af;">=";bf;" -> ";af>=bf
print af;"< ";bf;" -> ";af<bf
print af;"<=";bf;" -> ";af<=bf
print af;"<>";bf;" -> ";af<>bf
print af;"= ";bf;" -> ";af=bf
return

#checkMath
print "--------"
print af;"+";bf;" -> ";af+bf
print af;"-";bf;" -> ";af-bf
print af;"*";bf;" -> ";af*bf
print af;"/";bf;" -> ";af/bf
print af;"^";bf;" -> ";af^bf
return

#checkcompareInt
print "--------"
print ai ;"> ";bi;" -> ";ai >bi
print ai ;">=";bi;" -> ";ai >=bi
print ai ;"< ";bi;" -> ";ai <bi
print ai ;"<=";bi;" -> ";ai <=bi
print ai ;"<>";bi;" -> ";ai <>bi
print ai ;"= ";bi;" -> ";ai =bi
return
#checkMathInt
print "--------"
print ai;"+";bi;" -> ";ai+bi
print ai;"-";bi;" -> ";ai-bi
print ai;"*";bi;" -> ";ai*bi
print ai;"/";bi;" -> ";ai/bi
print ai;"^";bi;" -> ";ai^bi
return
#checkCompareFixStr
print a$;"> ";b$;" -> ";a$>b$
print a$;"< ";b$;" -> ";a$<b$
print a$;">=";b$;" -> ";a$>=b$
print a$;"<=";b$;" -> ";a$<=b$
print a$;"<>";b$;" -> ";a$<>b$
print a$;"= ";b$;" -> ";a$=b$
return
#checkCompareVarStr
print c$;"> ";d$;" -> ";c$>d$
print c$;"< ";d$;" -> ";c$<d$
print c$;">=";d$;" -> ";c$>=d$
print c$;"<=";d$;" -> ";c$<=d$
print c$;"<>";d$;" -> ";c$<>d$
print c$;"= ";d$;" -> ";c$=d$
return
#checkCompareVarFixStr
print c$;"> ";b$;" -> ";c$>b$
print c$;"< ";b$;" -> ";c$<b$
print c$;">=";b$;" -> ";c$>=b$
print c$;"<=";b$;" -> ";c$<=b$
print c$;"<>";b$;" -> ";c$<>b$
print c$;"= ";b$;" -> ";c$=b$
return
#checkCompareFixVarStr
print a$;"> ";d$;" -> ";a$>d$
print a$;"< ";d$;" -> ";a$<d$
print a$;">=";d$;" -> ";a$>=d$
print a$;"<=";d$;" -> ";a$<=d$
print a$;"<>";d$;" -> ";a$<>d$
print a$;"= ";d$;" -> ";a$=d$
return


stop
9998 stop
9999 save "unittest.bas"
