package main.precompiler;

import java.io.IOException;
import java.lang.invoke.VarHandle;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;
import java.util.Set;
import java.util.Stack;
import java.util.TreeMap;
import java.util.TreeSet;

import org.eclipse.osgi.internal.util.Tokenizer;

import main.precompiler.CBASICTokenizer.BASICToken;
import main.precompiler.CBASICTokenizer.BASICTokenTyp;
import zxcompiler.ZXToken;
import zxcompiler.ZXTokenizer.ParserToken.ZXTokenTyp;

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
		boolean elseExist = false;
		public String variable;
		public int count;
		public TreeMap<String, Integer> params;
		public String name;
		public TreeSet<String> mVariables = new TreeSet<String>();
	}

	class CProcedure {
		String name;
		ArrayList<String> parameter = new ArrayList<String>();
		TreeSet<String> proceduresCalled = new TreeSet<String>();
	}

	Stack<CStackEntry> mStack = new Stack<CBASICPreparser.CStackEntry>();
	private boolean mError;
	private CStackEntry mCurrentProcedure = null; // filled if we are in a procedure
	private String mCurrentProcedureName = null;
	private TreeMap<String, CProcedure> mapProcedures = new TreeMap<String, CBASICPreparser.CProcedure>();
	private TreeSet<String> mSetUsedProcedures = new TreeSet<String>();
	private TreeMap<String, String> mMacros = new TreeMap<String, String>();
	private TreeSet<String> mSetUnusedProcedures;
	private StringBuilder mLog;

	/**
	 * @param plog
	 * @param code        The modern BASIC Source code
	 * @param userDefines Set of defines like BASIC, COMPILER, ZXSPECTRUM, ZX81
	 * @return the compatible BASIC source code with line numbers. Pure text without
	 *         tokens it may contain commands that are compatible only for the
	 *         compiler.
	 */
	public String preparse(String filename, StringBuilder plog, String code, TreeSet<String> userDefines) {

		sb = plog;
		System.out.println("PreparseSub");
		String code1 = processIncludeAndIf(filename, code, userDefines);
		code1 = removeUnsedProcdures(code1);
		code1 = preparseSub(code1);
		/*
		 * System.out.println("Preparse Unused Procedures"); if (mProcedures.size() !=
		 * 0) { System.out.println("PreparseSub 2"); code1 = preparseSub(code1); }
		 */

		code1 = replaceLines(code1);
		return code1;
	}

	/**
	 * @param code The modern BASIC code
	 * @return pre-parsed BASIC code, Procedures, While etc are replaced with GOTO
	 *         and GOSUB, without Line numbers but with labels
	 */
	String preparseSub(String code) {
		code = code.replaceAll("\r", "\n");
		String[] lines = code.split("\n");
		sb = new StringBuilder();
		mError = false;
		for (String line : lines) {
			System.out.println(line);
			if (mError)
				break;
			String tline = line.trim();
			int p = line.lastIndexOf("//");
			if (p != -1)
				line = line.substring(0, p).trim();
			if (tline.startsWith("#")) {
				sb.append(line + "\n");
				continue;
			}
			if (tline.startsWith(";"))
				continue;
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

	/**
	 * Processes a line. Each token will be appended to the output, the pre-parsed
	 * BASIC source
	 * 
	 * @param line
	 */
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
			try {
				CProcedure proc = mapProcedures.get(token.literal.toLowerCase());
				if (proc != null) {
					compileCall(token.literal);
				} else {
					sb.append("LET ");
					replaceMacros(token);
					append(token);
					tokenizeEndOfStmt();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
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

	private void replaceMacros(BASICToken token) {
		if (token.literal != null) {
			String r = mMacros.get(token.literal.toLowerCase());
			if (r != null)
				token.literal = r;
		}

	}

	private void tokenizeEndOfStmt() {
		while (tokenizer.nextToken(token)) {
			if (token.typ == CBASICTokenizer.BASICTokenTyp.isVariable)
				replaceMacros(token);
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
						token.literal = String.format("PROC%s%s", mCurrentProcedure.name, token.literal);
				} else
					token.literal = String.format("PROC%s%d", mCurrentProcedure.name, repInteger.intValue());
			}
		}
	}

	/**
	 * Append the token to the pre-parsed BASIC source. Do the name-mangeling for
	 * variables in procedures
	 * 
	 * @param token The token to be appended to the pre-parsed source code
	 */
	private void append(BASICToken token) {
		if (mCurrentProcedure != null) {
			if (token.typ == CBASICTokenizer.BASICTokenTyp.isVariable) {
				Integer repInteger = mCurrentProcedure.params.get(token.literal.toLowerCase());
				if (repInteger == null) {
					if (mCurrentProcedure.mVariables.contains(token.literal.toLowerCase()))
						token.literal = String.format("PROC%s%s", mCurrentProcedure.name, token.literal);
				} else
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

		switch (token.token) {
		case ZXToken.ZXB_WHILE:
			entry = new CStackEntry();
			entry.token = token.token;
			entry.label = newLabel("while");
			mStack.push(entry);
			append(String.format("#%s\n", entry.label));
			append("IF NOT(");
			tokenizer.skipSpace(token);
			while (tokenizer.nextToken(token)) {
				if (isEnd(token)) {

					break;
				}
				append(token);
			}
			append(String.format(") THEN GOTO #%s_exit\n", entry.label));
			break;
		case ZXToken.ZXB_REPEAT:
			entry = new CStackEntry();
			entry.token = token.token;
			entry.label = newLabel("repeat");
			mStack.push(entry);
			append(String.format("#%s\n", entry.label));
			break;
		case ZXToken.ZXB_UNTIL:
			if (mStack.isEmpty()) {
				error("exit without while or do");
				return;
			}
			entry = mStack.pop();

			append("IF ");
			tokenizer.skipSpace(token);
			while (tokenizer.nextToken(token)) {
				if (isEnd(token)) {

					break;
				}
				append(token);
			}
			append(String.format(" THEN GOTO #%s_exit\n", entry.label));
			append(String.format("GOTO #%s\n", entry.label));
			append(String.format("#%s_exit", entry.label));
			break;
		case ZXToken.ZXB_EXIT:
			if (mStack.isEmpty()) {
				error("exit without while or do");
				return;
			}
			append("GOTO #");
			append(mStack.peek().label + "_exit\n");
			break;
		case ZXToken.ZXB_WHEN:
			entry = new CStackEntry();
			entry.token = token.token;
			entry.label = newLabel("when");
			mStack.push(entry);

			append("IF NOT(");
			tokenizer.skipSpace(token);
			while (tokenizer.nextToken(token)) {
				if (isEnd(token)) {

					break;
				}
				append(token);
			}
			append(String.format(") THEN GOTO #%s_exit\n", entry.label));
			break;
		case ZXToken.ZXB_ELSE:
			if (mStack.isEmpty()) {
				error("exit without while or do");
				return;
			}
			entry = mStack.peek();
			entry.elseExist = true;
			append(String.format("GOTO #%s_else\n", entry.label));
			append(String.format("#%s_exit", entry.label));
			break;
		case ZXToken.ZXB_WEND:
			if (mStack.isEmpty()) {
				error("exit without while or do");
				return;
			}
			entry = mStack.pop();
			append("GOTO #");
			append(entry.label + "\n");
			append(String.format("#%s_exit\n", entry.label));
			break;
		case ZXToken.ZXB_DO:
			entry = new CStackEntry();
			entry.token = token.token;
			entry.label = newLabel("do");
			mStack.push(entry);
			append(String.format("#%s\n", entry.label));
			break;
		case ZXToken.ZXB_AGAIN:
			if (mStack.isEmpty()) {
				error("again without do, while or repeat");
				return;
			}
			entry = mStack.peek();
			append(String.format("GOTO #%s\n", entry.label));
			break;
		case ZXToken.ZXB_LOOP:
			if (mStack.isEmpty()) {
				error("loop without do");
				return;
			}
			entry = mStack.pop();
			if (entry.token != ZXToken.ZXB_DO) {
				error("loop without DO");
				return;
			}
			append(String.format("GOTO #%s\n", entry.label));
			append(String.format("#%s_exit\n", entry.label));
			break;

		case ZXToken.ZXB_IF:
			append(token);
			while (tokenizer.nextToken(token)) {
				append(token);
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == ZXToken.ZXB_THEN)
					break;
			}
			break;
		case ZXToken.ZXB_WITH:
			entry = new CStackEntry();
			entry.token = token.token;
			entry.variable = "";
			append("WITH ");
			mStack.push(entry);
			break;
			
		case ZXToken.ZXB_SELECT:
			entry = new CStackEntry();
			entry.token = token.token;
			entry.label = newLabel("select");
			entry.count = 0;
			entry.variable = "";
			mStack.push(entry);
			while (tokenizer.nextToken(token)) {
				if (isEnd(token))
					break;
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
				append(String.format("#%s_%d\n", entry.label, entry.count));
			append("IF");
			String cond = "";
			tokenizer.skipSpace(token);
			while (tokenizer.nextToken(token)) {
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == ':')
					break;
				cond += token.literal;
			}
			append(String.format("%s <> %s THEN GOTO #%s_%d\n", entry.variable, cond, entry.label, entry.count + 1));
			entry.count++;
			break;
		case ZXToken.ZXB_DEFAULT:
			if (mStack.isEmpty()) {
				error("case without select");
				return;
			}
			entry = mStack.peek();
			if (entry.count > 0)
				append(String.format("#%s_%d\n", entry.label, entry.count));
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
			if (entry.token == ZXToken.ZXB_WITH) {
				append("END\n");
			} else if (entry.token == ZXToken.ZXB_WHEN) {
				if (entry.elseExist == false) {
					append(String.format("#%s_exit\n", entry.label));
				} else {
					append(String.format("#%s_else\n", entry.label));
				}

			} else if (entry.token == ZXToken.ZXB_SELECT) {
				append(String.format("#%s_%d\n", entry.label, entry.count));
				append(String.format("#%s_exit\n", entry.label));
			}
			break;
		case ZXToken.ZXB_VAR:
			while (tokenizer.nextToken(token)) {
				if (token.isKeyword(':'))
					break;
				if (token.isKeyword(','))
					continue;
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isVariable) {
					if (mCurrentProcedure != null)
						mCurrentProcedure.mVariables.add(token.literal.toLowerCase());
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
			String rem = " REM SUB " + entry.name;
			mProcedures.add(entry.name);
			entry.count = 0;
			mCurrentProcedure = entry;
			tokenizer.skipSpace(token);
			boolean firstpar = true;
			if (tokenizer.peekToken(token)) {
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == '(') {
					rem += "(";
					tokenizer.nextToken(token); // (
					boolean bExit = false;
					while (tokenizer.nextToken(token)) {
						switch (token.typ) {
						case isVariable:
							entry.params.put(token.literal.toLowerCase(), Integer.valueOf(entry.count));
							if (!firstpar)
								rem += ", ";
							firstpar = false;
							rem += String.format("%d=%s", entry.count, token.literal);
							entry.count++;
							break;
						case isKeyword:
							// entry.params.put(token.literal.toLowerCase(),
							// Integer.valueOf(entry.count++));
							if (token.token == ')') {
								rem += ")";
								bExit = true;
							}
							break;
						}
						if (bExit)
							break;
					}
				}

			}
			append(rem + "\n");
			String rem2 = "REM ";

			while (rem2.length() < rem.length())
				rem2 += "-";
			append(rem2 + "\n");
			append(String.format("#%s\n", entry.label));
			break;
		case ZXToken.ZXB_CALL:
			tokenizer.nextNonSpaceToken(token);
			String name = token.literal.toLowerCase();
			mCalls.add(name);
			int count = 0;
			tokenizer.skipSpace(token);
			if (tokenizer.peekToken(token)) {
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == '(') {
					tokenizer.nextToken(token); // (
					boolean bExit = false;
					String exprname = "";
					while (tokenizer.nextToken(token)) {
						switch (token.typ) {
						case isKeyword:
							if (token.token == ',') {
								append(String.format("LET PROC%s%d=%s:", name, count++, exprname));
								exprname = "";
							} else if (token.token == ')') {
								append(String.format("LET PROC%s%d=%s:", name, count++, exprname));
								bExit = true;
							} else
								exprname += token.literal;
							break;
						default:
							if (token.typ == BASICTokenTyp.isVariable)
								replaceProcParam(token);
							exprname += token.literal;
						}
						if (bExit)
							break;
					}
				}
				append(String.format("GO SUB #proc_%s", name));
			} else {
				append(String.format("GO SUB #proc_%s", name));
			}
			break;

		default:
			append(token);
			if (token.token == ':')
				break;
			tokenizeEndOfStmt();
		}

	}

	private void compileCall(String literal) {
		tokenizer.nextNonSpaceToken(token);
		String name = token.literal.toLowerCase();
		mCalls.add(name);
		int count = 0;
		tokenizer.skipSpace(token);
		if (tokenizer.peekToken(token)) {
			if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == '(') {
				tokenizer.nextToken(token); // (
				boolean bExit = false;
				String exprname = "";
				while (tokenizer.nextToken(token)) {
					switch (token.typ) {
					case isKeyword:
						if (token.token == ',') {
							append(String.format("LET PROC%s%d=%s:", name, count++, exprname));
							exprname = "";
						} else if (token.token == ')') {
							append(String.format("LET PROC%s%d=%s:", name, count++, exprname));
							bExit = true;
						} else
							exprname += token.literal;
						break;
					default:
						if (token.typ == BASICTokenTyp.isVariable)
							replaceProcParam(token);
						exprname += token.literal;
					}
					if (bExit)
						break;
				}
			}
			append(String.format("GO SUB #proc_%s", name));
		} else {
			append(String.format("GO SUB #proc_%s", name));
		}
	}

	private void append(String format) {
		sb.append(format);

	}

	private void error(String string) {
		mError = true;
		sb.append(string + "\n");
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

		StringBuilder sb = new StringBuilder();
		String[] lines = text.split("\n");

		int idline = 0;
		while (idline < lines.length) {
			String line = lines[idline++];
			if (line.isEmpty() || line.startsWith(";") || line.startsWith("//")) {
				sb.append(line + "\n");
				continue;
			}
			tokenizer.init(line);
			if (tokenizer.nextNonSpaceToken(token)) {
				if (token.typ == BASICTokenTyp.isKeyword && token.token == ZXToken.ZXB_PROC) {
					tokenizer.nextNonSpaceToken(token);
					if (!mSetUsedProcedures.contains(token.literal.toLowerCase())) { // remove procedure
						error("Removing procedure " + token.literal);
						while (idline < lines.length) {
							line = lines[idline++];
							tokenizer.init(line);
							if (tokenizer.nextNonSpaceToken(token)) {
								if (token.typ == BASICTokenTyp.isKeyword && token.token == ZXToken.ZXB_END)
									break;
							}
						}
					} else
						sb.append(line + "\n");
				} else
					sb.append(line + "\n");
			} else
				sb.append(line + "\n");

		}
		return sb.toString();

	}

	/**
	 * Create line numbers and replace #label with the line number
	 * 
	 * @param text
	 * @return
	 */
	String replaceLines(String text) {
		String tline;
		TreeMap<String, Integer> mapLabels = new TreeMap<String, Integer>();
		ArrayList<CBASICLine> blines = new ArrayList<CBASICPreparser.CBASICLine>();
		sb = new StringBuilder();
		int iline = 1000;
		int istep = 10;
		sb = new StringBuilder();
		String[] lines = text.split("\n");
		for (String line : lines) {
			tline = line.trim();
			if (tline.length() == 0)
				continue;
			if (tline.startsWith(";") || tline.startsWith("//"))
				continue;
			sb.append(tline);
			if (!tline.endsWith(":"))
				sb.append("\n");
		}
		text = sb.toString();
		lines = text.split("\n");
		sb = new StringBuilder();

		for (String line : lines) {
			tline = line.trim();
			if (tline.length() == 0)
				continue;
			if (tline.startsWith(";") || tline.startsWith("//"))
				continue;
			if (tline.startsWith("#")) {
				int p = tline.indexOf(':');
				if (p != -1)
					tline = "#" + tline.substring(p + 1);
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
			sb.append(String.format("%d %s\n", iline, content));
			iline += istep;
		}
		text = sb.toString();
		lines = text.split("\n");
		sb = new StringBuilder();
		for (String line : lines) {
			tokenizer.init(line);
			while (tokenizer.nextToken(token)) {
				if (token.typ == CBASICTokenizer.BASICTokenTyp.isKeyword && token.token == '#') {
					tokenizer.nextNonSpaceToken(token);
					Integer intLineNr = mapLabels.get("#" + token.literal);
					if (intLineNr != null) {
						append(intLineNr.toString());
					} else {
						append(String.format("#%s", token.literal)); // Fehler
					}
				} else
					append(token);
			}
			sb.append("\n");
		}
		return sb.toString();

	}

	/**
	 * Reads the BASIC program and finds #define either #define FLAG or #define key
	 * value
	 * 
	 * @param lines
	 * @return
	 */
	public TreeSet<String> findDefines(List<String> lines) {
		TreeSet<String> defines = new TreeSet<String>();
		for (String line : lines) {
			String lline = line.trim().toLowerCase();
			if (lline.isEmpty())
				continue;
			if (!lline.toLowerCase().startsWith("#define"))
				continue;
			String value = line.substring(8).trim();
			int p = value.indexOf(' ');
			if (p != -1) {
				String name = value.substring(0, p).trim().toLowerCase();
				value = line.substring(p + 9).trim();
				mMacros.put(name, value);
			} else
				defines.add(value.toLowerCase());

		}
		return defines;
	}

	/**
	 * Reads the BASIC programm and finds all CALL procedure and PROC procedure.
	 * creates a set of used procedures by recursivly traveling all calls It creates
	 * a
	 * 
	 * @param output
	 */
	public void processProcedures(List<String> output) {
		mapProcedures = new TreeMap<String, CBASICPreparser.CProcedure>();
		mSetUsedProcedures = new TreeSet<String>();
		mCurrentProcedureName = null;
		CProcedure proc;
		BASICToken token = new BASICToken();
		int level = 0;
		for (String line : output) {
			line = line.trim();
			if (line.startsWith(";") || line.startsWith("//"))
				continue;
			tokenizer.init(line);
			while (tokenizer.nextToken(token)) {
				if (token.typ == BASICTokenTyp.isKeyword) {
					switch (token.token) {
					case ZXToken.ZXB_PROC:
						tokenizer.nextNonSpaceToken(token);

						mCurrentProcedureName = token.literal;
						proc = new CProcedure();
						proc.name = mCurrentProcedureName;
						mapProcedures.put(proc.name.toLowerCase(), proc);
						tokenizer.nextNonSpaceToken(token);
						if (token.typ == BASICTokenTyp.isKeyword) {
							if (token.token == '(') {
								while (tokenizer.nextNonSpaceToken(token)) {
									proc.parameter.add(token.literal);
									tokenizer.nextNonSpaceToken(token);
									if (token.token == ')')
										break;
								}
							}
						}
						break;
					case ZXToken.ZXB_WHILE:
					case ZXToken.ZXB_DO:
					case ZXToken.ZXB_CASE:
					case ZXToken.ZXB_REPEAT:
					case ZXToken.ZXB_WHEN:
						level++;
						break;
					case ZXToken.ZXB_END:
						if (level == 0) {
							mCurrentProcedureName = null;
						} else
							level--;
						break;
					case ZXToken.ZXB_CALL:
						tokenizer.nextNonSpaceToken(token);
						if (mCurrentProcedureName != null) {
							proc = mapProcedures.get(mCurrentProcedureName.toLowerCase());
							if (proc != null)
								proc.proceduresCalled.add(token.literal);
							else
								System.out.println(token.literal + " not found");
						} else {
							mSetUsedProcedures.add(token.literal.toLowerCase());
						}
					}
				}
			}
		}
		while (true) {
			TreeSet<String> newprocs = new TreeSet<String>();
			newprocs.addAll(mSetUsedProcedures);
			for (String s : mSetUsedProcedures) {
				proc = mapProcedures.get(s.toLowerCase());
				if (proc == null) {
					System.out.println("not found procedure " + s);
					continue;
				}
				for (String sub : proc.proceduresCalled)
					newprocs.add(sub.toLowerCase());
			}
			if (newprocs.size() == mSetUsedProcedures.size())
				break;
			mSetUsedProcedures = newprocs;
		}
		mSetUnusedProcedures = new TreeSet<String>();
		for (String s : mapProcedures.keySet())
			mSetUnusedProcedures.add(s);
		for (String s : mSetUsedProcedures)
			mSetUnusedProcedures.remove(s);
		for (String s : mSetUnusedProcedures) {
			System.out.println("PROC used: " + s);
		}
		for (String s : mSetUnusedProcedures) {
			System.out.println("PROC unused: " + s);
		}
	}

	public String processIncludeAndIf(String filename, String text, Set<String> userdefines) {
		List<String> lines = new ArrayList<String>();
		String[] temp = text.split("\n");
		for (String l : temp)
			lines.add(l);

		List<String> output = new ArrayList<>();
		Deque<Boolean> conditionStack = new ArrayDeque<>();
		conditionStack.push(true); // oberste Ebene ist immer aktiv

		while (true) {
			boolean bInclued = false;
			for (int i = 0; i < lines.size(); i++) {
				String line = lines.get(i).trim().toUpperCase();

				if (line.startsWith("#INCLUDE")) {
					bInclued = true;
					String[] parts = line.split("\\s+", 2);
					Path parent = Paths.get(filename).getParent();

					String fileName = parent + "\\" + parts[1].replace("\"", "").trim();
					try {
						List<String> includedLines = Files.readAllLines(Paths.get(fileName));
						includedLines = processIncludes(Paths.get(fileName), includedLines);
						for (String s : includedLines)
							output.add(s);

					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					continue;
				}
				output.add(lines.get(i)); // originale Zeile übernehmen

			}
			if (bInclued == false)
				break;
			lines = output;
			output = new ArrayList<String>();
		}
		TreeSet<String> defines = findDefines(lines);
		defines.addAll(userdefines);

		lines = output;
		output = new ArrayList<String>();
		for (int i = 0; i < lines.size(); i++) {
			String line = lines.get(i).trim().toUpperCase();
			if (line.startsWith("#IF")) {
				String[] parts = line.split("\\s+", 2);
				boolean active = defines.contains(parts[1]) && conditionStack.peek();
				conditionStack.push(active);
				continue;
			}

			if (line.startsWith("#ENDIF")) {
				conditionStack.pop();
				continue;
			}

			if (conditionStack.peek()) {
				output.add(lines.get(i)); // originale Zeile übernehmen
			}
		}

		if (conditionStack.size() != 1) {
			error("Unbalanced #IF/#END detected");
		}
		processProcedures(output);
		StringBuilder sb = new StringBuilder();
		for (String l : output) {
			sb.append(l + "\n");
		}

		return sb.toString();
	}

	private List<String> processIncludes(Path path, List<String> lines) {
		ArrayList<String> output = new ArrayList<String>();
		boolean bInclued = false;
		for (int i = 0; i < lines.size(); i++) {
			String line = lines.get(i).trim().toUpperCase();

			if (line.startsWith("#INCLUDE")) {
				bInclued = true;
				String[] parts = line.split("\\s+", 2);
				Path parent = path.getParent();

				String fileName = parent + "\\" + parts[1].replace("\"", "").trim();
				try {
					List<String> includedLines = Files.readAllLines(Paths.get(fileName));
					includedLines = processIncludes(Paths.get(fileName), includedLines);
					for (String s : includedLines)
						output.add(s);

				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				continue;
			}
			output.add(lines.get(i)); // originale Zeile übernehmen

		}

		return output;
	}

	public String createLabels(String source) {
		TreeSet<Integer> setLines = new TreeSet<Integer>();
		CBASICTokenizer tokenizer = new CBASICTokenizer();
		BASICToken token = new CBASICTokenizer.BASICToken();
		StringBuilder output = new StringBuilder();
		String[] lines = source.split("\n");
		for (String line : lines) {
			tokenizer.init(line);
			while (tokenizer.nextNonSpaceToken(token)) {
				if (token.typ == BASICTokenTyp.isKeyword) {
					if (token.token == ZXToken.ZXB_GOSUB || token.token == ZXToken.ZXB_GOTO
							|| token.token == ZXToken.ZXB_RESTORE) {
						tokenizer.nextNonSpaceToken(token);
						if (token.typ == BASICTokenTyp.isNumber)
							setLines.add(Integer.parseInt(token.literal));
					}
				}
			}
		}

		for (String line : lines) {
			tokenizer.init(line);
			if (tokenizer.nextNonSpaceToken(token)) {
				if (token.typ == BASICTokenTyp.isNumber) {
					int linenr = Integer.parseInt(token.literal);
					if (setLines.contains(linenr)) {
						output.append(String.format("#L%d\n", linenr));
					}
				}
			}
			tokenizer.mbSpaceToken = true;
			while (tokenizer.nextToken(token)) {
				if (token.typ == BASICTokenTyp.isKeyword) {
					if (token.literal.compareTo(":") == 0) {
						output.append(":\n");
					} else if (token.token == ZXToken.ZXB_GOSUB || token.token == ZXToken.ZXB_GOTO
							|| token.token == ZXToken.ZXB_RESTORE) {
						String cmd = token.literal;
						tokenizer.nextNonSpaceToken(token);
						int linenr = Integer.parseInt(token.literal);
						output.append(String.format("%s #L%d", cmd, linenr));
					} else
						output.append(token.literal);
				} else
					output.append(token.literal);
			}
			output.append("\n");
		}

		return output.toString();
	}

}
