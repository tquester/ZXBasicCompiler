#define blau 1
#define rot 2
CLS
PRINT "Blau=";blau;" rot=";rot
PAUSE 0
CALL initMovement
 ;call test
CALL readudg
CLS
GO SUB #Level1
PAUSE 0
CLS
GO SUB #Level2
PAUSE 0
GOTO #ende
#include "C:\workspaces\basic\keyjoystick.bas"
#TILESET:Level1
PRINT "\INK\000\PAPER\006                               "
PRINT "\INK\000\PAPER\006                     \151         "
PRINT "\INK\000\PAPER\006                     \144\144\144\144      "
PRINT "\INK\000\PAPER\006                          \144\144   "
PRINT "\INK\000\PAPER\006    \151                   \144\144 \146\INK\006 \INK\000  "
PRINT "\INK\000\PAPER\006  \144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144   \146   "
PRINT "\INK\000\PAPER\006              \154            \146\146\146 "
PRINT "\INK\000\PAPER\006              \154               \146\014"
PRINT "\INK\000\PAPER\006              \154              \146 "
PRINT "\INK\000\PAPER\006              \154             \146  "
PRINT "\INK\000\PAPER\006              \154            \146   "
PRINT "\INK\000\PAPER\006      \143\143\146\143\143\143\143\143\143\146\146\146\144\144\144\144\144\144\144\144\144    "
PRINT " \INK\000\PAPER\006      \154                \154      "
PRINT "\INK\000\PAPER\006       \154                \154      "
PRINT "\INK\000\PAPER\006       \154                \154      "
PRINT "\INK\000\PAPER\006       \154                \154      "
PRINT "\INK\000\PAPER\006       \154                \154      "
PRINT "\INK\000\PAPER\006 \143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143\143 "
PRINT "\INK\000\PAPER\006                               "
PRINT "\INK\000\PAPER\006                               "
PRINT "\INK\000\PAPER\006                               "                               "
#END
RETURN
#TILESET:Level2
PRINT "\INK\007\PAPER\001                                "
PRINT "\INK\007\PAPER\001                  \151             "
PRINT "\INK\007\PAPER\001                                "
PRINT "\INK\007\PAPER\001                  \143\143\143\143\143\143\154       "
PRINT "\INK\007\PAPER\001                        \154       "
PRINT "\INK\007\PAPER\001              \144\144\144\144      \154       "
PRINT "\INK\007\PAPER\001                        \154       "
PRINT "\INK\007\PAPER\001         \145\145\145\145\145          \143\143\143\154\143\143\143\INK\003\PAPER\005\014"
PRINT "\INK\007\PAPER\001\145\145\145\145\145\154\145\145\145                  \154    "
PRINT "\INK\007\PAPER\001     \154                     \154    "
PRINT "\INK\007\PAPER\001     \154                     \154    "
PRINT "\INK\007\PAPER\001     \154                     \154    "
PRINT "\INK\007\PAPER\001     \154                     \154    "
PRINT "\INK\007\PAPER\001     \154       \152             \154    "
PRINT "\INK\007\PAPER\001\144\144\144\147\147\144\INK\003\PAPER\005\146\INK\007\PAPER\001\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\INK\003\PAPER\005\014"
PRINT "\INK\007\PAPER\001                                "
PRINT "\INK\007\PAPER\001  \INK\003\PAPER\004\139\131\131\131\131\131\135\INK\007\PAPER\001                       "
PRINT "\INK\007\PAPER\001  \INK\003\PAPER\005\142\140\140\140\140\140\141\INK\007\PAPER\001                       "
PRINT "\INK\007\PAPER\001                                "
PRINT "\INK\007\PAPER\001                                "
PRINT "\INK\007\PAPER\001                                "
PRINT "\INK\007\PAPER\001                                "
#END
RETURN
PAUSE 0
PROC readUDG
    RESTORE #FRAME
    REM float adr
    adr =  USR "A"
    ende = adr + 8 * 13
    WHILE adr < ende
        READ byte
        POKE adr,byte
        adr = adr + 1
    WEND
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
DATA 66, 66, 66, 126, 66, 66, 66, 126		// 154
DATA 56, 126, 52, 60, 24, 61, 62, 252		// 155
DATA 60, 60, 60, 60, 36, 36, 54, 54			// 156
#ende
STOP