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

import zxcompiler.Z80Emitter.CDefFN;
import zxcompiler.Z80Emitter.Variable;
import zxcompiler.ZXTokenizer.ParserToken;
import zxcompiler.ZXTokenizer.ParserToken.ZXTokenTyp;
import zxcompiler.ZXTokenizer.ZXBasicLine;

public class ZXCompiler {
	
	class CExprStackEntry {
		public VARTYP typ;
		public int size;
		CExprStackEntry(VARTYP typ, int size) {
			this.typ = typ;
			this.size = size;
		}
		public String toString() {
			return String.format("%s - %d", this.typ.toString(), this.size);
		}
	};
	


	ZXTokenizer mTokenizer = new ZXTokenizer();
	ZXBasicLine mBasicLine = new ZXBasicLine();
	public Z80Emitter mEmitter = new Z80Emitter();
	public StringBuilder mBASICSource = new StringBuilder();
	boolean mStringUsed=false;
	


	
	public boolean mSettingList=false;
	public int mSettingOptimize=0;
	public boolean mSettingVerbose=false;
	public boolean mSettingCompileDebug=false;
	public int mSettingStop=0;
	public boolean mSettingLineNr=false;
	public boolean mSettingsShortCircuit=false;
	public String mSettingBasicOutput = null;
	public VARTYP mDefaultType=VARTYP.TYPE_INT;
	public VARTYP mDefaultDataType=VARTYP.TYPE_UNDEF;
	private int mPass;

	Stack<CExprStackEntry> mTypeStack = new Stack<CExprStackEntry>();

	private String mFirstData=null;
	private String mCode;
	private int mPos;
	private int mEnd;
	boolean localAttributes = false;
	boolean localStream = false;

	ParserToken lookahead = new ParserToken();
	private int mBasicStmt;
	private ZXToken mzxToken = new ZXToken();
	private boolean mIsFactor;
	private String mFactorLiteral;
	private byte[] mZXProgram;
	private boolean mListing;
	private int mPopSize;

	public void start(byte[] zxProgram) {
		mListing = false;
		mZXProgram = zxProgram;
		mTokenizer.init(zxProgram);
		mBasicLine = new ZXBasicLine();
		mTokenizer.getLine(mBasicLine);
		mEmitter.mSettingDebug = mSettingCompileDebug;
		mEmitter.emitStart();
		//mEmitter.emitLine(mBasicLine.line);
		
		print(mBasicLine.toString());
	}

	boolean lexan(ParserToken token) {
		boolean r = mBasicLine.getNextToken(token);
		if (r == false) {
			mBasicStmt=1;
			r = mTokenizer.getLine(mBasicLine);
			if (mPass == 1) 
				mEmitter.storeLine(mBasicLine.line);
			if (mListing) {
				mEmitter.emitLine(mBasicLine.line);
				mEmitter.emitComment(mBasicLine.toString(false, true));
				mBASICSource.append(mBasicLine.toString(false, true, true)+"\r\n");
				if (mSettingLineNr) mEmitter.emitLineNr(mBasicLine.line);
				
			}
			if (r == false)
				return false;
			mBasicLine.getNextToken(token);
		}

		return true;
	}
	

	public void compile() {
		try {
			mEmitter.mSBLog = new StringBuilder();
			mPass = 1;
			mFirstData = null;
			compileDim();
			mPass = 2;
			mFirstData = null;
			mListing = true;
			mEmitter.mLog = true;
			mTokenizer.init(mZXProgram);
			mTokenizer.getLine(mBasicLine);
			
	 		while (true) {
				if (lexan(lookahead) == false)
					break;
				if (lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Token &&
					lookahead.zxToken == ZXToken.ZXB_STOP || lookahead.zxToken == ZXToken.ZXB_ENDOFCODE) break;
				if (lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_EndOfLine
						|| lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Colon)
					continue;
				compileStmt();
			}
	 		if (mFirstData != null)
	 			mEmitter.emitFirstRestore(mFirstData);
			mEmitter.writeVariables();
			mEmitter.emitEnd();
		}
		catch(Exception e) {
			e.printStackTrace();
			mEmitter.log(e.getMessage());
			mEmitter.log(e.getClass().toString());
			StackTraceElement[] elems = e.getStackTrace();
			for (StackTraceElement elem: elems) {
				mEmitter.log(elem.toString());
			}
		}
		
	}
	
	void compileDim() {
		mTokenizer.init(mZXProgram);
		mTokenizer.getLine(mBasicLine);
		mListing=false;
		while (true) {
			if (lexan(lookahead) == false)
				break;
			if (lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Token &&
					lookahead.zxToken == ZXToken.ZXB_STOP || lookahead.zxToken == ZXToken.ZXB_ENDOFCODE) break;
				if (lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_EndOfLine
						|| lookahead.typ == ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Colon)
					continue;
			compileDimStmt();
		}
		//mEmitter.writeVariables();
		//mEmitter.emitEnd();
		
	}

