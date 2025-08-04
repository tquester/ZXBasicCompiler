package main;

import java.util.*;

import zxcompiler.ZXToken;

public class CBasicPreparser2 {

    private static final int START_LINE = 1000;
    private static final int STEP = 10;
    ZXToken mZXToken = new ZXToken();

    public static class ParseResult {
        public List<String> code;                // BASIC mit Zeilennummern
        public byte[] parsedCode;
        public Map<String, Integer> labels;      // Label -> Zeilennummer
        public Map<String, String> resources;    // Label -> Ressourcentyp (UDG, TILE, SPRITE...)
    }
    
    static class BasicLine {
        int line;
        String text;
        BasicLine(int line, String text) { this.line = line; this.text = text.trim(); }
        @Override public String toString() { return line + " " + text; }
    }

    
    static class LoopContext {
        String type;            // "WHILE" oder "DO"
        int startLine;          // Startzeile der Schleife
        String condition;       // Bedingung (für WHILE oder UNTIL)
        List<BasicLine> exits = new ArrayList<BasicLine>(); // EXIT-Zeilen innerhalb dieser Schleife
        int endLine;            // Ziel für EXIT (wird beim WEND/LOOP UNTIL gesetzt)
    }

    public static List<BasicLine> preprocessLoops(List<String> source) {
        List<BasicLine> result = new ArrayList<>();
        Stack<LoopContext> loopStack = new Stack<>();
        
        int lineNumber = 1000; // Startzeile
        for (String rawLine : source) {
            String raw = rawLine.trim();
            if (raw.startsWith(";") || raw.startsWith("//")) 
            	continue;
            String upper = raw.toUpperCase(Locale.ROOT);

            if (upper.startsWith("WHILE ")) {
                // Neue WHILE-Schleife beginnen
                String cond = raw.substring(6).trim();
                LoopContext ctx = new LoopContext();
                ctx.type = "WHILE";
                ctx.startLine = lineNumber;
                ctx.condition = cond;
                loopStack.push(ctx);
                
                // IF NOT (cond) THEN GOTO ??? (wird später gepatcht)
                result.add(new BasicLine(lineNumber++, "IF NOT (" + cond + ") THEN GOTO ???"));
            }
            else if (upper.equals("WEND")) {
                // Schleife beenden
                if (loopStack.isEmpty() || !"WHILE".equals(loopStack.peek().type))
                    throw new RuntimeException("WEND ohne passendes WHILE!");
                LoopContext ctx = loopStack.pop();

                int wendLine = lineNumber;
                // Patch das IF NOT am Anfang
                backpatchGoto(result, ctx.startLine, wendLine);
                // Patch alle EXITs innerhalb dieser Schleife
                for (BasicLine exitLine : ctx.exits) {
                    exitLine.text = "GOTO " + (wendLine + 1) + " ; EXIT";
                }

                // Sprung zurück zur WHILE-Bedingung
                result.add(new BasicLine(lineNumber++, "GOTO " + ctx.startLine));
                result.add(new BasicLine(lineNumber++, "REM WEND"));
            }
            else if (upper.equals("DO")) {
                // Neue DO-Schleife beginnen
                LoopContext ctx = new LoopContext();
                ctx.type = "DO";
                ctx.startLine = lineNumber;
                loopStack.push(ctx);
                // DO selbst erzeugt keine Zeile
            }
            else if (upper.startsWith("LOOP UNTIL ")) {
                // LOOP UNTIL <bedingung>
                if (loopStack.isEmpty() || !"DO".equals(loopStack.peek().type))
                    throw new RuntimeException("LOOP UNTIL ohne passendes DO!");
                LoopContext ctx = loopStack.pop();
                String cond = raw.substring(11).trim();

                int loopEndLine = lineNumber;
                // Patch alle EXITs innerhalb dieser DO-Schleife
                for (BasicLine exitLine : ctx.exits) {
                    exitLine.text = "GOTO " + (loopEndLine + 1) + " ; EXIT";
                }

                // Bedingte Wiederholung
                result.add(new BasicLine(lineNumber++, "IF NOT (" + cond + ") THEN GOTO " + ctx.startLine));
                result.add(new BasicLine(lineNumber++, "REM LOOP UNTIL"));
            }
            else if (upper.equals("EXIT")) {
                if (loopStack.isEmpty())
                    throw new RuntimeException("EXIT ohne Schleife!");
                // EXIT gehört zur innersten Schleife
                LoopContext ctx = loopStack.peek();
                BasicLine exitLine = new BasicLine(lineNumber++, "GOTO ??? ; EXIT");
                ctx.exits.add(exitLine);
                result.add(exitLine);
            }
            else {
                // Normale BASIC-Zeile
                result.add(new BasicLine(lineNumber++, raw));
            }
        }

        if (!loopStack.isEmpty()) throw new RuntimeException("Fehlende WEND oder LOOP UNTIL!");

        return result;
    }
    
    

