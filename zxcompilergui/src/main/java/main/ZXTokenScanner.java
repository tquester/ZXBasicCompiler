package main;

import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.rules.IToken;
import org.eclipse.jface.text.rules.ITokenScanner;
import org.eclipse.jface.text.TextAttribute;
import org.eclipse.jface.text.rules.*;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Display;

import zxcompiler.ZXToken;

import java.util.ArrayList;
import java.util.List;
public class ZXTokenScanner extends RuleBasedScanner {

    public ZXTokenScanner(ZXToken tokens) {
        Display display = Display.getCurrent();

        // --- Farben / Styles ---
        TextAttribute keywordAttr   = new TextAttribute(display.getSystemColor(SWT.COLOR_BLUE), null, SWT.BOLD);
        TextAttribute stringAttr    = new TextAttribute(display.getSystemColor(SWT.COLOR_DARK_GREEN));
        TextAttribute commentAttr   = new TextAttribute(display.getSystemColor(SWT.COLOR_DARK_GRAY), null, SWT.ITALIC);
        TextAttribute numberAttr    = new TextAttribute(display.getSystemColor(SWT.COLOR_MAGENTA));
        TextAttribute variableAttr  = new TextAttribute(display.getSystemColor(SWT.COLOR_DARK_RED));
        TextAttribute preprocAttr   = new TextAttribute(display.getSystemColor(SWT.COLOR_DARK_BLUE), null, SWT.BOLD);
        TextAttribute remAttr       = new TextAttribute(display.getSystemColor(SWT.COLOR_BLUE), null, SWT.NORMAL);
        TextAttribute defaultAttr   = new TextAttribute(display.getSystemColor(SWT.COLOR_BLACK));

        IToken keywordToken   = new Token(keywordAttr);
        IToken stringToken    = new Token(stringAttr);
        IToken commentToken   = new Token(commentAttr);
        IToken numberToken    = new Token(numberAttr);
        IToken variableToken  = new Token(variableAttr);
        IToken preprocToken   = new Token(preprocAttr);
        IToken remToken       = new Token(remAttr);
        IToken defaultToken   = new Token(defaultAttr);

        List<IRule> rules = new ArrayList<>();

        // --- Strings ---
        rules.add(new SingleLineRule("\"", "\"", stringToken, '\\'));

        // --- Kommentare ---
        rules.add(new EndOfLineRule(";", commentToken));   // Assembler
        rules.add(new EndOfLineRule("//", commentToken));  // Java
        rules.add(new EndOfLineRule("'", commentToken));   // VB
        rules.add(new EndOfLineRule("REM", remToken));     // ZX BASIC
        rules.add(new MultiLineRule("/*", "*/", commentToken)); // C-Style

        // --- Preprocessor / Labels ---
        rules.add(new EndOfLineRule("#", preprocToken)); // ganze Zeile (z.B. #include)
        WordRule labelRule = new WordRule(new IWordDetector() {
            @Override
            public boolean isWordStart(char c) { return c == '#'; }
            @Override
            public boolean isWordPart(char c) { return Character.isLetterOrDigit(c) || c == '_' || c == '#'; }
        }, preprocToken);
        rules.add(labelRule);

        // --- Zahlen ---
        rules.add(new NumberRule(numberToken));

        // --- Keywords & Variablen ---
        WordRule wordRule = new WordRule(new IWordDetector() {
            @Override
            public boolean isWordStart(char c) { return Character.isLetter(c); }
            @Override
            public boolean isWordPart(char c) { return Character.isLetterOrDigit(c) || c == '$'; }
        }, variableToken); // Default: Variable

        for (String kw : tokens.mMapRTokens.keySet()) {
            wordRule.addWord(kw, keywordToken);
        }
        rules.add(wordRule);

        // --- Setze Regeln ---
        setDefaultReturnToken(defaultToken);
        setRules(rules.toArray(new IRule[0]));
    }
}