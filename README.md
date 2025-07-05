# ZXBasicCompiler

Diese BASIC-Compiler lädt das BASIC aus einer .TAP-Datei, d.h. man benutzt den ZX Spectrum Emulator zum Editieren und Testen.
Der Compiler erzeugt daraufhin eine Textdatei welche mit einem Assembler kompiliert werden muss (sjasmplus). 
Wenn die Optimierung eingeschaltet ist, wird eine gut lesbare Assemblerdatei erzeugt welche bei Bedarf weiter bearbeitet werden kann.
Da der Compiler nicht auf dem ZX Spectrum läuft, kann der gesamte nutzbare Speicher verwendet werden.


# Status

  | Schritt               |         Status |
  |-----------------------|----------------|
  | Erster Basic-Compiler |             OK
  | Strings               |             OK |
  | Floats                | In Bearbeitung |
  | Alle BASIC-Befehle laufen | In Bearbeitung |
  | Tests für jeden Befehl | In Bearbeitung | 
  | QBasic-Befehle laufen     | In Planung     |
  | Doku                      | In Beabeitung  |
  | English                   | In Planung     |
  
<b>7.5.2025: Heute erfolgt ein Update</b>

# Ziele
- Fast volle Unterstützung des Sinclair ZX Basic. Vorhandene Programme sollen mit wenigen Änderungen Änderungen kompilierbar sein
- Berechnung können in Floats oder in Integer gemacht werden. Integer ist ca. 20-30 mal schneller als Floats.
- In REM-Befehlen können Anweisungen für den Compiler gesendet werden, z.B. ob eine Variable als Float oder Integer zu interpretieren ist.
- Die Ausgabe erfolgt als lesbare Assembler-Datei. Es ist einfach einen Teil des BASIC-Programms in Assembler zu optimieren und dann diesen optimierten Teil im Kompilat statt dem kompilierten BASIC zu verwenden.
- Einbindung optimierte Programmteile über REM asm. z.B. REM asm include "code.asm" und REM asm call
- Die ursprüngliche Routine kann übersprungen werden. REM stop und REM continue wird ein Teil des Codes vom Kompilieren ausgeschlossen damit man stattdessen eine Assembler-Version nutzen kann.
- Eigener Heap für die Stringverarbeitung

Später werden die Funktionen der BASIC-Erweiterung hinzugefügt und es soll einen eigenen Editor geben

# Demo Tapes
BASIC: https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel2/compilerdemo.tap

Kompiliert: https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel2/Assembler/compiled.tap

Assembler-code: https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel2/Assembler/compiledBasic.asm
#Geschwindigkeit

# Geschwindigkeit

Doe Plot-Demo verwendet ausschließlich den Befehl PLOT und verwendet zur Berechnung der Koordinaten Variablen, Zuweisungen, Addition und Vergleiche.
Diese Art von Programmen profitiert am meisten vom Compiler, wenn die Variablen als Integer definiert werden. Entweder durch eine REM-Anweisung (REM int16 x y z) oder indem das Programm mit der Option Integer kompiliert wird.

Plot-Demo
|Frames  | BASIC | FLOAT | INTEGER |
|--------|-------|-------|---------|
|        | 10928 | 2798  |      121|
|BASIC   |       | * 3,9 |      *90|
|FLOAT   |       |       |      *23|

Die SIN/COS-Demo verwendet Gleitkommazahlen für die Berechnung von x, Sinus und Cosinus für die Werte. Gleitkomma-Multiplikation und Typumwandlung für das Anzeigen der Koordinaten. Außerdem STR, Stringfunktionen und zwei FOR-Schleifen.
Die FLOAT-Variante ist mit der Option /f kompiliert, d.h. jede Variable, auch die FOR-Schleife, der Index für die Stringoperationen usw. werden mit Gleitkomma berechnet. Die INT-Variante verwendet lediglich für X, SIN/COS und Y Gleitkommazahlen und Integer für alles andere.

SIN/COS-Demo
|Frames  | BASIC | FLOAT | INTEGER |
|--------|-------|-------|---------|
|        | 2108  | 1444  |     1370|
|BASIC   |       |* 1.45 |    *1.53|
|FLOAT   |       |       |    *1.05|



