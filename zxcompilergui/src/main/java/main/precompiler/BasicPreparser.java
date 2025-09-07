package main.precompiler;

import java.awt.font.LineMetrics;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import zxcompiler.ZXToken;

import java.util.*;

class BasicLine {
    Integer lineNumber;
    String raw;
    String label;
    List<String> params = new ArrayList<>();
    BasicLine(Integer lineNumber, String raw) { this.lineNumber = lineNumber; this.raw = raw.trim(); }
    @Override public String toString() { return (lineNumber != null ? lineNumber : "???") + " " + raw; }
}

@Deprecated
public class BasicPreparser {
    private static final int AUTO_START = 1000;
    private static final int AUTO_STEP = 10;
    
    static class Procedure {
        String name;
        String[] params;
        String body;
    }  

    static class LoopContext {
        String type;            // "WHILE" oder "DO"
        int startLine;          // Startzeile der Schleife
        String condition;       // Bedingung (für WHILE oder UNTIL)
        List<BasicLine> exits = new ArrayList<BasicLine>(); // EXIT-Zeilen innerhalb dieser Schleife
        int endLine;            // Ziel für EXIT (wird beim WEND/LOOP UNTIL gesetzt)
    }
    
    private static class CaseBlock {
        String value;
        String label;
        List<String> codeLines = new ArrayList<>();

        CaseBlock(String value, String code) {
            this.value = value;
            this.label = value.replaceAll("[^A-Za-z0-9]", "") + "_" + UUID.randomUUID().toString().substring(0, 4);
            if (!code.isEmpty()) codeLines.add(code);
        }

        void addInlineCode(String code) {
            codeLines.add(code);
        }
    }    
    
    // --- Innerer Hilfskontext ---
    private static class SelectContext {
        String variable;
        List<CaseBlock> cases = new ArrayList<>();
        CaseBlock caseElse;
        String endLabel;

        SelectContext(String variable) {
            this.variable = variable;
            this.endLabel = "scEnd_" + UUID.randomUUID().toString().substring(0, 4);
        }

        void addCase(String value, String code) {
            cases.add(new CaseBlock(value, code));
        }

        void setCaseElse(String code) {
            this.caseElse = new CaseBlock("ELSE", code);
        }

        void addInlineCode(String code) {
            if (!cases.isEmpty()) {
                cases.get(cases.size() - 1).addInlineCode(code);
            } else if (caseElse != null) {
                caseElse.addInlineCode(code);
            }
        }
        
        void addInlineCodeList(List<String> lines) {
            if (!cases.isEmpty()) {
                cases.get(cases.size() - 1).codeLines.addAll(lines);
            } else if (caseElse != null) {
                caseElse.codeLines.addAll(lines);
            }
        }        

        List<String> generateCode() {
            List<String> out = new ArrayList<>();

            // IF-Zeilen
            for (CaseBlock c : cases) {
                out.add("IF " + variable + "=" + c.value + " THEN GOTO #" + c.label);
            }
            if (caseElse != null) {
                    out.addAll(caseElse.codeLines);
                    out.add("GOTO #" + endLabel);
            } else {
                out.add("GOTO #" + endLabel);
            }

            // CASE Blöcke
            for (CaseBlock c : cases) {
                out.add("#" + c.label);
                out.addAll(c.codeLines);
                out.add("GOTO #" + endLabel);
            }

           

            // END SELECT
            out.add("#" + endLabel);
            return out;
        }
    }    
    
