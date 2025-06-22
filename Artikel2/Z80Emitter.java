package zxcompiler;

import java.util.ArrayList;
import java.util.Stack;
import java.util.TreeMap;
import java.util.TreeSet;

// writes Z80 code
public class Z80Emitter {
	static final boolean BlockComments=false;
	public int mSettingOptimize=0;
	public boolean mSettingVerbose=true;
	Z80Optimizer mOptimizer = new Z80Optimizer();
	boolean mLog=true;
	
	// in order to optimize the code, it is stored in machine readable format
	

	public static class Variable {
		public String name;
		public int    typ;
		public int[]  dimen = null;
		public String declare() {
			int size=0;
			int dims=1;
			switch(typ) {
				case ZXCompiler.TYPE_FLOAT:
					size = 5 * countDimen();
					return String.format("defs %s",size); 
	
				case ZXCompiler.TYPE_INT:
				case ZXCompiler.TYPE_STRING:
					dims = countDimen();
					size = 2 * dims;
					if (dims == 1) 
						return "dw 0";
					else
						return String.format("defs %s", size);
				default:
					return "error";
			}
		}
		private  int countDimen() {
			int count=1;
			if (dimen != null) {
				for (int i=0;i<dimen.length;i++) 
					count *= (dimen[i]+1);
			}
			return count;
		}
	}


	public StringBuffer sbCode = new StringBuffer();	
	String lastCommand="";
	int    lastLabel=0;
	int    mLastString=0;
	int    mLastFor=0;
	Stack<Integer> mForStack = new Stack<Integer>();
	TreeMap<String, Variable> mMapVariables = new TreeMap<String, Z80Emitter.Variable>();
	TreeMap<String, String>   mMapStrings = new TreeMap<String, String>();
	TreeMap<String, String>   mMapRStrings = new TreeMap<String, String>();
	ArrayList<Z80Command> mCommands = new ArrayList<Z80Command>();
	private StringBuilder mSBData = new StringBuilder();
	private boolean mUsesData;
	public int mOptimize=1;
	
	void emitStart() {
		sbCode.append("\r\n"
				+ "CBASIC_START\r\n"
				+ "compiledBasic:\r\n"
				+ "\tcall ZXHeapClear\r\n"
				+ "\tLD (runtimeSaveSP),SP\r\n"
				+ "");	
	}
	void emitEnd() {
		sbCode.append("\r\n"
				+ "    DISPLAY \"Compiled Basic = \", /D, $-CBASIC_START,  \" bytes\"");
	}
	
	
	void emitString(String str) {
		sbCode.append(str+"\n");
		if (mSettingVerbose && mLog)
				System.out.println(str);
	}
	
	void emitCommand(String command, String param1) {
		emitCommand(command,param1,null,null);
	}
	void emitCommand(String command, String param1, String param2) {
		emitCommand(command,param1,param2,null);
	}
	void emitCommand(String command, String param1, String param2, String comment) {
		if (mOptimize > 0) {
			mCommands.add(new Z80Command(command, param1, param2, comment));
			String str = command;
			if (param1 != null) str += " "+param1;
			if (param2 != null) str += ","+param2;
			if (comment != null) str += "\t;"+comment;
			if (str.compareTo("CALL runtimeCheckBreak") == 0 &&
				str.compareTo(lastCommand) == 0) return;
			if (lastCommand.compareTo("PUSH HL") == 0) {
				if (str.compareTo("POP HL")==0) { 
						lastCommand = str;
						return;
				} else
					emitString("\t"+lastCommand);
				
			}
			lastCommand = str;
			if (str.compareTo("PUSH HL") != 0)			
				emitString("\t"+str);
		}
		else {
			mCommands.add(new Z80Command(command, param1, param2, comment));
			String str = "\t"+command;
			if (param1 != null) str += " "+param1;
			if (param2 != null) str += ", "+param2;
			if (comment != null) str += "\t;"+comment;
			emitString(str);
		}
		
	}
	
	
	public void writeVariables() {
		mOptimizer.COMMENTOUT = false;
		if (mOptimize == 2) mOptimizer.COMMENTOUT = true;
		if (mOptimize > 0)
			mOptimizer.optimize(mCommands);
		
		sbCode = new StringBuffer();
		System.out.println("Writing optimized code");
		mLog=false;
		emitStart();
		for (Z80Command cmd: mCommands) {
			String s = cmd.toZ80();
			if (s != null)
				emitString(s);
		}
		
		for (Variable v: mMapVariables.values()) {
			emitString(String.format("ZXBASIC_VAR_%s:\t%s", v.name, v.declare()));
		}
		for (String name: mMapStrings.keySet()) {
			String value = mMapStrings.get(name);
			int len = value.length();
			int low = len % 256;
			int high = len / 256;
			emitString(String.format("%s:\tdw %d", name,len));
			String str = stringToAsmDB(value);
			if (str.length() > 0)
				emitString(String.format("\tdb\t%s", str));
		}
		if (mUsesData) {
			emitString(String.format("DATAPTR:\tDW 0"));
		}
		emitString(mSBData.toString());
	}
	
