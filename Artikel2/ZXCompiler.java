package zxcompiler;

import zxcompiler.ZXTokenizer.ParserToken;
import zxcompiler.ZXTokenizer.ParserToken.ZXTokenTyp;
import zxcompiler.ZXTokenizer.ZXBasicLine;

public class ZXCompiler {
	
	ZXTokenizer mTokenizer = new ZXTokenizer();
	ZXBasicLine mBasicLine = new ZXBasicLine();
	Z80Emitter  mEmitter   = new Z80Emitter();
	
	
	
	private String mCode; 
	private int mPos;
	private int mEnd;
	ParserToken lookahead = new ParserToken();
	
	public void start(byte [] zxProgram) {
		mTokenizer.init(zxProgram);
		mBasicLine = new ZXBasicLine();
		mTokenizer.getLine(mBasicLine);
		mEmitter.emitLine(mBasicLine.line);
		print(mBasicLine.toString());				
	}
	
	boolean lexan(ParserToken token) {
		boolean r = mBasicLine.getNextToken(token);
		if (r == false) {
			r = mTokenizer.getLine(mBasicLine);
			mEmitter.emitLine(mBasicLine.line);
			mEmitter.emitComment(mBasicLine.toString());
			if (r == false) return false;
			mBasicLine.getNextToken(token);
		}
		
		return true;
	}
	
	void compile() {
		while (true) {
			if (lexan(lookahead) == false) break;
			if (lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_EndOfLine ||
				lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Colon) continue;
			compileStmt();
		}
		mEmitter.writeVariables();
	}
	
	void compileStmt() {
		String literal;
			if (lookahead.typ != ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Token) {
				print("SyntaxError");
			}
			switch(lookahead.zxToken) {
				case ZXToken.ZXB_LET: {
					lexan(lookahead);
					literal = lookahead.literal;
					mEmitter.emitIntVar(literal);
					match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_literal);			
					match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Equals);
					expr();
					mEmitter.emitStoreIntegerVar(literal);
					break;
				}
				case ZXToken.ZXB_IF:
					lexan(lookahead);
					expr();
					String label = mEmitter.emitCheckFor0();
					while (true) {
						if (lexan(lookahead) == false) break;
						if (lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_EndOfLine) break;
						compileStmt();
						if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine)
							break;
					}
					mEmitter.emitLabel(label);
					break;
				case ZXToken.ZXB_PLOT:
					lexan(lookahead);;
					expr();
					match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
					expr();
					mEmitter.emitPlot();
					break;
					
				case ZXToken.ZXB_GOTO:
					lexan(lookahead);
					mEmitter.emitJumpToLine(lookahead.literal);
					break;
				case ZXToken.ZXB_GOSUB:
					lexan(lookahead);
					mEmitter.emitCallToLine(lookahead.literal);
					break;
				case ZXToken.ZXB_RETURN:
					mEmitter.emitReturn();
					break;
					
					
			
			}
		
		
	}
	
	
    void parse() {
    	lexan(lookahead);
    	while (lookahead.typ != ZXTokenizer.ParserToken.ZXTokenTyp.EOS) {
    		expr();
    		
    	}
    	
    }

	private void expr() {
		ParserToken t = new ParserToken();
		term();
		while (true) {
			switch(lookahead.typ) {
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Plus:
				t.copyFrom(lookahead);
				match(lookahead);
				term();
				mEmitter.emitPlus();
				continue;
				
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Minus:
				t.copyFrom(lookahead);
				match(lookahead);
				term();
				mEmitter.emitMinus();
				continue;
			case ZX_Token:
				switch(lookahead.zxToken) {
				case ZXToken.ZXB_ORX:
					t.copyFrom(lookahead);
					match(lookahead);
					term();
					mEmitter.emitOr();
					continue;
					
				case ZXToken.ZXB_ANDX:
					t.copyFrom(lookahead);
					match(lookahead);
					term();
					mEmitter.emitAnd();
					continue;
				default:
					return;
				}
				
				
				
			default:
				return;
			}
		}
		
	}


	private void term() {
		ParserToken t = new ParserToken();
		factor();
		while (true) {
			switch(lookahead.typ) {
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Mult:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				mEmitter.emitMult();
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Div:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				mEmitter.emitDiv();
				continue;
				
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Bigger:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				mEmitter.emitBigger();
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Smaller:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				mEmitter.emitSmaller();
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_SmallerEqual:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				mEmitter.emitSmallerEqual();
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_BiggerEqual:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				mEmitter.emitBiggerEqual();
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Unequal:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				mEmitter.emitUnequal();
				continue;
				
				
				
			default:
				return;
			}
		}
	}

	private void factor() {
		switch(lookahead.typ) {
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_OpenBracket:
				match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_OpenBracket);
				expr();
				match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Closebracket);
				break;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Integer:
				mEmitter.emitPushInteger(lookahead.literal);
				match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Integer);
				break;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_literal:
				mEmitter.emitPushIntegerVariable(lookahead.literal);
				match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_literal);
				break;
		}
		
	}

	

	private void print(String string) {
		System.out.println(string);
		
	}

	private void match(ZXTokenizer.ParserToken.ZXTokenTyp token) {
		if (lookahead.typ == token) {
			lexan(lookahead);
		} else {
			print("Nonsense in ZX Compiler");
		}
		
	}

	private void match(ParserToken token) {
		if (lookahead.typ == token.typ) {
			lexan(lookahead);
		} else {
			print("Nonsense in ZX Compiler");
		}
		
	}

}
