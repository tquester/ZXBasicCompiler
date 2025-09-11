package main;

import java.util.*;
import java.util.regex.*;

import zxcompiler.ZXToken;

public class ZXSpectrumPrettyPrinter {
    private static final Set<String> INDENT_KEYWORDS = new HashSet<>(Arrays.asList(
        "FOR",  "SELECT","WHILE","DO", "PROC","SUB","PROCEDURE", "REPEAT","SELECT","WHEN"
    ));
    
    private static final Set<String> OUTDENT_KEYWORDS = new HashSet<>(Arrays.asList(
        "NEXT", "END","WEND","LOOP","UNTIL"
    ));
    
    private static final Set<String> BASIC_KEYWORDS = new ZXToken().createExtendedSet(new String[] {"GO","SUB"});
    
    private static final Pattern LINE_NUMBER_PATTERN = Pattern.compile("^\\d+");
    private static final Pattern KEYWORD_PATTERN = Pattern.compile("(?i)\\b(" + String.join("|", BASIC_KEYWORDS) + ")\\b");
    
    Stack<String> mStack = new Stack<String>();
    
    public String prettyPrint(String code) {
        String[] lines = code.split("\\r?\\n");
        List<String> formattedLines = new ArrayList<>();
        int indentLevel = 0;
        boolean inCase=false;
        
        for (String line : lines) {
        	System.out.println(line);
            String trimmedLine = line.trim();
            if (trimmedLine.isEmpty()) {
                continue;
            }
            
            if (trimmedLine.startsWith(";") || trimmedLine.startsWith("//") || trimmedLine.length()==0) {
            	formattedLines.add(line);
            	continue;
            	
            }
            
            boolean inMultilineIf = !trimmedLine.endsWith("THEN");
            
            // Normalisiere Schlüsselwörter
            trimmedLine = capitalizeKeywords(trimmedLine);
            
            // Extrahiere Zeilennummer falls vorhanden
            String lineNumber = "";
            Matcher lineNumberMatcher = LINE_NUMBER_PATTERN.matcher(trimmedLine);
            if (lineNumberMatcher.find()) {
                lineNumber = lineNumberMatcher.group();
                trimmedLine = trimmedLine.substring(lineNumberMatcher.end()).trim();
            }
            
            // Handle Einrückung
            String firstWord = getFirstKeyword(trimmedLine);
            
            // Verringere Einrückung vor der Zeile wenn nötig
            if (OUTDENT_KEYWORDS.contains(firstWord) || 
                (firstWord.equals("END"))) {
                indentLevel = Math.max(0, indentLevel - 1);
                String cmd = mStack.pop();
                if (firstWord.equals("END") && cmd.equals("SELECT")) {
                	if (inCase) indentLevel--;
					inCase = false;
                }
            }
            
            // Baue formatierte Zeile
            StringBuilder formattedLine = new StringBuilder();
            
            // Zeilennummer hinzufügen falls vorhanden
            if (!lineNumber.isEmpty()) {
                formattedLine.append(lineNumber).append(" ");
            }
          
            if (firstWord.compareTo("CASE") == 0) {
            	if (inCase)
            		formattedLine.append(getIndentation(indentLevel-1));
            	else {
            		formattedLine.append(getIndentation(indentLevel));	            // Einrückung hinzufügen
            		inCase = true;
            		indentLevel++;
            	}
            		
            } else
            	formattedLine.append(getIndentation(indentLevel));	            // Einrückung hinzufügen

            
            // Code hinzufügen
            formattedLine.append(trimmedLine);
            
            formattedLines.add(formattedLine.toString());
            
          
            // Erhöhe Einrückung nach der Zeile wenn nötig
            if (INDENT_KEYWORDS.contains(firstWord)) {
                indentLevel++;
                mStack.push(firstWord);
            }
        }
        
        return String.join("\n", formattedLines);
    }
    
    private String capitalizeKeywords(String line) {
        StringBuffer result = new StringBuffer();
        Matcher matcher = KEYWORD_PATTERN.matcher(line);
        
        while (matcher.find()) {
            matcher.appendReplacement(result, matcher.group().toUpperCase());
        }
        matcher.appendTail(result);
        
        return result.toString();
    }
    
    private String getFirstKeyword(String line) {
        if (line.isEmpty()) return "";
        
        String[] parts = line.split("\\s+");
        String firstWord = parts[0].toUpperCase();
        
        // "END IF" als Spezialfall behandeln
        if (firstWord.equals("END") && parts.length > 1 && parts[1].equalsIgnoreCase("IF")) {
            return "END IF";
        }
        
        return firstWord;
    }
    
    private boolean isMultilineIf(List<String> lines, int currentIndex) {
        String line = lines.get(currentIndex);
        if (!line.toUpperCase().contains(" IF ")) return false;
        
        // Einzeiliges IF hat THEN mit Code in derselben Zeile
        if (line.toUpperCase().matches(".* THEN\\s+[^\\s].*")) {
            return false;
        }
        
        // Mehrzeilig wenn:
        // 1. THEN am Zeilenende oder allein in Zeile
        // 2. Folgezeilen bis END IF existieren
        if (line.toUpperCase().matches(".* THEN\\s*$")) {
            return true;
        }
        
        // Oder IF mit Zeilenumbruch
        return currentIndex + 1 < lines.size() && 
               !lines.get(currentIndex + 1).trim().toUpperCase().startsWith("END IF");
    }
    
    
    
    private String getIndentation(int level) {
        return "    ".repeat(level);
    }
    
    // Testmethode
  
}
