sidescroll:     LD HL,$4000		; Bildschirm
                ld D,H
                LD E,L
                ld b,192
                inc HL			; HL = $4001, DE=$4000
                ld  a,0
ScrollLoop:     push BC
                ld  bc,31		; Kopiere 31 Bytes
                LDIR 
                ld (DE),a		; Letztes Byte der Zeile auf 0 setzen
                inc hl
                inc de			; Zum Anfang der nächsten Zeile
                pop bc
                djnz ScrollLoop	; 192 mal durchlaufen
                ret
