package zxcompiler;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.classfile.attribute.ModuleExportInfo;
import java.lang.reflect.Member;
import java.util.ArrayList;
/* ZX Colors
 * 128 If the character position is flashing, 0 if it is steady 
64 if the character position is bright, 0 if it is normal 
8* the code for the paper colour 
the code for the ink colour
 */
import java.util.Stack;

import zxcompiler.Z80Emitter.Variable;
import zxcompiler.ZXTokenizer.ParserToken;
import zxcompiler.ZXTokenizer.ParserToken.ZXTokenTyp;
import zxcompiler.ZXTokenizer.ZXBasicLine;

public class ZXCompiler {

	ZXTokenizer mTokenizer = new ZXTokenizer();
	ZXBasicLine mBasicLine = new ZXBasicLine();
	Z80Emitter mEmitter = new Z80Emitter();
	boolean mStringUsed=false;

	static public final int TYPE_INT = 0;
	static public final int TYPE_STRING = 1;
	static public final int TYPE_FLOAT = 2;
	
	public boolean mSettingList=false;
	public int mSettingOptimize=1;
	public boolean mSettingVerbose=false;
	public int mSettingStop=0;

	Stack<Integer> mTypeStack = new Stack<Integer>();

	private String mCode;
	private int mPos;
	private int mEnd;

	ParserToken lookahead = new ParserToken();
	private int mBasicStmt;
	private boolean mSettingLineNr=false;

	public void start(byte[] zxProgram) {
		mTokenizer.init(zxProgram);
		mBasicLine = new ZXBasicLine();
		mTokenizer.getLine(mBasicLine);
		mEmitter.emitStart();
		mEmitter.emitLine(mBasicLine.line);
		print(mBasicLine.toString());
	}

	boolean lexan(ParserToken token) {
		boolean r = mBasicLine.getNextToken(token);
		if (r == false) {
			mBasicStmt=1;
			r = mTokenizer.getLine(mBasicLine);
			mEmitter.emitLine(mBasicLine.line);
			mEmitter.emitComment(mBasicLine.toString());
			if (mSettingLineNr) mEmitter.emitLineNr(mBasicLine.line);
			if (r == false)
				return false;
			mBasicLine.getNextToken(token);
		}

		return true;
	}

	void compile() {
		while (true) {
			if (lexan(lookahead) == false)
				break;
			if (lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Token &&
				lookahead.zxToken == ZXToken.ZXB_STOP) break;
			if (lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_EndOfLine
					|| lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Colon)
				continue;
			compileStmt();
		}
		mEmitter.writeVariables();
		mEmitter.emitEnd();
		
	}

	void compileStmt() {
		
		if (mSettingLineNr) mEmitter.emitStmtNr(mBasicStmt++);

		mStringUsed = false;
		if (lookahead.typ != ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Token) {
			print("SyntaxError");
		}
		if (mSettingStop == 1)
			mEmitter.emitCheckBreak();
		switch (lookahead.zxToken) {
		case ZXToken.ZXB_REM:
			compileRem();
			break;
		case ZXToken.ZXB_CLS: {
			mEmitter.emitCls();
			break;
		}
		case ZXToken.ZXB_DIM:
			compileDIM();
			break;
		case ZXToken.ZXB_POKE:
			compilePOKE();
			break;
		case ZXToken.ZXB_PAPER:
			lexan(lookahead);
			expr();
			checkType(TYPE_INT);
			mEmitter.emitPaper();
			break;
		case ZXToken.ZXB_INK:
			lexan(lookahead);
			expr();
			checkType(TYPE_INT);
			mEmitter.emitInk();
			break;
		case ZXToken.ZXB_FLASH:
			lexan(lookahead);
			expr();
			checkType(TYPE_INT);
			mEmitter.emitFlash();
			break;
		case ZXToken.ZXB_BRIGHT:
			lexan(lookahead);
			expr();
			checkType(TYPE_INT);
			mEmitter.emitBright();
			break;
		case ZXToken.ZXB_OVER:
			lexan(lookahead);
			expr();
			checkType(TYPE_INT);
			mEmitter.emitOver();
			break;
		case ZXToken.ZXB_RESTORE:
			lexan(lookahead);
			mEmitter.emitRestore(lookahead.literal);
			break;
		case ZXToken.ZXB_READ:
			lexan(lookahead);
			mEmitter.emitIntVar(lookahead.literal);
			mEmitter.emitRead(lookahead.literal);
			break;
		case ZXToken.ZXB_DATA:
			compileDATA();
			break;		
		case ZXToken.ZXB_PAUSE:
			lexan(lookahead);
			expr();
			mEmitter.emitPause();
			break;
		case ZXToken.ZXB_PRINT: {
			if (lexan(lookahead) == false)
				break;
			compilePRINT();
			break;
		}
		case ZXToken.ZXB_INPUT: {
			if (lexan(lookahead) == false)
				break;
			compileINPUT();
			break;
		}
		case ZXToken.ZXB_LET: {
			compileLET();
			
			break;
		}
		case ZXToken.ZXB_IF:
			compileIF();
			break;
		case ZXToken.ZXB_PLOT:
			compilePLOT();
			break;
		case ZXToken.ZXB_DRAW:
			compileDRAW();
			break;
		case ZXToken.ZXB_CIRCLE:
			compileCIRCLE();
			break;
		case ZXToken.ZXB_GOTO:
			if (mSettingStop == 2) mEmitter.emitCheckBreak();

			lexan(lookahead);
			mEmitter.emitJumpToLine(lookahead.literal);
			break;
		case ZXToken.ZXB_GOSUB:
			if (mSettingStop == 2) mEmitter.emitCheckBreak();
			lexan(lookahead);
			mEmitter.emitCallToLine(lookahead.literal);
			break;
		case ZXToken.ZXB_RETURN:
			if (mSettingStop == 2) mEmitter.emitCheckBreak();
			mEmitter.emitReturn();
			break;
		case ZXToken.ZXB_FOR:
			if (mSettingStop == 2) mEmitter.emitCheckBreak();
			compileFor();
			break;
		case ZXToken.ZXB_NEXT:
			if (mSettingStop == 2) mEmitter.emitCheckBreak();
			compileNext();
			break;
		}
		if (mStringUsed) 
			mEmitter.emitClearTemp();
			
	}

