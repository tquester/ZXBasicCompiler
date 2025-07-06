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
Geht momentan nur für Integer. 

## RESTORE, GOTO und GOSUB
Man kann hier nur eine Zahl angeben, keine Variablen. Das kompilierte Programm kennt keine Zeilennummern.
Für RESTORE sind nur Zeilennummern zulässig bei denen es eine DATA-Anweisung gibt.

## SAVE, LOAD, MERGE
Funktionieren nicht.
Später wird LOAD CODE und SAVE CODE eingebaut. BASIC-Programme und MERGE machen im Kompiler keinen Sinn
