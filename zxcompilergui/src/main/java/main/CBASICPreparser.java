package main;

import java.lang.invoke.VarHandle;
import java.util.ArrayList;
import java.util.Stack;
import java.util.TreeMap;
import java.util.TreeSet;

import main.CBASICTokenizer.BASICToken;
import main.CBASICTokenizer.BASICTokenTyp;
import zxcompiler.ZXToken;

public class CBASICPreparser {

	CBASICTokenizer tokenizer = new CBASICTokenizer();
	StringBuilder sb = new StringBuilder();
	CBASICTokenizer.BASICToken token = new CBASICTokenizer.BASICToken();
	TreeSet<String> mProcedures = new TreeSet<String>();
	TreeSet<String> mCalls = new TreeSet<String>();

	int ilabel = 1;

	public CBASICPreparser() {
		tokenizer.addExtendedTokens();
		tokenizer.mbSpaceToken = true;
	}

	class CStackEntry {
		int token;
		String label;
		public String variable;
		public int count;
		public TreeMap<String, Integer> params;
		public String name;
		public TreeSet<String> mVariables = new TreeSet<String>();
	}

	Stack<CStackEntry> mStack = new Stack<CBASICPreparser.CStackEntry>();
	private boolean mError;
	private CStackEntry mCurrentProcedure = null; // filled if we are in a procedure
	
	String preparse(String code) {
		System.out.println("PreparseSub");
		String code1 = preparseSub(code);
		System.out.println("Preparse Unused Procedures");
		String code2 = removeUnsedProcdures(code);
		if (mProcedures.size() != 0)  {
			System.out.println("PreparseSub 2");
			code1 = preparseSub(code2);
		}
			
		code1 = replaceLines(code1);
		return code1;
	}

	String preparseSub(String code) {
		code = code.replaceAll("\r", "\n");
		String[] lines = code.split("\n");
		sb = new StringBuilder();
		mError = false;
		for (String line : lines) {
			//System.out.println(line);
			if (mError)
				break;
			String tline = line.trim();
			int p = line.lastIndexOf("//");
			if (p != -1) 
				line = line.substring(0,p).trim();
			if (tline.startsWith("#")) {
				sb.append(line+"\n");
				continue;
			}
			if (tline.startsWith(";")) continue;
			if (tline.length() == 0 || tline.startsWith(";")) {
				sb.append(line + "\n");
				continue;
			}

			tokenizeLine(line);
			sb.append("\n");
		}
		code = sb.toString();
		return code;
	}

	private void tokenizeLine(String line) {
		tokenizer.init(line);
		while (tokenizer.nextToken(token)) {
			tokenizeStmt(token);
		}

	}

