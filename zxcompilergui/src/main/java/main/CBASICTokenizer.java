package main;

import zxcompiler.ZXToken;

public class CBASICTokenizer {
	public enum BASICTokenTyp {
		isKeyword,
		isString,
		isNumber,
		isVariable, isSpace, isNull
	}
	public boolean mbSpaceToken=false;			// return token for spaces
	
	public static class BASICToken {
		public String literal;
		public BASICTokenTyp typ;
		public int token;
		public String toString() {
			switch(typ) {
			case isNumber: return String.format("nr: %s", literal);
			case isString: return String.format("\"%s\"",literal);
			case isVariable: return String.format("var: %s",literal);
			case isKeyword: return String.format("token: %s %c",token,token);
			}
			return "unknown";
		}
	}
	ZXToken zxtoken = new ZXToken();
	ZX81CalcInputGenerator inputGenerator = new ZX81CalcInputGenerator();
	byte[] mTemp;
	int mLength;
	private String mLine;
	private int mPos;
	
	public void addExtendedTokens() {
		zxtoken.addExtendTokens();
	}
	
	byte[] tokenize(String basic, int start) throws Exception {
		byte[] result;
		try {
			mTemp = new byte[basic.length()*2];
			mLength = start;
			String[] lines = basic.split("\n");
			for (String line:lines) 
				tokenizeLine(line);
			result = new byte[mLength];
			for (int i=0;i<mLength;i++) 
				result[i] = mTemp[i];
		}
		catch(Exception e) {
			throw e;
		}
		return result;
	}
	
	public void init(String line) {
		mLine = line;
		mPos = 0;		
	}

	private void tokenizeLine(String line) throws Exception {
		System.out.println(line);
		mLine = line;
		mPos = 0;
		BASICToken token = new BASICToken();
		if (nextToken(token)) {
			System.out.println(token.toString());
			int lenptr = mLength;
			mLength+=2;
			if (token.typ != BASICTokenTyp.isNumber)
				throw new Exception("Line must start with number");
			writeInt(lenptr,Integer.parseInt(token.literal));
			mLength+=2;
				
			while (nextToken(token)) {
				System.out.println(token.toString());
				switch(token.typ) {
					case isNumber:
						writeNumber(token.literal);
						break;
					case isVariable:
						writeVariable(token.literal);
						break;
					case isString:
						writeString(token.literal);
						break;
					case isKeyword:
						mTemp[mLength++] = (byte)token.token;
						if (token.token == ZXToken.ZXB_REM) {
							while (mPos < mLine.length() ) {
								char c = mLine.charAt(mPos);
								if (c == 13 || c == ':') break;
								mTemp[mLength++] = (byte)c;
								mPos++;
							}
								
						}
						break;
				}
				
			}
			mTemp[mLength++] = 13;
			int size = mLength-lenptr-4;
			writeInt2(lenptr+2, size);
		}
	}

	private void writeString(String literal) throws Exception {
		int p=0;
		char c;
		String temp;
		mTemp[mLength++]='"';
		while (p<literal.length()) {
			c = literal.charAt(p++);
			if (c == '\\') {
				c = literal.charAt(p++);
				if (Character.isDigit(c)) {
					temp = ""+c;
					for (int i=0;i<2;i++) temp += literal.charAt(p++);
					mTemp[mLength++] = (byte)Integer.parseInt(temp);
				} else {
					String str = literal.substring(p).toUpperCase();
					if (str.startsWith("INK")) 
						mTemp[mLength++] = 0x10;
					else if (str.startsWith("PAPER")) 
						mTemp[mLength++] = 0x11;
					else if (str.startsWith("FLASH")) 
						mTemp[mLength++] = 0x12;
					else if (str.startsWith("BRIGHT")) 
						mTemp[mLength++] = 0x13;
					else if (str.startsWith("INVERSE")) 
						mTemp[mLength++] = 0x14;
					else if (str.startsWith("OVER")) 
						mTemp[mLength++] = 0x15;
					else if (str.startsWith("AT")) 
						mTemp[mLength++] = 0x16;
					else if (str.startsWith("TAB")) 
						mTemp[mLength++] = 0x17;
					else throw new Exception("Illegal escape sequence");
				}
			}
			else
				mTemp[mLength++] = (byte)c;
		}
		mTemp[mLength++]='"';
		
	}

	private void writeVariable(String literal) {
		for (int i=0;i<literal.length();i++)
			mTemp[mLength++] = (byte)literal.charAt(i);
			
		
	}

