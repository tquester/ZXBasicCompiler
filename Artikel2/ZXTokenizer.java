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
			ZX_EndOfLine,
			ZX_Token, // LET, PLOT etc.
			EOS, ZX_Comma
		};

		public String literal; // either a varible name or a number
		public ZXTokenTyp typ; //
		public int zxToken; // Any ZX Token
		public void copyFrom(ParserToken other) {
			literal = other.literal;
			typ = other.typ;
			zxToken = other.zxToken;
		}
	};

	public byte[] mZxBasic;
	private int mPos;

	static public class ZXBasicLine {
		public int mPos;
		public int line;
		public int len;
		public byte[] bytes;

		public String toString() {
			ZXToken token = new ZXToken();
			String strLine = String.format("%d ", line);
			int pos = 0;
			while (pos < bytes.length) {
				int b = bytes[pos++];
				if (b < 0)
					b += 256;
				if (b == 0x0e) { // a number

					strLine += "{";
					for (int i = 0; i < 5; i++) {
						int hex = bytes[pos++];
						if (hex < 0)
							hex += 256;
						strLine += String.format("%02x ", hex);
					}
					strLine += "}";
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

		public boolean getNextToken(ParserToken token) {
			if (mPos >= bytes.length)
				return false;
			int b = bytes[mPos++];
			if (b < 0)
				b += 256;
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
			case 13:
				token.typ = ParserToken.ZXTokenTyp.ZX_EndOfLine;
				break;

			case ZXToken.ZXB_UNEQUAL:
				token.typ = ParserToken.ZXTokenTyp.ZX_Unequal;
				break;
			default:
				if (b >= '0' && b <= '9') {
					token.typ = ParserToken.ZXTokenTyp.ZX_Integer;
					token.literal = String.format("%c", b);
					while (true) {
						b = bytes[mPos++]; if (b < 0) b+=256;
						if (b == 0x0e) {
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
						if (!((b >= 'a' && b <= 'z') || (b >= 'A' && b <= 'Z'))) break;
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