    private static void backpatchGoto(List<BasicLine> lines, int whileLine, int wendLine) {
        for (BasicLine line : lines) {
            if (line.line == whileLine && line.text.startsWith("IF NOT")) {
                line.text = line.text.replace("???", String.valueOf(wendLine));
                return;
            }
        }
    }


    public static ParseResult preprocess(List<String> input) {
        List<String> output = new ArrayList<>();
        Map<String, Integer> labels = new LinkedHashMap<>();
        Map<String, String> resources = new LinkedHashMap<>();
        int currentLineNumber = START_LINE;

        StringBuilder currentLine = null;
        List<String> pendingLabels = new ArrayList<>();

        for (int i = 0; i < input.size(); i++) {
            String line = input.get(i).trim();
            if (line.isEmpty()) continue;

            // Label oder Ressourcendeklaration
            if (line.startsWith("#")) {
                String labelDef = line.substring(1).trim();
                if (labelDef.contains(":")) {
                    String[] parts = labelDef.split(":", 2);
                    String type = parts[0].trim().toUpperCase();  // z.B. UDG, TILE, SPRITE
                    String name = parts[1].trim();
                    pendingLabels.add(name);
                    resources.put(name, type);
                } else {
                    pendingLabels.add(labelDef);
                }
                continue;
            }

            // Nummerierte Zeile
            if (line.matches("\\d+\\s+.*")) {
                if (currentLine != null) {
                    output.add(currentLine.toString());
                    currentLine = null;
                }
                int num = Integer.parseInt(line.split("\\s+")[0]);
                currentLineNumber = num;
                for (String label : pendingLabels) labels.put(label, currentLineNumber);
                pendingLabels.clear();
                currentLine = new StringBuilder(line);
            }
            // Unnummerierte Zeile
            else {
                for (String label : pendingLabels) labels.put(label, currentLineNumber);
                pendingLabels.clear();

                if (currentLine == null) {
                    currentLine = new StringBuilder(currentLineNumber + " " + line);
                } else {
                    currentLine.append(line.replaceAll("^\\d+\\s+", ""));
                }
            }

            if (!line.endsWith(":") && currentLine != null) {
                output.add(currentLine.toString());
                currentLine = null;
                currentLineNumber += STEP;
            }
        }

        if (currentLine != null) output.add(currentLine.toString());

        // Labelreferenzen ersetzen
        for (int i = 0; i < output.size(); i++) {
            String line = output.get(i);
            for (String label : labels.keySet()) {
                line = line.replace("#" + label, labels.get(label).toString());
            }
            output.set(i, line);
        }

        ParseResult result = new ParseResult();
        result.code = output;
        result.labels = labels;
        result.resources = resources;
        return result;
    }

    public static void main(String[] args) {
        List<String> code = Arrays.asList(
            "# UDG:Rocket",
            "RESTORE #Rocket",
            "# SPRITE:Enemy",
            "PRINT \"BANG\"",
            "# TILE:Level1",
            "9000 DATA 1,2,3"
        );

        ParseResult result = preprocess(code);
        System.out.println("=== BASIC Code ===");
        result.code.forEach(System.out::println);

        System.out.println("\n=== Labels ===");
        result.labels.forEach((k, v) -> System.out.println(k + " -> " + v));

        System.out.println("\n=== Ressourcen ===");
        result.resources.forEach((k, v) -> System.out.println(k + " : " + v));
    }
}

