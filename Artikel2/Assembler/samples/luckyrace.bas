; Lucky Race. A dice game for two persons
; ----------------------------------------

; define the ZX Spectrum colors
#define blue 1
#define red 2
#define magenta 3
#define green 4
#define cyan 5
#define yellow 6
#define white 7
#define black 0

CALL ReadUDG				// read UDGs
do							// star the game
	CALL game				
loop						// and restart forever
GOTO #ende

; Main game Loop
; --------------
SUB game
	paper blue: ink white:
    CLS
    LET p1 = 1: LET p2 = 1: LET player = 1
    CALL drawBoard		// draw the empty board
    call updateBoard	// draw the numbers and the players
    DO
        PRINT paper blue; ink white;AT 2,8; "Payer "; player; 
	    PRINT paper blue; ink red; AT 0, 18; "P1: Field "; p1
    	PRINT paper blue; ink cyan; AT 1, 18; "P2: Field "; p2
        CALL rollDice
		PRINT ink white; paper blue; AT 3,10;"                   ";  // clear the message aerea
		print at 2,25;roll;

		; Now we have the dice in the variable roll and go step for step with player one or two
		; on each step, we re-draw the board, so we see the player moving
        WHEN player = 1
            for p = 1 to roll
				p1=p1+1
			    call updateBoard	
			next p
            CALL checkSpecialFields(p1)
			if p1 <> result then p1=result:call updateBoard			// if found a special field, re-draw
        ELSE
            for p  = 1 to roll
				p2=p2+1
			    call updateBoard	
			next p
            CALL checkSpecialFields(p2)
			if p2 <> result then p2 = result:call updateBoard	
        END
       
        // Gewinnbedingung prüfen
        IF p1 >= 28 THEN INK 2: PRINT AT 16, 0; "Spieler 1 gewinnt! ";: goto #again
        IF p2 >= 28 THEN INK 5: PRINT AT 16, 0; "Spieler 2 gewinnt! ";: goto #again
        // Spieler wechseln
        LET player = 3 - player
    LOOP
#again
	pause 0
END

; The sprite table. Note the special label. Instead of simply writing #SPRITES we prefix with UDG.A
; this tells the UDG editor, where to look for UDGs, so you can see them right in the UDG view
#UDG.A:SPRITES
DATA 24, 60, 126, 219, 255, 126, 60, 24        // 144 Spieler 1
DATA 24, 60, 126, 219, 255, 102, 60, 24        // 145 Spieler 2
DATA 60, 66, 165, 129, 165, 153, 66, 60        // 146 Glücksfeld
DATA 60, 66, 165, 129, 153, 165, 66, 60        // 147 Pechfeld
DATA 60, 90, 189, 189, 189, 189, 90, 60        // 148 Würfel-nochmal-Feld
DATA 0, 0, 24, 60, 60, 24, 0, 0                // 149 Würfelpunkt (●)
data 0,0,0,0,0,0,0

SUB ReadUDG
    restore #SPRITES
    adr = USR "A"
    FOR i=1 TO 6
        FOR b = 1 TO 8
            READ a:POKE adr,a:adr=adr+1
        NEXT b
    NEXT i

END


SUB drawDice
    ; Note the GOTO #dice+10*frame and the REM after the label.
	; frame can be 1,2,3,4,5 or 6, so we never will go to the line #dice.
    ; instead of the rem, we could write goto #dice+10*(frame-1) but this
    ; is a bit slower
    ink white: paper blue: GOTO #dice+10*frame
    #dice
    REM there is nice 0
    PRINT AT 1, 0; "\138   \133";AT 2, 0; "\138 \149 \133";AT 3, 0; "\138   \133";:    RETURN
    PRINT AT 1, 0; "\138\149  \133";AT 2, 0; "\138   \133";AT 3, 0; "\138  \149\133";:    RETURN
    PRINT AT 1, 0; "\138\149  \133";AT 2, 0; "\138 \149 \133";AT 3, 0; "\138  \149\133";:    RETURN
    PRINT AT 1, 0; "\138\149 \149\133";AT 2, 0; "\138   \133";AT 3, 0; "\138\149 \149\133";:    RETURN
    PRINT AT 1, 0; "\138\149 \149\133";AT 2, 0; "\138 \149 \133";AT 3, 0; "\138\149 \149\133";:    RETURN
    PRINT AT 1, 0; "\138\149 \149\133";AT 2, 0; "\138\149 \149\133";AT 3, 0; "\138\149 \149\133";:    RETURN
