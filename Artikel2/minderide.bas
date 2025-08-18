; this program shows how to animate the Miner, it is not really the miner from Manic Miner but from my chip8 game
; enter the mine.
; inside the IDE you can click on UDG Edtitor, it will automatically locate the UDGs and displays them.

CLS
PRINT "Miner Demo"
LET playerx=10
LET playery=5
LET playerr=0
PRINT "reading DATA"
CALL readData
CALL showAllMiners
call setUDG(udgMiner)
PRINT "ready TO show miner"
#forever
FOR i=1 TO 4
    PRINT AT 1,20;"miner ";i
    oldplayerx = playerx
    oldplayery = playery
    CALL showMiner(playerx, playery, playerr, i)
    key = CODE inkey$
    PAUSE 10
    PRINT AT 0,0;key;"  ";
    playerx = playerx+(key = 9) - (key=8)
    playery = playery+(key = 10) - (key = 11)
    IF key=9 THEN playerr=0
    IF key=8 THEN playerr=1
    IF (playerx <> oldplayerx) OR (playery <> oldplayery) THEN CALL clearMiner(oldplayerx, oldplayery)
NEXT i
GOTO  #forever

; --------------------------------------------------------
; Debug, shows the UDGs and the animations
; --------------------------------------------------------
PROC showAllMiners
    CLS
	var i
    call setUDG(udgMiner)
;	call intpoke(23675,udgMiner)
    PRINT "All Miners"
    VAR i
    i=1
	p=0
    WHILE i < 8
        PRINT AT 2,p;"!";m$(i);
        PRINT AT 3,p;"!";m$(i+1);
        i = i + 2
		p = p + 3
    WEND
	p = 0
    WHILE i < 16
        PRINT AT 4,p;"!";m$(i);
        PRINT AT 5,p;"!";m$(i+1);
        i = i + 2
		p = p + 3
    WEND
	print at 6,0
	
    i = 144
	p = 6
	c = 1
    PRINT
    WHILE i < 164
        PRINT at p,c;i;"=";chr$(i)
        i=i+1
		p=p+1
		if p = 20 then c = 15: p = 6

    WEND
	print at 19,0;
	call setUDG(udgFrame)
;	call intpoke(23675,udgFrame)
	print "Frame udg:";
	let i=144
	while i < 155
       print chr$(i);
	   i=i+1
    wend
	print 
    PAUSE 0
