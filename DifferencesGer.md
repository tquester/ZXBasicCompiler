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
Arrays werden beim Kompilieren gebildet, d.h. man kann keine Variablen Arrays anlegen. DIM A(x) wird zwar kompiliert, hat aber keine Auswirkung auf die Array-Größe.
Um Arrays zu verwenden, fügen Sie die DIM-Anweisungen am Anfang mit einer festen Größe ein. 
Jeder Aufruf von DIM löscht das Array. Numerische Arrays werden mit 0 überschrieben, bei String-Arrays werden alle Strings freigegeben.

Wenn Sie ein vorhandenes BASIC-Programm haben, welches mitten im Code dynamisch Arrays definiert, stellen Sie fest, wie groß der maximale Bereich ist und fügen ein DIM am Anfang ein welchen diesen abdeckt.

```
1 REM int16 x()
2 DIM x(50,50)
.....
2530 dim x(a,b)
```
Zeile 1 definiert das X-Array als Integer, d.h. jedes Element belegt 2 Bytes
In Zeile 2 wird das Array physikalisch angelegt (50*50*2 = 5000 Bytes). Jedes Mal wenn die Zeile 2530 ausgeführt wird, wird das Array x gelöscht. a und b dürfen allerdings nicht größer als 50 sein ansonsten wird Speicher überschrieben.


## DATA
Data wird vom Compiler bearbeitet und in eine Datenstruktur in Assembler umgewandelt. In Data dürfen nur Konstanten erscheinen, keine Variablen.
Die Werte sind normalerweise Integer (außer -f ist gesetzt), aber man kann es steuern

Über das Format der Daten (Float oder Integer) entscheidet die Compiler-Option. Wenn mit -f (Floats) kompiliert wird, werden alle numerischen Werte in DATA als Gleitkomma angelegt.
Man kann dies mit 
```
REM data int16
```
oder 
```
REM data float
```
überschreiben, muss dann aber beim Read aufpassen, dass die Variablen den richtigen Typ haben.

Einzelne Datensätze kann man mit INT als int16 definieren oder mit dem Punkt als Gleitkommazahl: Zum Beispiel: 
```
DATA INT 5, 5.0
```
Erzeugt einen Integer-Wert und einen Gleitkommawert unabhängig davon welche Optionen eingestellt sind.

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

Beispiel:
```
50  DATA "H"
51  DATA  BIN 00011000
52  DATA  BIN 00111100
53  DATA  BIN 01100110
54  DATA  BIN 01000010
55  DATA  BIN 01100110
56  DATA  BIN 00111100
57  DATA  BIN 00011000
58  DATA  BIN 00000000
59  DATA 1.2, 3.4, 3.14
60  DATA  INT 1, INT 2, INT 3
```

Wird kompiliert als

```
DATA_50:
	dw 1
	db "H"
DATA_51:
	dw %00011000
DATA_52:
	dw %00111100
DATA_53:
	dw %01100110
DATA_54:
	dw %01000010
DATA_55:
	dw %01100110
DATA_56:
	dw %00111100
DATA_57:
	dw %00011000
DATA_58:
	dw %00000000
DATA_59:
	db $81,$19,$99,$99,$9a
	db $82,$59,$99,$99,$9a
	db $82,$48,$f5,$c2,$8f
DATA_60:
	dw 1
	dw 2
	dw 3
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
