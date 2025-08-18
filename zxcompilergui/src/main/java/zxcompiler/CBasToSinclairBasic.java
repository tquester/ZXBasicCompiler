package zxcompiler;

import zxcompiler.ZXTokenizer.ParserToken;
import zxcompiler.ZXTokenizer.ParserToken.ZXTokenTyp;

public class CBasToSinclairBasic {

	ZXToken zxtoken = new ZXToken();
	private String mBASIC;
	private int mPos;
	private int[] mCode;
	ParserToken token = new ParserToken();
	private int mBasLen;
	
	boolean token(ParserToken token) {
		if (mPos <= mBasLen) return false;
		char c;
		while (mPos < mBasLen) {
			c = mBASIC.charAt(mPos++);
			switch(c) {
				case '=': token.typ = ZXTokenTyp.ZX_Equals; break;
				case '-': token.typ = ZXTokenTyp.ZX_Minus; break;
				case '+': token.typ = ZXTokenTyp.ZX_Plus; break;
				case '*': token.typ = ZXTokenTyp.ZX_Mult; break;
				case '/': token.typ = ZXTokenTyp.ZX_Div; break;
				case '^': token.typ = ZXTokenTyp.ZX_Exp10; break;
				case '<': 
					token.typ = ZXTokenTyp.ZX_Bigger;
					if (nextChar() == '=') 
						token.typ = ZXTokenTyp.ZX_BiggerEqual;
					if (nextChar() == '>') 
						token.typ = ZXTokenTyp.ZX_Unequal;
					break;
				case '>': token.typ = ZXTokenTyp.ZX_Equals; 
					if (nextChar() == '=') 
						token.typ = ZXTokenTyp.ZX_SmallerEqual;
					break;
				case ':': token.typ = ZXTokenTyp.ZX_Colon; break;
				case '(': token.typ = ZXTokenTyp.ZX_OpenBracket; break;
				case ')': token.typ = ZXTokenTyp.ZX_Closebracket; break;
				case '"': token.typ = ZXTokenTyp.ZX_String;
					token.literal = "";
					while (mPos < mBasLen) {
						c = mBASIC.charAt(mPos++);
						if (c == '"') break;
						token.literal+=c;
					}
					break;
				case '.':
				case '0':
				case '1':
				case '2':
				case '3':
				case '4':
				case '5':
				case '6':
				case '7':
				case '8':
				case '9':
					token.typ = ZXTokenTyp.ZX_Integer;
					while (mPos < mBasLen) {
						c = mBASIC.charAt(mPos++);
						if (!(c == '.' || (c >= '0' && c <='9'))) break;
						token.literal+=c;
					}
					break;
				default:
					if (Character.isAlphabetic(c) || c == '_') {
						token.typ = ZXTokenTyp.ZX_literal;
						while (mPos < mBasLen) {
							c = mBASIC.charAt(mPos++);
							if (!Character.isAlphabetic(c) || Character.isDigit(c) || c == '_') break;
							token.literal+=c;
						}
						Integer itok = zxtoken.mMapRTokens.get(token.literal.toUpperCase());
						if (itok != null) {
							token.zxToken = itok.intValue();
							token.typ = ZXTokenTyp.ZX_Token;
						}
					}
			}
		}
		
		
		return true;
	}

	private char nextChar() {
		if (mPos+1 >= mBasLen) return '\0';
		return mBASIC.charAt(mPos+1);
	}

	public void parseBAS(String bas) {
		mBASIC = bas;
		mBasLen = bas.length();
		mPos = 0;
		mCode = new int[bas.length()];
	}
	
	
}
