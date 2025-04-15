package zxcompiler;

import java.util.TreeMap;
import java.util.TreeSet;

// writes Z80 code
public class Z80Emitter {
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
	
	void emitString(String str) {
		sbCode.append(str+"\n");
		System.out.println(str);
	}
	
	void emitCommand(String command) {
		if (lastCommand.compareTo("PUSH HL") == 0) {
			if (command.compareTo("POP HL")==0) { 
					lastCommand = command;
					return;
			} else
				emitString("\t"+lastCommand);
			
		}
		lastCommand = command;
		if (command.compareTo("PUSH HL") != 0)			
			emitString("\t"+command);
		
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
				emitString(String.format("ZXBASIC_VAR_%s:", v.name));
			}
		}
	}
	
	public void emitPushInteger(String number) {
		emitCommand(String.format("LD HL, %s", number));
		emitCommand("PUSH HL");
	}
	
	public void emitPushIntegerVariable(String varname) {
		emitCommand(String.format("LD HL, (ZXBASIC_VAR_%s)", varname));
		emitCommand("PUSH HL");
	}
	
	public void emitStoreIntegerVar(String varname) {
		emitCommand("POP HL");
		emitCommand(String.format("LD (BASIC_VAR_%s),HL", varname));
	}
	
	public void emitPlus() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("ADD HL, DE");
		emitCommand("PUSH HL");
	}

	public void emitMinus() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("SUB HL, DE");
		emitCommand("PUSH HL");
	}
	
	public void emitMult() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("call Mult16bit");
		emitCommand("PUSH HL");
	}

	public void emitDiv() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("call Div16bit");
		emitCommand("PUSH HL");
	}
	
	public void emitSmaller() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("SUB HL, DE");
		emitCommand("LD  HL,0");
		emitCommand("call c, HL1");
		emitCommand("PUSH HL");
	}
	
	public void emitBigger() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("SUB HL, DE");
		emitCommand("LD  HL,0");
		emitCommand("call nc, HL1");
		emitCommand("PUSH HL");
	}

	public void emitSmallerEqual() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("SUB HL, DE");
		emitCommand("LD  HL,0");
		emitCommand("call c, HL1");
		emitCommand("call z, HL1");
		emitCommand("PUSH HL");
	}
	
	public void emitBiggerEqual() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("SUB HL, DE");
		emitCommand("LD  HL,0");
		emitCommand("call nc, HL1");
		emitCommand("call z, HL1");
		emitCommand("PUSH HL");
	}

	public void emitUnequal() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("SUB HL, DE");
		emitCommand("LD  HL,0");
		emitCommand("call nz, HL1");
		emitCommand("PUSH HL");
	}

	public void emitEqual() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("SUB HL, DE");
		emitCommand("LD  HL,0");
		emitCommand("call z, HL1");
		emitCommand("PUSH HL");
	}

	public void emitLine(int line) {
		emitString(String.format("ZX_LINE_%d:", line));
	}

	public void emitOr() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("LD  A,L");
		emitCommand("OR  E");
		emitCommand("LD  L,A");
		emitCommand("LD  H,0");
	}

	public void emitAnd() {
		emitCommand("POP HL");
		emitCommand("POP DE");
		emitCommand("LD  A,L");
		emitCommand("AND  E");
		emitCommand("LD  L,A");
		emitCommand("LD  H,0");
	}

	public void emitComment(String string) {
		emitString(";"+string);
	}

	public String emitCheckFor0() {
		String label = newLabel();
		emitCommand("POP HL");
		emitCommand("LD  A,L");
		emitCommand("OR  A");
		emitCommand("JR  Z,"+label);
		
		// TODO Auto-generated method stub
		return label;
	}

	private String newLabel() {
		lastLabel++;
		return String.format("ZXB_LABEL_%d", lastLabel);
	}

	public void emitLabel(String label) {
		emitString(String.format("%s:",label));
		
	}

	public void emitJumpToLine(String line) {
		emitCommand(String.format("JP ZX_LINE_%s", line));
	}

	public void emitCallToLine(String line) {
		emitCommand(String.format("CALL ZX_LINE_%:", line));
		
	}

	public void emitReturn() {
		emitCommand("RET");
		
	}
}
