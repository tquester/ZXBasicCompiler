; -----------------------------------------------------------------------------------------------
; Player movement library
; simply call keyboard or call joystick to move the player
; -----------------------------------------------------------------------------------------------
#define USEKEMPSTON 2
#define USEKEYBOARD 1
#define USESINCLAIR 3
;CALL initMovement
;CALL test
PROC test
    count=0
    ;call portTest
    DO
        x1=playerx:
        y1=playery:
        PRINT AT playery,playerx;"X";
        REPEAT
            CALL playerMovement:
            IF singleKey = CODE "k" THEN CLS:CALL defineKeys
            count=count+1:
            PRINT AT 0,20;count;" ";:
        UNTIL playermoved=1
        PRINT AT playeryold,playerxold;" ";
    LOOP
END
PROC initMovement
    LET playerx = 0:				// x coordinate of the player
    LET playery = 0:				// y coordinate of the player
    LET playerxold = 0:				// previous x coordinate of the player
    LET playeryold = 0:				// previous y coordinate of the player
    LET playerfire = 0:				// fire status of player (0, 1 OR 2)
    LET playerstep=2:				// The amount of steps TO MOVE
    LET playermoved=0:				// 1 IF coordinates have changed
    LET singleKey=0:				// the last key pressed
// data to be set. Excample for PRINT AT (x=0..31, y=0..21)
    LET playerleft=0:				// leftmost coordinate of player
    LET playerright=31:				// rightmost coordinate of player
    LET playerup=0:					// upper most coordinate of player
    LET playerdown=21:				// lower most coordnate of player
    LET playerKeyMoveLeft = 111:	// o
    LET playerKeyMoveRight = 112:	// p
    LET playerKeyMoveUp = 113:		// q
    LET playerKeyMoveDown = 97:		// a
    LET playerKeyFire = 13:			// Enter
    LET playerKeyFire2 = 32:		// Space
    LET playerInputSelect=2:			// 1 = Keyboard, 2 = Kempston, 3 = Sinclair
; because in compiled programs, everything is faster, we need to have either a pause or wait for the key
; to be released. If the game needs precision, such as chess where we only move from one field to the next
; we can wait for key relese. In a jump and rum game a pause is better.
    LET playerWaitKeyRelease=0:		// wait FOR key relase
    LET playerWaitKeyPause=13:		// wait FOR key relase
END
PROC portTest
    DO
        PRINT AT 0,0;"IN FEFE 65278=";IN 65278;"   "
        PRINT "IN FDFE 65022=";IN 65022;"   "
        PRINT "IN FBFE 64510=";IN 64510;"   "
        PRINT "IN F7FE 63486=";IN 63486;"   "
        PRINT "IN EFFE 61438=";IN 61438;"   "
        PRINT "IN BFFE 49150=";IN 49150;"   "
        PRINT "IN 7FFE 32766=";IN 32766;"   "
        port1 = IN 61438
        p1 = INT(port1 / 2)
        playerKeyFire = (port1 - p1*2) = 0
        PRINT "fire=";playerKeyFire;" "
        PRINT "p1=";p1;"  "
    LOOP
END
PROC playerMovement
	if playerInputSelect = 1 then call keyboard
	if playerInputSelect = 2 then call kempstonJoystick
	if playerInputSelect = 3 then call sinclairJoystick

END
PROC kempstonJoystick
    playerfire = 0:
    playermoved=0:
    singleKey = CODE inkey$:
    port1=IN 31:
    IF port1=0 THEN RETURN
    IF port1 > 15 THEN playerfire=1: port1=port1-16
    playerxold = playerx:
    playeryold = playery:
    playerx = playerx - ((port1=2 OR port1=10 OR port1=6)  AND playerx > playerleft) + ((port1=1 OR port1=5 OR port1=9) AND playerx <playerright):
    playery = playery - ((port1=8 OR port1=9 OR port1=10) AND playery > playerup ) + ((port1=4 OR port1=5 OR port1=6)  AND playery <playerdown ):
    playermoved=1
END
PROC sinclairJoystick
    playerfire = 0:
    playermoved=0:
    singleKey = CODE inkey$:
    playerxold = playerx:
    playeryold = playery:
    port1 = IN 61438:
    IF port1 = 191 THEN RETURN
    p1 = INT(port1 / 2):
    playerfire = (port1 - p1*2) = 0:
    playerx = playerx - ((p1=85 OR p1=86 OR p1=87)  AND playerx > playerleft) + ((p1=89 OR p1=90 OR p1=91) AND playerx <playerright):
    playery = playery - ((p1=86 OR p1=90 OR p1=94) AND playery > playerup) + ((p1=85 OR p1=93 OR p1=89) AND playery <playerdown):
    IF playerxold <> playerx OR playeryold <> playery THEN playermoved=1
END
PROC keyboard
;    VAR a
    
    singleKey = CODE inkey$:
    IF singleKey=0 THEN playermoved=0:playerfire=0:RETURN
    playerxold = playerx:
    playeryold = playery:
    playermoved=1:
	a=singleKey
    playerfire=a=13:
    LET playerx = playerx + ((a=playerKeyMoveRight OR a=9) AND playerx <playerright) - ((a=playerKeyMoveLeft OR a=8) AND playerx > playerleft):
    LET playery = playery + ((a=playerKeyMoveDown OR a=10) AND playery <playerdown) - ((a=playerKeyMoveUp OR a=11) AND playery > playerup)
    IF playerxold <> playerx OR playeryold <> playery THEN playermoved=1
    IF playerWaitKeyRelease=1 THEN CALL waitKeyRelease
    IF playerWaitKeyPause>0 THEN PAUSE playerWaitKeyPause
END
PROC getSingleKey
    VAR a
    REPEAT
        singleKey = CODE inkey$
    UNTIL singleKey <> 0
    REPEAT
        a = CODE inkey$
    UNTIL a = 0
END
PROC defineKeys
    PRINT "Press Key FOR left ";:
    CALL getSingleKey:
    PRINT chr$(singleKey):
    playerKeyMoveLeft = singleKey
    PRINT "Press Key FOR right ";:
    CALL getSingleKey:
    PRINT chr$(singleKey):
    playerKeyMoveRight = singleKey
    PRINT "Press Key FOR up ";:
    CALL getSingleKey:
    PRINT chr$(singleKey):
    playerKeyMoveUp = singleKey
    PRINT "Press Key FOR down ";:
    CALL getSingleKey:
    PRINT chr$(singleKey):
    playerKeyMoveDown = singleKey
    PRINT "Press Key FOR fire ";:
    CALL getSingleKey:
    PRINT chr$(singleKey):
    playerKeyFire = singleKey
END
PROC waitKeyRelease
    VAR a
    DO
        a = CODE inkey$
        IF a = 0 THEN EXIT
    LOOP
END
