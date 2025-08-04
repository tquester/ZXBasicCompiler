package main;

enum TokenType {
    KEYWORD,
    NUMBER,
    STRING,
    SYMBOL,
    IDENTIFIER,
    LABEL,
    COMMENT,
    EOF
}

class BasicToken {
	public TokenType type;
    public String text;  // z.B. Keyword-Name, Nummer als String, Identifier-Name, Symbol als String
    public int zxtoken;
	public int pos;

    public BasicToken(TokenType type, String text, int pos) {
        this.type = type;
        this.text = text;
        this.zxtoken = 0;
        this.pos = pos;
        
    }

    public BasicToken(TokenType type, String text, int pos, int zxtoken) {
        this.type = type;
        this.text = text;
        this.pos = pos;
        this.zxtoken = zxtoken;
        
    }

    public String toString() {
        return type + "(" + text + ")";
    }
}
