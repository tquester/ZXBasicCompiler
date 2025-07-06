package zxcompiler;

import zxcompiler.ZXTokenizer.ParserToken.ZXTokenTyp;

public class ZXTokenizer {

	static public class ParserToken {
		public static enum ZXTokenTyp {
			ZX_literal, // a variable like a or a$
			ZX_Integer, // a number
			ZX_Float, // a floatint point number
			ZX_String, // a string
			ZX_Equals, // =
			ZX_Plus, // +
			ZX_Minus, // -
			ZX_Mult, // *
			ZX_Div, // /
			ZX_Bigger, // >
			ZX_Smaller, // <
			ZX_SmallerEqual, // <=
			ZX_BiggerEqual, // >=
			ZX_Unequal, // <>
			ZX_OpenBracket, // (
			ZX_Closebracket, // )
			ZX_OpenArray, // [
			ZX_CloseArray, // ]
			ZX_Colon,
			ZX_Hash,
			ZX_Semicolon,
			ZX_EndOfLine,
			ZX_Token, // LET, PLOT etc.
			EOS, ZX_Comma, NULL
		};

		public String literal; // either a varible name or a number
		public ZXTokenTyp typ; //
		public int zxToken; // Any ZX Token
		public int[] floatLiteral;
		public void copyFrom(ParserToken other) {
			literal = other.literal;
			typ = other.typ;
			zxToken = other.zxToken;
		}
		public String toString() {
			
			if (typ == ZXTokenTyp.ZX_Token)
				return String.format("Token: %s", ZXToken.instance().tokenToStr(zxToken));
			String s = typ.toString();
			if (typ == ZXTokenTyp.ZX_Float || typ== ZXTokenTyp.ZX_Integer ||
				typ == ZXTokenTyp.ZX_String || typ == ZXTokenTyp.ZX_literal)
				 s += " = "+literal;
			return s;
		}
	};

	public byte[] mZxBasic;
	private int mPos;

	static public class ZXBasicLine {
		public int mPos;
		public int line;
		public int len;
		public byte[] bytes;
		private ParserToken mUngetToken=null;
		private ParserToken mPrevToken=new ParserToken();

		public String toString() {
			return toString(false);
		}
		
		public String toString(boolean oneStatement) {
			return toString(oneStatement, false);
		}
		public String toString(boolean oneStatement, boolean skipBinary) {
			ZXToken token = new ZXToken();
			String strLine = String.format("%d ", line);
			int pos = 0;
			if (oneStatement) { 
				pos = mPos-1;
				if (pos < 0) pos=0;
				strLine = "";
			}
			while (pos < bytes.length) {
				int b = bytes[pos++];
				if (oneStatement) {
					if (b == ':') break;
				}
				if (b < 0)
					b += 256;
				if (b == 0x0e) { // a number
					if (skipBinary) {
						pos+=5;
					} else {
						strLine += "{";
						for (int i = 0; i < 5; i++) {
							int hex = bytes[pos++];
							if (hex < 0)
								hex += 256;
							strLine += String.format("%02x ", hex);
						}
						strLine += "}";
					}
				} else {
					String strToken = token.mMapTokens.get(b);
					if (strToken == null)
						strLine += String.format("%c", b);
					else
						strLine += " " + strToken + " ";
				}

			}
			return strLine;
		}
		
		public void unget(ParserToken token) {
			mUngetToken = new ParserToken();
			mUngetToken.copyFrom(token);
			token.copyFrom(mPrevToken);
		}

		public void ungetLastToken() {
			mUngetToken = new ParserToken();
			mUngetToken.copyFrom(mPrevToken);
		}