	private String stringToAsmDB(String value) {
		String r = "";
	
		boolean inString=false;
		int i=0;
		while (i<value.length()) {
			char c = value.charAt(i);
			if (c == '\\') {
				if (inString) { r += "\""; inString = false; }
				String d = value.substring(i+1,i+3);
				if (i > 0) r += ", ";
				r += "$"+d;
				i+=3;
			} else {
				if (!inString) {
					if (i>0) r += ", ";
					r += "\"";
					inString=true;
				}
				r += c;
				i++;
			}
		}
		if (inString) r += "\"";
		return r;
	}

	public void emitPushInteger(String number) {
		emitCommand("LD", "HL", String.format("%s", number));
		emitCommand("PUSH","HL");
	}
	
	public void emitPushString(String literal) {
		String adr = allocateString(literal);
		emitCommand("LD", "HL", String.format("%s", adr),literal);
		emitCommand("PUSH","HL");
		
	}

	
	private String allocateString(String literal) {
		
		String name = mMapRStrings.get(literal);
		if (name != null) return name;
		
		name = String.format("STRING_%d",mLastString++);
		
		mMapStrings.put(name,  literal);
		mMapRStrings.put(literal, name);
		
		return name;
	}

	public void emitPushIntegerVariable(String varname, boolean isArray) {
		if (isArray) {
			emitCommand("LD",String.format("DE, ZXBASIC_VAR_%s", varname));
			emitCommand("ADD","HL","DE");
			emitCommand("LD","DE","(HL)");
			emitCommand("PUSH","DE");

		} else {
			emitCommand("LD","HL",String.format("(ZXBASIC_VAR_%s)", varname));
			emitCommand("PUSH","HL");
		}
	}
	
	public void emitPushFloatVar(String varname, boolean isArray) {
		if (isArray) {
			emitCommand("LD",String.format("DE, ZXBASIC_VAR_%s", varname));
			emitCommand("ADD","HL","DE");
			emitCommand("CALL","runtimePushFloatVar");

		} else {
			emitCommand("LD","HL",String.format("ZXBASIC_VAR_%s",varname ));
			emitCommand("CALL","runtimePushFloatVar");
		}
		
	}

	
	public void emitStoreIntegerVar(String varname, boolean isIndexed) {
		emitBlockComment("Store "+varname);
		if (isIndexed) {
			emitCommand("POP","DE");
			emitCommand("POP","HL");
			emitCommand("LD","BC",String.format("ZXBASIC_VAR_%s", varname));
			emitCommand("ADD","HL","BC");
			emitCommand("LD","(HL)","DE");	
		} else {
			emitCommand("POP","HL");
			emitCommand("LD",String.format("(ZXBASIC_VAR_%s)", varname),"HL");
			emitBlockCommentEnd();
		}
	}
	
