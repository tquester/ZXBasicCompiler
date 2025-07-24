package zxcompiler;

import java.util.ArrayList;
import java.util.Stack;
import java.util.TreeMap;
import java.util.TreeSet;

import zxcompiler.ZXTokenizer.ParserToken;
import zxcompiler.ZXTokenizer.ZXBasicLine;

// writes Z80 code
public class Z80Emitter {
	static final boolean BlockComments = false;
	public int mSettingOptimize = 0;
	public boolean mSettingVerbose = true;
	Z80Optimizer mOptimizer = new Z80Optimizer();
	boolean mLog = true;

	// in order to optimize the code, it is stored in machine readable format

	public class CBasicLine {
		int line;
		int stmt;
		String text;
	}
	public static class Variable {
		public String name;
		public VARTYP typ;
		public int[] dimen = null;
		public boolean step = false;

		public String declare() {
			int size = 0;
			int dims = 1;
			switch (typ) {
			case VARTYP.TYPE_FLOAT:
				size = 5 * countDimen();
				return String.format("defs %s", size);

			case VARTYP.TYPE_INT:
			case VARTYP.TYPE_STRING:
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

		private int countDimen() {
			int count = 1;
			if (dimen != null) {
				for (int i = 0; i < dimen.length; i++)
					count *= (dimen[i] + 1);
			}
			return count;
		}
		
		public String toString() {
			String strtyp="undef";
			switch(typ) {
			case VARTYP.TYPE_INT: strtyp = "int16"; break;
			case VARTYP.TYPE_FLOAT: strtyp = "float"; break;
			case VARTYP.TYPE_STRING: strtyp = "string"; break;
			}
			return String.format("%s %s", strtyp, name);
		}

		public int getFixStringLen() {
			int i = dimen.length;
			if (i == 0) return 0;
			i--;
			return dimen[i];
		}
	}

	public static class CDefFN {
		public String name;
		public ArrayList<Variable> mListVariables = new ArrayList<Variable>();
		public TreeMap<String, Variable> mVariables = new TreeMap<String, Z80Emitter.Variable>();
		public VARTYP typ;
	}

	public StringBuffer sbCode = new StringBuffer();
	String lastCommand = "";
	int lastLabel = 0;
	int mLastString = 0;
	int mLastFor = 0;
	Stack<Integer> mForStack = new Stack<Integer>();
	private TreeMap<String, CDefFN> mMapDefFn = new TreeMap<String, Z80Emitter.CDefFN>();
	private TreeMap<String, Variable> mMapVariables = new TreeMap<String, Z80Emitter.Variable>();
	private CDefFN mCurDefFN = null;
	TreeMap<String, String> mMapStrings = new TreeMap<String, String>();
	TreeMap<String, String> mMapRStrings = new TreeMap<String, String>();
	TreeMap<String, String> mMapFloatConsts = new TreeMap<String, String>();
	TreeMap<String, String> mMapFloatValues = new TreeMap<String, String>();
	TreeMap<String, String> mMapRFloatConsts = new TreeMap<String, String>();
	TreeMap<Integer, String> mMapDataLines = new TreeMap<Integer, String>();
	TreeMap<Integer, String> mMapCodeLines = new TreeMap<Integer, String>();
	public boolean mUsesVarGoto = false;
	public boolean mUsesVarData = false;
	ArrayList<Z80Command> mCommands = new ArrayList<Z80Command>();
	ArrayList<Z80Command> mLocalCommands = new ArrayList<Z80Command>();
	ArrayList<Z80Command> mSaveCommands;
	ArrayList<CBasicLine> mBasicLines = new ArrayList<Z80Emitter.CBasicLine>();
	private StringBuilder mSBData = new StringBuilder();
	private boolean mUsesData;
	public int mOptimize = 1;
	private int mFloatNr = 1;
	private String mNextComment;
	public boolean mSettingDebug;
	private boolean mSettingsInline=true;

	Variable getVariable(String name) {
		if (name.endsWith("$"))
			name = name.substring(0, name.length() - 1) + "_string";

		Variable r = null;
		if (mCurDefFN != null) {
			r = mCurDefFN.mVariables.get(name);
			if (r != null)
				return r;
		}
		return mMapVariables.get(name);
	}

	void emitStart() {
		sbCode.append("\r\n" + "CBASIC_START\r\n" + "compiledBasic:\r\n" + "\tcall ZXHeapClear\r\n"
				+ "\tLD (runtimeSaveSP),SP\r\n" + "");
	}

	void emitEnd() {
		sbCode.append("\r\n" + "    DISPLAY \"Compiled Basic = \", /D, $-CBASIC_START,  \" bytes\"");
	}

	void emitString(String str) {
		sbCode.append(str + "\n");
		if (mSettingVerbose && mLog)
			System.out.println(str);
	}

	Z80Command emitCommand(String command, String param1) {
		return emitCommand(command, param1, null, null);
	}

	Z80Command emitCommand(String command, String param1, String param2) {
		return emitCommand(command, param1, param2, null);
	}

	Z80Command emitCommand(String command, String param1, String param2, String comment) {
	
		mNextComment=null;
		Z80Command z80cmd = null;
		if (mOptimize > 0) {
			z80cmd = new Z80Command(command, param1, param2, comment);
			mCommands.add(z80cmd);
			String str = command;
			if (param1 != null)
				str += " " + param1;
			if (param2 != null)
				str += "," + param2;
			if (comment != null)
				str += "\t;" + comment;
			if (str.compareTo("CALL runtimeCheckBreak") == 0 && str.compareTo(lastCommand) == 0)
				return z80cmd;
			emitString("\t" + str);
			/*
			if (lastCommand.compareTo("PUSH HL") == 0) {
				if (str.compareTo("POP HL") == 0) {
					lastCommand = str;
					return z80cmd;
				} else
					emitString("\t" + lastCommand);

			}
			lastCommand = str;
			if (str.compareTo("PUSH HL") != 0)
				emitString("\t" + str);
			*/
		} else {
			z80cmd = new Z80Command(command, param1, param2, comment);
			mCommands.add(z80cmd);
			String str = "\t" + command;
			if (param1 != null)
				str += " " + param1;
			if (param2 != null)
				str += ", " + param2;
			if (comment != null)
				str += "\t;" + comment;
			emitString(str);
		}
		return z80cmd;

	}

	public void writeVariables() {
		mOptimizer.COMMENTOUT = false;
		if (mOptimize == 2)
			mOptimizer.COMMENTOUT = true;
		if (mOptimize > 0)
			mOptimizer.optimize(mCommands);

		sbCode = new StringBuffer();
		System.out.println("Writing optimized code");
		mLog = false;
		emitStart();
		for (Z80Command cmd : mCommands) {
			String s = cmd.toZ80();
			if (s != null)
				emitString(s);
		}

		for (Variable v : mMapVariables.values()) {
			emitString(String.format("ZXBASIC_VAR_%s:\t%s", v.name, v.declare()));
		}
		for (String key : mMapFloatConsts.keySet()) {
			String val = mMapFloatConsts.get(key);
			String comment = mMapFloatValues.get(val);
			if (comment == null)
				emitString(String.format("%s:\tdb %s", key, val));
			else
				emitString(String.format("%s:\tdb %s\t;%s", key, val, comment));
		}
		for (String name : mMapStrings.keySet()) {
			String value = mMapStrings.get(name);
			int len = value.length();
			int low = len % 256;
			int high = len / 256;
			emitString(String.format("%s:\tdw %d", name, stringToAsmDBLen(value)));
			String str = stringToAsmDB(value);
			if (str.length() > 0)
				emitString(String.format("\tdb\t%s", str));
		}
		if (mUsesVarGoto) writeLineMap(mMapCodeLines,"ZXLINES");
		if (mUsesVarData) writeLineMap(mMapDataLines,"ZXDATA");
		if (mUsesData) {
			emitString(String.format("DATAPTR:\tDW 0"));
		}
		emitString(mSBData.toString());
			writeDebugInfos();
	}
	
	private void writeDebugInfos() {
		emitString("ZX_VARIABLES:");
		if (mSettingDebug) {
			for (String key: mMapVariables.keySet()) {
				Variable var = mMapVariables.get(key);
				String varname = key;
				if (varname.endsWith("_string")) 
					varname = varname.substring(0,varname.length()-7)+"$";
				String line = String.format("\tdb %d,\"%s\",%d", varname.length(), varname, typtoint(var.typ));
				if (var.dimen == null) {
					line += ",0";
				} else {
					line += String.format(",%d", var.dimen.length);
					for (int i=0;i<var.dimen.length;i++) {
						line += String.format(",%d", var.dimen[i]);
					}
				}
				emitString(line);
				emitString(String.format("\tdw ZXBASIC_VAR_%s", key));
				
			}
		}
		emitString("\tdb 0");
		
	}

	private int typtoint(VARTYP typ) {
		switch(typ) {
		case TYPE_INT: return 1;
		case TYPE_FLOAT: return 2;
		case TYPE_STRING: return 3;
		case TYPE_FIXSTRING: return 4;
		}
		return 0;
	}

	String findCodeLine(int line) {
		Integer cint = Integer.valueOf(line);
		String label = mMapCodeLines.get(cint);
		if (label != null) return label;
		for (Integer ii: mMapCodeLines.keySet()) {
			int i = ii.intValue();
			if (ii >= line) 
				return mMapCodeLines.get(ii);
		}
		return null;
	}

	String findDataLine(int line) {
		Integer cint = Integer.valueOf(line);
		String label = mMapDataLines.get(cint);
		if (label != null) return label;
		for (Integer ii: mMapDataLines.keySet()) {
			int i = ii.intValue();
			if (ii >= line) 
				return mMapDataLines.get(ii);
		}
		return null;
		
		
		
	}

	private void writeLineMap(TreeMap<Integer, String> map, String label) {
		if (map.size() == 0) return;
		emitString(label+":");
		for (Integer key: map.keySet()) {
			String val = map.get(key);
			emitString(String.format("\tdw %s, %s", key.toString(),val));
		}
		emitString(String.format("\tdw %s, %s", "0","0"));
	}

	private String stringToAsmDB(String value) {
		String r = "";
		int count=0;

		boolean inString = false;
		int i = 0;
		while (i < value.length()) {
			char c = value.charAt(i);
			if (c == '\\') {
				if (inString) {
					r += "\"";
					inString = false;
				}
				String d = value.substring(i + 1, i + 3);
				if (count > 0)
					r += ", ";
				r += "$" + d;
				i += 3;
				count++;
				if (count >= 100) {
					count=0;
					r += "\n\tdb ";
				}
			} else {
				if (!inString) {
					if (count > 0)
						r += ", ";
					r += "\"";
					inString = true;
				}
				r += c;
				i++;
				count++;
			}
		}
		if (inString)
			r += "\"";
		return r;
	}

	private int stringToAsmDBLen(String value) {
		int r = 0;

		boolean inString = false;
		int i = 0;
		while (i < value.length()) {
			char c = value.charAt(i);
			if (c == '\\') {
				r++;
				i += 3;
			} else {
				r++;
				i++;
			}
		}
		return r;
	}

	public void emitPushInteger(String number) {
		emitCommand("LD", "HL", String.format("%s", number));
		emitCommand("PUSH", "HL");
	}

	public void emitPushString(String literal) {
		String adr = allocateString(literal);
		emitCommand("LD", "HL", String.format("%s", adr), literal);
		emitCommand("PUSH", "HL");

	}

	private String allocateString(String literal) {

		String name = mMapRStrings.get(literal);
		if (name != null)
			return name;

		name = String.format("STRING_%d", mLastString++);

		mMapStrings.put(name, literal);
		mMapRStrings.put(literal, name);

		return name;
	}

	public void emitPushIntegerVariable(String varname, boolean isArray) {
		if (isArray) {
			emitCommand("LD", String.format("DE, ZXBASIC_VAR_%s", varname));
			emitCommand("ADD", "HL", "DE");
			emitCommand("LD", "DE", "(HL)");
			emitCommand("PUSH", "DE");

		} else {
			emitCommand("LD", "HL", String.format("(ZXBASIC_VAR_%s)", varname));
			emitCommand("PUSH", "HL");
		}
	}

	public void emitPushFloatVar(String varname, boolean isArray) {
		if (isArray) {
			emitCommand("LD", String.format("DE, ZXBASIC_VAR_%s", varname));
			emitCommand("ADD", "HL", "DE");
			emitCommand("CALL", "runtimePushFloatVar");

		} else {
			emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s", varname));
			emitCommand("CALL", "runtimePushFloatVar");
		}

	}

	public void emitFloat(ParserToken lookahead) {
		String strBytes = "";
		for (int i = 0; i < 5; i++) {
			int b = lookahead.floatLiteral[i];
			if (b < 0)
				b += 256;
			if (i > 0)
				strBytes += ", ";
			strBytes += String.format("$%02x", b);
		}
		String label = mMapRFloatConsts.get(strBytes);
		if (label == null) {
			label = String.format("FLOAT_%d", mFloatNr++);
			mMapFloatConsts.put(label, strBytes);
			mMapFloatValues.put(strBytes, lookahead.literal);
			mMapRFloatConsts.put(strBytes, label);
		}
		emitCommand("LD", "HL", label, lookahead.literal);
		emitCommand("CALL", "runtimePushFloatVar");

	}

	public void emitStoreIntegerVar(String varname, boolean isIndexed) {
		emitBlockComment("Store " + varname);
		if (isIndexed) {
			emitCommand("POP", "DE");
			emitCommand("POP", "HL");
			emitCommand("LD", "BC", String.format("ZXBASIC_VAR_%s", varname));
			emitCommand("ADD", "HL", "BC");
			emitCommand("LD", "(HL)", "DE");
		} else {
			emitCommand("POP", "HL");
			emitCommand("LD", String.format("(ZXBASIC_VAR_%s)", varname), "HL");
			emitBlockCommentEnd();
		}
	}

	public void emitStoreFloatVar(String varname, boolean isIndexed) {
		if (isIndexed) {
			emitCommand("POP", "HL");
			emitCommand("LD", "BC", String.format("ZXBASIC_VAR_%s", varname));
			emitCommand("ADD", "HL", "BC");
			emitCommand("CALL", "runtimeStoreFloat");
			emitBlockCommentEnd();

		} else {
			emitBlockComment("Store float" + varname);
			emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s", varname));
			emitCommand("CALL", "runtimeStoreFloat");
			emitBlockCommentEnd();
		}

	}

	public void emitStoreStringVar(String varname, boolean isSubstring, VARTYP sourceTyp, int strlen) {
		emitBlockComment("Store string" + varname);
		if (isSubstring) {
			if (sourceTyp == VARTYP.TYPE_STRING) {
				emitCommand("POP", "HL");
				emitCommand("POP", "DE");
				emitCommand("POP", "BC");
				emitCommand("LD", "IX", String.format("ZXBASIC_VAR_%s", varname));
				emitCommand("call","runtimeStoreSubstringVarVar");
			} else if (sourceTyp == VARTYP.TYPE_FIXSTRING) {
				emitCommand("LD","BC",String.format("%d",strlen));
				emitCommand("LD", "IX", String.format("ZXBASIC_VAR_%s", varname));
				emitCommand("POP","HL");
				emitCommand("PUSH","IX");
				emitCommand("call","runtimeStoreSubstringVarFix");
			}
		} else {
			emitCommand("POP", "DE");
			emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s", varname));
			if (sourceTyp == VARTYP.TYPE_STRING)
				emitCommand("CALL", "runtimeStoreString");
			else {
				emitCommand("LD","BC",String.format("%d",strlen));
				emitCommand("CALL", "runtimeStoreStringVarFix");
			}
			emitBlockCommentEnd();
		}
	}
	
	public void emitStoreStringFix(String varname, boolean isSubstring, int size) {
		if (isSubstring) {
			// on Stack: from and to
			emitCommand("LD","BC",String.format("%d", size));
			emitCommand("LD", "IX", String.format("ZXBASIC_VAR_%s", varname));
			emitCommand("call","runtimeStoreSubstringVarFix");
		} else {
			emitCommand("POP", "DE");
			emitCommand("LD","BC",String.format("%d", size));
			emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s", varname));
			emitCommand("CALL", "runtimeStoreStringVarFix");
			emitBlockCommentEnd();
		}
		
	}
	

	public void emitPlus() {
		emitBlockComment("+");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("ADD", "HL", "DE");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitMinus() {
		emitBlockComment("-");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("EX", "HL", "DE");
		emitCommand("SUB", "HL", "DE");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitMult() {
		emitBlockComment("*");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("call", "runtimeMult16bit");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitDiv() {
		emitBlockComment("/");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("call", "runtimeDiv16bit");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitSmaller() {
		emitBlockComment("<");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL","runtimeCmpHLltDE");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitBigger() {
		emitBlockComment("OR");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL","runtimeCmpHlGtDE");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitSmallerEqual() {
		emitBlockComment("<=");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL","runtimeCmpHLLeDE");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitBiggerEqual() {
		emitBlockComment(">=");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL","runtimeCmpHLGeDE");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitUnequal() {
		emitBlockComment("<>");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL","runtimeCmpHlNeDE");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitEqual() {
		emitBlockComment("==");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL","runtimeCmpHLEqDE");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void storeLine(int line) {
		mMapCodeLines.put(Integer.valueOf(line),String.format("ZXBASIC_LINE_%d",line));
	}
	public void storeDataLine(int line) {
		String label=String.format("DATA_%d",line);
		Integer cline = Integer.valueOf(line);
		mMapDataLines.put(cline,label);
	}
	
	public void emitLine(int line) {
		String label = String.format("ZXBASIC_LINE_%d", line);
		emitString(label + ":");
		Z80Command cmd = new Z80Command(label, null, null, null, null);
		Integer cline = Integer.valueOf(line);
		mCommands.add(cmd);
	}

	public void emitOr() {
		emitBlockComment("OR");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("call","runtimeOrHLDE");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitAnd() {
		emitBlockComment("AND");
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("call","runtimeAndHLDE");
		emitCommand("PUSH", "HL");
		emitBlockCommentEnd();
	}

	public void emitComment(String string) {
		Z80Command cmd = new Z80Command(null, null, null, string);
		mCommands.add(cmd);
		emitString(";" + string);
	}

	public String emitCheckFor0() {
		String label = newLabel();
		emitBlockComment("check for 0");
		emitCommand("POP", "HL");
		emitCommand("LD", "A", "L");
		emitCommand("CP", "0");
		emitCommand("JP", "Z", label);
		emitBlockCommentEnd();

		// TODO Auto-generated method stub
		return label;
	}

	private void emitBlockComment(String string) {
		if (BlockComments)
			emitComment(string);
	}

	private void emitBlockCommentEnd() {
		if (BlockComments)
			emitComment("---");

	}

	public String newLabel() {
		lastLabel++;
		return String.format("ZXB_LABEL_%d", lastLabel);
	}

	public void emitLabel(String label) {
		Z80Command z80 = new Z80Command(label, null, null, null, null);
		mCommands.add(z80);
		emitString(String.format("%s:", label));

	}

	public void emitJumpToLine(String line) {
		emitCommand("JP", line);
	}

	public void emitCallToLine(String line) {
		emitCommand("CALL", line);

	}

	public void emitReturn() {
		emitCommand("RET", null);

	}

	public void emitPlot() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL", "runtimePlot");
	}

	public void emitDraw() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("LD", "B", "L");
		emitCommand("LD", "C", "E");
		emitCommand("CALL", "runtimeDraw");
	}

	public void emitDrawArc() {
		// TODO Auto-generated method stub

	}

	public void emitCircle() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("LD", "B", "L");
		emitCommand("LD", "C", "E");
		emitCommand("POP", "DE");
		emitCommand("CALL", "$233B",null,"ROM: Circle");
	}

	public void emitPoke() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("EX", "HL", "DE");
		emitCommand("LD", "(HL)", "E");
	}

	public void emitPlusString() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL", "runtimeStringAdd");
		emitCommand("PUSH", "HL");
	}

	public void emitCls() {
		emitCommand("CALL", "runtimeCls");
	}

	public void emitPrintInt() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimePrintInt");
	}

