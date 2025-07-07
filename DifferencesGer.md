# Unterschiede im BASIC
Das kompilierte BASIC hat einige Unterschiede zum BASIC im ZX Spectrum

## Integer
Wenn Variablen als Integer definiert sind, ist der Wertebereich -32767 bis 32767 und es gibt natürlich keine Nachkommastellen, d.h. 1/7 = 0
Dafür sind Integer-Variablen 20-30 mal schneller als Gleitkomma

## DRAW
Es gibt (noch) keinen Dritten Parameter, DRAW geht momentan nur für grade Linien

## INPUT und VAL
In BASIC können Input, VAL und VAL$ Ausdrücke auswerten, d.h wenn man in BASIC nach einer Zahl gefragt wird, kann man auch a+b eingeben wenn die Variablen a und b definiert sind.
Im Compiler gibt es keine Namen für Variablen und es können keine Ausdrücke ausgewertet werden.

Wenn die Variable bei Input ein Integer ist, können nur "-" und Ziffern eingegeben werden, bei Float "-", Ziffern und "."

Es gibt kein LINE INPUT, Input wird immer ohne Anführungszeichen ausgeführt.

VAL kann ebenfalls nur Ziffern in Zahlen umwandeln und keine Formeln auswerten.
VAL$ ist nicht definiert und führt zu Fehlern.

## DIM
Arrays werden beim Kompilieren gebildet, d.h. man kann keine Variablen Arrays anlegen. DIM A(x) geht nicht und führt zu Fehler

## DATA
Data wird vom Compiler bearbeitet und in eine Datenstruktur in Assembler umgewandelt. In Data dürfen nur Konstanten erscheinen, keine Variablen.
Die Werte sind normalerweise Integer (außer -f ist gesetzt), aber man kann es steuern
```
1000 DATA 1.0, 2.0, 3.14 : REM Gleitkommazahlen
1010 DATA INT 1, INT 2, INT 3: REM Ganzzahlen
1010 DATA 1,2,3 : REM Integer oder Gleitzahlen, je nach Einstellung
1020 DATA "1","2","3" : REM Strings
Beim Lesen müssen Sie aufpassen, den richtigen Typ zu erwischen
1100 rem float f1 f2 f3
1110 rem int16 a1 a2 a3
1120 restore 1000: read f1: read f2: read f3
1130 read a1: read a2: read a3
1140 read a$: read b$: read c$
```

Der Compiler fügt die Daten in den Datenbereich des Programms ohne Angabe des Typs an. Wenn Sie zum Beispiel den String "hallo" mit einer Integer-Variablen lesen, erhalten Sie beim ersten Mal 4 (die Länge des Strings) danach CODE "h" + 256 * CODE "a" usw.
Wenn Sie mehr Daten einlesen als es gibt, wird einfach über den Bereich hinausgelesen und sie erhalten die Bytes die dort zufällig im Speicher stehen.

## DATA *
Diese Variante gehört zur QBasic2-Erweiterung (noch nicht implementiert)
```
1000 * DATA USR "A", 1,2,3,4,5,6,7,8
1010 * DATA 1, 1,2,3,4,5,6,7,8,11,12,13,14,15,16,17,18,21,22,23,24,25,26,27,28,31,32,33,34,35,36,37,38
```

Die erste Variante definiert das UDB A (chr$ 144) mit den 8 Werten 1,2,3,4,6,7,8
Die Zeile 1010 definiert das Sprite 1 mit den folgenden 32 Werte (4 * 8 Bytes für ein 16x16 Pixel Sprite)

Der Unterschied ist, dass bei * DATA die Daten als Byte abgelegt werden. Die USGs werden beim Programmstart automatisch initialisiert, die Sprite-Daten liegen liegen direkt im Sprite-Buffer der Sprite-Library und müssen nicht umkopiert werden

## RESTORE, GOTO und GOSUB
Man kann hier nur eine Zahl angeben, keine Variablen. Das kompilierte Programm kennt keine Zeilennummern.
Für RESTORE sind nur Zeilennummern zulässig bei denen es eine DATA-Anweisung gibt.

## SAVE, LOAD, MERGE
Funktionieren nicht.
Später wird LOAD CODE und SAVE CODE eingebaut. BASIC-Programme und MERGE machen im Kompiler keinen Sinn