    public static List<String> convertSelectCase(List<String> lines) {
        List<String> result = new ArrayList<>();
        Stack<SelectContext> stack = new Stack<>();

        for (String rawLine : lines) {
            String line = rawLine.trim().toUpperCase();

            if (line.startsWith("SELECT ")) {
                // Variable extrahieren
                String varName = rawLine.trim().substring(7).trim();
                stack.push(new SelectContext(varName));
            }
            else if (line.startsWith("ELSE")) {
            	
                if (!stack.isEmpty()) {
                    String[] parts = rawLine.split(":", 2);
                    stack.peek().setCaseElse(parts.length > 1 ? parts[1].trim() : "");
                }
            }
            else if (line.startsWith("CASE ")) {
                if (!stack.isEmpty()) {
                    String caseLine = rawLine.trim().substring(5).trim();
                    String caseValue;
                    String caseCode = "";

                    if (caseLine.startsWith("\"")) { // String mit Leerzeichen
                        int endQuote = caseLine.indexOf("\"", 1);
                        if (endQuote < 0) throw new RuntimeException("Fehlendes schließendes Anführungszeichen: " + rawLine);
                        caseValue = caseLine.substring(0, endQuote + 1); // inkl. Quotes
                        if (endQuote + 1 < caseLine.length() && caseLine.charAt(endQuote + 1) == ':') {
                            caseCode = caseLine.substring(endQuote + 2).trim();
                        }
                    } else { // Zahl oder Identifier
                        String[] parts = caseLine.split(":", 2);
                        caseValue = parts[0].trim();
                        if (parts.length > 1) caseCode = parts[1].trim();
                    }
                    stack.peek().addCase(caseValue, caseCode);
                }
            }
            else if (line.equals("END SELECT")) {
                if (!stack.isEmpty()) {
                    SelectContext ctx = stack.pop();
                    List<String> generated = ctx.generateCode();

                    if (!stack.isEmpty()) {
                        // Verschachtelt: Füge generierten Code in aktuellen CASE-Block des übergeordneten SELECT ein
                        stack.peek().addInlineCodeList(generated);
                    } else {
                        // Äußerster SELECT: direkt in Ergebnis
                        result.addAll(generated);
                    }
                }
            }
            else {
                // Normale Zeile wird direkt übernommen, wenn kein aktiver SELECT
                if (stack.isEmpty()) {
                    result.add(rawLine);
                } else {
                    // Innerhalb eines CASE-Blocks: normalen Code an den aktuellen CASE hängen
                    stack.peek().addInlineCode(rawLine);
                }
            }
        }

        return result;
    }
    