	public void emitStoreFloatVar(String varname, boolean isIndexed) {
		emitBlockComment("Store float"+varname);
		emitCommand("LD","HL",String.format("ZXBASIC_VAR_%s", varname));
		emitCommand("CALL", "runtimeStoreFloat");
		emitBlockCommentEnd();
		
	}

	public void emitStoreStringVar(String varname, boolean isIndexed) {
		emitBlockComment("Store string"+varname);
		if (isIndexed) {
			emitCommand("POP","DE");
			emitCommand("POP","HL");
			emitCommand("LD","BC",String.format("ZXBASIC_VAR_%s", varname));
			emitCommand("ADD","HL","BC");
			emitCommand("LD","(HL)","DE");	
		} else {		
			emitCommand("POP","DE");
			emitCommand("LD","HL",String.format("ZXBASIC_VAR_%s", varname));
			emitCommand("CALL","runtimeStoreString");
			emitBlockCommentEnd();
		}
		
	}
	
	
	public void emitPlus() {
		emitBlockComment("+");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("ADD","HL","DE");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}

	public void emitMinus() {
		emitBlockComment("-");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("EX","HL","DE");
		emitCommand("SUB","HL","DE");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}
	
	public void emitMult() {
		emitBlockComment("*");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("call","runtimeMult16bit");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}

	public void emitDiv() {
		emitBlockComment("/");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("call","runtimeDiv16bit");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}
	
	public void emitSmaller() {
		emitBlockComment("<");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("SUB","HL","DE");
		emitCommand("LD","HL","0");
		emitCommand("call","nc","HL1");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}
	
	public void emitBigger() {
		emitBlockComment("OR");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("SUB","HL","DE");
		emitCommand("LD","HL","0");
		emitCommand("call", "c", "HL1");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}

	public void emitSmallerEqual() {
		emitBlockComment("<=");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("SUB", "HL", "DE");
		emitCommand("LD", "HL","0");
		emitCommand("call", "nc", "HL1");
		emitCommand("call", "z", "HL1");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}
	
	public void emitBiggerEqual() {
		emitBlockComment(">=");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("SUB","HL", "DE");
		emitCommand("LD",  "HL","0");
		emitCommand("call","c", "HL1");
		emitCommand("call", "z", "HL1");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}

	public void emitUnequal() {
		emitBlockComment("<>");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("SUB","HL", "DE");
		emitCommand("LD",  "HL","0");
		emitCommand("CALL","NZ", "HL1");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}

	public void emitEqual() {
		emitBlockComment("==");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("SUB", "HL", "DE");
		emitCommand("LD",  "HL","0");
		emitCommand("CALL","Z", "HL1");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}

	public void emitLine(int line) {
		String label = String.format("ZX_LINE_%d", line); 
		emitString(label+":");
		Z80Command cmd = new Z80Command(label, null, null, null, null);
		mCommands.add(cmd);
	}

