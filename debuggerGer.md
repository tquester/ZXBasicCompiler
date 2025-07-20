# Eingebauter Debugger

<img width="352" height="370" alt="image" src="https://github.com/user-attachments/assets/e0c66056-b00c-446b-b592-339f63e429e7" />

Der Compiler verfügt über einen eingebauten Debugger. Das Programm muss dabei mit der Option -d kompiliert werden, damit der Compiler bei jedem Befehl einen Aufruf zum Debugger und eine Symboltabelle für die Variablen einbaut.
In Main.asm muss der EQU Debug auf 1 gesetzt werden, damit der Debugger in den Code eingebunden wird.

Beim Start des Programmes sieht man nun im oberen Drittel des Bildschirms den Debugger. Druck auf R startet das Programm. Mit Break (Shift Leertaste) kommt man in den Debugger zurück.
Mit B kann man einen Breakpoint auf eine BASIC-Zeile setzen
Mit W kann man Variablen angeben, die man sich ansehen möchte. Die Variablen werden mit Leerzeichen getrennt. (Es geht momentan noch nicht für Arrays)
Mit einer beliebigen anderen Taste wird der nächste BASIC-Befehl ausgeführt.

Der Debugger zeigt den BASIC-Befehl nicht, sondern nur die Zeilennummer, das BASIC-Programm wird jedoch beim Kompilieren als .bas-Datei erzeugt, wenn man es mit -out angibt. Hier kann man sich orientieren und sehen welche Variablen verwendet werden.

Der Debugger benötigt recht viel Speicher (ca. 5KB), da er über eigene Ausgabefunktionen verfügt und die Library noch einige unnötige Dinge enthält, außerdem belegt die Symboltabelle für die Variablen ein wenig Speicherplatz.

```
1000  GOSUB 3700:
     LET x=1:
     LET y=21:
     LET dx=1:
     LET dy=1
1005  FOR i=1 TO 5000
1010  PLOT  OVER 1; INK 3;x,y
1020  LET x=x+dx
1030  LET y=y+dy
1040  IF x <= 1 OR x >= 250 THEN  LET dx=0-dx
1050  IF y <= 20 OR y >= 160 THEN  LET dy=0-dy
1060  NEXT i
1070  GOTO 3710
1100  GOSUB 3700
1120  FOR i=0 TO 255 STEP 3
1130  PLOT  INK 1;i,0
1140  DRAW  INK 1;255-i,170
1150  NEXT i
1155  RETURN 
```