    public static List<BasicLine> preProcess(String code) {
    	code = transformProcedureToLabels(code);
    	ArrayList<String> lcode = new ArrayList<String>();
    	for (String line: code.split("\n")) {
    		lcode.add(line);
    	}
    	return preprocess(lcode);
    	
    }

  


    
    public static List<BasicLine> preprocess(List<String> src2) {
    	List<String> src = convertSelectCase(src2);
        BasicTokenizer tokenizer = new BasicTokenizer(new TreeMap<String, Integer>());
        List<BasicLine> lines = new ArrayList<>();
        Map<String,Integer> labelMap = new HashMap<>();
        Integer currentNum = null;
        int autoNum = AUTO_START;
        Stack<LoopContext> loopStack = new Stack<>();
        // Phase 1: Einlesen
        for (String rawLine : src) {
            rawLine = rawLine.trim();
            if (rawLine.startsWith(";") || rawLine.startsWith("//")) continue;
            if (rawLine.isEmpty()) continue;

            // Prüfen auf Zeilennummer
            String[] parts = rawLine.split("\\s+", 2);
            Integer lineNum = null;
            String content = rawLine;

            if (parts[0].matches("\\d+")) {
                lineNum = Integer.parseInt(parts[0]);
                content = parts.length > 1 ? parts[1] : "";
                currentNum = lineNum; // explizite Zeilennummer überschreibt den Auto-Zähler
            }
            
            String upper = rawLine.toUpperCase(Locale.ROOT);
            if (lineNum == null) {
                if (currentNum == null) currentNum = autoNum;
                lineNum = currentNum;
            }

/*
            if (upper.startsWith("WHILE ")) {
                // Neue WHILE-Schleife beginnen
                String cond = rawLine.substring(6).trim();
                LoopContext ctx = new LoopContext();
                ctx.type = "WHILE";
                ctx.startLine = lineNum;
                ctx.condition = cond;
                loopStack.push(ctx);
                
                // IF NOT (cond) THEN GOTO ??? (wird später gepatcht)
                lines.add(new BasicLine(lineNum, "IF NOT (" + cond + ") THEN GOTO ???"));
                autoNum += AUTO_STEP;
                currentNum = null;
               continue;
            } 
            else if (upper.equals("WEND")) {
                // Schleife beenden
                if (loopStack.isEmpty() || !"WHILE".equals(loopStack.peek().type))
                    throw new RuntimeException("WEND ohne passendes WHILE!");
                LoopContext ctx = loopStack.pop();

                int wendLine = lineNum + AUTO_STEP;
                // Patch das IF NOT am Anfang
                backpatchGoto(lines, ctx.startLine, wendLine);
                // Patch alle EXITs innerhalb dieser Schleife
                for (BasicLine exitLine : ctx.exits) {
                	while (exitLine.raw.contains("???"))
                		exitLine.raw = exitLine.raw.replace("???",String.format("%d",wendLine));
                }
                
                // Sprung zurück zur WHILE-Bedingung
                lines.add(new BasicLine(autoNum, "GOTO " + ctx.startLine));
                autoNum += AUTO_STEP;
                currentNum = null;
                continue;
                //result.add(new BasicLine(lineNumber++, "REM WEND"));
            }
            else if (upper.equals("DO")) {
                // Neue DO-Schleife beginnen
                LoopContext ctx = new LoopContext();
                ctx.type = "DO";
                ctx.startLine = lineNum;
                loopStack.push(ctx);
                continue;
                // DO selbst erzeugt keine Zeile
            }
            else if (upper.startsWith("LOOP UNTIL ")) {
                // LOOP UNTIL <bedingung>
                if (loopStack.isEmpty() || !"DO".equals(loopStack.peek().type))
                    throw new RuntimeException("LOOP UNTIL ohne passendes DO!");
                LoopContext ctx = loopStack.pop();
                String cond = rawLine.substring(11).trim();

                int loopEndLine = lineNum;
                // Patch alle EXITs innerhalb dieser DO-Schleife
                for (BasicLine exitLine : ctx.exits) {
                    exitLine.raw = "GOTO " + (loopEndLine + 1) + " ; EXIT";
                }

                // Bedingte Wiederholung
                lines.add(new BasicLine(lineNum,"IF NOT (" + cond + ") THEN GOTO " + ctx.startLine));
                //result.add(new BasicLine(lineNumber++, "IF NOT (" + cond + ") THEN GOTO " + ctx.startLine));
                //result.add(new BasicLine(lineNumber++, "REM LOOP UNTIL"));
                continue;
            }
            else if(upper.contains("EXIT")) {
            	LoopContext ctx = loopStack.peek();
            	while (upper.contains("EXIT"))  {
            		tokenizer.start(rawLine);
            		while (tokenizer.hasData()) {
            			BasicToken token = tokenizer.nextToken(); 
            			if (token.type == TokenType.IDENTIFIER) {
            				if (token.text.toUpperCase().compareTo("EXIT") == 0) {
            					String left = rawLine.substring(0,token.pos);
            					String right = rawLine.substring(token.pos+4);
            					rawLine = left + "GOTO ???" + right;
            					break;
            					
            				}
            			}
            		}
            		upper = rawLine.toUpperCase();
            	}
            	
            	BasicLine exitLine = new BasicLine(lineNum++, rawLine);
                ctx.exits.add(exitLine);
                lines.add(exitLine);
                autoNum += AUTO_STEP;
                currentNum = null;
            	
            	
                continue;
            } 
           */

            // Prüfen auf Label-Zeile
            String label = null;
            List<String> params = new ArrayList<>();
            if (content.startsWith("#")) {
                // z.B. #tile 31,20:level1
                String rest = content.substring(1);
                if (rest.contains(":")) {
                    String[] sub = rest.split(":");
                    parseLabel(sub[0], params);       // #tile 31,20
                    label = params.remove(0);         // label = "tile"
                    labelMap.put(label, (lineNum != null) ? lineNum : autoNum);
                    labelMap.put(sub[1].toLowerCase(), (lineNum != null) ? lineNum : autoNum); // sublabel
                } else {
                    parseLabel(rest, params);
                    label = params.remove(0);
                    labelMap.put(label.toLowerCase(), (lineNum != null) ? lineNum : autoNum);
                }
                continue;
            }

            if (lineNum == null) {
                if (currentNum == null) currentNum = autoNum;
                lineNum = currentNum;
            }

            lines.add(new BasicLine(lineNum, content));
            if (!content.endsWith(":")) {
                autoNum += AUTO_STEP;
                currentNum = null;
            }
        }

        // Phase 2: Sprünge auflösen
        for (BasicLine line : lines) {
        	if (line.raw.contains("#")) {
        		int len = line.raw.length();
        		int i=0;
        		String t="";
        		while (i<len) {
        			char c = line.raw.charAt(i++);
        			if (c == '"') {
        				t+=c;
        				while (i<len) {
        					c = line.raw.charAt(i++);
        					t+=c;
        					if (c == '"') break;
        				}
        			} else if (c == '#') {
        				String lbl = "";
        				while (i<len) {
        					c = line.raw.charAt(i);
        					if (c == ' ' || c == 13 || c == ':') break;
        					lbl += c;
        					i++;
        				}
        				Integer l = labelMap.get(lbl.toLowerCase());
        				if (l == null)
        					t += lbl;
        				else 
        					t += String.format("%d", l.intValue());
        			}
        			else 
        				t+=c;
        		}
        		line.raw = t;

        	}
        }

        return lines;
    }
    
