package main;

import java.awt.font.LineMetrics;
import java.util.*;

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

public class BasicPreparser {
    private static final int AUTO_START = 1000;
    private static final int AUTO_STEP = 10;

    static class LoopContext {
        String type;            // "WHILE" oder "DO"
        int startLine;          // Startzeile der Schleife
        String condition;       // Bedingung (für WHILE oder UNTIL)
        List<BasicLine> exits = new ArrayList<BasicLine>(); // EXIT-Zeilen innerhalb dieser Schleife
        int endLine;            // Ziel für EXIT (wird beim WEND/LOOP UNTIL gesetzt)
    }
    
    public static List<BasicLine> preprocess(List<String> src) {
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
            //autoNum += AUTO_STEP;
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
}

