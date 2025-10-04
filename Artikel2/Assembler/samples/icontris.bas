#define blue 1
#define red 2
#define magenta 3
#define green 4
#define cyan 5
#define yellow 6
#define white 7
DIM t$(32)
DIM g$(11,9)
numIcons=18
call mainMenu
GOTO #ende
SUB mainMenu
    INK blue: PAPER green: CLS
    PRINT "   \INK\001\PAPER\004\133\139\131\139\131\135\139\135\135\139\139\135\133\139\131"
    PRINT "   \INK\001\PAPER\004\133\138\138\133\138\133\133\138\142\141\133\134\140"
    PRINT "   \INK\001\PAPER\004\133\142\140\142\140\141\138\133\133\138\138\134\133\140\141"
    PRINT
    PRINT "0 Start game"
    call getSingleKey
    call game
    call getSingleKey
END
SUB game
    CLS
    CALL readUDG
    CALL createTiles
    CLS
    CALL drawLevel
    DO
        CALL getSingleKey
        WHEN singleKey > 48 AND singleKey < 59
            row = singleKey-48
            icon = CODE t$(1)
            call setIcon(row, icon)
            call scrollIcons
            PRINT AT 0,0;t$;
        END
    LOOP
END
SUB createTiles
    pos=1
    FOR i = 1 TO 16
        char = RND*numIcons+144
        t$(pos)=chr$ char
        t$(pos+1) = " "
        pos = pos + 2
    NEXT i
END
PROC scrollIcons
    t$ = t$(3 TO)
    char = RND*numIcons+144
    t$(31) = chr$ char
    t$(32) = " "
END
SUB drawLevel
    CLS
    LET height=110
    LET t=160
    FOR i = 1 TO 9
        PRINT AT 3,i*3;i;
        PLOT i*3*8-4,t: DRAW 0,-height
    NEXT i
    PLOT i*3*8-4,t: DRAW 0,-height
    PLOT 0,t:DRAW 255,0
    PLOT 0,t-height:DRAW 255,0
    PRINT AT 0,0;t$;
END
SUB setIcon(row, icon)
    i=1
    x = 3*row
    WHILE i < 12
        card=CODE g$(i,row)
        IF card <> 32 THEN i=i-1: EXIT
        PRINT AT 3+i,x;chr$ icon;
        IF i > 1 THEN PRINT AT 2+i,x;" ";
        i=i+1
        PAUSE 1
    WEND
    IF i=12 THEN i=11
    g$(i,row)=chr$(icon)
    CALL checkRow(row)
END
; checks if there are 3 or more icons of the same kind in the row. We start at 12 and go backward to 1
SUB checkRow(column)
    row=11
    count=0
    start=0
    cur=0
    redraw=0
    icon=0
    WHILE row > 1
        icon=CODE g$(row,column)
        IF icon=32 THEN EXIT
        WHEN icon = cur
            count=count+1
            WHEN count > 2
                redraw=1
                WHILE start >= row
                    g$(start,column) = " "
                    start = start -1
                WEND
            END
            ELSE
            count=1
            start=row
            cur=icon
        END
        row=row-1
    WEND
    WHEN redraw
        CALL drawColumn(column)
        CALL compact(column)
        CALL drawColumn(column)
    END
END
SUB drawColumn(column)
    x = 3 * column
    FOR i = 1 TO 11
        PRINT AT i+3,x;g$(i,column);
    NEXT i
END
SUB compact(column)
    bottom=11
    t=11
    WHILE bottom > 1
        icon = CODE g$(bottom,column)
        WHEN icon = 32
            t=bottom-1
            WHILE t > 1
                topicon=CODE g$(t,column)
                IF topicon <> 32 THEN g$(bottom,column) = chr$(topicon): g$(t,column)=" ": EXIT
                t=t-1
            WEND
        END
        bottom = bottom-1
    WEND
END
// --------------------------------------------------
// Read 18 UDGs randomly from the set of 61 UDGs
// --------------------------------------------------
PROC readUDG
; In ZX Spectrum BASIC one digit variables are faster than variables with more than one letter
; Since we know what we do, the var is not used. Also prefer long lines instead of many lines
; If you are using the compiler, the variable length is not important, all variables are the same speed
;
; in more general procedurs you should use var in order to disguise the local variables, otherwise a procedure may overwrite your variables
;
; var will prefix the variables with the name of the procedure
    RANDOMIZE
;    VAR char, b, c, a, byte,i
    INK 1
