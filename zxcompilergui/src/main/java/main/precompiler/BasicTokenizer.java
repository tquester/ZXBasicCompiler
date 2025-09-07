package main.precompiler;

import java.util.Map;

import main.precompiler.BasicToken.TokenType;

public class BasicTokenizer {
    private final Map<String, Integer> keywordMap;  // z.B. "PRINT"->1, "LET"->2, ...
    private String input;
    private int pos = 0;

    public BasicTokenizer(Map<String, Integer> keywordMap) {
        this.input = "";
        this.keywordMap = keywordMap;
    }

    
    public BasicTokenizer(String input, Map<String, Integer> keywordMap) {
        this.input = input;
        this.keywordMap = keywordMap;
    }

    public BasicToken nextToken() {
    	int begin;
        skipWhitespace();
        if (pos >= input.length()) {
            return new BasicToken(TokenType.EOF, "",0);
        }

        char ch = input.charAt(pos);
        while (Character.isSpace(ch)) { 
        	pos++;
        	ch = input.charAt(pos);
        }
        begin = pos;

        // Stringliteral (Anführungszeichen)
        if (ch == '"') {
            int start = ++pos;
            while (pos < input.length() && input.charAt(pos) != '"') pos++;
            String str = input.substring(start, pos);
            if (pos < input.length()) pos++; // schließe Anführungszeichen
            return new BasicToken(TokenType.STRING, str, begin);
        }

        // Zahl (integer)
        if (Character.isDigit(ch)) {
            int start = pos;
            while (pos < input.length() && Character.isDigit(input.charAt(pos))) pos++;
            return new BasicToken(TokenType.NUMBER, input.substring(start, pos),begin);
        }

        // Identifier oder Keyword (Buchstabe oder _ beginnend)
        if (Character.isLetter(ch) || ch == '_') {
            int start = pos;
            while (pos < input.length() &&
                    (Character.isLetterOrDigit(input.charAt(pos)) || input.charAt(pos) == '_')) {
                pos++;
            }
            String word = input.substring(start, pos).toUpperCase();
            if (keywordMap.containsKey(word)) {
                return new BasicToken(TokenType.KEYWORD, word, begin, keywordMap.get(word).intValue());
            } else {
                return new BasicToken(TokenType.IDENTIFIER, word, begin);
            }
        }

        // Symbole (z.B. + - = ; , ( ) )
        pos++;
        return new BasicToken(TokenType.SYMBOL, Character.toString(ch), begin);
    }

    private void skipWhitespace() {
        while (pos < input.length() && Character.isWhitespace(input.charAt(pos))) pos++;
    }


	public void start(String lineText) {
		input = lineText;
		pos=0;
		
	}


	public boolean hasData() {
		if (pos >= input.length()) return false;
		return true;
	}
}