	private void tokenizeStmt(BASICToken token) {
		switch (token.typ) {
		case isSpace:
			append(token);
			break;
		case isVariable:
			sb.append("LET ");
			append(token);
			tokenizeEndOfStmt();
			break;
		case isNumber: {
			append(token);
			tokenizer.nextToken(token);
			if (token.typ == CBASICTokenizer.BASICTokenTyp.isSpace) {
				append(token);
				tokenizer.nextToken(token);
			}
			if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword) {
				tokenizeKeyword(token);
			} else if (token.typ == CBASICTokenizer.BASICTokenTyp.isVariable) {
				sb.append("LET " + token.literal);
				tokenizeEndOfStmt();

			}
			break;
		}
		case isKeyword:
			tokenizeKeyword(token);
		}

	}

	private void tokenizeEndOfStmt() {
		while (tokenizer.nextToken(token)) {
			
			
			append(token);
			if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == ':')
				return;
			if (token.typ == CBASICTokenizer.BASICTokenTyp.isSpace
					&& (token.literal.contains("\n") || token.literal.contains("\r")))
				return;

		}

	}
	
	private void replaceProcParam(CBASICTokenizer.BASICToken token) {
		if (mCurrentProcedure != null) {
			if (token.typ == CBASICTokenizer.BASICTokenTyp.isVariable) {
				Integer repInteger = mCurrentProcedure.params.get(token.literal);
				if (repInteger == null) {
					if (mCurrentProcedure.mVariables.contains(token.literal.toLowerCase()))
						token.literal =String.format("PROC%s%s",mCurrentProcedure.name, token.literal); 
				}
				else 
					token.literal = String.format("PROC%s%d", mCurrentProcedure.name, repInteger.intValue()); 
			} 
		}
	}

	private void append(BASICToken token) {
		if (mCurrentProcedure != null) {
			if (token.typ == CBASICTokenizer.BASICTokenTyp.isVariable) {
				Integer repInteger = mCurrentProcedure.params.get(token.literal.toLowerCase());
				if (repInteger == null) {
					if (mCurrentProcedure.mVariables.contains(token.literal.toLowerCase()))
						token.literal =String.format("PROC%s%s",mCurrentProcedure.name, token.literal); 
				}
				else 
					token.literal = String.format("PROC%s%d", mCurrentProcedure.name, repInteger.intValue()); 
			} 
		}
		if (token.typ == CBASICTokenizer.BASICTokenTyp.isString)
			sb.append("\"" + token.literal + "\"");
		else
			sb.append(token.literal);

	}

	private void tokenizeKeyword(BASICToken token) {
		CStackEntry entry;
		switch(token.token) {
		case ZXToken.ZXB_WHILE:
			entry = new CStackEntry();
			entry.token = token.token;
			entry.label = newLabel("while");
			mStack.push(entry);
			append(String.format("#%s\n", entry.label));
			append("IF NOT(");
			tokenizer.skipSpace(token);
			while (tokenizer.nextToken(token))  {
				if (isEnd(token)) {
					
					break;
				}
				append(token);
			}
			append(String.format(") THEN GOTO #%s_exit\n",entry.label));
			break;
		case ZXToken.ZXB_EXIT:
			if (mStack.isEmpty()) {
				error("exit without while or do");
				return;
			}
			append("GOTO #");
			append(mStack.peek().label+"_exit\n");
			break;
		case ZXToken.ZXB_WEND:
			if (mStack.isEmpty()) {
				error("exit without while or do");
				return;
			}
			entry = mStack.pop();
			append("GOTO #");
			append(entry.label+"\n");
			append(String.format("#%s_exit\n",entry.label));
			break;
		case ZXToken.ZXB_DO:
			entry = new CStackEntry();
			entry.token = token.token;
			entry.label = newLabel("do");
			mStack.push(entry);
			append(String.format("#%s\n", entry.label));
			break;
		case ZXToken.ZXB_LOOP:
			if (mStack.isEmpty()) {
				error("loop without do");
				return;
			}
			entry = mStack.pop();
			if (entry.token != ZXToken.ZXB_LOOP) {
				error("loop without DO");
				return;
			}
			entry = mStack.pop();
			append(String.format("GOTO #%s\n",entry.label));
			break;
			
		case ZXToken.ZXB_IF:
			append(token);
			while (tokenizer.nextToken(token)) {
				append(token);
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == ZXToken.ZXB_THEN)
					break;
			}
			break;
		case ZXToken.ZXB_SELECT:
			entry = new CStackEntry();
			entry.token = token.token;
			entry.label = newLabel("select");
			entry.count=0;
			entry.variable = "";
			mStack.push(entry);
			while (tokenizer.nextToken(token)) {
				if (isEnd(token)) break;
				entry.variable += token.literal;
			}
			break;
		case ZXToken.ZXB_CASE:
			if (mStack.isEmpty()) {
				error("case without select");
				return;
			}
			entry = mStack.peek();
			if (entry.count > 0) 
				append(String.format("#%s_%d\n",entry.label,entry.count));
			append("IF");
			String cond = "";
			tokenizer.skipSpace(token);
			while (tokenizer.nextToken(token)) {
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == ':') break;
				cond += token.literal;
			}
			append(String.format("%s <> %s THEN GOTO #%s_%d\n",entry.variable, cond, entry.label, entry.count+1));
			entry.count++;
			break;
		case ZXToken.ZXB_DEFAULT:
			if (mStack.isEmpty()) {
				error("case without select");
				return;
			}
			entry = mStack.peek();
			if (entry.count > 0) 
				append(String.format("#%s_%d\n",entry.label,entry.count));
			entry.count++;
			tokenizer.peekToken(token);
			if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == ':')
				tokenizer.nextToken(token);
			
			break;
		case ZXToken.ZXB_BREAK:
			if (mStack.isEmpty()) {
				error("end without select");
				return;
			}
			entry = mStack.peek();
			append(String.format("GOTO #%s_exit", entry.label));
			break;
			
		case ZXToken.ZXB_END:
			if (mStack.isEmpty()) {
				if (mCurrentProcedure != null) { 
					append("return\n");
					mCurrentProcedure = null;
				} else {
					error("end without select");
				}
				return;
			}
			entry = mStack.pop();
			if (entry.token == ZXToken.ZXB_SELECT) {
				append(String.format("#%s_%d\n", entry.label, entry.count));
				append(String.format("#%s_exit\n", entry.label));
			}
			break;
		case ZXToken.ZXB_VAR:
			while (tokenizer.nextToken(token)) {
				if (token.isKeyword(':')) break;
				if (token.isKeyword(',')) continue;
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isVariable) {
					if (mCurrentProcedure != null)
						mCurrentProcedure.mVariables .add(token.literal.toLowerCase());
				}
			}
			break;
			
		case ZXToken.ZXB_PROC:
			entry = new CStackEntry();
			entry.token = token.token;
			entry.params = new TreeMap<String, Integer>();
			tokenizer.nextNonSpaceToken(token);
			entry.label = String.format("proc_%s", token.literal.toLowerCase());
			entry.name = token.literal.toLowerCase();
			String rem = "REM PROCEDURE "+entry.name; 
			mProcedures.add(entry.name);
			entry.count=0;
			append(String.format("#%s\n", entry.label));
			mCurrentProcedure = entry;
			tokenizer.skipSpace(token);
			boolean firstpar=true;
			if (tokenizer.peekToken(token)) {
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == '(') {
					rem += "(";
					tokenizer.nextToken(token);					// (
					boolean bExit=false;
					while (tokenizer.nextToken(token)) {
						switch(token.typ) {
							case isVariable:
								entry.params.put(token.literal.toLowerCase(), Integer.valueOf(entry.count));
								if (!firstpar) rem += ", ";
								firstpar = false;
								rem+=String.format("%d=%s",entry.count, token.literal);
								entry.count++;
								break;
							case isKeyword:
								//entry.params.put(token.literal.toLowerCase(), Integer.valueOf(entry.count++));
								if (token.token == ')') {
									rem += ")";
									append(rem+"\n");
									bExit=true;
								}
								break;
						}
						if (bExit) break;
					}
				}
			}
			break;
		case ZXToken.ZXB_CALL:
			tokenizer.nextNonSpaceToken(token);
			String name = token.literal.toLowerCase();
			mCalls.add(name);
			int count=0;
			tokenizer.skipSpace(token);
			if (tokenizer.peekToken(token)) {
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == '(') {
					tokenizer.nextToken(token);					// (
					boolean bExit=false;
					String exprname="";
					while (tokenizer.nextToken(token)) {
						switch(token.typ) {
							case isKeyword:
								if (token.token == ',') {
									append(String.format("LET PROC%s%d=%s:", name,count++,exprname));
									exprname="";
								} else 
								if (token.token == ')') {
									append(String.format("LET PROC%s%d=%s:", name,count++,exprname));
									bExit=true;
								} else
									exprname+=token.literal;
								break;
							default:
								if (token.typ == BASICTokenTyp.isVariable) replaceProcParam(token); 
								exprname += token.literal;
						}
						if (bExit) break;
					}
				}
				append(String.format("GO SUB #proc_%s\n", name));
			} else {
				append(String.format("GO SUB #proc_%s\n", name));
			}
			break;
			
			
		default:
			append(token);
			tokenizeEndOfStmt();
		}
		
	}

	private void append(String format) {
		sb.append(format);

	}

	private void error(String string) {
		mError = true;
		sb.append(string);
	}

	private String newLabel(String keyword) {
		return String.format("%s_%d", keyword, ilabel++);
	}

	private boolean isEnd(BASICToken token2) {
		if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == ':')
			return true;
		return token.typ == CBASICTokenizer.BASICTokenTyp.isSpace
				&& (token.literal.contains("\n") || token.literal.contains("\r"));
	}
	
	class CBASICLine {
		int number;
		String line;
	}
	
	String removeUnsedProcdures(String text) {
		
		for (String call: mCalls) {
			mProcedures.remove(call);
		}
		if (mProcedures.size() == 0) 
			return text;
		
		StringBuilder sb = new StringBuilder();
		String[] lines = text.split("\n");
		
		int idline=0;
		while (idline < lines.length) {
			String line = lines[idline++];
			if (line.isEmpty() || line.startsWith(";") || line.startsWith("//")) {
				sb.append(line+"\n");
				continue;
			}
			tokenizer.init(line);
			if (tokenizer.nextNonSpaceToken(token)) {
				if (token.typ == BASICTokenTyp.isKeyword && token.token == ZXToken.ZXB_PROC) {
					tokenizer.nextNonSpaceToken(token);
					if (mProcedures.contains(token.literal.toLowerCase())) { // remove procedure
						System.out.println("Removing procedure "+token.literal);
						while (idline < lines.length) {
							line = lines[idline++];
							tokenizer.init(line);
							if (tokenizer.nextNonSpaceToken(token)) {
								if (token.typ == BASICTokenTyp.isKeyword && token.token == ZXToken.ZXB_END) 
									break;
							}
						}
					}
					else
						sb.append(line+"\n");
				}
				else
					sb.append(line+"\n");
			} else
				sb.append(line+"\n");
			
		
		}
		return sb.toString();
		
	}
	
	String replaceLines(String text) {
		TreeMap<String, Integer> mapLabels = new TreeMap<String, Integer>();
		ArrayList<CBASICLine> blines = new ArrayList<CBASICPreparser.CBASICLine>();
		sb = new StringBuilder();
		int iline=1000;
		int istep=10;
		sb = new StringBuilder();
		String[] lines = text.split("\n");
		for (String line:lines) {
			String tline = line.trim();
			if (tline.length() == 0) continue;
			if (tline.startsWith(";") || tline.startsWith("//")) continue;
			if (tline.startsWith("#")) {
				int p = tline.indexOf(':');
				if (p != -1) 
					tline = "#"+tline.substring(p+1);
				mapLabels.put(tline, iline);
				continue;
			}
            // Prüfen auf Zeilennummer
            String[] parts = tline.split("\\s+", 2);
            String content = tline;
            if (parts[0].matches("\\d+")) {
            	iline = Integer.parseInt(parts[0]);
                content = parts.length > 1 ? parts[1] : "";
            }
            sb.append(String.format("%d %s\n",iline,content));
            iline += istep;
		}
		text = sb.toString();
		lines = text.split("\n");
		sb = new StringBuilder();
		for (String line:lines) {
			tokenizer.init(line);
			while (tokenizer.nextToken(token)) {
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == '#') {
					tokenizer.nextNonSpaceToken(token);
					Integer intLineNr = mapLabels.get("#"+token.literal);
					if (intLineNr != null) {
						append(intLineNr.toString());
					} else {
						append(String.format("#%s", token.literal));		// Fehler
					}
				} else
					append(token);
			}
			sb.append("\n");
		}
		return sb.toString();
		
	}

}
