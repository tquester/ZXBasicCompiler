CLS
PRINT "Miner Demo"
a=1
b=2
LET minerx=10
LET minery=5
PRINT "reading DATA"
GO SUB #readData
PRINT "ready TO show miner"
#forever
FOR i=1 TO 4
    PRINT AT 1,20;"miner ";i
    LET miner=i
    GO SUB #showminer
    PAUSE 10
NEXT i
GOTO  #forever
#readData
RESTORE #MINER
LET adr=USR "A"
PRINT "adr=";adr
FOR i=1 TO 72
    READ b
    POKE adr,b
	;print adr;" ";b
    LET adr = adr + 1
NEXT i
FOR i=144 TO 153
    PRINT chr$(i);
NEXT i
DIM m$(9,2)
LET m$(1) = "\144\145"
LET m$(2) = "\146\147"
LET m$(3) = "\144\145"
LET m$(4) = "\148\145"
LET m$(5) = "\144\145"
LET m$(6) = "\149\150"
LET m$(7) = "\144\145"
LET m$(8) = "\151\152"
RETURN
#showminer
LET idminer=miner*2-1
PRINT AT minery, minerx;m$(idminer); AT minery+1, minerx;m$(idminer+1);
RETURN
#UDG.A:MINER
9000 DATA 3, 31, 62, 26, 31, 30, 12, 30
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 63, 63, 123, 125, 26, 59, 55, 59
DATA 0, 0, 128, 128, 0, 0, 0, 128
DATA 55, 55, 55, 59, 30, 12, 12, 14
DATA 63, 63, 119, 123, 30, 59, 55, 57
DATA 0, 0, 128, 128, 0, 0, 0, 128
DATA 63, 127, 255, 222, 30, 59, 99, 113
DATA 0, 128, 192, 192, 0, 64, 192, 128
; -- end udg --
