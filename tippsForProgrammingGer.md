# Programmierhinweise
Um schnelle Programme zu schreiben, sollten wir nach Möglichkeit Integer verwenden. Der Compiler verwendet als Default int16 für Variablen, man kann dies aber forcieren
* Mit REM
```
10 REM float af bf cf f()
20 REM int16 ai bi ci i()
30 DIM i(10)
40 DIM f(10)
```
* Implizit
```
10 LET a = INT 5
20 LET f = 5.0
```
* Automatisch
```
10 LET x = RND*30
20 LET x = RND*30.0
```

REM float bzw. rem int16 erzeugt jeweils Variablen mit dem richtigem Typ. f() erzeugt ein leeres Array mit dem Typ Float, so dass bei einem späteren ein Float-Array erzeugt wird.
Wenn man Konstanten mit INT angibt, weiß der Compiler, dass man eine Int16-Konstante verwenden möchte. Gibt man einen Punkt an, das geht auch bei 0.0, wird immer eine Gleitkommazahl erzeugt
Im letzten Fall wird jeweils RND*30 als Float-Ausdruck berechnet, weil RND den Ausdruck auf Gleitkomma anhebt. Im ersten Fall wird die 30 als Integer angelegt und mit IntToFloat in 
eine Gleitkommazahl umgewandelt, im zweiten Fall wird direkt eine Gleitkommazahl verwendet.

# Vermeiden Sie Strings, wenn nötig
```
1000 LET i$=INKEY$
1010 IF i$="A" then goto 2000
2020 IF i$="B" then goto 3000
```

Besser ist es 
```
1000 LET i=CODE INKEY$
1010 IF i=CODE "A" then goto 2000
1020 IF i=CODE "B" then goto 3000
```

Im Zweiten Fall weiß der Compiler dass CODE "A" = 65 ist und schreibt es so in den Code. Es findet daher nur ein Vergleich auf Integer-Zahlen statt, dieser ist wesentlich schneller als ein Vergleich auf Strings

# Vermeiden Sie unnötige Array-Zugriffe
```
1 DIM m$(10,13)
1000 if m$(l,c(x),d(y)) = "A" then ink 1
1010 if m$(l,c(x),d(y)) = "B" then ink 2
1020 if m$(l,c(x),d(y)) = "C" then ink 3
```

Besser ist:
```
1000 let t=CODE(m$(c(c),d(x)))
1010 if t = CODE "A" then ink 1
1020 if t = CODE "B" then ink 2
1030 if t = CODE "C" then ink 3
```

Arrayzugriffe benötigen immer mindestens eine Multiplikation, wenn c und d Gleitkomma sind muss jeweils mit 5 multipliziert werden, ansonsten mit 2 (das wird durch Addition gelöst) danach muss noch einmal mit der 2 Dimension des M-Arrays multipliziert werden (hier 13)
Das Abspeichern in einer Integer-Variable führt dies nur einmal durch.

# Vermeiden Sie berechnete Sprünge
```
10 LET InitLevel=2000
..
500 GOSUB InitLevel
...
2000 REM Init Level
```
Nicht nur, dass dies von der Renumber-Funktion des ZX Spectrum 128 berücksichtigt wird, der Compiler erzeugt eine Tabelle mit allen Zeilennummern und durchsucht diese jedes Mal.
Variablen sind gut für die Übersicht und man kann berechnete Sprünge gut einsetzen wenn man kein Renumber verwendet, z.B. um Leveldaten zu laden, aber es ist wesentlich langsamer als ein Sprung zu einer Zeilennummer.

Es gibt diverse Tools, mit denen man die BASIC-Programme bequem unter Windows mit Labeln erfassen kann, dies wird dann umgewandelt in Zeilennummern und als .TAP zur Verfügung gestellt. 