	public void emitPrintString() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimePrintString");

	}

	public void emitPrintFloat() {
		emitCommand("CALL", "runtimePrintFloat");
	}

	public void emitPrintTab() {
		emitCommand("CALL", "runtimePrintTab");

	}

	public void emitPrintNewline() {
		emitCommand("CALL", "runtimePrintNewline");

	}

	public void emitPrintAt() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL", "runtimePrintAt");
	}
	
	public void emitTab() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeTab");
	}
	/*
	 * ZX Colors 128 If the character position is flashing, 0 if it is steady 64 if
	 * the character position is bright, 0 if it is normal 8* the code for the paper
	 * colour the code for the ink colour
	 */

	public void emitLocalInk() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeLocalInk");

	}

	public void emitLocalPaper() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeLocalPaper");

	}

	public void emitLocalFlash() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeLocalFlash");
	}

	public void emitLocalBright() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeLocalBright");
	}

	public void emitLocalOver() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeLocalOver");
	}

	public void emitLocalInverse() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeLocalInverse");

	}

	public void emitInk() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeInk");
		

	}

	public void emitPaper() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimePaper");

	}

	public void emitFlash() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeFlash");
	}

	public void emitBright() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeBright");
	}

	public void emitOver() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeOver");

	}

	public void emitRestoreAttr() {
		emitCommand("LD", "A", "(ZX_ATTR_P)");
		emitCommand("LD", "(ZX_ATTR_T)", "A");
	}

	public void emitFloatToInt() {
		emitCommand("CALL", "runtimeFloatToInt");
		emitCommand("PUSH", "HL");

	}

	public void emitIntToFloat() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeIntToFloat");

	}

	public void emitInputInt(String literal) {
		emitCommand("CALL", "runtimeInputInt");
		emitCommand("PUSH", "HL");
		emitStoreIntegerVar(literal, false);

	}

	public void emitInputString(String literal, boolean bLine) {
		if (literal.endsWith("$"))
			literal = literal.substring(0, literal.length() - 1) + "_string";
		emitCommand("CALL", "runtimeInputString");
		emitCommand("PUSH", "HL");
		emitStoreStringVar(literal, false, VARTYP.TYPE_STRING, 0);

	}

	public void emitInputFloat(String literal) {
		emitCommand("CALL", "runtimeInputFloat");
		emitStoreFloatVar(literal, false);

	}

	public void emitCvIntToFloat() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeIntToFloat");

	}

	public void swapFloat() {
		emitCommand("CALL", "runtimeSwapFloat");

	}

	public void emitPushFloat(int[] floatLiteral) {
		emitCommand("CALL", "runtimeSwapFloat");
		emitCommand("PUSH", "HL");

	}

	public void emitPushHL() {
		emitCommand("PUSH", "HL");

	}

	public void emitRnd() {
		emitCommand("CALL", "runtimeRND");

	}

	public void emitCode() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeCode");
		emitCommand("PUSH", "HL");
	}

	public void emitChr() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeChr");
		emitCommand("PUSH", "HL");

	}

	public void emitVal() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeVal");
	}

	public void emitStr() {
		emitCommand("CALL", "runtimeStr");
		emitCommand("PUSH", "HL");

	}

	public void emitPeek() {
		emitCommand("POP", "HL");
		emitCommand("LD", "L", "(HL)");
		emitCommand("LD", "H", "0");
		emitCommand("PUSH", "HL");

	}

	public void emitSin() {
		emitCommand("RST", "$28");
		emitCommand("db", "zxcalc_sin");
		emitCommand("db", "$38", null, "end calc");

	}

	public void emitCos() {
		emitCommand("RST", "$28");
		emitCommand("db", "zxcalc_cos");
		emitCommand("db", "$38", null, "end calc");

	}

	public void emitTan() {
		emitCommand("CALL", "runtimeTan");

	}

	public void emitSqr() {
		emitCommand("CALL", "runtimeSqr");

	}

	public void emitLen() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeLen");
		emitCommand("PUSH", "HL");

	}

	public void emitUsr() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeUsr");
		emitCommand("PUSH", "HL");
	}

	public void emitUsrUDG() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeUsrUDG");
		emitCommand("PUSH", "HL");
	}
	public void emitUsrUDGFixString() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeUsrUDGFixString");
		emitCommand("PUSH", "HL");
		
	}
	

	public void emitLn() {
		emitCommand("CALL", "runtimeLn");

	}

	public void emitExp() {
		emitCommand("CALL", "runtimeExp");

	}

	public void emitInkey() {
		emitCommand("CALL", "runtimeInkey");
		emitCommand("PUSH", "HL");
	}

	public void emitPlusFloat() {
		emitCommand("CALL", "runtimePlusFloat");

	}

	public void emitMinusFloat() {
		emitCommand("CALL", "runtimeMinusFloat");

	}

	public void emitOrFloat() {
		emitCommand("CALL", "runtimeOrFloat");
		emitCommand("PUSH", "HL");

	}

	public void emitAndFloat() {
		emitCommand("CALL", "runtimeAndFloat");
		emitCommand("PUSH", "HL");

	}

	public void emitMultFloat() {
		emitCommand("RST", "$28");
		emitCommand("DB", "$04", null, "MULT");
		emitCommand("DB", "$38", null, "END CALC");
	}

	public void emitDivFloat() {
		emitCommand("RST", "$28");
		emitCommand("DB", "$05", null, "DIV");
		emitCommand("DB", "$38", null, "END CALC");

	}

	public void emitBiggerFloat() {
		emitCommand("CALL", "runtimeBiggerFloat");
		emitCommand("PUSH", "HL");

	}

	public void emitSmallerFloat() {
		emitCommand("CALL", "runtimeSmallerFloat");
		emitCommand("PUSH", "HL");

	}

	public void emitSmallerEqualFloat() {
		emitCommand("CALL", "runtimeSmallerEqualFloat");
		emitCommand("PUSH", "HL");

	}

	public void emitBiggerEqualFloat() {
		emitCommand("CALL", "runtimeBiggerEqualFloat");
		emitCommand("PUSH", "HL");

	}

	public void emitEqualString() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL", "runtimeEqualString");
		emitCommand("PUSH", "HL");

	}

	public void emitUnequalString() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL", "runtimeUnequalString");
		emitCommand("PUSH", "HL");
	}

	public void emitBiggerString() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL", "runtimeBiggerString");
		emitCommand("PUSH", "HL");

	}

	public void emitBiggerEqualString() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL", "runtimeBiggerEqualString");
		emitCommand("PUSH", "HL");
	}

	public void emitSmallerEqualString() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL", "runtimeSmallerEqualString");
		emitCommand("PUSH", "HL");

	}

	public void emitSmallerString() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("CALL", "runtimeSmallerString");
		emitCommand("PUSH", "HL");

	}

	public void emitUnequalFloat() {
		emitCommand("CALL", "runtimeUnequalFloat");
		emitCommand("PUSH", "HL");

	}

	public void emitStream() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimeSetStream");
	}

	public void emitCloseStream() {
		emitCommand("LD", "HL", "0");
		emitCommand("CALL", "runtimeSetStream");
	}

	public String emitStartData(int line) {
		String label=String.format("DATA_%d",line);
		mSBData.append(String.format("DATA_%s:\n", line));
		mUsesData = true;
		return label;

	}

	public void emitDataInt(String literal) {
		mSBData.append(String.format("\tdw %s\n", literal));

	}

	public void emitDataFloat(ParserToken lookahead) {
		mSBData.append(String.format("\tdb $%02x,$%02x,$%02x,$%02x,$%02x\t;%s\n", uint8(lookahead.floatLiteral[0]),
				uint8(lookahead.floatLiteral[1]), uint8(lookahead.floatLiteral[2]), uint8(lookahead.floatLiteral[3]),
				uint8(lookahead.floatLiteral[4]), lookahead.literal));

	}

	int uint8(int x) {
		if (x < 0)
			x += 256;
		return x;
	}

	public void emitDataString(String literal) {
		
		String str = stringToAsmDB(literal);
		
		mSBData.append(String.format("\tdw %d\n", stringToAsmDBLen(literal)));
		mSBData.append(String.format("\tdb %s\n", str));
	}

	public void emitRestore(String literal) {
		emitCommand("LD", "HL", literal);
		emitCommand("LD", "(DATAPTR)", "HL");
		mUsesData = true;
	}
	
	public void emitRestore2(String literal) {
		emitCommand("LD", "HL", literal);
		emitCommand("LD", "(DATAPTR)", "HL");
		mUsesData = true;
	}
	public void emitFirstRestore(String literal) {
		Z80Command cmd;
		cmd = new Z80Command("LD", "(DATAPTR)", "HL", null);
		mCommands.addFirst(cmd);
		cmd = new Z80Command("LD", "HL", literal, null);
		mCommands.addFirst(cmd);
		
	}
	

	public void emitReadInt(String literal) {
		if (mSettingsInline) {
			emitCommand("LD", "HL", "(DATAPTR)");
			emitCommand("LD", "DE", "(HL)");
			emitCommand("INC", "HL");
			emitCommand("INC", "HL");
			emitCommand("LD", "(DATAPTR)", "HL");
			emitCommand("LD", String.format("(ZXBASIC_VAR_%s)", literal), "DE");
		} else {
			emitCommand("LD", String.format("ZXBASIC_VAR_%s", literal), "DE");
			emitCommand("CALL","runtimeReadInt");
			
		}
	}

	public void emitReadString(String literal) {
		emitCommand("LD", "HL", "(DATAPTR)");
		emitCommand("LD", String.format("(ZXBASIC_VAR_%s)", literal), "HL");
		emitCommand("LD", "BC","(HL)");
		emitCommand("INC", "HL");
		emitCommand("INC", "HL");
		emitCommand("ADD","HL","BC");
		emitCommand("LD", "(DATAPTR)", "HL");
	}
	
	// reads (BASCIC READ) a string, pushes the BASIC String to the stack
	public void emitReadString(String name, boolean isArray, Variable var) {
		if (isArray == false) {
			if (mSettingsInline) {
				emitCommand("LD","HL",String.format("ZXBASIC_VAR_%s", name));
				emitCommand("CALL","ZXFreeStringVar");
				emitCommand("LD", "HL", "(DATAPTR)");
				emitCommand("LD", String.format("(ZXBASIC_VAR_%s)", name), "HL");
				emitCommand("LD", "BC","(HL)");
				emitCommand("INC", "HL");
				emitCommand("INC", "HL");
				emitCommand("ADD","HL","BC");
				emitCommand("LD", "(DATAPTR)", "HL");
			} else {
				emitCommand("LD","HL",String.format("ZXBASIC_VAR_%s", name));
				emitCommand("CALL","runtimeReadVarString");
			}
				
		} else {
			emitCommand("LD", "HL", "(DATAPTR)"); 
			emitStoreStringVar(name, isArray, VARTYP.TYPE_STRING, 0);
			emitCommand("LD", "HL", "(DATAPTR)");
			emitCommand("INC", "HL");
			emitCommand("INC", "HL");
			emitCommand("LD", "(DATAPTR)", "HL");
		}
	}
	

	public void emitReadFloat(String literal, boolean isArray) {
		if (mSettingsInline) {
			emitCommand("LD", "HL", "(DATAPTR)");
			emitCommand("LD", "DE", String.format("ZXBASIC_VAR_%s", literal));
			emitCommand("LD", "BC","5");
			emitCommand("LDIR", null);
			emitCommand("LD", "(DATAPTR)", "HL");
		} else {
			emitCommand("LD", "DE", String.format("ZXBASIC_VAR_%s", literal));
			emitCommand("CALL","runtimeReadFloat");
		}
		
	}


	public void emitPush1() {
		emitCommand("LD", "HL", "1");
		emitCommand("PUSH", "HL");

	}

	public String getForLabel() {
		return String.format("FOR_%d", mLastFor);
	}

	public void emitForLabel() {
		String label = String.format("FOR_%d", mLastFor);
		emitString(label + ":");
		Z80Command z80 = new Z80Command(label, null, null, null, null);
		mCommands.add(z80);
		mForStack.push(Integer.valueOf(mLastFor));
		mLastFor++;
	}

	public void emitNext(String literal) {
		String forlabel = String.format("for_%s", literal);
		Variable var = mMapVariables.get(forlabel);
		String lbl = String.format("FOR_%d", mForStack.pop().intValue());

		if (var.step == false) {
			if (var.typ == VARTYP.TYPE_INT) {
				emitCommand("LD", "HL", String.format("(ZXBASIC_VAR_%s)", literal));
				emitCommand("INC", "HL");
				emitCommand("LD", String.format("(ZXBASIC_VAR_%s)", literal), "HL");
				emitCommand("LD", "DE", String.format("(ZXBASIC_VAR_%s)", forlabel));
				emitCommand("EX", "HL", "DE");
				emitCommand("SUB", "HL", "DE");
				emitCommand("JP", "NC", lbl);
			} else if (var.typ == VARTYP.TYPE_FLOAT) {
				emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s", literal));
				emitCommand("CALL", "runtimePushFloatVar");
				emitCommand("RST", "$28");
				emitCommand("DB", "zxcalc_stack_one", null, "STACK ONE");
				emitCommand("DB", "zxcalc_addition", null, "ADD");
				// emitCommand("DB","$31",null,"DUPLICATE");
				emitCommand("DB", "zxcalc_end_calc", null, "END CALC");
				emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s", literal));
				emitCommand("CALL", "runtimeStoreFloat");
				emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s", forlabel));
				emitCommand("CALL", "runtimePushFloatVar");
				emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s", literal));
				emitCommand("CALL", "runtimePushFloatVar");
				emitCommand("CALL", "runtimeSmallerFloat");
				emitCommand("LD", "A", "L");
				emitCommand("CP", "0");
				emitCommand("JP", "Z", lbl);
			}
		} else {
			if (var.typ == VARTYP.TYPE_INT) {
				emitCommand("LD", "HL", String.format("(ZXBASIC_VAR_%s)", literal));
				emitCommand("LD", "BC", String.format("(ZXBASIC_VAR_%s_step)", forlabel));
				emitCommand("LD", "A", "B");
				emitCommand("ADD", "HL", "BC");
				emitCommand("LD", String.format("(ZXBASIC_VAR_%s)", literal), "HL");
				emitCommand("LD", "DE", String.format("(ZXBASIC_VAR_%s)", forlabel));
				emitCommand("AND", "$80");
				emitCommand("JR", "Z", lbl + "_1");
				emitCommand("SUB", "HL", "DE");
				emitCommand("JP", "NC", lbl);
				emitCommand("JR", lbl + "_2");
				emitCommandLabel(lbl + "_1");
				emitCommand("EX", "HL", "DE");
				emitCommand("SUB", "HL", "DE");
				emitCommand("JP", "NC", lbl);
				emitCommandLabel(lbl + "_2");
			} else if (var.typ == VARTYP.TYPE_FLOAT) {
				emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s", forlabel));
				emitCommand("CALL", "runtimePushFloatVar");
				emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s", literal));
				emitCommand("CALL", "runtimePushFloatVar");
				emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s_step", forlabel));
				emitCommand("CALL", "runtimePushFloatVar");
				emitCommand("RST", "$28");
				emitCommand("DB", "zxcalc_addition", null, "ADD");
				emitCommand("DB", "zxcalc_duplicate", null, "DUPLICATE");
				emitCommand("DB", "$38", null, "END CALC");
				emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s", literal));
				emitCommand("CALL", "runtimeStoreFloat");
				emitCommand("RST", "$28");
				emitCommand("db", "zxcalc_subtract");
				emitCommand("db", "zxcalc_end_calc");
				emitCommand("LD", "HL", String.format("ZXBASIC_VAR_%s_step", forlabel));
				emitCommand("CALL", "runtimePushFloatVar");
				emitCommand("CALL", "runtimeNextFloat");
				emitCommand("CP", "0");
				emitCommand("JP", "Z", lbl);
			}
		}

		// TODO Auto-generated method stub

	}

	private void emitCommandLabel(String string) {
		Z80Command cmd = new Z80Command(null, null, null, null);
		cmd.label = string;
		mCommands.add(cmd);
		emitString(string + ":");

	}

	public void emitMultiPlyTopOfStack(int faktor) {
		if (faktor == 1) {
			return;
		}
		emitCommand("POP", "HL");
		if (faktor == 2) {
			emitCommand("ADD", "HL", "HL");
		} else if (faktor == 4) {
			emitCommand("ADD", "HL", "HL");
			emitCommand("ADD", "HL", "HL");
		} else if (faktor == 8) {
			emitCommand("ADD", "HL", "HL");
			emitCommand("ADD", "HL", "HL");
			emitCommand("ADD", "HL", "HL");
		} else {
			emitCommand("LD", "DE", String.format("%d", faktor));
			emitCommand("CALL", "runtimeMult16bit");
		}
	}

	public void emitMultiPlyTopOfStackPush(int faktor) {
		if (faktor == 1) {
			return;
		}
		emitCommand("POP", "HL");
		if (faktor == 2) {
			emitCommand("ADD", "HL", "HL");
		} else if (faktor == 4) {
			emitCommand("ADD", "HL", "HL");
			emitCommand("ADD", "HL", "HL");
		} else if (faktor == 8) {
			emitCommand("ADD", "HL", "HL");
			emitCommand("ADD", "HL", "HL");
			emitCommand("ADD", "HL", "HL");
		} else {
			emitCommand("LD", "DE", String.format("%d", faktor));
			emitCommand("CALL", "runtimeMult16bit");
		}
		emitCommand("PUSH","HL");
	}
	public void emitPause() {
		emitCommand("POP", "HL");
		emitCommand("CALL", "runtimePause");

	}

	public void emitEqualFloat() {
		emitCommand("CALL", "runtimeEqualFloat");
		emitCommand("PUSH", "HL");

	}

	public void emitCheckBreak() {
		if (mSettingDebug)
			emitCommand("CALL", "runtimeCheckBreakDebug");
		else
			emitCommand("CALL", "runtimeCheckBreak");
	}

	public void emitStartInput() {
		if (mSettingsInline) {
			emitCommand("LD", "A", "$01");// Open channel 'K'.
			emitCommand("CALL", "$1601");
			emitCommand("CALL", "$0D6E");
			emitCommand("LD", "A", "1");
			emitCommand("LD", "($5C3A)", "A");
		} else {
			emitCommand("CALL","runtimeStartInput");
		}

	}

	public void emitSubstring() {
		emitCommand("POP", "HL");
		emitCommand("POP", "DE");
		emitCommand("POP", "BC");
		emitCommand("CALL", "runtimeSubstring");
		emitCommand("PUSH", "HL");
	}

	public void emitCharAt() {
		emitCommand("POP", "HL");
		emitCommand("POP", "BC");
		emitCommand("CALL", "runtimeCharAt");
		emitCommand("PUSH", "HL");
	}

	public Variable emitIntVar(String name) {
		Variable var = mMapVariables.get(name);
		if (var == null) {
			var = new Variable();
			var.name = name;
			var.typ = VARTYP.TYPE_INT;
			mMapVariables.put(name, var);
		}
		return var;
	}

	public Variable emitFloatVar(String name) {
		Variable var = mMapVariables.get(name);
		if (var == null) {
			var = new Variable();
			var.name = name;
			var.typ = VARTYP.TYPE_FLOAT;
			mMapVariables.put(name, var);
		}
		return var;

	}

	public Variable emitStringVar(String name) {
		Variable var = mMapVariables.get(name);
		if (var == null) {
			var = new Variable();
			var.name = name;
			var.typ = VARTYP.TYPE_STRING;
			mMapVariables.put(name, var);
		}
		return var;

	}

	public void emitClearTemp() {
		emitCommand("CALL", "ZXFreeTempCompact");
	}

	public void emitPushAddFloat() {
		if (mSettingsInline) {
			emitCommand("RST", "$28");
			emitCommand("DB", "$0f", null, "ADD");
			emitCommand("DB", "$38", null, "END CALC");
		} else {
			emitCommand("CALL","runtimePlusFloat");
		}
	}

	public void emitPushSubFloat() {
		if (mSettingsInline) {		
			emitCommand("RST", "$28");
			emitCommand("DB", "$03", null, "SUB");
			emitCommand("DB", "$38", null, "END CALC");
		} else
			emitCommand("CALL","runtimeMinusFloat");

	}

	public void emitPushPi() {
		emitCommand("CALL", "runtimePushPi");

	}

	public void emitStrInt() {
		emitCommand("POP","HL");
		emitCommand("CALL", "runtimeStrInt");
		emitCommand("PUSH","HL");

	}

	public void emitLineNr(int line) {
		emitCommand("LD", "HL", String.format("%d", line));
		emitCommand("LD", "(23621)", "HL");
	}

	public void emitStmtNr(int stmt) {
		
		emitCommand("LD", "A", String.format("%d", stmt));
		emitCommand("LD", "(23623)", "a");
	}

	public void emitStoreVariable(VARTYP targetType, String name, boolean block) {
		switch (targetType) {
		case VARTYP.TYPE_INT:
			emitStoreIntegerVar(name, block);
			break;
		case VARTYP.TYPE_FLOAT:
			emitStoreFloatVar(name, block);
			break;
		case VARTYP.TYPE_STRING:
			emitStoreStringVar(name, block, VARTYP.TYPE_STRING, 0);
			break;
		}
		// TODO Auto-generated method stub

	}

	public Variable emitVar(String name, VARTYP targetType) {
		if (name.endsWith("$")) {
			name = name.substring(0, name.length() - 1) + "_string";
			targetType = VARTYP.TYPE_STRING;
		}
		switch (targetType) {
		case VARTYP.TYPE_INT:
			return emitIntVar(name);
		case VARTYP.TYPE_FLOAT:
			return emitFloatVar(name);
		case VARTYP.TYPE_STRING:
			return emitStringVar(name);
		}
		return null;

	}

	public void emitUpperScreen(int channel) {
		emitCommand("LD", "A", String.format("%d",channel));
//		emitCommand("LD", "(ZX_TV_FLAG)", "A");
		emitCommand("CALL", "$1601",null,"Open Channel");


	}

	public void emitLowerScreen() {
		emitCommand("LD", "A", "1");
		emitCommand("LD", "(ZX_TV_FLAG)", "A");

	}

	public Variable createVar(String literal) {
		VARTYP typ = VARTYP.TYPE_INT;
		if (literal.endsWith("$")) {
			literal = literal.substring(0, literal.length() - 1) + "_string";
			typ = VARTYP.TYPE_STRING;
		}
		return emitVar(literal, typ);
	}

	public void emitEndInput() {
		emitCommand("CALL", "$0D6E", null, "Clear lower screen");

	}

	public void emitBeep() {
		emitCommand("CALL", "$03F8");
	}

	public void emitBorder() {
		emitCommand("POP","HL");
		emitCommand("LD", "A", "L");
		emitCommand("call", "$2297");
	}

	public void emitOut() {
		emitCommand("POP", "HL");
		emitCommand("POP", "BC");
		emitCommand("LD", "A", "L");
		emitCommand("OUT", "(C)", "A");
	}

	public void emitIn() {
		emitCommand("POP", "BC");
		emitCommand("IN", "A", "(C)");
		emitCommand("LD", "L", "A");
		emitCommand("LD", "H", "0");
		emitCommand("PUSH", "HL");

	}

	public void addVariable(String varname, Variable variable) {
		mMapVariables.put(varname, variable);

	}

	public void setCurDefFn(CDefFN deffn) {
		mCurDefFN = deffn;

	}

	public void emitPopHL() {
		emitCommand("POP", "HL");

	}

	public CDefFN getCurDefFN() {
		return mCurDefFN;
	}

	public void addDefFN(CDefFN deffn) {
		mMapDefFn.put(deffn.name, deffn);

	}

	public CDefFN getDefFn(String literal) {

		return mMapDefFn.get(literal);
	}

	public void emitCallFN(CDefFN fn) {
		emitCommand("CALL", String.format("ZX_FN_%s", fn.name));

	}

	public void emitJump(String string) {
		emitCommand("JP", string);
	}

	public void emitNot() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeNotHL");
		emitCommand("PUSH","HL");
		
	}

	public void emitNegInt() {
		emitCommand("POP","BC");
		emitCommand("LD","HL","0");
		emitCommand("SUB","HL","BC");
		emitCommand("PUSH","HL");
	}

	public void emitNegFloat() {
		emitCommand("CALL","runtimeNegFloat");
		
	}

	public void setComment(String str) {
		//mNextComment = str;
		emitComment(str);
		
	}

	public void emitSgnFloat() {
		emitCommand("rst", "$28");
		emitCommand("db","zxcalc_sgn");
		emitCommand("db","zxcalc_end_calc");
	}

	public void emitSgnInt() {
		emitCommand("POP","BC");
		emitCommand("CALL","runtimeSgnInt");
		emitCommand("PUSH","HL");
		
	}

	public void emitClearArray(String name, int size) {
		emitCommand("LD","HL","ZXBASIC_VAR_"+name);
		emitCommand("LD","BC",String.format("%d",size));
		emitCommand("CALL","runtimeClearArray");
	}

	public void emitClearStringArray(String name, int size) {
		emitCommand("LD","HL","ZXBASIC_VAR_"+name);
		emitCommand("LD","BC",String.format("%d",size));
		emitCommand("CALL","runtimeClearStringArray");
		
	}

	public void startTempCode() {
		mSaveCommands = mCommands;
		mLocalCommands = new ArrayList<Z80Command>();
		mCommands = mLocalCommands;
	}

	public void stopTempCode() {
		mCommands = mSaveCommands;
	}

	public void writeTempCode() {
		for (Z80Command cmd : mCommands)
			mSaveCommands.add(cmd);
	}

	public void emitGotoVar() {
		emitCommand("POP","DE");
		emitCommand("LD","HL","ZXLINES");
		emitCommand("CALL","runtimeFindLine");
		emitCommand("JP","(HL)");
	}

	public void emitRestoreVar() {
		emitCommand("POP","DE");
		emitCommand("LD","HL","ZXDATA");
		emitCommand("CALL","runtimeFindLine");
		emitCommand("EX","HL","DE");
		emitCommand("LD","(DATAPTR)","DE");
	}

	public void emitGosubVar() {
		emitCommand("POP","DE");
		emitCommand("LD","HL","ZXLINES");
		emitCommand("CALL","runtimeFindLine");
		emitCommand("CALL","runtimeVarCall");
	}

	public void emitPushVarAddress(Variable var) {
		emitCommand("LD","HL",String.format("ZXBASIC_VAR_%s",var.name));
		emitCommand("PUSH","HL");
		
	}

	public void emitAssignFixedStringWithRange() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeStoreFixedStringWithRangeFromBstr");
	}
	
	public void emitAssignFixedStringFixStringWithRange(int size) {
		
		emitCommand("POP","HL");
		emitCommand("LD","BC", String.format("%d", size));
		emitCommand("CALL","runtimeSetFixedStringFixedWithRange");
		
	}
	

	public void emitAssignFixedString(int stringSize) {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("LD","BC",String.format("%d", stringSize));
		emitCommand("CALL","runtimeStoreStringVarFix");
		
	}

	public void emitAssignFixedFixedString(int size1, int size2) {
		emitCommand("LD","BC",String.format("%d", size1));
		emitCommand("PUSH","BC");
		emitCommand("LD","BC",String.format("%d", size2));
		emitCommand("PUSH","BC");
		emitCommand("CALL","runtimeSetFixedString");
	}

	public void emitFixedStringSubString() {
		emitCommand("POP","BC");
		emitCommand("POP","DE");
		emitCommand("POP","HL");
		emitCommand("CALL","runtimePushFixedSubString");
		emitCommand("PUSH","HL");
		
	}

	public void emitPrintFixString(int size) {
		emitCommand("POP","HL");
		emitCommand("LD","BC",String.format("%d", size));
		emitCommand("CALL","runtimePrintFixString");
	}


	public void emitPlusVarFixString(int size) {
		emitCommand("POP","HL");
		emitCommand("LD","BC",String.format("%d", size));
		emitCommand("CALL","runtimeAddStringVarFix");
		emitCommand("PUSH","HL");
		
	}



	public void emitCreatesubstring() {
		emitCommand("POP","DE");
		emitCommand("POP","BC");
		emitCommand("CALL","runtimeSubstring");
		emitCommand("PUSH","HL");
	
	}

	public void emitDup() {
		emitCommand("POP","HL");
		emitCommand("PUSH","HL");
		emitCommand("PUSH","HL");
		
	}

	public void emitAttr() {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("CALL","runtimeAttr");
		emitCommand("PUSH","HL");
	}

	public void emitPoint() {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("CALL","runtimePoint");
		emitCommand("PUSH","HL");
	}

	public void emitScreen() {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("CALL","runtimeScreen");
		emitCommand("PUSH","HL");
	}

	public void emitDebug(int line, int stmt) {
		emitCommand("LD","HL",String.format("%d", line));
		emitCommand("LD","A",String.format("%d", stmt));
		emitCommand("CALL","runtimeDebug");
	}

	public void emitAndStringInt() {
		emitCommand("POP","DE");
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeVarStrAndInt");
		emitCommand("PUSH","HL");
	}

	public void emitAndStringFloat() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeVarStrAndFloat");
		emitCommand("PUSH","HL");
		
	}

	public void savePFlags() {
		emitCommand("LD","A","(ZX_P_FLAG)");
		emitCommand("PUSH","AF");
	}

	public void restorePFlags() {
		emitCommand("POP","AF");
		emitCommand("LD","(ZX_P_FLAG)","A");
	}

	public void emitJumpOnZero(String label) {
		emitCommand("POP","HL");
		emitCommand("PUSH","HL");
		emitCommand("LD","A","H");
		emitCommand("OR","L");
		emitCommand("JR","Z",label);
	}

	public void emitJumpOnNonZero(String label) {
		emitCommand("POP","HL");
		emitCommand("LD","A","H");
		emitCommand("OR","L");
		emitCommand("JR","NZ",label);
		emitCommand("PUSH","HL");
	}
	
	// -------- String-Vergleiche ---------
	
	
	// Vergleiche Var mit Fix

	public void emitBiggerVarFixString(int size) {
		emitCommand("POP","HL");
		emitCommand("POP","IX");
		emitCommand("LD","DE",String.format("%d", size));
		emitCommand("CALL","runtimeBiggerStringVarFix");
		emitCommand("PUSH","HL");
	}

	public void emitBiggerEqualVarFixString(int size) {
		emitCommand("POP","HL");
		emitCommand("POP","IX");
		emitCommand("LD","DE",String.format("%d", size));
		emitCommand("CALL","runtimeBiggerEqualStringVarFix");
		emitCommand("PUSH","HL");
	}


	public void emitSmallerVarFixString(int size) {
		emitCommand("POP","HL");
		emitCommand("POP","IX");
		emitCommand("LD","DE",String.format("%d", size));
		emitCommand("CALL","runtimeSmallerStringVarFix");
		emitCommand("PUSH","HL");
	}

	public void emitEqualVarFixString(int size) {
		emitCommand("POP","HL");
		emitCommand("POP","IX");
		emitCommand("LD","DE",String.format("%d", size));
		emitCommand("CALL","runtimeEqualStringVarFix");
		emitCommand("PUSH","HL");
	}

	public void emitUnEqualVarFixString(int size) {
		emitCommand("POP","DE");
		emitCommand("POP","HL");
		emitCommand("LD","BC",String.format("%d", size));
		emitCommand("CALL","runtimeUnequalStringVarFix");
		emitCommand("PUSH","HL");
	}
	
	public void emitSmallerEqualVarFixString(int size) {
		emitCommand("POP","HL");
		emitCommand("POP","IX");
		emitCommand("LD","DE",String.format("%d", size));
		emitCommand("CALL","runtimeSmallerEqualStringVarFix");
		emitCommand("PUSH","HL");
		
	}
	
	// Vergleiche Fix mit Var
	
	public void emitEqualFixVarString(int size) {
		emitCommand("POP","IX");
		emitCommand("POP","HL");
		emitCommand("LD","DE",String.format("%d", size));
		emitCommand("CALL","runtimeEqualStringFixVar");
		emitCommand("PUSH","HL");
		
	}



	public void emitUnEqualFixVarString(int size) {
		emitCommand("POP","IX");
		emitCommand("POP","HL");
		emitCommand("LD","DE",String.format("%d", size));
		emitCommand("CALL","runtimeUnequalStringFixVar");
		emitCommand("PUSH","HL");
		
	}	

	public void emitPlusFixVarString(int size) {
		emitCommand("POP","HL");
		emitCommand("LD","BC",String.format("%d", size));
		emitCommand("CALL","runtimeAddStringFixVar");
		emitCommand("PUSH","HL");
		
	}

	public void emitBiggerFixVarString(int size) {
		emitCommand("POP","IX");
		emitCommand("POP","HL");
		emitCommand("LD","DE",String.format("%d", size));
		emitCommand("CALL","runtimeBiggerStringFixVar");
		emitCommand("PUSH","HL");
		
	}
	
	public void emitBiggerEqualFixVarString(int size) {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("LD","BC",String.format("%d", size));
		emitCommand("CALL","runtimeBiggerEqualStringFixVar");
		emitCommand("PUSH","HL");
		
	}
	
	public void emitSmallerFixVarString(int size) {
		emitCommand("POP","IX");
		emitCommand("POP","HL");
		emitCommand("LD","DE",String.format("%d", size));
		emitCommand("CALL","runtimeSmallerStringFixVar");
		emitCommand("PUSH","HL");
		
	}

	public void emitSmallerEqualFixVarString(int size) {
		emitCommand("POP","IX");
		emitCommand("POP","HL");
		emitCommand("LD","DE",String.format("%d", size));
		emitCommand("CALL","runtimeSmallerEqualStringFixVar");
		emitCommand("PUSH","HL");
		
	}
	
	
	// Vergleiche Fix String mit Fix String
	

	public void emitEqualFixFixString(int size1, int size2) {
		emitCommand("POP","HL");
		emitCommand("POP","IX");
		emitCommand("LD","BC",String.format("%d", size1));
		emitCommand("LD","DE",String.format("%d", size2));
		emitCommand("CALL","runtimeEqualStringFixFix");
		emitCommand("PUSH","HL");
	}

	public void emitUnEqualFixFixString(int size1, int size2) {
		emitCommand("POP","HL");
		emitCommand("POP","IX");
		emitCommand("LD","BC",String.format("%d", size1));
		emitCommand("LD","DE",String.format("%d", size2));
		emitCommand("CALL","runtimeUnequalStringFixFix");
		emitCommand("PUSH","HL");
	}	

	public void emitBiggerFixFixString(int size1, int size2) {
		emitCommand("POP","IX");
		emitCommand("POP","HL");
		emitCommand("LD","BC",String.format("%d", size1));
		emitCommand("LD","DE",String.format("%d", size2));
		emitCommand("CALL","runtimeBiggerStringFixFix");
		emitCommand("PUSH","HL");
	}	

	
	public void emitPlusFixFixString(int size1, int size2) {
		emitCommand("LD","BC",String.format("%d", size1));
		emitCommand("PUSH","BC");
		emitCommand("LD","BC",String.format("%d", size2));
		emitCommand("PUSH","BC");
		emitCommand("CALL","runtimeAddStringFixFix");
		emitCommand("PUSH","HL");
	}



	public void emitBiggerEqualFixFixString(int size1, int size2) {
		emitCommand("POP","HL");
		emitCommand("POP","IX");
		emitCommand("LD","BC",String.format("%d", size1));
		emitCommand("LD","DE",String.format("%d", size2));
		emitCommand("CALL","runtimeBiggerEqualStringFixFix");
		emitCommand("PUSH","HL");
	}

	public void emitSmallerFixFixString(int size1, int size2) {
		emitCommand("POP","HL");
		emitCommand("POP","IX");
		emitCommand("LD","BC",String.format("%d", size1));
		emitCommand("LD","DE",String.format("%d", size2));
		emitCommand("CALL","runtimeSmallerStringFixFix");
		emitCommand("PUSH","HL");
	}

	public void emitSmallerEqualFixFixString(int size1, int size2) {
		emitCommand("POP","HL");
		emitCommand("POP","IX");		
		emitCommand("LD","BC",String.format("%d", size1));
		emitCommand("LD","DE",String.format("%d", size2));
		emitCommand("CALL","runtimeSmallerEqualStringFixFix");
		emitCommand("PUSH","HL");
	}

	public void emitAbsInt() {
		emitCommand("POP","HL");
		emitCommand("CALL","runtimeAbsInt");
		emitCommand("PUSH","HL");
	}

	public void emitAbsFloat() {
		emitCommand("RST","$28");
		emitCommand("db","zxcalc_abs");
		emitCommand("db","$38");
		
	}

	public void emitBasicLine(int line, int stmt, String text) {
		CBasicLine bline = new CBasicLine();
		bline.line = line;
		bline.stmt = stmt;
		bline.text = text;
		mBasicLines.add(bline);
		
	}





	
}