	private void compileRem() {
		int typ=-1;
		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine) break;
			
			if (lookahead.typ == ZXTokenTyp.ZX_literal)  {
				if (lookahead.literal.compareTo("asm") == 0) {
					compileRemAsm();
					return;
				}
				if (lookahead.literal.compareToIgnoreCase("float") == 0) typ = TYPE_FLOAT;
				else if (lookahead.literal.compareToIgnoreCase("int16") == 0) typ = TYPE_INT;
				else {
					switch(typ) {
						case TYPE_FLOAT:
							System.out.println("definie "+lookahead.literal+" as float");
							mEmitter.emitFloatVar(lookahead.literal);
							break;
						case TYPE_INT: 
							System.out.println("definie "+lookahead.literal+" as int");
							mEmitter.emitIntVar(lookahead.literal);
							break;
					}
				}
			}
			
			lexan(lookahead);
		}
		// TODO Auto-generated method stub
		
	}

	private void compileRemAsm() {
		String line = mBasicLine.restOfLine();
		int p = line.indexOf(':');
		if (p == -1) 
			mEmitter.emitCommand(line, null);
		else {
			Z80Command z80cmd = mEmitter.emitCommand(line.substring(p+1),null);
			z80cmd.label = line.substring(0,p);
		}
		
		
	}

	private void compileDIM() {
		ArrayList<Integer> dims = new ArrayList<Integer>();
		lexan(lookahead);
		if (lookahead.typ != ZXTokenTyp.ZX_literal) {
			error("Erwarte Variablename");
			return;
		}
		String varname = lookahead.literal;
		Z80Emitter.Variable variable = new Z80Emitter.Variable();
		variable.typ = TYPE_INT;
		if (varname.endsWith("$")) {
			varname = varname.substring(0,varname.length()-1)+"_string";
			variable.typ = TYPE_STRING;
		}
		lexan(lookahead);
		match(ZXTokenTyp.ZX_OpenBracket);
		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_Comma) {
				lexan(lookahead);
				continue;
			} 
			else if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine || lookahead.typ == ZXTokenTyp.ZX_Closebracket) break;
			else if (lookahead.typ == ZXTokenTyp.ZX_Integer) {
				dims.add(Integer.valueOf(Integer.parseInt(lookahead.literal)));
			} else {
				error("Erwarte Zahl");
				return;
			}
			lexan(lookahead);

		}
		variable.dimen = new int[dims.size()];
		variable.name = varname;
		for (int i=0;i<dims.size();i++) {
			variable.dimen[i] = dims.get(i).intValue();
		}
		mEmitter.mMapVariables.put(varname, variable);
	}

	private void compilePOKE() {
		lexan(lookahead);
		expr();
		checkType(TYPE_INT);
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
		expr();
		checkType(TYPE_INT);
		mEmitter.emitPoke();
	}

	private void compileLET() {
		int typ;
		boolean isIndexed=false;
		String literal;
		lexan(lookahead);
		literal = lookahead.literal;
		if (literal.endsWith("$"))
			literal = literal.substring(0,literal.length()-1)+"_string";
		Z80Emitter.Variable variable = mEmitter.mMapVariables.get(literal);
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_literal);
		if (variable != null) {
			if (variable.dimen != null) {
				compileArrayAccess(variable, true);
				isIndexed = true;
			}
		}
		
		
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Equals);
 		expr();
		typ = popType();
		Variable v = mEmitter.mMapVariables.get(literal);
		if (v != null) {
			if (v.typ == TYPE_FLOAT) {
				cvToFloat(typ, v.typ);
				typ = v.typ;
			}
			
		}
		switch (typ) {
		case TYPE_INT:
			mEmitter.emitIntVar(literal);
			mEmitter.emitStoreIntegerVar(literal, isIndexed);
			break;
		case TYPE_FLOAT:
			mEmitter.emitFloatVar(literal);
			mEmitter.emitStoreFloatVar(literal, isIndexed);
			break;
		case TYPE_STRING:
			mEmitter.emitStringVar(literal);
			mEmitter.emitStoreStringVar(literal, isIndexed);
			mStringUsed = false;
			break;
		}
	}

	private void compileINPUT() {
		int typ;
		ZXTokenTyp last = ZXTokenTyp.NULL;
		boolean localAttributes = false;
		mEmitter.emitStartInput();

		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine)
				break;
			switch (lookahead.typ) {
			case ZXTokenTyp.ZX_Comma:
				last = lookahead.typ;
				mEmitter.emitPrintTab();
				lexan(lookahead);
				break;
			case ZXTokenTyp.ZX_Semicolon:
				last = lookahead.typ;
				lexan(lookahead);
				break;
			case ZXTokenTyp.ZX_Token: {
				switch (lookahead.zxToken) {
				case ZXToken.ZXB_AT:
					lexan(lookahead);
					expr();
					checkType(TYPE_INT);
					match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
					expr();
					checkType(TYPE_INT);
					mEmitter.emitPrintAt();
					break;
				case ZXToken.ZXB_INK:
				case ZXToken.ZXB_PAPER:
				case ZXToken.ZXB_BRIGHT:
				case ZXToken.ZXB_FLASH:
				case ZXToken.ZXB_INVERSE:
					compileLocalAttr();
					localAttributes = true;
					break;
				}

				break;
			}

			default:
				last = ZXTokenTyp.NULL;
				// lexan(lookahead);
				expr();
				typ = popType();
				switch (typ) {
				case TYPE_INT:
					mEmitter.emitInputInt();
					break;
				case TYPE_STRING:
					mEmitter.emitInputString();
					break;
				case TYPE_FLOAT:
					mEmitter.emitInputFloat();
					break;
				}

			}
			if (last == ZXTokenTyp.NULL) {
				mEmitter.emitPrintNewline();
			}
			if (localAttributes) {
				localAttributes = false;
				mEmitter.emitRestoreAttr();
			}

		}
	}

	private void compilePRINT() {
		int typ;
		ZXTokenTyp last = ZXTokenTyp.NULL;
		boolean localAttributes = false;
		boolean localStream = false;
		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine || lookahead.typ == ZXTokenTyp.ZX_Colon )
				break;
			switch (lookahead.typ) {
			case ZXTokenTyp.ZX_Hash:
				lexan(lookahead);
				expr();
				localStream = true;
				mEmitter.emitStream();
				
				break;
			case ZXTokenTyp.ZX_Comma:
				last = lookahead.typ;
				mEmitter.emitPrintTab();
				lexan(lookahead);
				break;
			case ZXTokenTyp.ZX_Semicolon:
				last = lookahead.typ;
				lexan(lookahead);
				break;
			case ZXTokenTyp.ZX_Token: {
				switch (lookahead.zxToken) {
				case ZXToken.ZXB_AT:
					lexan(lookahead);
					expr();
					checkType(TYPE_INT);
					match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
					expr();
					checkType(TYPE_INT);
					mEmitter.emitPrintAt();
					break;
				case ZXToken.ZXB_INK:
				case ZXToken.ZXB_PAPER:
				case ZXToken.ZXB_BRIGHT:
				case ZXToken.ZXB_FLASH:
				case ZXToken.ZXB_INVERSE:
				case ZXToken.ZXB_OVER:
					compileLocalAttr();
					localAttributes = true;
					break;
				default:
					last = ZXTokenTyp.NULL;
					// lexan(lookahead);
					expr();
					typ = popType();
					switch (typ) {
					case TYPE_INT:
						mEmitter.emitPrintInt();
						break;
					case TYPE_STRING:
						mEmitter.emitPrintString();
						break;
					case TYPE_FLOAT:
						mEmitter.emitPrintFloat();
						break;
					}
				}

				break;
			}

			default:
				last = ZXTokenTyp.NULL;
				// lexan(lookahead);
				expr();
				typ = popType();
				switch (typ) {
				case TYPE_INT:
					mEmitter.emitPrintInt();
					break;
				case TYPE_STRING:
					mEmitter.emitPrintString();
					break;
				case TYPE_FLOAT:
					mEmitter.emitPrintFloat();
					break;
				}

			}


		}
		if (last == ZXTokenTyp.NULL) {
			mEmitter.emitPrintNewline();
		}
		if (localAttributes) {
			localAttributes = false;
			mEmitter.emitRestoreAttr();
		}
		if (localStream) {
			mEmitter.emitCloseStream();
			localStream = false;
		}
	}

	private void compileCIRCLE() {
		boolean localAttributes;
		while (true) {
			lexan(lookahead);
			if (lookahead.typ == ZXTokenTyp.ZX_Token) {
				switch (lookahead.zxToken) {
				case ZXToken.ZXB_INK:
				case ZXToken.ZXB_PAPER:
				case ZXToken.ZXB_BRIGHT:
				case ZXToken.ZXB_FLASH:
				case ZXToken.ZXB_INVERSE:
					compileLocalAttr();
					localAttributes = true;
					break;
				default:
					error("Illegal option in PLOT");
				}
			} else
				break;
		}
		expr();
		checkType(TYPE_INT);
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
		expr();
		checkType(TYPE_INT);
		expr();
		checkType(TYPE_INT);
		mEmitter.emitCircle();
	}

	private void compileDRAW() {
		boolean localAttributes;
		while (true) {
			lexan(lookahead);
			if (lookahead.typ == ZXTokenTyp.ZX_Token) {
				switch (lookahead.zxToken) {
				case ZXToken.ZXB_INK:
				case ZXToken.ZXB_PAPER:
				case ZXToken.ZXB_BRIGHT:
				case ZXToken.ZXB_FLASH:
				case ZXToken.ZXB_INVERSE:
					compileLocalAttr();
					localAttributes = true;
					break;
				default:
					error("Illegal option in PLOT");
				}
			} else
				break;
		}
		if (lookahead.typ == ZXTokenTyp.ZX_Semicolon)
			lexan(lookahead);
		
		expr();
		checkType(TYPE_INT);
		lexan(lookahead);
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
		expr();
		checkType(TYPE_INT);
		mEmitter.emitDraw();
	}

	private void compilePLOT() {
		boolean localAttributes;
		while (true) {
			lexan(lookahead);
			if (lookahead.typ == ZXTokenTyp.ZX_Token) {
				switch (lookahead.zxToken) {
				case ZXToken.ZXB_INK:
				case ZXToken.ZXB_PAPER:
				case ZXToken.ZXB_BRIGHT:
				case ZXToken.ZXB_FLASH:
				case ZXToken.ZXB_INVERSE:
				case ZXToken.ZXB_OVER:
					compileLocalAttr();
					localAttributes = true;
					break;
				default:
					error("Illegal option in PLOT");
				}
			} else
				break;
		}
		if (lookahead.typ == ZXTokenTyp.ZX_Semicolon)
			lexan(lookahead);

		expr();
		checkType(TYPE_INT);
		lexan(lookahead);
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
		expr();
		checkType(TYPE_INT);
		mEmitter.emitPlot();
	}

	private void compileIF() {
 		lexan(lookahead);
		expr();
		checkType(TYPE_INT);
		String label = mEmitter.emitCheckFor0();
        lexan(lookahead);
		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_Token.ZX_Colon) {
				lexan(lookahead);
				continue;
			}
			if (lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_EndOfLine)
				break;
			compileStmt();
			if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine)
				break;
			lexan(lookahead);
			if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine)
				break;
		}
		mEmitter.emitLabel(label);
	}

	private void compileDATA() {
		mEmitter.emitStartData(mBasicLine.line);
		while (true) {
			lexan(lookahead);
			if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine)
				break;
			if (lookahead.typ == ZXTokenTyp.ZX_Integer)
				mEmitter.emitDataInt(lookahead.literal); 
			else if (lookahead.typ == ZXTokenTyp.ZX_String)
				mEmitter.emitDataString(lookahead.literal);
		}
	}
	
	private void compileFor() {
		String varname;
		String forlbl = mEmitter.getForLabel();
		lexan(lookahead);				// variable
		varname = lookahead.literal;
		String forlabel = String.format("for_%s", varname);
		lexan(lookahead);				// variable
		match(ParserToken.ZXTokenTyp.ZX_Equals);
		expr();
		mEmitter.emitIntVar(varname);
		mEmitter.emitStoreIntegerVar(varname, false);
		mEmitter.mOptimize=mSettingOptimize;
		match(ParserToken.ZXTokenTyp.ZX_Token);
		mEmitter.emitIntVar(forlabel);
		mEmitter.emitIntVar(forlabel+"_step");

		
		expr();
		mEmitter.emitStoreIntegerVar(forlabel, false);
//		lexan(lookahead);
		if (lookahead.typ == ParserToken.ZXTokenTyp.ZX_Token && lookahead.zxToken  == ZXToken.ZXB_STEP) {
			lexan(lookahead);
			expr();			
		} else {
			mEmitter.emitPush1();
			mBasicLine.unget(lookahead);
		}
		mEmitter.emitStoreIntegerVar(forlabel+"_step", false);
		mEmitter.mOptimize = mSettingOptimize;
		mEmitter.emitForLabel();
	}
	
	private void compileNext() {
		lexan(lookahead);
		mEmitter.emitNext(lookahead.literal);
	}

	private void compileLocalAttr() {
		int token = lookahead.zxToken;
		lexan(lookahead);
		expr();
		switch (token) {
		case ZXToken.ZXB_INK:
			mEmitter.emitLocalInk();
			break;
		case ZXToken.ZXB_PAPER:
			mEmitter.emitLocalPaper();
			break;
		case ZXToken.ZXB_BRIGHT:
			mEmitter.emitLocalBright();
			break;
		case ZXToken.ZXB_FLASH:
			mEmitter.emitLocalFlash();
			break;
		case ZXToken.ZXB_OVER:
			mEmitter.emitLocalOver();
			break;
		case ZXToken.ZXB_INVERSE:
			mEmitter.emitLocalInverse();
			break;
		}
	}

	void checkType(int totype) {
		int type = popType();
		if (type == totype)
			return;
		switch (totype) {
		case TYPE_INT:
			if (type == TYPE_FLOAT) {
				mEmitter.emitFloatToInt();
			} else
				error("Fehler in Typumwandlung");
			break;
		case TYPE_FLOAT:
			if (type == TYPE_FLOAT) {
				mEmitter.emitIntToFloat();
			} else
				error("Fehler in Typumwandlung");
			break;
		default:
			error("Fehler in Typumwandlung");
		}
	}

	private void error(String string) {
		System.out.println(string);

	}

	void parse() {
		lexan(lookahead);
		while (lookahead.typ != ZXTokenizer.ParserToken.ZXTokenTyp.EOS) {
			expr();

		}

	}

	// expression evaluation for function
	private void exprFn() {
		if (lookahead.typ == ZXTokenTyp.ZX_OpenBracket) {
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_OpenBracket);
			expr();
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Closebracket);			
		} else
			factor();
	}
	
	// main expression evaluation
	private void expr() {
		int typ1, typ2;
		ParserToken t = new ParserToken();
		term();
		while (true) {
			switch (lookahead.typ) {
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Plus:
				t.copyFrom(lookahead);
				match(lookahead);
				term();
				typ1 = popType();
				typ2 = popType();
				if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
					mEmitter.emitPlus();
					pushType(TYPE_INT);
				} else if (typ1 == TYPE_FLOAT && typ2 == TYPE_FLOAT) {
				    mEmitter.emitPushAddFloat();
				    pushType(TYPE_FLOAT);
				}				
				else if (typ1 == TYPE_STRING && typ2 == TYPE_STRING) {
					mEmitter.emitPlusString();
					pushType(TYPE_STRING);
				}  else if (cvToFloat(typ1, typ2)) {
					mEmitter.emitPlusFloat();
					pushType(TYPE_FLOAT);
				}
				continue;

			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Minus:
				t.copyFrom(lookahead);
				match(lookahead);
				term();
				typ1 = popType();
				typ2 = popType();
				if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
					mEmitter.emitMinus();
					pushType(TYPE_INT);
				} else if (typ1 == TYPE_FLOAT && typ2 == TYPE_FLOAT) {
				    mEmitter.emitPushSubFloat();
				    pushType(TYPE_FLOAT);
				}else if (cvToFloatSwap(typ1, typ2)) {
					mEmitter.emitMinusFloat();
					pushType(TYPE_FLOAT);
				}
				continue;
			case ZX_Token:
				switch (lookahead.zxToken) {
				case ZXToken.ZXB_ORX:
					t.copyFrom(lookahead);
					match(lookahead);
					term();
					typ1 = popType();
					typ2 = popType();
					if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
						mEmitter.emitOr();
						pushType(TYPE_INT);
					}else if (cvToFloat(typ1, typ2)) {
						cvToFloat(typ1, typ2);
						mEmitter.emitOrFloat();
						mEmitter.emitPushHL();
						pushType(TYPE_INT);
					}
					continue;

				case ZXToken.ZXB_ANDX:
					t.copyFrom(lookahead);
					match(lookahead);
					term();
					typ1 = popType();
					typ2 = popType();
					if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
						mEmitter.emitAnd();
						pushType(TYPE_INT);
					} else if (cvToFloat(typ1, typ2)) {
						
						mEmitter.emitAndFloat();
						mEmitter.emitPushHL();
						pushType(TYPE_INT);
					}
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
		int typ1, typ2;
		ParserToken t = new ParserToken();
		factor();
		while (true) {
			switch (lookahead.typ) {
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Mult:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				typ1 = popType();
				typ2 = popType();
				if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
					mEmitter.emitMult();
					pushType(TYPE_INT);
				} else if (typ1 == TYPE_FLOAT && typ2 == TYPE_FLOAT) {
					mEmitter.emitMultFloat();
					pushType(TYPE_FLOAT);
				}
				else if (cvToFloat(typ1, typ2)) {
					t.copyFrom(lookahead);
					//match(lookahead);
					//factor();
					mEmitter.emitMultFloat();
					pushType(TYPE_FLOAT);
				} else {
					error("Error in type for mult");
				}
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Div:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				typ1 = popType();
				typ2 = popType();
				if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
					mEmitter.emitDiv();
					pushType(TYPE_INT);
				} else if (typ1 == TYPE_FLOAT && typ2 == TYPE_FLOAT) {
					mEmitter.emitDivFloat();
					pushType(TYPE_FLOAT);
				}else if (cvToFloatSwap(typ1, typ2)) {
					t.copyFrom(lookahead);
					//match(lookahead);
					//factor();
					mEmitter.emitDivFloat();
					pushType(TYPE_FLOAT);
				} else {
					error("Error in type for mult");
				}
				continue;

			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Bigger:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				typ1 = popType();
				typ2 = popType();
				if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
					mEmitter.emitBigger();
					pushType(TYPE_INT);
				} else if (typ1 == TYPE_STRING && typ2 == TYPE_STRING) {
					mEmitter.emitBiggerString();
					mEmitter.emitPushHL();
					pushType(TYPE_INT);
				} else if (cvToFloatSwap(typ1, typ2)) {
					mEmitter.emitBiggerFloat();
					pushType(TYPE_INT);
				} else 
					error("Wrong type");
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Smaller:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				typ1 = popType();
				typ2 = popType();
				if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
					mEmitter.emitSmaller();
					pushType(TYPE_INT);
				} else if (typ1 == TYPE_STRING && typ2 == TYPE_STRING) {
					mEmitter.emitSmallerString();
					mEmitter.emitPushHL();
					pushType(TYPE_INT);
				} else if (cvToFloatSwap(typ1, typ2)) {
					mEmitter.emitSmallerFloat();
					pushType(TYPE_INT);
				} else 
					error("Wrong type");
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_SmallerEqual:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				typ1 = popType();
				typ2 = popType();
				if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
					mEmitter.emitSmallerEqual();
					pushType(TYPE_INT);
				}  else if (typ1 == TYPE_STRING && typ2 == TYPE_STRING) {
					mEmitter.emitSmallerEqualString();
					mEmitter.emitPushHL();
					pushType(TYPE_INT);
				} else if (cvToFloatSwap(typ1, typ2)) {
					mEmitter.emitSmallerEqualFloat();
					pushType(TYPE_INT);
				} else 
					error("Wrong type");
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_BiggerEqual:
				t.copyFrom(lookahead);
				match(lookahead);
				factor(); 
				typ1 = popType();
				typ2 = popType();
				if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
					mEmitter.emitBiggerEqual();
					pushType(TYPE_INT);
				}  else if (typ1 == TYPE_STRING && typ2 == TYPE_STRING) {
					mEmitter.emitBiggerEqualString();
					mEmitter.emitPushHL();
					pushType(TYPE_INT);
				} else if (cvToFloatSwap(typ1, typ2)) {
					mEmitter.emitBiggerEqualFloat();
					pushType(TYPE_INT);
				} else 
					error("Wrong type");
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Unequal:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				typ1 = popType();
				typ2 = popType();
				if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
					mEmitter.emitUnequal();
					pushType(TYPE_INT);
				}  else if (typ1 == TYPE_STRING && typ2 == TYPE_STRING) {
					mEmitter.emitUnequalString();
					mEmitter.emitPushHL();
					pushType(TYPE_INT);
				} else if (cvToFloat(typ1, typ2)) {
					mEmitter.emitUnequalFloat();
					pushType(TYPE_INT);
				} else 
					error("Wrong type");
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Equals:
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				typ1 = popType();
				typ2 = popType();
				if (typ1 == TYPE_INT && typ2 == TYPE_INT) {
					mEmitter.emitEqual();
					pushType(TYPE_INT);
				}  else if (typ1 == TYPE_STRING && typ2 == TYPE_STRING) {
					mEmitter.emitEqualString();
					mEmitter.emitPushHL();
					pushType(TYPE_INT);
				} else if (cvToFloat(typ1, typ2)) {
					mEmitter.emitEqualFloat();
					pushType(TYPE_INT);
				} else 
					error("Wrong type");
				continue;
			

			default:
				return;
			}
		}
	}

	// Convert to Float without swap
	// if one of the types is int and the other is float, we call
	// emitIntToFloat to push the int to the floating point stack
	// for + and * and = it is not important which comes first and
	// which goes last. For -, *, >, <, <=, >= we must swap the
	// two numbers if typ1 is INT
	private boolean cvToFloat(int typ1, int typ2) {
		if ((typ1 == TYPE_INT && typ2 == TYPE_FLOAT) || (typ1 == TYPE_FLOAT && typ2 == TYPE_INT)) {
			mEmitter.emitCvIntToFloat();
			return true;
		}
		return false;
	}

	private boolean cvToFloatSwap(int typ1, int typ2) {
		if (typ1 == TYPE_INT && typ2 == TYPE_FLOAT) {
			mEmitter.emitCvIntToFloat();
			return true;
		} else if (typ1 == TYPE_FLOAT && typ2 == TYPE_INT) {
			mEmitter.emitCvIntToFloat();
			mEmitter.swapFloat();
			return true;

		}
		return false;
	}

	private int popType() {
		Integer t = mTypeStack.pop();
		return t.intValue();
	}
	
	private int peekType() {
		Integer t = mTypeStack.peek();
		return t.intValue();
	}


	private void pushType(int typ) {
		mTypeStack.push(Integer.valueOf(typ));
	}

	private void factor() {
		int typ;
		switch (lookahead.typ) {
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_OpenBracket:
//			int type = peekType();
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_OpenBracket);
			expr();
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Closebracket);
			break;
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Integer:
			if (lookahead.floatLiteral != null) {
				if (lookahead.floatLiteral[0] != 0) {
					mEmitter.emitFloat(lookahead);
					match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Integer);
					mTypeStack.push(Integer.valueOf(TYPE_FLOAT));
					break;
				}
			}
			mEmitter.emitPushInteger(lookahead.literal);
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Integer);
			mTypeStack.push(Integer.valueOf(TYPE_INT));
			break;
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Float:
			mEmitter.emitPushFloat(lookahead.floatLiteral);
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Float);
			mTypeStack.push(Integer.valueOf(TYPE_FLOAT));
			break;
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_String:
			mEmitter.emitPushString(lookahead.literal);
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_String);
			mTypeStack.push(Integer.valueOf(TYPE_STRING));
			break;
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_literal:
			boolean isArray=false;
			
			String varname = lookahead.literal;
			int vartyp = TYPE_INT;
			if (lookahead.literal.indexOf('$') != -1) {
				vartyp = TYPE_STRING;
				varname = varname.substring(0,varname.length()-1)+"_string";
			}
			Z80Emitter.Variable variable = mEmitter.mMapVariables.get(varname);
			if (variable != null) 
				vartyp = variable.typ;
			
			isArray = compileArray(variable, vartyp);
			
			
			switch(vartyp)  
			{
				case TYPE_INT:
					mEmitter.emitPushIntegerVariable(varname, isArray);
					if (lookahead.typ == ZXTokenTyp.ZX_literal)
						lexan(lookahead);
					break;
				case TYPE_STRING:
					mEmitter.emitPushIntegerVariable(varname, isArray);
					compileSubstring(vartyp);
					if (lookahead.typ == ZXTokenTyp.ZX_literal)
						lexan(lookahead);
					break;
				case TYPE_FLOAT:
					mEmitter.emitPushFloatVar(varname, isArray);
					if (lookahead.typ == ZXTokenTyp.ZX_literal)
						lexan(lookahead);
					break;
			}
			
			pushType(vartyp);
			break;
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Token:
			switch(lookahead.zxToken) {
				case ZXToken.ZXB_RND:
					 mEmitter.emitRnd();
					 pushType(TYPE_FLOAT);
					 break;					 
				case ZXToken.ZXB_INT:
					 exprlexanfn();
					 checkType(TYPE_INT);
					 pushType(TYPE_INT);
					 break;
				case ZXToken.ZXB_VAL:
					 exprlexanfn();
					 checkType(TYPE_STRING);
					 mEmitter.emitVal();
					 pushType(TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_STR:
					 mStringUsed = true;
					 exprlexanfn();
					 typ = peekType();
					 if (typ == TYPE_FLOAT) {
						 checkType(TYPE_FLOAT);
						 mEmitter.emitStr();
					 } else {
						 mEmitter.emitStrInt();
					 }
					 pushType(TYPE_STRING);
					 break;
				case ZXToken.ZXB_CODE:
					 exprlexanfn();
					 checkType(TYPE_STRING);
					 mEmitter.emitCode();
					 pushType(TYPE_INT);
					 break;
				case ZXToken.ZXB_CHR:
					 mStringUsed = true;
					 exprlexanfn();
					 checkType(TYPE_INT);
					 mEmitter.emitChr();
					 pushType(TYPE_STRING);
					 break;
				case ZXToken.ZXB_PEEK:
					 exprlexanfn();
					 checkType(TYPE_INT);
					 mEmitter.emitPeek();
					 pushType(TYPE_INT);
					 break;
				case ZXToken.ZXB_SIN:
					exprlexanfn();
					 checkType(TYPE_FLOAT);
					 mEmitter.emitSin();
					 pushType(TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_COS:
					exprlexanfn();
					 checkType(TYPE_FLOAT);
					 mEmitter.emitCos();
					 pushType(TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_SGN:
					exprlexanfn();
					 checkType(TYPE_FLOAT);
					 mEmitter.emitTan();
					 pushType(TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_ABSX:
					 exprlexanfn();
					 checkType(TYPE_FLOAT);
					 mEmitter.emitTan();
					 pushType(TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_SQR:
					exprlexanfn();
					 checkType(TYPE_FLOAT);
					 mEmitter.emitSqr();
					 pushType(TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_LEN:
				     exprlexanfn();
					 checkType(TYPE_STRING);
					 mEmitter.emitLen();
					 pushType(TYPE_INT);
					 break;
				case ZXToken.ZXB_USR:
					 exprlexanfn();
					 typ = popType();
					 if (typ == TYPE_INT)
						 mEmitter.emitUsr();
					 else if (typ == TYPE_STRING) 
						 mEmitter.emitUsrUDG();
					 
					 pushType(TYPE_INT);
					 break;
				case ZXToken.ZXB_LN:
					exprlexanfn();
					 checkType(TYPE_FLOAT);
					 mEmitter.emitLn();
					 pushType(TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_EXP:
					exprlexanfn();
					 checkType(TYPE_FLOAT);
					 mEmitter.emitExp();
					 pushType(TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_INKEY:
					 mStringUsed = true;
					 mEmitter.emitInkey();
					 pushType(TYPE_STRING);
					 break;
				case ZXToken.ZXB_PI:
					 mEmitter.emitPushPi();
					 pushType(TYPE_FLOAT);
					 lexan(lookahead);
					 break;
					 
					
					 
			}
		}

	}


	private boolean compileArray(Variable variable, int vartyp) {
		
		lexan(lookahead);
		if (lookahead.typ != ZXTokenTyp.ZX_OpenBracket) {
			mBasicLine.unget(lookahead);
			return false;
		}
		boolean isArray = false;
		if (variable != null) {
			if (variable.dimen != null) {
				compileArrayAccess(variable, false);
				isArray=true;
			}
		}
		return isArray;
	}

	/* Parse String substrings:
	 *   (a TO b)
	 *   (a)
	 *   (a TO)
	 *   (TO a)
	 *   this may repeat for example A$(2 TO)(1)
	 */
	private void compileSubstring(int vartyp) {
		if (vartyp != TYPE_STRING) return;
		mStringUsed = true;
		if (lookahead.typ != ZXTokenTyp.ZX_OpenBracket) return;
 		lexan(lookahead);
		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_TO) 
				mEmitter.emitPushInteger("1");
			else {
			
				expr();
			}
			if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) {
				mEmitter.emitCharAt();
				if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) {
					lexan(lookahead);
					break;
				}
				
			} else {
				if (!(lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_TO))
				{
					error("Erwarte TO"); return;
				}
				lexan(lookahead);
				if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) 
					mEmitter.emitPushInteger("-1");
				else {
					expr();
				}
				mEmitter.emitSubstring();
				if (lookahead.typ != ZXTokenTyp.ZX_Closebracket) {
					error("Erwarte )");
					return;
				}
				lexan(lookahead);
				if (lookahead.typ != ZXTokenTyp.ZX_OpenBracket) 
					break;
				lexan(lookahead);
			}
		}
	}

	private void compileArrayAccess(Variable variable, boolean push) {
		match(ZXTokenTyp.ZX_Token.ZX_OpenBracket);
		for (int i=0;i<variable.dimen.length;i++) {
			
			expr();
			int faktor=1;
			if (i < variable.dimen.length ) {
				for (int j=i+1;j<variable.dimen.length;j++) {
					faktor *= variable.dimen[j];
				}
			}
			if (faktor != 1) {
				mEmitter.emitMultiPlyTopOfStack(faktor);
				mEmitter.emitPushHL();
			}
			if (lookahead.typ == ZXTokenTyp.ZX_Token.ZX_Comma) {
				lexan(lookahead);
				continue;
			}
			if (i > 0)
				mEmitter.emitPlus();
			break;
		}
		match(ZXTokenTyp.ZX_Token.ZX_Closebracket);
		if (variable.typ == TYPE_STRING || variable.typ == TYPE_INT)
			mEmitter.emitMultiPlyTopOfStack(2);
		if (variable.typ == TYPE_FLOAT)
			mEmitter.emitMultiPlyTopOfStack(5);
		if (push) {
			mEmitter.mOptimize = 0;
			mEmitter.emitPushHL();
			mEmitter.mOptimize = mEmitter.mSettingOptimize;
		}
		
		
	}

	private void exprlexan() {
		lexan(lookahead);
		expr();
		
	}
	private void exprlexanfn() {
		lexan(lookahead);
		exprFn();
		
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

	public void writeCode(String filename) {
		PrintWriter writer;
		try {
			writer = new PrintWriter(filename, "UTF-8");
			writer.println(mEmitter.sbCode.toString());
			writer.close();	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