END
; --------------------------------------------------------
; reads the data from the data statments and initalizes 
; the string array
; --------------------------------------------------------
PROC readData

	let udgMiner = usr "A"
	call newUDG
	let udgFrame = ramtop

	print "udg miner = ";udgMiner
	print "udg Frame = ";udgFrame


    CALL readUDG(udgMiner,19, #MINER)
	call readUDG(udgFrame,10, #FRAME)
    DIM m$(16,2)
    LET m$(1) = "\144\145"
    LET m$(2) = "\146\147"
    LET m$(3) = "\144\145"
    LET m$(4) = "\148\145"
    LET m$(5) = "\144\145"
    LET m$(6) = "\149\147"
    LET m$(7) = "\144\145"
    LET m$(8) = "\151\152"
; left looking miner
    LET m$(9)  = "\153\145"
    LET m$(10) = "\154\155"
    LET m$(11) = "\156\145"
    LET m$(12) = "\157\145"
    LET m$(13) = "\158\145"
    LET m$(14) = "\159\145"
    LET m$(15) = "\160\161"
    LET m$(16) = "\162\163"
	print "Press any key"
	pause 0
END

; --------------------------------------------------------
; Restores to the label and reads count bytes of data
; --------------------------------------------------------

PROC readUDG(adr, count, label)
    VAR byte, ende
    RESTORE label
    LET ende=adr+count*8
    WHILE adr<ende
        READ byte
        POKE adr,byte
        adr = adr+1
    WEND
END

; --------------------------------------------------------
; RAMTop-Verwaltung, lesen und setzen. 
; --------------------------------------------------------

sub getRamtop
	let ramtop = peek 23730 + 256 * peek 23731
    print "ramtop =";ramtop
end

proc setRamtop(ramtop)
    call intpoke(23730,ramtop)
end


; --------------------------------------------------------
;  16bit Poke
; --------------------------------------------------------
sub intpoke(adr, value)
    var l,h
    h = int(value/256)
    l = value - 256*h
	;print "setRamtop h=";h; " l = ";l
    poke adr,l: poke adr+1,h
    ;print "poke ";adr;" ";l;" ";h
	;pause 0
end

; --------------------------------------------------------
; Work with more than one UDG set. For each set we reduce
; ramtop by 168 bytes (21*8). The caller must remember the address
; call newUDG: let myudg = ramtop
; Later we can switch beteen the udg sets by calling setUDG(myudg)
; the original UDG set is at USR "A", this must be called before 
; any setUDG
; --------------------------------------------------------

proc setUDG(udgadr) 
    call intpoke(23675,udgadr)
end

procedure newUDG
   call getRamtop
   ramtop = ramtop - 168		// 8*21 bytes
   call setRamtop(ramtop)
end



; --------------------------------------------------------
; shows the miner
; --------------------------------------------------------

PROC showMiner(x,y,r,id)
    VAR idminer
    LET idminer=id*2-1+r*8
    PRINT AT y, x;m$(idminer); AT y+1, x;m$(idminer+1);
END

; --------------------------------------------------------
; removes the miner
; --------------------------------------------------------

PROC clearMiner(x,y)
    PRINT AT y,x,"  ";AT y+1,x;"  ";
END
#UDG.A:FRAME
DATA 255, 255, 85, 170, 85, 170, 85, 170	// 144
DATA 255, 195, 165, 153, 153, 165, 195, 255	// 145
DATA 170, 85, 170, 85, 170, 85, 170, 85		// 146
DATA 0, 0, 170, 85, 170, 85, 170, 85		// 147
DATA 0, 0, 0, 0, 170, 85, 170, 85			// 148
DATA 0, 0, 0, 0, 0, 0, 170, 85				// 149
DATA 0, 0, 0, 0, 0, 0, 0, 0					// 150
DATA 67, 167, 191, 160, 64, 0, 0, 0			// 151
DATA 0, 0, 16, 16, 146, 84, 56, 56			// 152
DATA 8, 20, 34, 65, 130, 68, 40, 16			// 153


#UDG.A:MINER
// Miner looking right
DATA 3, 31, 62, 26, 31, 30, 12, 30			// 144
DATA 0, 0, 0, 0, 0, 0, 0, 0					// 145
DATA 63, 63, 123, 125, 26, 59, 55, 59		// 146
DATA 0, 0, 128, 128, 0, 0, 0, 128			// 147
DATA 55, 55, 55, 59, 30, 12, 12, 14			// 148
DATA 63, 63, 119, 123, 30, 59, 55, 57		// 149
DATA 0, 0, 128, 128, 0, 0, 0, 128			// 150
DATA 63, 127, 255, 222, 30, 59, 99, 113		// 151
DATA 0, 128, 192, 192, 0, 64, 192, 128		// 152
// Miner looking left
DATA 48, 62, 31, 22, 62, 30, 12, 30			// 153
DATA 63, 63, 119, 111, 22, 55, 59, 119		// 154
DATA 0, 0, 128, 128, 0, 0, 0, 0				// 155
DATA 96, 124, 62, 44, 124, 60, 24, 60		// 156
DATA 118, 118, 118, 110, 60, 24, 24, 56		// 157
DATA 48, 62, 31, 22, 62, 30, 12, 30			// 158
DATA 63, 63, 123, 119, 30, 55, 59, 103		// 159
DATA 24, 31, 15, 11, 31, 15, 6, 15			// 160
DATA 0, 0, 128, 0, 0, 0, 0, 0				// 161
DATA 31, 63, 127, 111, 15, 91, 120, 49		// 162
DATA 128, 192, 224, 96, 0, 128, 192, 192	// 163
; -- end udg --