; c = char
; a = adr
; b = byte
; i counts from 0..7
    figures = (#endcards-#cards)/10:
    start = INT(RND * (figures-19)):
    PRINT "Figures=";figures;" start=";start; " RESTORE=";#cards + start * 10:
    RESTORE #cards + start * 10:
    c = 144:
    a = USR "A"
    WHILE c < 165
        READ a$:
        PRINT "reading ";a$;": ";:
        i=0
        WHILE i < 8
            READ b:
            POKE a,b:
            a = a + 1:
            i = i + 1
        WEND
        PRINT chr$(c):
        c = c + 1
    WEND
END
#cards
DATA "CUBE", 31,35,69,249,137,137,138,252
DATA "BUBBLE", 24,36,66,145,129,66,36,24
DATA "LLAMA", 32,96,32,34,60,60,20,20
DATA "SQUARE", 0,126,66,66,66,66,126,0
DATA "TRIANGE", 16,16,40,40,68,68,130,254
DATA "HEART", 0,108,254,254,254,124,56,16
DATA "HOUSE", 60,126,255,0,126,78,74,122
DATA "FORK", 84,84,84,56,16,16,16,16
DATA "COFFE CUP", 36,72,0,254,133,134,132,120
DATA "HUMAN FIGURE", 24,24,0,126,24,24,36,66
DATA "HAND", 84,85,85,85,191,191,223,254
DATA "HEADSET", 60,66,129,129,195,195,195,0
DATA "EYEGLASSES", 0,0,33,66,254,170,238,0
DATA "CROSS", 56,40,238,130,238,40,40,56
DATA "ENVELOPE", 255,195,165,153,129,129,255,0
DATA "MAGNIFIER", 48,72,164,132,72,52,2,1
DATA "SUN", 145,66,24,61,188,24,66,137
DATA "SKULL", 60,126,147,147,255,254,124,84
DATA "SCISSORS", 0,2,197,38,24,38,197,2
DATA "FISH", 0,49,91,255,123,49,0,0
DATA "DUMBELL", 0,0,66,195,255,195,66,0
DATA "SWORD", 3,5,10,84,40,112,232,192
DATA "SHIELD", 254,226,226,226,226,100,40,16
DATA "ROCKING HORSE", 64,226,124,60,36,165,66,60
DATA "BRICK WALL", 187,187,0,239,239,0,187,187
DATA "SPIRAL", 128,191,161,173,165,189,129,255
DATA "CHERRY", 15,18,100,180,246,107,15,6
DATA "KEY", 120,132,132,120,32,48,32,56
DATA "PADLOCK", 56,68,68,0,124,108,108,124
DATA "HOURGLASS", 56,68,40,16,16,40,68,56
DATA "START FLAG", 106,84,106,84,106,64,64,64
DATA "TOBACCO PIPE", 80,161,2,230,236,248,112,0
DATA "ROOK", 90,126,0,60,60,60,0,126
DATA "WALKING STICK", 16,40,8,8,8,8,8,8
DATA "UMBRELLA", 0,56,124,254,16,16,80,32
DATA "MONITOR", 255,129,129,129,129,255,24,60
DATA "LIGHTNING", 8,16,32,124,8,80,96,112
DATA "CHESSBOARD", 85,170,85,170,85,170,85,170
DATA "SHIP", 16,48,52,116,246,16,255,126
DATA "GRASS", 0,1,66,36,148,84,85,85
DATA "BUSH", 33,18,148,92,57,154,92,56
DATA "TREE", 34,20,217,58,92,24,24,60
DATA "GRID", 255,170,255,170,255,170,255,170
DATA "WATER DROP", 16,16,56,56,92,124,124,56
DATA "WAVES", 6,9,144,96,0,24,36,67
DATA "COIN", 56,124,238,206,238,198,124,56
DATA "ICICLE", 255,109,109,108,104,104,32,32
DATA "PILLAR", 126,60,24,24,24,24,60,126
DATA "ARROW", 15,3,5,9,16,32,64,128
DATA "WORM", 112,168,250,137,113,49,27,14
DATA "BIRD", 0,0,66,231,189,24,36,0
DATA "ROCKET", 16,56,124,124,124,124,254,214
DATA "MAGNET", 220,222,7,3,3,7,222,220
DATA "HAMMER", 124,126,124,16,16,16,16,16
DATA "BOW", 15,58,98,68,200,144,224,128
DATA "FLOWER", 16,40,84,40,146,84,56,16
DATA "BAT", 0,0,36,126,219,129,0,0
DATA "COMET", 1,8,34,8,96,20,208,192
DATA "DOT", 0,0,0,16,0,0,0,0
DATA "CLOCK", 126,239,239,225,255,255,126,0
DATA "AXE", 28,56,61,47,23,46,64,128
DATA "NECKLACE", 10,32,129,0,66,24,60,24
DATA "HEDGEHOG", 20,42,85,122,93,254,127,36
#endcards
#include "../include/keyjoystick.bas"
#ende
RETURN
STOP