	public void emitOr() {
		emitBlockComment("OR");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("LD","A","L");
		emitCommand("OR","E");
		emitCommand("LD","L","A");
		emitCommand("LD","H","0");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitAnd() {
		emitBlockComment("AND");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("LD","A","L");
		emitCommand("AND","E");
		emitCommand("LD","L","A");
		emitCommand("LD","H","0");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitComment(String string) {
		Z80Command cmd = new Z80Command(null, null, null, string);
		mCommands.add(cmd);
		emitString(";"+string);
	}

	public String emitCheckFor0() {
		String label = newLabel();
		emitBlockComment("check for 0");
		emitCommand("POP", "HL");
		emitCommand("LD", "A","L");
		emitCommand("CP", "0");
		emitCommand("JR", "Z",label);
		emitBlockCommentEnd();
		
		
		// TODO Auto-generated method stub
		return label;
	}

	private void emitBlockComment(String string) {
		if (BlockComments) 	emitComment(string);		
	}

	private void emitBlockCommentEnd() {
		if (BlockComments) 	emitComment("---");
		
	}

	private String newLabel() {
		lastLabel++;
		return String.format("ZXB_LABEL_%d", lastLabel);
	}

	public void emitLabel(String label) {
		Z80Command z80 = new Z80Command(label, null, null, null, null);
		mCommands.add(z80);
		emitString(String.format("%s:",label));
		
	}

	public void emitJumpToLine(String line) {
		emitCommand("JP",String.format("ZX_LINE_%s", line));
	}

	public void emitCallToLine(String line) {
		emitCommand("CALL",String.format("ZX_LINE_%s:", line));
		
	}

	public void emitReturn() {
		emitCommand("RET",null);
		
	}
	
	public void emitPlot() {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("CALL","runtimePlot");
	}
	
	public void emitDraw() {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("LD","B","L");
		emitCommand("LD","C","E");
		emitCommand("CALL","runtimeDraw");
	}
	
	public void emitCircle() {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("LD","B","L");
		emitCommand("LD","C","E");
		emitCommand("POP","DE");
		emitCommand("CALL","runtimeCircle");
	}
	
	
	
	public void emitPoke() {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("EX","HL","DE");
		emitCommand("LD","(HL)","E");
	}


	public void emitPlusString() {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("CALL","runtimeStringAdd");
		emitCommand("PUSH","HL");
	}

	public void emitCls() {
		emitCommand("CALL","runtimeCls");
	}

	public void emitPrintInt() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimePrintInt");
	}

	public void emitPrintString() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimePrintString");
		
	}

	public void emitPrintFloat() {
		emitCommand("CALL","runtimePrintFloat");
	}

	public void emitPrintTab() {
		emitCommand("CALL","runtimePrintTab");
		
	}

	public void emitPrintNewline() {
		emitCommand("CALL","runtimePrintNewline");
		
	}

	public void emitPrintAt() {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("CALL","runtimePrintAt");
		
	}
	/* ZX Colors
	 * 128 If the character position is flashing, 0 if it is steady 
	64 if the character position is bright, 0 if it is normal 
	8* the code for the paper colour 
	the code for the ink colour
	 */