    private static void backpatchGoto(List<BasicLine> lines, int whileLine, int wendLine) {
        for (BasicLine line : lines) {
            if (line.lineNumber == whileLine && line.raw.startsWith("IF NOT")) {
                line.raw = line.raw.replace("???", String.valueOf(wendLine));
                return;
            }
        }
    }
    
    List<String> createBASIC(List<BasicLine> preparsed) {
    	ArrayList<String> result = new ArrayList();
    	int lastLine=-1;
    	String cmd=null;
    	for (BasicLine line: preparsed) {
    		if (line.lineNumber == lastLine) {
    			cmd += ":"+line.raw;
    		} else {
    			if (cmd != null)
    				result.add(cmd);
    			cmd = line.toString();
    			lastLine = line.lineNumber;
    		}
    	}
    	
    	return result;
    }

    private static void parseLabel(String text, List<String> out) {
        // Zerlegt "tile 31,20" in ["tile", "31", "20"]
        String[] parts = text.split("\\s+", 2);
        out.add(parts[0].toLowerCase());
        if (parts.length > 1) {
            for (String p : parts[1].split(",")) out.add(p.trim());
        }
    }
    
    public static String transformProcedureToLabels(String code) {
        // 1. Prozedur-Definitionen extrahieren
        List<Procedure> procedures = new ArrayList<>();
        Pattern procPattern = Pattern.compile("(?i)procedure\\s+(\\w+)\\(([^)]*)\\)(.*?)end\\s+proc", Pattern.DOTALL);
        Matcher procMatcher = procPattern.matcher(code);
        
        while (procMatcher.find()) {
            Procedure p = new Procedure();
            p.name = procMatcher.group(1);
            p.params = Arrays.stream(procMatcher.group(2).split(","))
                            .map(String::trim)
                            .toArray(String[]::new);
            p.body = procMatcher.group(3).trim();
            procedures.add(p);
        }

        // 2. Prozedur-Aufrufe ersetzen
        StringBuffer result = new StringBuffer();
        Pattern callPattern = Pattern.compile("(?i)(\\w+)\\s*\\(([^)]*)\\)");
        Matcher callMatcher = callPattern.matcher(procPattern.matcher(code).replaceAll(""));
        
        while (callMatcher.find()) {
            String procName = callMatcher.group(1);
            String[] args = callMatcher.group(2).split(",");
            
            StringBuilder replacement = new StringBuilder();
            // Parameter-Zuweisungen
            for (int i = 0; i < args.length; i++) {
                replacement.append("LET ").append(procName).append("_")
                          .append(i+1).append("=").append(args[i].trim()).append(":");
            }
            // GOSUB mit Label
            replacement.append("GOSUB #proc_").append(procName);
            callMatcher.appendReplacement(result, replacement.toString());
        }
        callMatcher.appendTail(result);
        
        // 3. Prozedur-Definitionen als Labels anhängen
        for (Procedure p : procedures) {
            result.append("\n#proc_").append(p.name).append("\n");
            // Parameter im Body ersetzen
            String body = p.body;
            for (int i = 0; i < p.params.length; i++) {
                body = body.replaceAll("(?i)\\b" + p.params[i] + "\\b", 
                                      p.name + "_" + (i+1));
            }
            result.append(body).append("\nRETURN");
        }
        
        return result.toString();
    }

  
}