END

SUB rollDice
  // Schnelle Würfel-Animation bis Taste gedrückt wird
    LET frame =0:
    LET lastKey =0:
    PRINT AT 5, 0; "Taste=STOP":
    INK 7:
    PAPER 1:
    PRINT AT 0, 0; "\139\131\131\131\135";AT 4,0;"\142\140\140\140\141";		// draw top/bottom of the dice
    DO
        frame = frame + 1
        IF frame = 7 THEN frame=1    		   // Zeige rotierenden Würfel (komplett IN einem Aufruf)
        CALL drawDice(frame):    			   // Prüfe auf Tastendruck (nicht-blockierend)
        LET k = CODE inkey$:
        IF k <> 0 THEN LET lastKey = k:EXIT    // Kurze PAUSE für Animation
        #IF COMPILER
        PAUSE 2
        #endif
    LOOP
    roll=frame									// store the result in roll
    INK 7
    PAPER 0
END

   
SUB drawBoard
    // Zeichnet das Spielbrett

    CLS:
    PRINT AT 0, 5; "LUCKY RACE";:
    // Draw the grid. Note that most lines end with :
	// for the BASIC interpreter we want the few but long lines
    // because each new line costs time. Only after IF we can not
    // combine the lines and also not before a label
    row = 0:
    col = 0:
	x = 0:
    y = 6:
    FOR f = 1 TO 28
        INK 4: PAPER 7:
		r = y+ row*3:
        c = x+col * 4:
		print at r, c; "\139\131\131\131";:
		print at r+1, c; "\138";:
		print "  ";:
        IF f = 5 OR f = 15 OR f = 25 THEN print INK 3; "\146";:goto #drawboard1
        IF f = 8 OR f = 18 OR f = 28 THEN print INK 1; "\147";:goto #drawboard1
        IF f = 12 OR f = 22 THEN print INK 6; "\148";:goto #drawboard1
		print " ";
#drawboard1
		INK 4: PAPER 7:
	    print at r+2, c; "\142\140\140\140";:

        // Spieler oder Spezialfelder
        col=col+1: if col=7 then print at r, c+4;"\135";at r+1,c+4;"\133";at r+2,c+4;"\141";:col=0: row=row+1
        #drawBoard1
    NEXT f
END

; Update the board. In each cell we either draw the number or one or both players.

sub updateBoard
    row = 0:
    col = 0:
	x = 1:
    y = 7:
 	ink cyan:paper white:
    for f =1 TO 28:
      a$=str f: if f < 10 then a$=" "+a$
      when p1 = f or p2 = f
         a$="":
         if p1 = f then a$="\ink\002\144"
         if p2 = f then a$=a$+"\ink\000\145"
         if len(a$) = 3 then a$=a$+" "
      end
      print ink cyan;paper white; at y+row*3,x+col*4;a$;:
      col=col+1:if col=7 then col=0:row=row+1
    next f
end

; check if pos is a specal field, if yes, advance or reduce the position and return the result in the variable result
SUB checkSpecialFields(pos)
 IF pos=5 OR pos=15 OR pos=25 THEN INK 3: PRINT ink white; paper blue; AT 3,10;"Glueck! +2         ": LET pos=pos+2
 IF pos=8 OR pos=18 OR pos=28 THEN INK 1: PRINT ink white; paper blue; AT 3,10;"Pech! -3           ": LET pos=pos-3: IF pos<1 THEN LET pos=1
 IF pos=12 OR pos=22 THEN INK 6: PRINT ink white; paper blue; AT 3,10;"Nochmal wuerfeln!  "
 result = pos
END SUB

   

#ende
STOP