	private void writeNumber(String literal) {
		for (int i=0;i<literal.length();i++)
			mTemp[mLength++] = (byte)literal.charAt(i);
		double d = Double.parseDouble(literal);
		byte[] zxnr = inputGenerator.doubleToZXFloat(d);
		mTemp[mLength++] = 0x0e;
		for (int i=0;i<5;i++) 
			mTemp[mLength++] = zxnr[i]; 
		
		
	}

	private void writeInt(int pos, int int1) {
		mTemp[pos] = (byte)(int1/256);
		mTemp[pos+1] = (byte)(int1%256);
	}
	private void writeInt2(int pos, int int1) {
		mTemp[pos+1] = (byte)(int1/256);
		mTemp[pos] = (byte)(int1%256);
	}
	
	public boolean peekToken(BASICToken token) {
		int pos = mPos;
		boolean r = nextToken(token);
		mPos = pos;
		return r;
	}

	public boolean nextToken(BASICToken token) {
		int len = mLine.length();
		char c=0;
		if (mPos >= len) return false;
		token.typ = BASICTokenTyp.isNull;
		token.literal = "";
		while (mPos < len) {
			c = mLine.charAt(mPos);
			if (!Character.isSpace(c)) break;
			token.typ = BASICTokenTyp.isSpace;
			if (mbSpaceToken) token.literal += c;
			mPos++;
		}
		if (mbSpaceToken && token.typ == BASICTokenTyp.isSpace)
			return true;
		
		if (c >= '0' && c <= '9' || c == '.') {
			token.typ = BASICTokenTyp.isNumber;
			token.literal = "" + c;
			mPos++;
			while (mPos < len) {
				c = mLine.charAt(mPos);
				if (!(c >= '0' && c <= '9' || c == '.')) break;
				token.literal += c;
				mPos++;
			}
			return true;
		}
		if (Character.isAlphabetic(c)) {
			token.typ = BASICTokenTyp.isVariable;
			token.literal = "" + c;
			mPos++;
			while (mPos < len) {
				c = mLine.charAt(mPos);
				if (c == ' ') {
					String s = "";
					for (int i=1;i<=4;i++)
						if (i+mPos < len) s += mLine.charAt(i+mPos);
					s = s.toUpperCase();
					if (!(s.startsWith("TO") || s.startsWith("SUB"))) break;
				} else	
					if (!(c=='_' || c=='$' || Character.isAlphabetic(c) || Character.isDigit(c))) break;
				token.literal += c;
				mPos++;
			}
			Integer itoken = zxtoken.mMapRTokens.get(token.literal.toUpperCase());
			if (itoken != null) {
				token.typ = BASICTokenTyp.isKeyword;
				token.token = itoken.intValue();
			}
				
			return true;
			
		}
		char c1 = 0;
		if (mPos+1 < len) c1 = mLine.charAt(mPos+1);  
		switch(c) {
		case '=':
		case '+':
		case '-':
		case '*':
		case '/':
		case '^':
		case '(':
		case ',':
		case ':':
		case ';':
		case '#':
		case ')':
			token.typ = BASICTokenTyp.isKeyword;
			token.token = c;
			token.literal = ""+c;
			mPos++;
			break;
		case '<':
			token.literal = ""+c;
			token.typ = BASICTokenTyp.isKeyword;
			mPos++;
			if (c1 == '=') {
				mPos++;
				token.literal += c;
				token.token = ZXToken.ZXB_SMALLERTHAN;
			} else if (c1 == '>') {
				mPos++;
				token.literal += '>';
				token.token = ZXToken.ZXB_UNEQUAL;
			}
			else
				token.token = c;
			break;
		case '>':
			token.literal = ""+c;
			mPos++;
			token.typ = BASICTokenTyp.isKeyword;
			if (c1 == '=') {
				token.literal +=c;
				mPos++;
				token.token = ZXToken.ZXB_BIGGERTHAN;
			} 			else
			token.token = c;
			break;
		case '"':
			mPos++;
			token.literal = "";
			token.typ = BASICTokenTyp.isString;
			while (mPos < len) {
				c = mLine.charAt(mPos++);
				if (c == '"') break;
				token.literal += c;
			}
			break;
		}
		
		
		return true;
	}

	public boolean nextNonSpaceToken(BASICToken token) {
		boolean b;
		while (true) {
			b = nextToken(token);
			if (!b) break;
			if (token.typ == BASICTokenTyp.isSpace) continue;
			break;
		}
		return b;
	}

	public void skipSpace(BASICToken token) {
		while (true) {
			boolean b = peekToken(token);
			if (b == false) break;
			if (token.typ == BASICTokenTyp.isSpace) {
				nextToken(token);
				continue;
			}
			break;
		}
	}

}
