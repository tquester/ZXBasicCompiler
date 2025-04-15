package zxcompiler;

import java.util.ArrayList;
import java.util.TreeMap;
import java.util.TreeSet;

// writes Z80 code
public class Z80Emitter {
	static final boolean BlockComments=true;
	// in order to optimize the code, it is stored in machine readable format
	
	class Z80Command {
		public Z80Command(String command2, String param1, String param2) {
			this.command = command2;
			this.par1 = param1;
			this.par2 = param2;
		}
		public String command;
		public String par1=null;
		public String par2=null;
	}
	class Variable {
		public static int TYP_INT;
		public static int TYP_STRING;
		public static int TYP_FLOAT;
		public String name;
		public int    typ;
	}

	public StringBuffer sbCode = new StringBuffer();	
	String lastCommand="";
	int    lastLabel=0;
	TreeMap<String, Variable> mMapVariables = new TreeMap<String, Z80Emitter.Variable>();
	ArrayList<Z80Command> mCommands = new ArrayList<Z80Emitter.Z80Command>();
	
	void emitString(String str) {
		sbCode.append(str+"\n");
		System.out.println(str);
	}
	
	void emitCommand(String command, String param1) {
		emitCommand(command,param1,null);
	}
	void emitCommand(String command, String param1, String param2) {
		mCommands.add(new Z80Command(command, param1, param2));
		String str = command;
		if (param1 != null) str += " "+param1;
		if (param2 != null) str += ","+param2;
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
	
	public void emitIntVar(String name) {
		Variable var = mMapVariables.get(name);
		if (var == null) {
			var = new Variable();
			var.name = name;
			var.typ = Variable.TYP_INT;
			mMapVariables.put(name, var);
		}
	}
	
	public void writeVariables() {
		for (Variable v: mMapVariables.values()) {
			if (v.typ == Variable.TYP_INT) {
				emitString(String.format("ZXBASIC_VAR_%s:\tdw 0", v.name));
			}
		}
	}
	
	public void emitPushInteger(String number) {
		emitCommand("LD", String.format("HL, %s", number));
		emitCommand("PUSH","HL");
	}
	
	public void emitPushIntegerVariable(String varname) {
		emitCommand("LD",String.format("HL, (ZXBASIC_VAR_%s)", varname));
		emitCommand("PUSH","HL");
	}
	
	public void emitStoreIntegerVar(String varname) {
		emitBlockComment("Store "+varname);
		emitCommand("POP","HL");
		emitCommand("LD",String.format("(ZXBASIC_VAR_%s),HL", varname));
		emitBlockCommentEnd();
	}
	
	public void emitPlus() {
		emitBlockComment("+");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("ADD","HL, DE");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}

	public void emitMinus() {
		emitBlockComment("-");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("EX","HL,DE");
		emitCommand("SUB","HL, DE");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}
	
	public void emitMult() {
		emitBlockComment("*");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("call","Mult16bit");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}

	public void emitDiv() {
		emitBlockComment("/");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("call","Div16bit");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}
	
	public void emitSmaller() {
		emitBlockComment("<");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("SUB","HL, DE");
		emitCommand("LD","HL,0");
		emitCommand("call","c, HL1");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}
	
	public void emitBigger() {
		emitBlockComment("OR");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("SUB","HL","DE");
		emitCommand("LD","HL","0");
		emitCommand("call", "nc", "HL1");
		emitCommand("PUSH","HL");
		emitBlockCommentEnd();
	}

	public void emitSmallerEqual() {
		emitBlockComment("<=");
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("SUB", "HL", "DE");
		emitCommand("LD", "HL","0");
		emitCommand("call", "c", "HL1");
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
		emitCommand("call","nc", "HL1");
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
		emitString(String.format("ZX_LINE_%d:", line));
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
		emitString(String.format("%s:",label));
		
	}

	public void emitJumpToLine(String line) {
		emitCommand("JP",String.format("ZX_LINE_%s", line));
	}

	public void emitCallToLine(String line) {
		emitCommand("CALL",String.format("ZX_LINE_%:", line));
		
	}

	public void emitReturn() {
		emitCommand("RET",null);
		
	}
	
	public void emitPlot() {
		emitCommand("POP","HL");
		emitCommand("POP","DE");
		emitCommand("LD","B","L");
		emitCommand("LD","C","E");
		emitCommand("CALL","RuntimePlot");
	}
}