## Original in Basic:
![plot_basic](https://github.com/user-attachments/assets/345013ba-d3f8-418b-8e68-745ea46f87f1)

## Kompiliert mit Option Gleitkomma
![plot_compiled_fp](https://github.com/user-attachments/assets/9f0514d7-b88c-4473-a784-3408b5c0c54f)

## Kompiliert mit Option Integer
![plot_compiled_it](https://github.com/user-attachments/assets/6b9085e1-4c57-4f30-b053-36e6cbda1c50)

Kompiliert mit Integer


                


# Beispiel
Da der Compiler eine Textdatei (.asm) erzeugt muss man diese noch mit einem Assembler assemblieren, dies kann aber automatisch mit einer Batchdatei erfolgen, so dass man mit wenigen Klicks den Code von einem Emulator in einen weiteren als kompiliertes Programm transferieren kann.

Es ist sogar möglich, den kompilierten Code dirket in DeZog (Visual Studio Code + DeZog) zu debuggen.

Ein Beispiel:

Die Zeile LET a2=b*b+c*c wird in Assembler so umgesetzt, standardmäßig werden Variablen als Integer behandelt
```
ZX_LINE_50:
; 50  LET a2=b*b+c*c
	LD DE,(ZXBASIC_VAR_b)
	LD HL,(ZXBASIC_VAR_b)
	call runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_c)
	LD HL,(ZXBASIC_VAR_c)
	call runtimeMult16bit
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_a2),HL
```
Möchte man Floats verwenden muss man es per REM definieren

```
ZX_LINE_60:
; 60  REM float af bf cf
ZX_LINE_65:
; 65  LET af=bf*bf+cf*cf
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_cf
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_cf
	CALL runtimePushFloatVar
	RST $28
	DB $04	;MULT
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_af
	CALL runtimeStoreFloat
```

Da der Compiler den Quellcode ausgibt, kann man diesen von Hand optimieren und später aus BASIC aufrufen:
```
  REM asm call myfunction
  REM stop
  LET a2=a*a+b*b
  REM continue
```
Und an einer Stelle am besten hinter einem Return
```
  REM asm include "mycode.asm"
```

In der Datei mycode.asm befindet sich die optimierte Version
```
myfunction:
	LD DE,(ZXBASIC_VAR_b)
	LD HL,DE
	call runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_c)
	LD HL,DE
	call runtimeMult16bit
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_a2),HL
	RET
```

Dadurch sollte es möglich sein, Spiele zu entwickeln, die eine ähnliche Performance haben wie in Assembler.

# ZXBasic Compiler
Dieser Compiler ist ein Artikel für die Spectrum User Group.
Im Ordner Artikel1 befindet sich ein rudimentärer Compiler welcher im Artikel erläutert wird.
Im Ordner Artikel2 befindet sich die aktuell in Entwicklung befindliche Version.

Sie können der Benutzergruppe beitreten unter
https://www.speccy-scene.de 

Wenn wir ein ZX Spectrum BASIC Programm mit 16bit Integers anstelle von Floats kompilieren, sieht der Geschwindigkeitszuwachs wie folgt aus
Der linke Bildschirm ist interpretiertes BASIC, der rechte Bildschirm das gleiche Programm, kompiliert mit unserem Compiler

![Speed compare](https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel1/BasicVSAssembler.gif)

Das gleiche Programm kompiliert mit genialen MCoder III verwendet Gleitkommazahlen und ist deswegen langsamer. Integer werden direkt von der CPU ausgeführt und belegen 2 Bytes, während Gleitkommazahlen mit vielen Zeilen Code berechnet werden und 5 Bytes pro Zahl benötigen. Ziel des neuen Compilers muss es daher sein, dass man als BASIC-Programmierer entscheidet, welche Variablen Gleitkommazahlen sind und welche Integer. Was aber im Gegenzug vom BASIC-Programmierer etwas mehr Arbeit verlangt.

![BasicVSMCoder](https://github.com/user-attachments/assets/86a15789-e422-47ab-92c5-e5490e5a9bfb)