	public void emitLocalInk() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeLocalInk");
		
	}
	public void emitLocalPaper() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeLocalPaper");
		
	}
	public void emitLocalFlash() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeLocalFlash");		
	}
	public void emitLocalBright() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeLocalBright");		
	}
	public void emitLocalOver() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeLocalOver");				
	}
	public void emitLocalInverse() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeLocalInverse");				
		
	}

	
	public void emitInk() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeInk");
		
	}
	public void emitPaper() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimePaper");
		
	}
	public void emitFlash() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeFlash");		
	}
	public void emitBright() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeBright");		
	}

	public void emitOver() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeOver");		
		
	}

	public void emitRestoreAttr() {
		emitCommand("LD","A", "(ZX_ATTR_P)");
		emitCommand("LD","(ZX_ATTR_T)", "A");
	}

	public void emitFloatToInt() {
		emitCommand("CALL","runtimeFloatToInt");
		
	}

	public void emitIntToFloat() {
		emitCommand("CALL","runtimeIntToFloat");
		
	}



	public void emitInputInt() {
		emitCommand("CALL","runtimeInputInt");
		emitCommand("PUSH","HL");
		
	}

	public void emitInputString() {
		emitCommand("CALL","runtimeInputString");
		emitCommand("PUSH","HL");
		
	}

	public void emitInputFloat() {
		emitCommand("CALL","runtimeInputFloat");
		
	}

	public void emitCvIntToFloat() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeIntToFloat");
		
	}

	public void swapFloat() {
		emitCommand("CALL","runtimeSwapFloat");
		
	}

	public void emitPushFloat(int[] floatLiteral) {
		emitCommand("CALL","runtimeSwapFloat");
		emitCommand("PUSH","HL");
		
	}

	public void emitPushHL() {
		emitCommand("PUSH","HL");
		
	}

	public void emitRnd() {
		emitCommand("CALL","runtimeRND");
		
	}

	public void emitCode() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeCode");
		emitCommand("PUSH","HL");
	}
	
	public void emitChr() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeChr");
		emitCommand("PUSH","HL");
		
	}

	public void emitVal() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeVal");
	}

	public void emitStr() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeStr");
		emitCommand("PUSH","HL");
		
	}

	public void emitPeek() {
		emitCommand("POP","HL");
		emitCommand("LD","L","(HL)");
		emitCommand("LD","H","0");
		emitCommand("PUSH","HL");
		
	}

	public void emitSin() {
		emitCommand("CALL","runtimeSin");
		
	}

	public void emitCos() {
		emitCommand("CALL","runtimeCos");
		
	}

	public void emitTan() {
		emitCommand("CALL","runtimeTan");
		
	}

	public void emitSqr() {
		emitCommand("CALL","runtimeSqr");
		
	}

	public void emitLen() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeLen");
		emitCommand("PUSH","HL");
		
	}

	public void emitUsr() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeUsr");
		emitCommand("PUSH","HL");
	}
	
	public void emitUsrUDG() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeUsrUDG");
		emitCommand("PUSH","HL");
		
	}
	

	public void emitLn() {
		emitCommand("CALL","runtimeLn");
		
	}

	public void emitExp() {
		emitCommand("CALL","runtimeExp");
		
	}

	public void emitInkey() {
		emitCommand("CALL","runtimeInkey");
		emitCommand("PUSH","HL");		
	}

	public void emitPlusFloat() {
		emitCommand("CALL","runtimePlusFloat");
		
	}

	public void emitMinusFloat() {
		emitCommand("CALL","runtimeMinusFloat");
		
	}

	public void emitOrFloat() {
		emitCommand("CALL","runtimeOrFloat");
		
	}

	public void emitAndFloat() {
		emitCommand("CALL","runtimeAndFloat");
		
	}

	public void emitMultFloat() {
		emitCommand("CALL","runtimeMultFloat");
	}

	public void emitDivFloat() {
		emitCommand("CALL","runtimeDivFloat");
		
	}

	public void emitBiggerString() {
		// TODO Auto-generated method stub
		
	}

	public void emitBiggerFloat() {
		// TODO Auto-generated method stub
		
	}

	public void emitSmallerString() {
		// TODO Auto-generated method stub
		
	}

	public void emitSmallerFloat() {
		// TODO Auto-generated method stub
		
	}

	public void emitSmallerEqualString() {
		// TODO Auto-generated method stub
		
	}

	public void emitSmallerEqualFloat() {
		// TODO Auto-generated method stub
		
	}

	public void emitBiggerEqualString() {
		// TODO Auto-generated method stub
		
	}

	public void emitBiggerEqualFloat() {
		// TODO Auto-generated method stub
		
	}

	public void emitUnequalString() {
		// TODO Auto-generated method stub
		
	}

	public void emitUnequalFloat() {
		// TODO Auto-generated method stub
		
	}

	public void emitStream() {
		emitCommand("POP", "HL");
		emitCommand("CALL","runtimeSetStream");
	}

	public void emitCloseStream() {
		emitCommand("LD", "HL","0");
		emitCommand("CALL","runtimeSetStream");
	}

	public void emitStartData(int line) {
		mSBData.append(String.format("DATA_%s:\n", line));
		
	}

	public void emitDataInt(String literal) {
		mSBData.append(String.format("\tdw %s\n", literal));
		
	}

	public void emitDataString(String literal) {
		mSBData.append(String.format("\tdw %d\n", literal.length()));
		mSBData.append(String.format("\tdb \"%s\"\n", literal));
	}

	public void emitRestore(String literal) {
		emitCommand("LD","HL","DATA_"+literal);
		emitCommand("LD","(DATAPTR)","HL");
		mUsesData = true;
		
	}

	public void emitRead(String literal) {
		emitCommand("LD","HL","(DATAPTR)");
		emitCommand("LD","DE","(HL)");
		emitCommand("INC","HL");
		emitCommand("INC","HL");
		emitCommand("LD","(DATAPTR)","HL");
		emitCommand("LD",String.format("(ZXBASIC_VAR_%s)", literal),"DE");
	}

	public void emitPush1() {
		emitCommand("LD","HL","1");
		emitCommand("PUSH","HL");
		
	}

	public void emitForLabel() {
		String label = String.format("FOR_%d", mLastFor); 
		emitString(label+":");
		Z80Command z80 = new Z80Command(label, null, null, null, null);
		mCommands.add(z80);
		mForStack.push(Integer.valueOf(mLastFor));
		mLastFor++;
	}

	public void emitNext(String literal) {
		String lbl = String.format("FOR_%d", mForStack.pop().intValue());
		emitCommand("LD","HL","0");
		emitCommand("ADD","HL","SP");
		emitCommand("LD","IX","HL");		// ^0 = step, ix+2=to
		emitCommand("LD","HL",String.format("(ZXBASIC_VAR_%s)", literal));
		emitCommand("LD","BC","(IX+0)");
		emitCommand("ADD","HL","BC");
		emitCommand("LD",String.format("(ZXBASIC_VAR_%s)", literal),"HL");
		emitCommand("LD","DE","(IX+2)");
		emitCommand("EX","HL","DE");
		emitCommand("SUB","HL","DE");
		emitCommand("JP","NC",lbl);
		emitCommand("POP","AF");
		emitCommand("POP","AF");

		// TODO Auto-generated method stub
		
	}

	public void emitMultiPlyTopOfStack(int faktor) {
		emitCommand("POP","HL");
		if (faktor == 2) {
			emitCommand("ADD","HL","HL");
		} else if (faktor == 4) {
			emitCommand("ADD","HL","HL");
			emitCommand("ADD","HL","HL");
		} else if (faktor == 8) {
			emitCommand("ADD","HL","HL");
			emitCommand("ADD","HL","HL");
			emitCommand("ADD","HL","HL");
		} else {
			emitCommand("LD","DE",String.format("%d",faktor));
			emitCommand("CALL","runtimeHlTimesDe");
		}
	}

	public void emitPause() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimePause");
		
	}

	public void emitEqualString() {
		// TODO Auto-generated method stub
		
	}

	public void emitEqualFloat() {
		// TODO Auto-generated method stub
		
	}
	public void emitCheckBreak() {
		emitCommand("CALL","runtimeCheckBreak");
	}
	public void emitStartInput() {
		emitCommand("LD","A","$01");//	Open channel 'K'.
		emitCommand("CALL","$1601");
		emitCommand("CALL","0D6E");
		emitCommand("LD","A","1");
		emitCommand("LD","($5C3A)","A");
		
	}
	public void emitSubstring() {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("POP","BC");
		emitCommand("CALL","runtimeSubstring");
		emitCommand("PUSH","HL");
	}
	public void emitCharAt() {
		emitCommand("POP","HL");
		emitCommand("POP","BC");
		emitCommand("CALL","runtimeCharAt");
		emitCommand("PUSH","HL");
	}
	
	public void emitIntVar(String name) {
		Variable var = mMapVariables.get(name);
		if (var == null) {
			var = new Variable();
			var.name = name;
			var.typ = ZXCompiler.TYPE_INT;
			mMapVariables.put(name, var);
		}
	}

	public void emitFloatVar(String name) {
		Variable var = mMapVariables.get(name);
		if (var == null) {
			var = new Variable();
			var.name = name;
			var.typ = ZXCompiler.TYPE_FLOAT;
			mMapVariables.put(name, var);
		}
		
	}
	public void emitStringVar(String name) {
		Variable var = mMapVariables.get(name);
		if (var == null) {
			var = new Variable();
			var.name = name;
			var.typ = ZXCompiler.TYPE_STRING;
			mMapVariables.put(name, var);
		}
		
	}
	public void emitClearTemp() {
		emitCommand("CALL", "ZXFreeTemp");
	}
	public void emitPushAddFloat() {
		emitCommand("CALL","runtimeAddFloat");
	}
	public void emitPushSubFloat() {
		emitCommand("CALL","runtimeSubFloat");
		
	}
	
	public void emitPushPi() {
		emitCommand("CALL","runtimePushPi");
		
	}







}
