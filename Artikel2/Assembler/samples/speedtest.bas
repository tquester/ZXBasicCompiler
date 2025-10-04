#define display 16358
#define attributes 22528
cls
call psycho
GOTO #ende
; draw a box in attributes
SUB psycho
    rounds=10
#ifdef COMPILER
    rounds=200
#endif
    print at 0,15;"psychodelic";
    color=0
    FOR k=1 TO rounds
	print at 0,0;k
        FOR j=1 TO 11
            CALL box(color*8,j)
            color=color+1
            IF color=9 THEN color=0
        NEXT j
    NEXT k
END
SUB box(atr, ofs)
    adr = attributes+ofs*32
    temp=adr
    FOR i = ofs TO 32-ofs
        POKE adr+i,atr
    NEXT i
    adr=adr+32
    FOR i=1 TO 23-ofs*2
        POKE adr+ofs,atr
        POKE adr+32-ofs,atr
        adr=adr+32
    NEXT i
    FOR i = ofs TO 32-ofs
        POKE adr+i,atr
    NEXT i
END
#ende