	private void compileDimStmt() {
		if (lookahead.typ == ZXTokenTyp.ZX_Token) {
			switch (lookahead.zxToken) {
			case ZXToken.ZXB_DATA:
				mEmitter.storeDataLine(mBasicLine.line);
				mBasicLine.restOfLine();
				break;
			case ZXToken.ZXB_DIM:
				
				mEmitter.emitComment(String.format("%d.%s %s", mBasicLine.line, mBasicStmt, mBasicLine.toString(true, true)));
				compileDIM();
				break;
			default:
				while (true) {
					if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine || lookahead.typ == ZXTokenTyp.ZX_Colon) break;
					lexan(lookahead);
				}
			}
		}
		
	}

	void compileStmt() {
		if (mTypeStack.size() > 0) {
			System.out.println("Typestack error");
		}
		if (!(lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_REM)) {
			String stmt =  mBasicLine.getStmt();
			mEmitter.emitBasicLine(mBasicLine.line, mBasicStmt, stmt);
			mEmitter.emitComment(String.format("\t\t%d.%d %s",mBasicLine.line, mBasicStmt, stmt));
		}
		if (mSettingLineNr) mEmitter.emitStmtNr(mBasicStmt);
		if (mSettingCompileDebug) mEmitter.emitDebug(mBasicLine.line, mBasicStmt);
		mBasicStmt++;
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
		case ZXToken.ZXB_DEFFN:
			compileDefFn();
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
			cvToType(popType(), VARTYP.TYPE_INT);
			mEmitter.emitPaper();
			popType();
			break;
		case ZXToken.ZXB_INK:
			lexan(lookahead);
			expr();
			cvToType(popType(), VARTYP.TYPE_INT);
			mEmitter.emitInk();
			popType();
			break;
		case ZXToken.ZXB_FLASH:
			lexan(lookahead);
			expr();
			cvToType(popType(), VARTYP.TYPE_INT);
			mEmitter.emitFlash();
			popType();
			break;
		case ZXToken.ZXB_BRIGHT:
			lexan(lookahead);
			expr();
			cvToType(popType(), VARTYP.TYPE_INT);
			mEmitter.emitBright();
			popType();
			break;
		case ZXToken.ZXB_OVER:
			lexan(lookahead);
			expr();
			cvToType(popType(), VARTYP.TYPE_INT);
			mEmitter.emitOver();
			popType();
			break;
		case ZXToken.ZXB_READ:
			compileRead();
			break;
		case ZXToken.ZXB_DATA:
			compileDATA();
			break;		
		case ZXToken.ZXB_PAUSE:
			lexan(lookahead);
			expr();
			cvToType(popType(), VARTYP.TYPE_INT);
			mEmitter.emitPause();
			popType();
			break;
		case ZXToken.ZXB_LPRINT:
			if (lexan(lookahead) == false)
				break;
			compilePRINT(3);
			break;
		case ZXToken.ZXB_PRINT: {
			if (lexan(lookahead) == false)
				break;
			compilePRINT(2);
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
		case ZXToken.ZXB_OUT:
			compileOUT();
			break;
		case ZXToken.ZXB_DRAW:
			compileDRAW();
			break;
		case ZXToken.ZXB_BORDER:
			compileBorder();
			break;
		case ZXToken.ZXB_BEEP:
			compileBeep();
			break;
		case ZXToken.ZXB_CIRCLE:
			compileCIRCLE();
			break;
		case ZXToken.ZXB_RESTORE:
			mIsFactor = true;
		//	mEmitter.startTempCode();
			lexan(lookahead);
			if (lookahead.typ == ZXTokenTyp.ZX_Colon || lookahead.typ == ZXTokenTyp.ZX_EndOfLine)
			{
				if (mFirstData != null)
					mEmitter.emitRestore2(mFirstData);
			} else {
				expr();
				cvToType(popType(), VARTYP.TYPE_INT);
				popType();
				/*
				if (mIsFactor) {
					mEmitter.stopTempCode();
	
			
					mEmitter.emitRestore(mEmitter.findDataLine(Integer.parseInt(mFactorLiteral)));
				}
				else {
					mEmitter.writeTempCode();
					mEmitter.stopTempCode();
				*/
					mEmitter.emitRestoreVar();
					mEmitter.mUsesVarData = true;
	
				//}
			}
			break;
			
		case ZXToken.ZXB_GOTO:
			if (mSettingStop == 2) mEmitter.emitCheckBreak();
			mIsFactor = true;
			mEmitter.startTempCode();
			lexan(lookahead);
			expr();
			cvToType(popType(), VARTYP.TYPE_INT);
			popType();
			if (mIsFactor) {
				mEmitter.stopTempCode();
				mEmitter.emitJumpToLine(mEmitter.findCodeLine(Integer.parseInt(mFactorLiteral)));
			}
			else {
				mEmitter.writeTempCode();
				mEmitter.stopTempCode();
				mEmitter.emitGotoVar();
				mEmitter.mUsesVarGoto = true;
			}
			break;
		case ZXToken.ZXB_GOSUB:
			if (mSettingStop == 2) mEmitter.emitCheckBreak();
			mIsFactor = true;
			mEmitter.startTempCode();
			lexan(lookahead);
			expr();
			cvToType(popType(), VARTYP.TYPE_INT);
			popType();
			if (mIsFactor) {
				mEmitter.stopTempCode();
				mEmitter.emitCallToLine(mEmitter.findCodeLine(Integer.parseInt(mFactorLiteral)));
			}
			else {
				mEmitter.writeTempCode();
				mEmitter.stopTempCode();
				mEmitter.emitGosubVar();
				mEmitter.mUsesVarGoto = true;
			}
			
			
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
		if (mTypeStack.size() > 0) {
			System.out.println("Typestack error");
		}
		if (mStringUsed) 
			mEmitter.emitClearTemp();
			
	}

	private void compileRead() {
		// TODO Auto-generated method stub
		
		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine || lookahead.typ == ZXTokenTyp.ZX_Colon) break;
			lexan(lookahead);
			if (lookahead.typ == ZXTokenTyp.ZX_Comma) continue;
			if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine || lookahead.typ == ZXTokenTyp.ZX_Colon) break;
			Variable var = mEmitter.getVariable(lookahead.literal);
			if (var == null) {
				var = mEmitter.emitVar(lookahead.literal, mDefaultType);
			}
			boolean isArray=false;
				lexan(lookahead);
				
			switch(var.typ) {
			case TYPE_INT:
				mEmitter.emitReadInt(var.name);
				break;
			case TYPE_STRING:
				if (var.dimen != null)
					compileReadFixedString(var,isArray);
				else
					mEmitter.emitReadString(var.name,isArray, var);
				break;
			case TYPE_FLOAT:
				mEmitter.emitReadFloat(lookahead.literal, isArray);
				break;
			}
			
		}
		

		
	}

	private void compileDefFn() {
		CDefFN deffn = new CDefFN();
		lexan(lookahead);
		deffn.name = lookahead.literal;
		String lblname = String.format("ZX_FN_%s", deffn.name);
		mEmitter.emitJump(lblname+"_END");
		mEmitter.emitLabel(lblname);
		mEmitter.addDefFN(deffn);
		lexan(lookahead);
		check(ZXTokenTyp.ZX_OpenBracket);
		while (true) {
			lexan(lookahead);
			if (lookahead.typ == ZXTokenTyp.ZX_Comma) continue;
			if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) break;
			if (lookahead.typ == ZXTokenTyp.ZX_literal) {
				Variable var= new Variable();
				var.name = String.format("fn_%s_%s", deffn.name, lookahead.literal);
				var.typ = mDefaultType;
				Variable var2 = mEmitter.getVariable(lookahead.literal);
				if (var2 != null)
					var.typ = var2.typ;
				deffn.mVariables.put(lookahead.literal, var);
				mEmitter.addVariable(var.name, var);
				deffn.mListVariables.add(var);
			}
		}
		mEmitter.setCurDefFn(deffn);
		lexan(lookahead);
		match(ZXTokenTyp.ZX_Equals);
		expr();
		VARTYP typ = popType();
		deffn.typ = typ;
		switch(typ) {
		case VARTYP.TYPE_INT:
		case VARTYP.TYPE_STRING:
			mEmitter.emitPopHL();
		}
		mEmitter.emitReturn();
		mEmitter.emitLabel(lblname+"_END");
		mEmitter.setCurDefFn(null);
		
	}
	
	private void compileFN() {
		CDefFN lastFN = mEmitter.getCurDefFN();
		lexan(lookahead);
		CDefFN fn = mEmitter.getDefFn(lookahead.literal);
		int varid=0;
		lexan(lookahead);
		check(ZXTokenTyp.ZX_OpenBracket);
		lexan(lookahead);
		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_Comma) {
				lexan(lookahead);
				continue;
			}
			if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) {
				lexan(lookahead);
				break;
			}
			expr();
			Variable var = fn.mListVariables.get(varid++);
			cvToType(popType(),var.typ);
			mEmitter.emitStoreVariable(var.typ, var.name, false);
			popType();
		}
		mEmitter.emitCallFN(fn);
		if (fn.typ != VARTYP.TYPE_FLOAT)
			mEmitter.emitPushHL();
		pushType(fn.typ);
		
	}

	private void compileOUT() {
		lexan(lookahead);
		expr();
		cvToType(popType(), VARTYP.TYPE_INT);
		popType();
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
		expr();
		cvToType(popType(), VARTYP.TYPE_INT);
		popType();
		mEmitter.emitOut();
		
	}

	private void compileRem() {
		String remLine = mBasicLine.restOfLine();
		lookahead.typ = ZXTokenTyp.ZX_EndOfLine;
		
		parseRemLine(remLine);
	}
	
	
	private void parseRemLine(String line) {
		VARTYP typ=VARTYP.TYPE_UNDEF;
		String[] words = line.split(" ");
		int id=0;
		while (id < words.length) {
			    String word = words[id++].trim();
			    switch(word.toLowerCase()) {
			    case "asm":
					id = compileRemAsm(words, id);
					return;
			    case "data":
					if (id >= words.length) break;
					word = words[id++].trim();;
					
					switch(word.toLowerCase()) {
						case "int16": mDefaultDataType = VARTYP.TYPE_INT; break;
						case "float": mDefaultDataType = VARTYP.TYPE_FLOAT; break;
					}
					break;
			    case "float":
					typ = VARTYP.TYPE_FLOAT;
					id = compileRemVarsToType(typ, words, id);
					break;
			    case "int16":
					typ = VARTYP.TYPE_INT;
					id = compileRemVarsToType(typ, words, id);
					break;
			    case "pause":
			    	mEmitter.emitPushInteger(words[id]);
			    	mEmitter.emitPauseAbs();
			    	break;
				}
			}
		
		// TODO Auto-generated method stub
		
	}

	private int compileRemVarsToType(VARTYP typ, String[] words, int id) {
		String varname;
		while (id < words.length) {
			String word = words[id++].trim();
			varname = word;
			int pos = mBasicLine.mPos;
			if (word.endsWith("()")) {
				varname = varname.substring(0,varname.length()-2)+ "_array";
				word = words[id++];
			}
			switch(typ) {
				case VARTYP.TYPE_FLOAT:
					System.out.println("definie "+varname+" as float");
					mEmitter.emitFloatVar(varname);
					break;
				case VARTYP.TYPE_INT: 
					System.out.println("definie "+varname+" as int");
					mEmitter.emitIntVar(varname);
					break;
			}
		}
		return id;
		
	}

	private boolean IsEndToken(ZXTokenTyp typ) {
		return (typ == ZXTokenTyp.ZX_Colon || typ == ZXTokenTyp.ZX_EndOfLine);
	}

	private int compileRemAsm(String[] words, int id) {
		
		String line = "";
		while (id < words.length) line += words[id++]+" ";
		int p = line.indexOf(':');
		if (p == -1) 
			mEmitter.emitCommand(line, null);
		else {
			Z80Command z80cmd = mEmitter.emitCommand(line.substring(p+1),null);
			z80cmd.label = line.substring(0,p);
		}
		return id;
		
		
	}
	
	/*
	 * If we dim an int or float array, a number of ints or floats are created. 
	 * DIM x(1) creates the variable x_array
	 * 
	 * If we dim a string, a fixed length string is created
	 * dim a$(10) creates a_string with a fixed length of 10
	 * dim b$(10,10) creates 10 strings with a fixed length of 10
	 * 
	 * We do not use the heap while assigning the string but the heap is used to push a string to
	 * the stack on expr. In this case the fixed length string will be prefixed by its length and
	 * a heap entry with type 1 (temp) will be created.
	 * The assignment in let will remove the length information and store the text only also it will
	 * cut the text to the length
	 * dim x$(2,3)
	 * let x$(1) = "12345"
	 * let x$(2) = "1"
	 * x$(1) = "123"
	 * x$(2) = "1  "
	 * 
	 * also we can assign parts
	 * x$(1, 1) = "x"
	 * x$(1, 2 to 3) = "xy"
	 * x$(1,  to 2) = "xy"
	 * x$(1, 2 to) = "xy"
	 * 
	 */

	private void compileDIM() {
		boolean existing = false;
		int arraySize = 0;
		VARTYP vartype = mDefaultType;
		ArrayList<Integer> dims = new ArrayList<Integer>();
		lexan(lookahead);
		if (lookahead.typ != ZXTokenTyp.ZX_literal) {
			error("Erwarte Variablename");
			return;
		}
		String name = lookahead.literal;
		String varname = name+"_array"; 
		if (name.endsWith("$")) {
			name = name.substring(0, name.length() - 1) + "_string";
			vartype = VARTYP.TYPE_STRING;
			varname = name;
		}

		
		Z80Emitter.Variable variable;
		variable = mEmitter.getVariable(varname);
		if (variable == null) {
			variable = mEmitter.createVar(varname);
			variable.typ = mDefaultType;
		} else {
			if (variable.dimen != null) {
				existing=true;
				arraySize = 0;
				for (int d: variable.dimen) {
					if (arraySize == 0) 
						arraySize = d+1;
					else
						arraySize *= d+1;
				}
			}
			
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
		if (!existing) {
			variable.dimen = new int[dims.size()];
			variable.name = varname;
			variable.typ = vartype;
			arraySize = 0;
			for (int i=0;i<dims.size();i++) {
				variable.dimen[i] = dims.get(i).intValue();
				if (arraySize == 0) 
					arraySize = variable.dimen[i]+1;
				else
					arraySize *= (variable.dimen[i]+1);
			}
			mEmitter.addVariable(varname, variable);
		}
		switch(variable.typ) {
		case TYPE_INT:
			mEmitter.emitClearArray(variable.name,2*arraySize);
			break;
		case TYPE_FLOAT:
			mEmitter.emitClearArray(variable.name, 5*arraySize);
			break;
		case TYPE_STRING:
			mEmitter.emitClearStringArray(variable.name, arraySize);
			break;
			
			
			
		}
		
	}

	private void compilePOKE() {
		lexan(lookahead);
		expr();
		cvToType(popType(), VARTYP.TYPE_INT);
		popType();
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
		expr();
		cvToType(popType(), VARTYP.TYPE_INT);
		popType();
		mEmitter.emitPoke();
	}

	private void compileLET() {
		VARTYP typ;
		boolean isIndexed=false;
		String literal;
		lexan(lookahead);
		literal = lookahead.literal;
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_literal);
		if (literal.endsWith("$"))
			literal = literal.substring(0,literal.length()-1)+"_string";
		else  {
			if (lookahead.typ == ZXTokenTyp.ZX_OpenBracket) {
				literal = literal+"_array";
			}
		}
		Z80Emitter.Variable variable = mEmitter.getVariable(literal);
		
		if (variable != null) {
			if (variable.typ == VARTYP.TYPE_STRING && variable.dimen != null) {
				compileLetFixedString(variable);
			    return;
			}
		} else 
			error("Variable "+literal+" not found");
		
		
		
		
		if (lookahead.typ == ZXTokenTyp.ZX_OpenBracket) {
			
			if (variable.typ != VARTYP.TYPE_STRING) {
				Variable var = variable;
				if (var != null) {
					if (var.dimen != null)  {
						variable = var;
						literal = var.name;
						compileArrayAccess(var, true);
						isIndexed = true;
					}
				} else
					error("Variable "+literal+"_array not found");
			}
			if (variable.typ == VARTYP.TYPE_STRING) {
				compileStringSubstring();
			//	mEmitter.emitPushVarAddress(variable);
				lexan(lookahead);
				isIndexed=true;
			}
		}
		
		
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Equals);
 		expr();
 		VARTYP vartyp = mDefaultType;
		typ = popType();
		Variable v = mEmitter.getVariable(literal);
		if (v == null) {
			if (typ == VARTYP.TYPE_STRING) {
				v = mEmitter.emitStringVar(literal);
			} else {
				if (mDefaultType == VARTYP.TYPE_INT)
					v = mEmitter.emitIntVar(literal);
				else if (mDefaultType == VARTYP.TYPE_FLOAT)
					v = mEmitter.emitFloatVar(literal);
			}
		}
		if (v != null)  {
			vartyp = v.typ;
		}
		if (typ == VARTYP.TYPE_STRING) vartyp = typ;
		cvToType(typ, vartyp);
		popType();
		switch (vartyp) {
		case TYPE_INT:
			mEmitter.emitStoreIntegerVar(literal, isIndexed);
			break;
		case TYPE_FLOAT:
			mEmitter.emitStoreFloatVar(literal, isIndexed);
			break;
		case TYPE_STRING:
			mEmitter.emitStoreStringVar(literal, isIndexed, typ, mPopSize);
			mStringUsed = false;
			break;
		case TYPE_FIXSTRING:
			mEmitter.emitStoreStringFix(literal, isIndexed, mPopSize);
			mStringUsed = false;
			break;
		
		}
	}

	private void CompileLiteralFixString(Variable var) {
		int dimenSize = var.dimen.length;
		int stringSize = var.dimen[var.dimen.length-1];
		boolean bSetSubstring = false;
		boolean closed=false;
		boolean needsPlus=false;
		lexan(lookahead);
		if (lookahead.typ == ZXTokenTyp.ZX_OpenBracket) {
		   if (dimenSize > 1) {
			   for (int i=0;i<dimenSize-1;i++) {
				   if (i >= 2) mEmitter.emitPlus();
				   lexan(lookahead);
				   needsPlus = true;
				   expr();
				   cvToType(popType(), VARTYP.TYPE_INT);
				   popType();
				 
				   int faktor =1;
				   for (int j=i+1;j<dimenSize;j++) faktor *= var.dimen[j];
				   //mEmitter.emitPushInteger(String.format("%d", faktor));
				   //mEmitter.emitMult();
				   mEmitter.emitMultiPlyTopOfStackPush(faktor);
				   if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) {
					   closed = true;
					   break;
				   }
				   if (lookahead.typ != ZXTokenTyp.ZX_Comma) {
					   System.out.printf("Expected comma");
					   return;
				   }
			   }
		   }
		   mEmitter.emitPushVarAddress(var);
		   pushType(VARTYP.TYPE_STRING);
		   if (needsPlus) mEmitter.emitPlus();
		   if (!closed) {
			   while (lookahead.typ == ZXTokenTyp.ZX_OpenBracket || lookahead.typ == ZXTokenTyp.ZX_Comma) {
				   bSetSubstring = true;
				   lexan(lookahead);
				   if (lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_TO) {
					   mEmitter.emitPushInteger("1");
					   pushType(VARTYP.TYPE_INT);
					   lexan(lookahead);
					   expr();
					   cvToType(popType(), VARTYP.TYPE_INT);
				

					   // x( TO 1) after the TO without a start there is always a number.
				   } else {
					   // either n or n to m
					   expr();

					   cvToType(popType(), VARTYP.TYPE_INT);

					   if (lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_TO) {
						   lexan(lookahead);
						   if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) {
							   mEmitter.emitPushInteger("-1");
							   pushType(VARTYP.TYPE_INT);
						   } else {
							   expr();
							   cvToType(popType(), VARTYP.TYPE_INT);
						   }
					   }
					   else {
						   mEmitter.emitDup();
						   pushType(VARTYP.TYPE_INT);
					   }
				   }
				   if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) {
					   if (!bSetSubstring) {
						    popType();
							pushType(VARTYP.TYPE_FIXSTRING, stringSize);
						} else {
							popType();
							popType();
							popType();
							mEmitter.emitFixedStringSubString();
							pushType(VARTYP.TYPE_STRING);
						}
					   lexan(lookahead);
				   }
					   
			   }
		   } else {
			   if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) {
				   lexan(lookahead);
				   if (!bSetSubstring) {
					   popType();
						pushType(VARTYP.TYPE_FIXSTRING, stringSize);
					} else {
						mEmitter.emitFixedStringSubString();
						popType();
						pushType(VARTYP.TYPE_STRING);
					}
			   }			   
		   }
		  // match(ZXTokenTyp.ZX_Closebracket);
		} else {
			mEmitter.emitPushVarAddress(var);
			pushType(VARTYP.TYPE_FIXSTRING, var.getFixStringLen());
		}
		
		
		
	}

	private void compileLetFixedString(Variable var) {
		int dimenSize = var.dimen.length;
		int stringSize = var.dimen[var.dimen.length-1];
		boolean bSetSubstring = false;
		boolean closed=false;
		boolean needsPlus = false;
		if (lookahead.typ == ZXTokenTyp.ZX_OpenBracket) {
		   if (dimenSize > 1) {
			   for (int i=0;i<dimenSize-1;i++) {
				   if (i >= 2) mEmitter.emitPlus();
				   lexan(lookahead);
				   expr();
				   needsPlus = true;
				   cvToType(popType(), VARTYP.TYPE_INT);
				   popType();
				   int faktor =1;
				   for (int j=i+1;j<dimenSize;j++) faktor *= var.dimen[j];
				   mEmitter.emitMultiPlyTopOfStackPush(faktor);
				   //mEmitter.emitPushInteger(String.format("%d", faktor));
				   //mEmitter.emitMult();
				   if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) {
					   closed = true;
					   break;
				   }
				   if (lookahead.typ != ZXTokenTyp.ZX_Comma) {
					   System.out.printf("Expected comma");
					   return;
				   }
			   }
		   }
		   mEmitter.emitPushVarAddress(var);
		   if (needsPlus) mEmitter.emitPlus();
		   if (!closed) {
			   bSetSubstring = true;
			   lexan(lookahead);
			   if (lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_TO) {
				   // ( to x)
				   mEmitter.emitPushInteger("1");
				   lexan(lookahead);
				   expr();
				   cvToType(popType(), VARTYP.TYPE_INT);
				   popType();
				   // x( TO 1) after the TO without a start there is always a number.
			   } else {
				   // either n or n to m
				   // (a to b) or (a)
				   expr();
				   cvToType(popType(), VARTYP.TYPE_INT);
				   popType();
				   if (lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_TO) {
					   // (a to b)
					   lexan(lookahead);
					   expr();
					   cvToType(popType(), VARTYP.TYPE_INT);
					   popType();
				   }
				   else {
					   mEmitter.emitDup();
					   // (a) coded as (a to a)B
				   }
			   }
		   } 
		   match(ZXTokenTyp.ZX_Closebracket);
		}
		else 
			mEmitter.emitPushVarAddress(var);
		match(ZXTokenTyp.ZX_Equals);
		expr();
		VARTYP typ = popType();
		if (!isStringTyp(typ)) {
			error("Expeced String");
			return;
		}
		if (bSetSubstring) {
			if (typ == VARTYP.TYPE_STRING)
				mEmitter.emitAssignFixedStringWithRange();
			if (typ == VARTYP.TYPE_FIXSTRING)
				mEmitter.emitAssignFixedStringFixStringWithRange(mPopSize);
		} else {
			if (typ == VARTYP.TYPE_STRING) {
				mEmitter.emitAssignFixedString(stringSize);
			}
			if (typ == VARTYP.TYPE_FIXSTRING) {
				mEmitter.emitAssignFixedFixedString(stringSize, mPopSize);
			}
		}
	}
	
	private void compileReadFixedString(Variable var, boolean isArray) {
		int dimenSize = var.dimen.length;
		int stringSize = var.dimen[var.dimen.length-1];
		boolean bSetSubstring = false;
		boolean closed=false;
		boolean needsPlus = false;
		if (lookahead.typ == ZXTokenTyp.ZX_OpenBracket) {
		   if (dimenSize > 1) {
			   for (int i=0;i<dimenSize-1;i++) {
				   if (i >= 2) mEmitter.emitPlus();
				   lexan(lookahead);
				   expr();
				   needsPlus = true;
				   cvToType(popType(), VARTYP.TYPE_INT);
				   int faktor =1;
				   for (int j=i+1;j<dimenSize;j++) faktor *= var.dimen[j];
				   //mEmitter.emitPushInteger(String.format("%d", faktor));
				   //mEmitter.emitMult();
				   mEmitter.emitMultiPlyTopOfStackPush(faktor);
				   if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) {
					   closed = true;
					   break;
				   }
				   if (lookahead.typ != ZXTokenTyp.ZX_Comma) {
					   System.out.printf("Expected comma");
					   return;
				   }
			   }
		   }
		   mEmitter.emitPushVarAddress(var);
		   if (needsPlus) mEmitter.emitPlus();
		   if (!closed) {
			   bSetSubstring = true;
			   lexan(lookahead);
			   if (lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_TO) {
				   mEmitter.emitPushInteger("1");
				   lexan(lookahead);
				   expr();
				   // x( TO 1) after the TO without a start there is always a number.
			   } else {
				   // either n or n to m
				   expr();
				   if (lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_TO) {
					   lexan(lookahead);
					   expr();
				   }
				   else {
					   mEmitter.emitPushInteger(String.format("%d", stringSize));
				   }
			   }
		   } 
		   match(ZXTokenTyp.ZX_Closebracket);
		} else
			mEmitter.emitPushVarAddress(var);
		mEmitter.emitReadString();

		VARTYP typ = VARTYP.TYPE_STRING;
		if (bSetSubstring) {
			if (typ == VARTYP.TYPE_STRING)
				mEmitter.emitAssignFixedStringWithRange();
		} else {
			if (typ == VARTYP.TYPE_STRING) {
				mEmitter.emitAssignFixedString(stringSize);
			}
		}
	}
	

	void compileStringSubstring() {
		   lexan(lookahead);
		   if (lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_TO) {
			   mEmitter.emitPushInteger("1");
			   lexan(lookahead);
			   expr();
			   cvToType(popType(), VARTYP.TYPE_INT);
			   popType();
			   // x( TO 1) after the TO without a start there is always a number.
		   } else {
			   // either n or n to m
			   expr();
			   cvToType(popType(), VARTYP.TYPE_INT);
			   popType();
			   if (lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_TO) {
				   lexan(lookahead);
				   if (lookahead.typ == ZXTokenTyp.ZX_Closebracket) {
					   mEmitter.emitPushInteger("-1");
				   } else {
					   expr();
					   cvToType(popType(), VARTYP.TYPE_INT);
					   popType();
				   }
			   }
			   else {
				   mEmitter.emitDup();
			   }
		   }

	}
	private boolean isStringTyp(VARTYP typ) {
		return typ == VARTYP.TYPE_STRING || typ == VARTYP.TYPE_FIXSTRING;
	}

	private void compileINPUT() {
		VARTYP typ;
		boolean bLine = false;
		ZXTokenTyp last = ZXTokenTyp.NULL;
		boolean localAttributes = false;
		mEmitter.emitStartInput();
		Variable var;

		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine || lookahead.typ == ZXTokenTyp.ZX_Colon)
				break;
			switch (lookahead.typ) {
			case ZXTokenTyp.ZX_OpenBracket:
				lexan(lookahead);
				compileInputPrint();
				match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Closebracket);
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
					cvToType(popType(), VARTYP.TYPE_INT);
					popType();
					match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
					expr();
					cvToType(popType(), VARTYP.TYPE_INT);
					popType();
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
				case ZXToken.ZXB_LINE:
					bLine = true;
					lexan(lookahead);
					break;
				}

				break;
			}

			default:
				last = ZXTokenTyp.NULL;
				// lexan(lookahead);
				
				switch (lookahead.typ) {
				case ParserToken.ZXTokenTyp.ZX_Integer:
				case ParserToken.ZXTokenTyp.ZX_String:
					expr();
					typ = popType();
					printStackTop(typ);
					break;
				case ParserToken.ZXTokenTyp.ZX_literal:
					var = mEmitter.getVariable(lookahead.literal);
					if (var == null) 
						var = mEmitter.createVar(lookahead.literal);
					if (var != null) {
						switch(var.typ) {
						case TYPE_INT:
							mEmitter.emitInputInt(lookahead.literal);
							break;
						case TYPE_STRING:
							mEmitter.emitInputString(lookahead.literal, bLine);
							break;
						case TYPE_FLOAT:
							mEmitter.emitInputFloat(lookahead.literal);
							break;
						}
						bLine = false;
						lexan(lookahead);
					}
				
				}

			}
		}
		if (localAttributes) {
			localAttributes = false;
			mEmitter.emitRestoreAttr();
		}
		mEmitter.emitEndInput();

	}

	private void compileInputPrint() {
		ZXTokenTyp last = ZXTokenTyp.NULL;
		localAttributes = false;
		localStream = false;
		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_Closebracket)
				break;
			last = printPart(last);

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

	private void compilePRINT(int channel) {
		ZXTokenTyp last = ZXTokenTyp.NULL;
		localAttributes = false;
		localStream = false;
		mEmitter.emitUpperScreen(channel);
		mEmitter.savePFlags();
		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine || lookahead.typ == ZXTokenTyp.ZX_Colon )
				break;
			last = printPart(last);

		}
		if (last == ZXTokenTyp.NULL) {
			mEmitter.emitPrintNewline();
		}
		if (localAttributes) {
			localAttributes = false;
			mEmitter.emitRestoreAttr();
		}
		mEmitter.restorePFlags();
		if (localStream) {
			mEmitter.emitCloseStream();
			localStream = false;
		}
	}
	
	ZXTokenTyp printPart(ZXTokenTyp last) {
		VARTYP typ;
		switch (lookahead.typ) {
		case ZXTokenTyp.ZX_Hash:
			lexan(lookahead);
			expr();
			localStream = true;
			cvToType(popType(), VARTYP.TYPE_INT);
			popType();
			
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
				cvToType(popType(), VARTYP.TYPE_INT);
				popType();
				match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
				expr();
				cvToType(popType(), VARTYP.TYPE_INT);
				popType();
				mEmitter.emitPrintAt();
				break;
			case ZXToken.ZXB_TAB:
				lexan(lookahead);
				expr();
				cvToType(popType(), VARTYP.TYPE_INT);
				popType();
				mEmitter.emitTab();
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
				
				printStackTop(typ);
			}

			break;
		}

		default:
			last = ZXTokenTyp.NULL;
			// lexan(lookahead);
			expr();
			typ = popType();
			printStackTop(typ);

		}
		return last;
	}

	private void printStackTop(VARTYP typ) {
		switch (typ) {
		case VARTYP.TYPE_INT:
			mEmitter.emitPrintInt();
			break;
		case VARTYP.TYPE_STRING:
			mEmitter.emitPrintString();
			break;
		case VARTYP.TYPE_FIXSTRING:
			mEmitter.emitPrintFixString(mPopSize);
			break;
		case VARTYP.TYPE_FLOAT:
			mEmitter.emitPrintFloat();
			break;
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
		cvToType(popType(), VARTYP.TYPE_FLOAT);
		popType();
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
		expr();
		cvToType(popType(), VARTYP.TYPE_FLOAT);
		popType();
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
		expr();
		cvToType(popType(), VARTYP.TYPE_FLOAT);
		popType();
		mEmitter.emitCircle();
	}

	private void compileDRAW() {
		boolean localAttributes;
		mEmitter.savePFlags();
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
		cvToType(popType(), VARTYP.TYPE_INT);
		popType();
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
		expr();
		cvToType(popType(), VARTYP.TYPE_INT);
		popType();
		if (lookahead.typ == ZXTokenTyp.ZX_Comma) {
			expr();
			mEmitter.emitDrawArc();
		}
		else 
			mEmitter.emitDraw();
		mEmitter.restorePFlags();
	}

	private void compileBeep() {
		lexan(lookahead);
		expr();
		cvToType(popType(), VARTYP.TYPE_FLOAT);
		popType();
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
		expr();
		cvToType(popType(), VARTYP.TYPE_FLOAT);
		popType();
		mEmitter.emitBeep();
		
	}
	
	private void compileBorder() {
		lexan(lookahead);
		expr();
		cvToType(popType(), VARTYP.TYPE_INT);
		popType();
		mEmitter.emitBorder();
	}
	private void compilePLOT() {
		boolean localAttributes;
		mEmitter.savePFlags();
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
		cvToType(popType(), VARTYP.TYPE_INT);
		popType();
		match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
		expr();
		cvToType(popType(), VARTYP.TYPE_INT);
		popType();
		mEmitter.emitPlot();
		mEmitter.restorePFlags();
	}

	private void compileIF() {
 		lexan(lookahead);
		expr();
		cvToType(popType(), VARTYP.TYPE_INT);
		popType();
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
		
		String label = mEmitter.emitStartData(mBasicLine.line);
		if (mFirstData == null)
			mFirstData = label;
		
		VARTYP datatype = mDefaultDataType;
		if (datatype == VARTYP.TYPE_UNDEF) datatype = mDefaultType;
		
		
		while (true) {
			lexan(lookahead);
			if (lookahead.typ == ZXTokenTyp.ZX_EndOfLine || lookahead.typ == ZXTokenTyp.ZX_Colon)
				break;
			String faktor="";
			if (lookahead.typ == ZXTokenTyp.ZX_Minus) {
				faktor="-";
				lexan(lookahead);
			}
			if (lookahead.typ == ZXTokenTyp.ZX_Integer) {
				if (lookahead.floatLiteral != null) {
					if (lookahead.floatLiteral[0] != 0 || lookahead.literal.indexOf('.') != -1 || datatype == VARTYP.TYPE_FLOAT) {
						mEmitter.emitDataFloat(lookahead);
					} else 
						mEmitter.emitDataInt(faktor+lookahead.literal);

				} else {
					mEmitter.emitDataInt(faktor+lookahead.literal);
				}
			}
			else if (lookahead.typ == ZXTokenTyp.ZX_String)
				mEmitter.emitDataString(lookahead.literal);
			else if (lookahead.typ == ZXTokenTyp.ZX_Token) {
				if (lookahead.zxToken == ZXToken.ZXB_INT) {
					lexan(lookahead);
					mEmitter.emitDataInt(lookahead.literal);
				} else if (lookahead.zxToken == ZXToken.ZXB_BIN) {
					lexan(lookahead);
					mEmitter.emitDataInt("%"+lookahead.literal);
					
				}
				
			}
		}
	}
	
	private void compileFor() {
		Variable var;
		VARTYP     targetType = VARTYP.TYPE_INT;
		String varname;
		String forlbl = mEmitter.getForLabel();
		lexan(lookahead);				// variable
		varname = lookahead.literal;
		String forlabel = String.format("for_%s", varname);
		String stepvarname = forlabel+"_step";
		var = mEmitter.getVariable(varname);
		
		lexan(lookahead);				// variable
		match(ParserToken.ZXTokenTyp.ZX_Equals);
		expr();
		VARTYP typ = popType();
		if (var != null) {
			cvToType(typ, var.typ);
			popType();
			typ = var.typ;
		}
		if (typ == VARTYP.TYPE_INT) {
			
			mEmitter.emitIntVar(varname);
			mEmitter.emitStoreIntegerVar(varname, false);
		} else if (typ == VARTYP.TYPE_FLOAT) {
			mEmitter.emitFloatVar(varname);;
			mEmitter.emitStoreFloatVar(varname, false);
			targetType = VARTYP.TYPE_FLOAT;
		}
		mEmitter.mOptimize=mSettingOptimize;
		match(ParserToken.ZXTokenTyp.ZX_Token);
		
		mEmitter.emitVar(forlabel, targetType);
		var = mEmitter.getVariable(forlabel);
		
		expr();
		cvToType(popType(), targetType);
		mEmitter.emitStoreVariable(targetType, forlabel, false);
		popType();
	
		if (lookahead.typ == ParserToken.ZXTokenTyp.ZX_Token && lookahead.zxToken  == ZXToken.ZXB_STEP) {
			lexan(lookahead);
			var.step = true;
			expr();
			VARTYP typ2 = popType();
			cvToType(typ2, targetType);
			mEmitter.emitVar(stepvarname, targetType);
			mEmitter.emitStoreVariable(targetType, stepvarname, false);
			popType();
		} else {
			mBasicLine.unget(lookahead);
			var.step = false;
		}
//		mEmitter.mOptimize = mSettingOptimize;
		mEmitter.emitForLabel();
	}
	
	private void cvToType(VARTYP type, VARTYP targetType) {
		switch(targetType) {
			case VARTYP.TYPE_INT:
				if (type == VARTYP.TYPE_FLOAT) mEmitter.emitFloatToInt();
				break;
			case VARTYP.TYPE_FLOAT:
				if (type == VARTYP.TYPE_INT) mEmitter.emitIntToFloat();
				break;
		}
		pushType(targetType);
	}

	private void compileNext() {
		lexan(lookahead);
		mEmitter.emitNext(lookahead.literal);
	}

	private void compileLocalAttr() {
		int token = lookahead.zxToken;
		lexan(lookahead);
		expr();
		VARTYP typ = popType();
		cvToType(typ, VARTYP.TYPE_INT);
		popType();
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

	void checkType(VARTYP totype) {
		VARTYP type = popType();
		if (type == totype)
			return;
		switch (totype) {
		case VARTYP.TYPE_INT:
			if (type == VARTYP.TYPE_FLOAT) {
				mEmitter.emitFloatToInt();
			} else
				error("Fehler in Typumwandlung");
			break;
		case VARTYP.TYPE_FLOAT:
			if (type == VARTYP.TYPE_FLOAT) {
				mEmitter.emitIntToFloat();
			} else
				error("Fehler in Typumwandlung");
			break;
		default:
			error("Fehler in Typumwandlung");
		}
	}

	private void error(String string) {
		mEmitter.log(String.format("%d:%d %s",mBasicLine.line, mBasicStmt, string));

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
	
	/* todo Refactor
	 * 	expr()        → or()
		or()          → and() {"OR" and()}*
		and()         → rel() {"AND" rel()}*
		rel()         → add() {("=" | "<>" | "<" | ">" | "<=" | ">=") add()}*
		add()         → mul() {("+" | "-") mul()}*
		mul()         → unary() {("*" | "/") unary()}*
		unary()       → {"-" | "NOT"} pow()
		pow()         → factor() {"^" pow()}*
		factor()      → Zahl | Variable | "(" expr() ")"
	 */
	
	private void expr() {
		String label;
		VARTYP typ1, typ2;
		ParserToken t = new ParserToken();
		expr2();
		while (true) {
			switch (lookahead.typ) {
			case ZX_Token:
				switch (lookahead.zxToken) {
				case ZXToken.ZXB_ORX:
					mIsFactor=false;

					t.copyFrom(lookahead);
					label=null;
					if (mSettingsShortCircuit) {
						if (peekType() == VARTYP.TYPE_INT) {
							label = "or_"+mEmitter.newLabel();
							mEmitter.emitJumpOnNonZero(label);
						}
					}
					match(lookahead);
					expr2();
					mEmitter.setComment("OR");
					typ1 = popType();
					typ2 = popType();
					if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
						mEmitter.emitOr();
						pushType(VARTYP.TYPE_INT);
					}else if (cvToFloat(typ1, typ2)) {
						cvToFloat(typ1, typ2);
						mEmitter.emitOrFloat();
						pushType(VARTYP.TYPE_INT);
					}
					if (mSettingsShortCircuit && label != null)
						mEmitter.emitLabel(label);
					continue;

				case ZXToken.ZXB_ANDX:
					mIsFactor=false;
					t.copyFrom(lookahead);
					label="";
					/*
					if (mSettingsShortCircuit) {
						label = "and_"+mEmitter.newLabel();
						mEmitter.emitJumpOnZero(label);
					}
					*/
					
					match(lookahead);
					expr2();
					//if (mSettingsShortCircuit)		mEmitter.emitLabel(label);
					mEmitter.setComment("AND");
					typ1 = popType();
					typ2 = popType();
					if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
						mEmitter.emitAnd();
						pushType(VARTYP.TYPE_INT);
					} else if (cvToFloat(typ1, typ2)) {
						mEmitter.emitAndFloat();
						pushType(VARTYP.TYPE_INT);
					} else if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_STRING) {
						mEmitter.emitAndStringInt();
						pushType(VARTYP.TYPE_STRING);
					} else if(typ1 == VARTYP.TYPE_FLOAT && typ2 == VARTYP.TYPE_STRING) {
						mEmitter.emitAndStringFloat();
						pushType(VARTYP.TYPE_STRING);
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
	
	// main expression evaluation
	private void expr2() {
		VARTYP  typ1, typ2;
		int size1, size2;
		ParserToken t = new ParserToken();
		term();
		while (true) {
			switch (lookahead.typ) {
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Plus:
				mIsFactor=false;

				t.copyFrom(lookahead);
				match(lookahead);
				term();
				mEmitter.setComment("+");
				typ1 = popType();
				size1 = mPopSize;
				typ2 = popType();
				size2 = mPopSize;
				if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
					mEmitter.emitPlus();
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_FLOAT && typ2 == VARTYP.TYPE_FLOAT) {
				    mEmitter.emitPushAddFloat();
				    pushType(VARTYP.TYPE_FLOAT);
				}				
				else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitPlusString();
					pushType(VARTYP.TYPE_STRING);
				} else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitPlusFixVarString(size1);
					pushType(VARTYP.TYPE_STRING);
				} else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitPlusVarFixString(size2);
					pushType(VARTYP.TYPE_STRING);
				} else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitPlusFixFixString(size1, size2);
					pushType(VARTYP.TYPE_STRING);
				}
				
				
				else if (cvToFloat(typ1, typ2)) {
					mEmitter.emitPlusFloat();
					pushType(VARTYP.TYPE_FLOAT);
				}
				continue;

			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Minus:
				mIsFactor=false;

				t.copyFrom(lookahead);
				match(lookahead);
				term();
				mEmitter.setComment("-");
				typ1 = popType();
				typ2 = popType();
				if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
					mEmitter.emitMinus();
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_FLOAT && typ2 == VARTYP.TYPE_FLOAT) {
				    mEmitter.emitPushSubFloat();
				    pushType(VARTYP.TYPE_FLOAT);
				}else if (cvToFloatSwap(typ1, typ2)) {
					mEmitter.emitMinusFloat();
					pushType(VARTYP.TYPE_FLOAT);
				}
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Bigger:
				mIsFactor=false;

				t.copyFrom(lookahead);
				match(lookahead);
				term();
				mEmitter.setComment(">");
				typ1 = popType();
				size1=mPopSize;
				typ2 = popType();
				size2=mPopSize;
				if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
					mEmitter.emitBigger();
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitBiggerString();
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitBiggerFixVarString(size1);
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitBiggerVarFixString(size2);
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitBiggerFixFixString(size1, size2);
					pushType(VARTYP.TYPE_INT);
				} else if (cvToFloatSwap(typ1, typ2)) {
					mEmitter.emitBiggerFloat();
					pushType(VARTYP.TYPE_INT);
				} else 
					error("Wrong type");
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Smaller:
				mIsFactor=false;

				t.copyFrom(lookahead);
				match(lookahead);
				term();
				mEmitter.setComment("<");
				typ1 = popType();
				size1 = mPopSize;
				typ2 = popType();
				size2 = mPopSize;
				if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
					mEmitter.emitSmaller();
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitSmallerString();
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitSmallerVarFixString(size2);
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitSmallerFixVarString(size1);
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitSmallerFixFixString(size1, size2);
					pushType(VARTYP.TYPE_INT);
				} else if (cvToFloatSwap(typ1, typ2)) {
					mEmitter.emitSmallerFloat();
					pushType(VARTYP.TYPE_INT);
				} else 
					error("Wrong type");
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_SmallerEqual:
				mIsFactor=false;
				
				t.copyFrom(lookahead);
				match(lookahead);
				term();
				mEmitter.setComment("<=");
				typ1 = popType();
				size1 = mPopSize;
				typ2 = popType();
				size2 = mPopSize;
				if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
					mEmitter.emitSmallerEqual();
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitSmallerEqualString();
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitSmallerEqualVarFixString(size2);
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitSmallerEqualFixVarString(size1);
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitSmallerEqualFixFixString(size1,size2);
					pushType(VARTYP.TYPE_INT);
				} else if (cvToFloatSwap(typ1, typ2)) {
					mEmitter.emitSmallerEqualFloat();
					pushType(VARTYP.TYPE_INT);
				} else 
					error("Wrong type");
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_BiggerEqual:
				mIsFactor=false;

				t.copyFrom(lookahead);
				match(lookahead);
				term(); 
				mEmitter.setComment(">=");
				typ1 = popType();
				size1 = mPopSize;
				typ2 = popType();
				size2 = mPopSize;
				if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
					mEmitter.emitBiggerEqual();
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitBiggerEqualString();
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitBiggerEqualVarFixString(size2);
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitBiggerEqualFixVarString(size1);
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitBiggerEqualFixFixString(size1, size2);
					pushType(VARTYP.TYPE_INT);
				} else if (cvToFloatSwap(typ1, typ2)) {
					mEmitter.emitBiggerEqualFloat();
					pushType(VARTYP.TYPE_INT);
				} else 
					error("Wrong type");
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Unequal:

				t.copyFrom(lookahead);
				match(lookahead);
				term();
				mEmitter.setComment("<>");
				typ1 = popType();
				size1 = mPopSize;
				typ2 = popType();
				size2 = mPopSize;
				if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
					mEmitter.emitUnequal();
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitUnequalString();
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitUnEqualVarFixString(size2);
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitUnEqualFixVarString(size1);
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitUnEqualFixFixString(size1, size2);
					pushType(VARTYP.TYPE_INT);
				} else if (cvToFloat(typ1, typ2)) {
					mEmitter.emitUnequalFloat();
					pushType(VARTYP.TYPE_INT);
				} else 
					error("Wrong type");
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Equals:
				mIsFactor=false;

				t.copyFrom(lookahead);
				match(lookahead);
				term();
				mEmitter.setComment("=");
				typ1 = popType();
				size1 = mPopSize;
				typ2 = popType();
				size2 = mPopSize;
				if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
					mEmitter.emitEqual();
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitEqualString();
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_STRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitEqualVarFixString(size2);
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_FIXSTRING) {
					mEmitter.emitEqualFixFixString(size1,size2);
					pushType(VARTYP.TYPE_INT);
				}  else if (typ1 == VARTYP.TYPE_FIXSTRING && typ2 == VARTYP.TYPE_STRING) {
					mEmitter.emitEqualFixVarString(size1);
					pushType(VARTYP.TYPE_INT);
				} else if (cvToFloat(typ1, typ2)) {
					mEmitter.emitEqualFloat();
					pushType(VARTYP.TYPE_INT);
				} else 
					error("Wrong type");
				continue;

				
				

			default:
				return;
			}
		}

	}

	private void term() {
		VARTYP typ1, typ2;
		ParserToken t = new ParserToken();
		factor();
		while (true) {
			switch (lookahead.typ) {
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Power:
				mIsFactor=false;
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				mEmitter.setComment("*");
				typ1 = popType();
				typ2 = popType();
				if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
					mEmitter.emitPower();
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_FLOAT && typ2 == VARTYP.TYPE_FLOAT) {
					mEmitter.emitPowerFloat();
					pushType(VARTYP.TYPE_FLOAT);
				}
				else if (cvToFloat(typ1, typ2)) {
					t.copyFrom(lookahead);
					//match(lookahead);
					//factor();
					mEmitter.emitPowerFloat();
					pushType(VARTYP.TYPE_FLOAT);
				} else {
					error("Error in type for mult");
				}
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Mult:
				mIsFactor=false;
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				mEmitter.setComment("*");
				typ1 = popType();
				typ2 = popType();
				if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
					mEmitter.emitMult();
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_FLOAT && typ2 == VARTYP.TYPE_FLOAT) {
					mEmitter.emitMultFloat();
					pushType(VARTYP.TYPE_FLOAT);
				}
				else if (cvToFloat(typ1, typ2)) {
					t.copyFrom(lookahead);
					//match(lookahead);
					//factor();
					mEmitter.emitMultFloat();
					pushType(VARTYP.TYPE_FLOAT);
				} else {
					error("Error in type for mult");
				}
				continue;
			case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Div:
				mIsFactor=false;
				t.copyFrom(lookahead);
				match(lookahead);
				factor();
				mEmitter.setComment("/");
				typ1 = popType();
				typ2 = popType();
				if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_INT) {
					mEmitter.emitDiv();
					pushType(VARTYP.TYPE_INT);
				} else if (typ1 == VARTYP.TYPE_FLOAT && typ2 == VARTYP.TYPE_FLOAT) {
					mEmitter.emitDivFloat();
					pushType(VARTYP.TYPE_FLOAT);
				}else if (cvToFloatSwap(typ1, typ2)) {
					t.copyFrom(lookahead);
					//match(lookahead);
					//factor();
					mEmitter.emitDivFloat();
					pushType(VARTYP.TYPE_FLOAT);
				} else {
					error("Error in type for mult");
				}
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
	private boolean cvToFloat(VARTYP  typ1, VARTYP typ2) {
		if ((typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_FLOAT) || (typ1 == VARTYP.TYPE_FLOAT && typ2 == VARTYP.TYPE_INT)) {
			mEmitter.emitCvIntToFloat();
			return true;
		}
		if (typ1 == VARTYP.TYPE_FLOAT && typ2 == VARTYP.TYPE_FLOAT) return true;
		return false;
	}

	private boolean cvToFloatSwap(VARTYP typ1, VARTYP typ2) {
		if (typ1 == VARTYP.TYPE_INT && typ2 == VARTYP.TYPE_FLOAT) {
			mEmitter.emitCvIntToFloat();
			return true;
		} else if (typ1 == VARTYP.TYPE_FLOAT && typ2 == VARTYP.TYPE_INT) {
			mEmitter.emitCvIntToFloat();
			mEmitter.swapFloat();
			return true;

		} else if (typ1 == VARTYP.TYPE_FLOAT && typ2 == VARTYP.TYPE_FLOAT) 
			return true;
		return false;
	}

	private VARTYP popType() {
		CExprStackEntry entry = mTypeStack.pop();
		mPopSize = entry.size;
		return entry.typ;
	}
	
	private VARTYP peekType() {
		CExprStackEntry entry = mTypeStack.peek();
		mPopSize = entry.size;
		return entry.typ;
	}


	private void pushType(VARTYP typ) {
		pushType(typ,0);
	}

	private void pushType(VARTYP typ, int stringSize) {
		mTypeStack.push(new CExprStackEntry(typ, stringSize)); 
	}

	private void factor() {
		VARTYP typ;
		String literal;
		switch (lookahead.typ) {
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Minus:
			mIsFactor=false;

			lexan(lookahead);
			expr();
			mEmitter.setComment("-");
			typ = popType();
			switch(typ) {
				case TYPE_INT:
					mEmitter.emitNegInt();
					break;
				case TYPE_FLOAT:
					mEmitter.emitNegFloat();
					break;
			}
			pushType(typ);
			break;
			
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_OpenBracket:
			mIsFactor=false;
//			int type = peekType();
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_OpenBracket);
			mEmitter.setComment("(");
			expr();
			mEmitter.setComment(")");
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Closebracket);
			break;
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Integer:
			mIsFactor = true;
			mFactorLiteral = lookahead.literal;
			if (lookahead.floatLiteral != null) {
				if (lookahead.floatLiteral[0] != 0 || lookahead.literal.indexOf('.') != -1 || mDefaultType == VARTYP.TYPE_FLOAT) {
					mEmitter.emitFloat(lookahead);
					match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Integer);
					pushType(VARTYP.TYPE_FLOAT);
					break;
				}
			}
			mEmitter.emitPushInteger(lookahead.literal);
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Integer);
			pushType(VARTYP.TYPE_INT);
			break;
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Float:
			mEmitter.emitPushFloat(lookahead.floatLiteral);
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Float);
			pushType(VARTYP.TYPE_FLOAT);
			break;
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_String:
			mIsFactor=true;
			mEmitter.emitPushString(lookahead.literal);
			match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_String);
			pushType(VARTYP.TYPE_STRING);
			break;
		case ZXTokenizer.ParserToken.ZXTokenTyp.ZX_literal:
			mIsFactor=false;
			boolean isArray=false;
			
			String varname = lookahead.literal;
			VARTYP vartyp = mDefaultType;
			if (lookahead.literal.indexOf('$') != -1) {
				vartyp = VARTYP.TYPE_STRING;
				varname = varname.substring(0,varname.length()-1)+"_string";
			}
			Z80Emitter.Variable variable = mEmitter.getVariable(varname);
			if (variable != null)  {
				vartyp = variable.typ;
				varname = variable.name;
				if (vartyp == VARTYP.TYPE_STRING && variable.dimen != null) {
					CompileLiteralFixString(variable);
					break;
				}
			}
			
			lexan(lookahead);
			if (lookahead.typ != ZXTokenTyp.ZX_OpenBracket) {
				mBasicLine.unget(lookahead);
				isArray = false;
			} else {
				isArray = false;
				Variable var = mEmitter.getVariable(varname+"_array");
				if (var != null) {
					variable = var;
					vartyp = var.typ;
					if (variable.dimen != null) {
						mEmitter.setComment("Array-Access");
						compileArrayAccess(var, false);
						varname = var.name;
						isArray=true;
					}
				}
			}
		
		//	isArray = compileArray(variable, vartyp);
			if (vartyp == VARTYP.TYPE_INT) {
				if (lookahead.literal.indexOf('.') != -1)
					vartyp = VARTYP.TYPE_FLOAT;
			}
			
			
			
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
			mIsFactor=false;
			mEmitter.setComment(mzxToken .tokenToStr(lookahead.zxToken));
			switch(lookahead.zxToken) {
				 case ZXToken.ZXB_BIN:
					 lexan(lookahead);
					 
					 if (lookahead.floatLiteral != null) {
							if (lookahead.floatLiteral[0] != 0 || lookahead.literal.indexOf('.') != -1 || mDefaultType == VARTYP.TYPE_FLOAT) {
								mEmitter.emitFloat(lookahead);
								match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Integer);
								pushType(VARTYP.TYPE_FLOAT);
								break;
							}
						}
						mEmitter.emitPushInteger("%"+lookahead.literal);
						break;
				case ZXToken.ZXB_FN:
					compileFN();
					break;
				case ZXToken.ZXB_SCREEN:
					 lexan(lookahead);					 
					 match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_OpenBracket);
					 expr();
					 
					 cvToType(popType(),VARTYP.TYPE_INT);
					 popType();
					 match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
					 expr();
					 cvToType(popType(),VARTYP.TYPE_INT);
					 popType();
					 match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Closebracket);
					 mEmitter.emitScreen();
					 pushType(VARTYP.TYPE_STRING);
					 break;
					
				case ZXToken.ZXB_POINT:
					 lexan(lookahead);					 
					 match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_OpenBracket);
					 expr();
					 
					 cvToType(popType(),VARTYP.TYPE_INT);
					 popType();
					 match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
					 expr();
					 cvToType(popType(),VARTYP.TYPE_INT);
					 popType();
					 match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Closebracket);
					 mEmitter.emitPoint();
					 pushType(VARTYP.TYPE_INT);
					 break;
					
				case ZXToken.ZXB_ATTR:
					 lexan(lookahead);					 
					 match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_OpenBracket);
					 expr();
					 
					 cvToType(popType(),VARTYP.TYPE_INT);
					 popType();
					 match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Comma);
					 expr();
					 cvToType(popType(),VARTYP.TYPE_INT);
					 popType();
					 match(ZXTokenizer.ParserToken.ZXTokenTyp.ZX_Closebracket);
					 mEmitter.emitAttr();
					 pushType(VARTYP.TYPE_INT);
					 break;
				case ZXToken.ZXB_RND:
					 mEmitter.emitRnd();
					 pushType(VARTYP.TYPE_FLOAT);
					 lexan(lookahead);
					 break;					 
				case ZXToken.ZXB_IN:
					 exprlexanfn();
					 cvToType(popType(), VARTYP.TYPE_INT);
					 popType();
					 mEmitter.emitIn();
					 pushType(VARTYP.TYPE_INT);
					 break;
				case ZXToken.ZXB_INT:
					 exprlexanfn();
					 cvToType(popType(), VARTYP.TYPE_INT);
					 popType();
					 pushType(VARTYP.TYPE_INT);
					 break;
				case ZXToken.ZXB_VAL:
					 exprlexanfn();
					 checkType(VARTYP.TYPE_STRING);
					 mEmitter.emitVal();
					 pushType(VARTYP.TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_STR:
					 mStringUsed = true;
					 exprlexanfn();
					 typ = popType();
					 if (typ == VARTYP.TYPE_FLOAT) {
						 mEmitter.emitStr();
					 } else {
						 mEmitter.emitStrInt();
					 }
					 pushType(VARTYP.TYPE_STRING);
					 break;
				case ZXToken.ZXB_CODE:
					 mIsFactor = false;
					 mEmitter.startTempCode();
						lexan(lookahead);
						 literal = lookahead.literal;
						exprFn();
					 checkType(VARTYP.TYPE_STRING);
					 if (mIsFactor && literal.length() > 0 && isnumber(literal)) {
						 mEmitter.stopTempCode();
						 mEmitter.emitPushInteger(String.format("%d", (int)literal.charAt(0)));
					 } else {
						 mEmitter.writeTempCode();
						 mEmitter.stopTempCode();
						 mEmitter.emitCode();
					 }
					 pushType(VARTYP.TYPE_INT);
					 break;
				case ZXToken.ZXB_CHR:
					 mIsFactor = false;
//					 mEmitter.startTempCode();
					 lexan(lookahead);
					 literal = lookahead.literal;
					 exprFn();
					 mStringUsed = true;
					 /*
					 if (mIsFactor && isnumber(literal)) {
						 mEmitter.stopTempCode();
						 popType();
						 int code = Integer.parseInt(literal);
						 if (code < 128)
							 literal = String.format("%c", code);
						 else
							 literal = String.format("\\%2x", code);
						 mEmitter.emitPushString(literal);
					 } else {
						 mEmitter.writeTempCode();
						 mEmitter.stopTempCode();
						 cvToType(popType(), VARTYP.TYPE_INT);
						 mEmitter.emitChr();
					 }
					 */
					 cvToType(popType(), VARTYP.TYPE_INT);
					 popType();
					 mEmitter.emitChr();
					 
					 pushType(VARTYP.TYPE_STRING);
					 break;
				case ZXToken.ZXB_PEEK:
					 exprlexanfn();
					 cvToType(popType(), VARTYP.TYPE_INT);
					 popType();
					 mEmitter.emitPeek();
					 pushType(VARTYP.TYPE_INT);
					 break;
				case ZXToken.ZXB_SIN:
					exprlexanfn();
					 checkType(VARTYP.TYPE_FLOAT);
					 mEmitter.emitSin();
					 pushType(VARTYP.TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_COS:
					exprlexanfn();
					 checkType(VARTYP.TYPE_FLOAT);
					 mEmitter.emitCos();
					 pushType(VARTYP.TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_SGN:
					exprlexanfn();
					typ = popType();
					switch(typ) {
						case TYPE_FLOAT:
							mEmitter.emitSgnFloat();
							pushType(VARTYP.TYPE_FLOAT);
							break;
						case TYPE_INT:
							mEmitter.emitSgnInt();
							pushType(VARTYP.TYPE_INT);
							break;
					}
					 pushType(typ);
					 break;
				case ZXToken.ZXB_ABSX:
					 exprlexanfn();
					 typ = popType();
					 switch(typ) {
					 	case VARTYP.TYPE_INT:
					 		mEmitter.emitAbsInt();
					 		pushType(VARTYP.TYPE_INT);
					 		break;
					 	case VARTYP.TYPE_FLOAT:
					 		mEmitter.emitAbsFloat();
					 		pushType(VARTYP.TYPE_FLOAT);
					 		break;
					 }
					 break;
				case ZXToken.ZXB_SQR:
					exprlexanfn();
					 checkType(VARTYP.TYPE_FLOAT);
					 mEmitter.emitSqr();
					 pushType(VARTYP.TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_LEN:
				     exprlexanfn();
					 checkType(VARTYP.TYPE_STRING);
					 mEmitter.emitLen();
					 pushType(VARTYP.TYPE_INT);
					 break;
				case ZXToken.ZXB_USR:
					 exprlexanfn();
					 typ = popType();
					 switch(typ) {
					 	case VARTYP.TYPE_INT: 
					 		mEmitter.emitUsr();
					 		break;
					 	case VARTYP.TYPE_FLOAT:
					 		cvToType(typ, VARTYP.TYPE_INT);;
					 		mEmitter.emitUsr();
					 		break;
					 	case VARTYP.TYPE_STRING:
							 mEmitter.emitUsrUDG();
							 break;
					 	case VARTYP.TYPE_FIXSTRING:
							 mEmitter.emitUsrUDGFixString();
							 break;
					 		
					 }
					 pushType(VARTYP.TYPE_INT);
					 break;
				case ZXToken.ZXB_LN:
					exprlexanfn();
					 checkType(VARTYP.TYPE_FLOAT);
					 mEmitter.emitLn();
					 pushType(VARTYP.TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_EXP:
					exprlexanfn();
					 checkType(VARTYP.TYPE_FLOAT);
					 mEmitter.emitExp();
					 pushType(VARTYP.TYPE_FLOAT);
					 break;
				case ZXToken.ZXB_INKEY:
					 mStringUsed = true;
					 mEmitter.emitInkey();
					 pushType(VARTYP.TYPE_STRING);
					 lexan(lookahead);
					 break;
				case ZXToken.ZXB_PI:
					 mEmitter.emitPushPi();
					 pushType(VARTYP.TYPE_FLOAT);
					 lexan(lookahead);
					 break;
				case ZXToken.ZXB_NOTX:
					exprlexanfn();
					 cvToType(popType(), VARTYP.TYPE_INT);
					 popType();
					 mEmitter.emitNot();
					 pushType(VARTYP.TYPE_INT);
			}
		}

	}



	private boolean isnumber(String literal) {
		try {
			int i = Integer.parseInt(literal);
			return true;
		} 
		catch(Exception e) {
			return false;
		}
	}

	private boolean compileArray(Variable variable) {
		
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
	private void compileSubstring(VARTYP vartyp) {
		if (vartyp != VARTYP.TYPE_STRING) return;
		mStringUsed = true;
		if (lookahead.typ != ZXTokenTyp.ZX_OpenBracket) return;
 		lexan(lookahead);
		while (true) {
			if (lookahead.typ == ZXTokenTyp.ZX_Token && lookahead.zxToken == ZXToken.ZXB_TO) 
				mEmitter.emitPushInteger("1");
			else {
				expr();
				cvToType(popType(), VARTYP.TYPE_INT);
				popType();
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
					cvToType(popType(),VARTYP.TYPE_INT);
					popType();
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
			cvToType(popType(),VARTYP.TYPE_INT);
			popType();
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
		if (variable.typ == VARTYP.TYPE_STRING || variable.typ == VARTYP.TYPE_INT)
			mEmitter.emitMultiPlyTopOfStack(2);
		if (variable.typ == VARTYP.TYPE_FLOAT)
			mEmitter.emitMultiPlyTopOfStack(5);
		if (push) {
	//		mEmitter.mOptimize = 0;
			mEmitter.emitPushHL();
	//		mEmitter.mOptimize = mEmitter.mSettingOptimize;
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
			error("Nonsense in ZX Compiler");
		}

	}

	private void check(ZXTokenizer.ParserToken.ZXTokenTyp token) {
		if (lookahead.typ == token) return;
		error("Nonsense in ZX Compiler");

	}

	private void match(ParserToken token) {
		if (lookahead.typ == token.typ) {
			lexan(lookahead);
		} else {
			error("Nonsense in ZX Compiler");
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

	public void writeBasicFile(String filename) {
		PrintWriter writer;
		try {
			writer = new PrintWriter(filename, "UTF-8");
			writer.println(mBASICSource.toString());
			writer.close();	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