		public boolean getNextToken(ParserToken token) {
			mPrevToken.copyFrom(token);
			if (mUngetToken != null)
			{
				token.copyFrom(mUngetToken);
				mUngetToken = null;
				return true;
				
			}
			if (mPos >= bytes.length)
				return false;
			int b = bytes[mPos++];
			if (b < 0)
				b += 256;
			if (b == 14) {
				mPos += 5;
				b = bytes[mPos++];
			}
			switch (b) {
			case '+':
				token.typ = ParserToken.ZXTokenTyp.ZX_Plus;
				break;
			case '-':
				token.typ = ParserToken.ZXTokenTyp.ZX_Minus;
				break;
			case '/':
				token.typ = ParserToken.ZXTokenTyp.ZX_Div;
				break;
			case '*':
				token.typ = ParserToken.ZXTokenTyp.ZX_Mult;
				break;
			case '(':
				token.typ = ParserToken.ZXTokenTyp.ZX_OpenBracket;
				break;
			case ')':
				token.typ = ParserToken.ZXTokenTyp.ZX_Closebracket;
				break;
			case '[':
				token.typ = ParserToken.ZXTokenTyp.ZX_OpenArray;
				break;
			case ']':
				token.typ = ParserToken.ZXTokenTyp.ZX_CloseArray;
				break;
			case '#':
				token.typ = ParserToken.ZXTokenTyp.ZX_Hash;
				break;
			case '>':
				token.typ = ParserToken.ZXTokenTyp.ZX_Bigger;
				break;
			case '<':
				token.typ = ParserToken.ZXTokenTyp.ZX_Smaller;
				break;
			case '=':
				token.typ = ParserToken.ZXTokenTyp.ZX_Equals;
				break;
			case ZXToken.ZXB_BIGGERTHAN:
				token.typ = ParserToken.ZXTokenTyp.ZX_BiggerEqual;
				break;
			case ZXToken.ZXB_SMALLERTHAN:
				token.typ = ParserToken.ZXTokenTyp.ZX_SmallerEqual;
				break;
			case ':':
				token.typ = ParserToken.ZXTokenTyp.ZX_Colon;
				break;
			case ',':
				token.typ = ParserToken.ZXTokenTyp.ZX_Comma;
				break;
			case ';':
				token.typ = ParserToken.ZXTokenTyp.ZX_Semicolon;
				break;
			case 13:
				token.typ = ParserToken.ZXTokenTyp.ZX_EndOfLine;
				break;
			case 34: // String
				token.typ = ParserToken.ZXTokenTyp.ZX_String;
				token.literal = "";
				while (true) {
					b = bytes[mPos++];
					if (b == 34) 
						break;
					if (b > 0) {
						token.literal += (char)b;
					} else {
						int c = b+256;
						token.literal += String.format("\\%02x", c);
					}
				}
				break;

			case ZXToken.ZXB_UNEQUAL:
				token.typ = ParserToken.ZXTokenTyp.ZX_Unequal;
				break;
			default:
				if (b >= '0' && b <= '9') {
					token.typ = ParserToken.ZXTokenTyp.ZX_Integer;
					token.literal = String.format("%c", b);
					while (true) {
						b = bytes[mPos++]; 
						if (b == 13) break;
						if (b < 0) b+=256;
						if (b == 0x0e) {
							token.floatLiteral = new int[5];
							for (int i=0;i<5;i++) {
								token.floatLiteral[i] = bytes[mPos+i];
							}
							mPos+=5;
							break;
						}
						token.literal += String.format("%c", b);
					}
					break;
				}
				if ((b >= 'a' && b <= 'z') || (b >= 'A' && b <= 'Z') ) {
					token.typ = ParserToken.ZXTokenTyp.ZX_literal;
					token.literal = String.format("%c", b);
					while (true) {
						b = bytes[mPos]; if (b < 0) b+=256;
						if (!(
								(b >= 'a' && b <= 'z') || 
								(b >= 'A' && b <= 'Z') || 
								b == '$' || 
								(b >= '0' && b <= '9'))) break;
						mPos++;
						token.literal += String.format("%c", b);
					}
					break;
				}
				if (b >= 0xA5) {
					token.typ = ParserToken.ZXTokenTyp.ZX_Token;
					token.zxToken = b;
					break;
				}
			}

			return true;
		}

		public String restOfLine() {
			String result="";
			while (mPos < bytes.length)
				result += (char)bytes[mPos++];
			return result;
		}

		public Object getStmt() {
			return toString(true);
		}
	}

	void init(byte[] basicProgram) {
		mZxBasic = new byte[basicProgram.length - 5];
		int pos = 0;
		for (int i = 5; i < basicProgram.length; i++)
			mZxBasic[pos++] = basicProgram[i];
		mPos = 0;
	}

	boolean getLine(ZXBasicLine line) {
		if (mPos >= mZxBasic.length)
			return false;
		int iLine = b2int(mZxBasic[mPos]) * 256 + b2int(mZxBasic[mPos + 1]);
		int iLen = b2int(mZxBasic[mPos + 2]) + b2int(mZxBasic[mPos + 3]) * 256;
		line.line = iLine;
		if (iLine == 0x7800) return false; // todo; where is the end of the BASIC program on tape?
		line.len = iLen;
		line.mPos = 0;
		line.bytes = new byte[iLen];
		
		for (int i = 0; i < iLen; i++) {
			if (mPos + 5 + i >= mZxBasic.length ) break;
			line.bytes[i] = mZxBasic[mPos + 4 + i];
		}
		mPos += iLen + 4;
		return true;
	}

	private int b2int(byte b) {
		return b < 0 ? (int) b + 256 : (int) b;
	}

}
