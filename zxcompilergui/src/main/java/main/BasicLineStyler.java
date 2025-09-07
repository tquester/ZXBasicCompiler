package main;

// see http://www.java2s.com/Code/Java/SWT-JFace-Eclipse/JavaSourcecodeViewer.htm
import java.io.IOException;
import java.io.StringReader;
import java.util.Hashtable;
import java.util.Vector;

import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.LineStyleEvent;
import org.eclipse.swt.custom.LineStyleListener;
import org.eclipse.swt.custom.StyleRange;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.RGB;
import org.eclipse.swt.widgets.Display;
import main.precompiler.BasicToken;
import main.precompiler.BasicToken.TokenType;
import main.precompiler.BasicTokenizer;
import main.precompiler.Z80Tokens;
import zxcompiler.ZXToken;
import zxcompiler.ZXTokenizer;

import org.eclipse.swt.widgets.Control;

public class BasicLineStyler implements LineStyleListener {

	ZXToken zxTokens = new ZXToken();
	BasicTokenizer tokenizer = new BasicTokenizer(zxTokens.mMapRTokens);
	Vector blockComments = new Vector();

	private Color mColorWord;

	private Color mColorString;

	private Color mColorKeyword;

	private Color mColorNumber;

	private Color mColorComment;
	private Color mColorLabel;

	public BasicLineStyler() {
		initializeColors();
		
	}
  
	Color getColor(BasicToken token) {
		if (token == null)
			return mColorWord;
		switch (token.type) {
		case COMMENT:
			return mColorComment;
		case STRING:
			return mColorString;
		case NUMBER:
			return mColorNumber;
		case LABEL:
			return mColorLabel;
		case IDENTIFIER:
			return mColorWord;

		default:
			return mColorKeyword;
		}

	}


	void initializeColors() {
		Display display = Display.getDefault();
		mColorWord = display.getSystemColor(SWT.COLOR_BLACK);
		mColorString = display.getSystemColor(SWT.COLOR_BLUE);
		mColorKeyword = display.getSystemColor(SWT.COLOR_DARK_RED);
		mColorNumber = display.getSystemColor(SWT.COLOR_DARK_BLUE);
		mColorComment = display.getSystemColor(SWT.COLOR_DARK_GREEN);
		mColorLabel = display.getSystemColor(SWT.COLOR_DARK_GRAY);
		zxTokens.addExtendTokens();
		zxTokens.addToken(0,"GO");
		zxTokens.addToken(0,"SUB");
	}
	
	void initializeZ80() {
		Z80Tokens z80t = new Z80Tokens();
		for (String t: z80t.mTokens)
			zxTokens.mMapRTokens.put(t, 0);
	}

	void disposeColors() {
	}

	/**
	 * Event.detail line start offset (input) Event.text line text (input)
	 * LineStyleEvent.styles Enumeration of StyleRanges, need to be in order.
	 * (output) LineStyleEvent.background line background color (output)
	 */
	public void lineGetStyle(LineStyleEvent event) {
		try {
		Vector styles = new Vector();
		//CToken token = new CToken();
		StyleRange lastStyle;

		Color defaultFgColor = ((Control) event.widget).getForeground();
		tokenizer.start(event.lineText);

		while (tokenizer.hasData()) {
			BasicToken token = tokenizer.nextToken();
			if (token.type == TokenType.IDENTIFIER)
				continue;
			
				Color color = getColor(token);
				// Only create a style if the token color is different than the
				// widget's default foreground color and the token's style is
				// not
				// bold. Keywords are bolded.
				if ((!color.equals(defaultFgColor))) {
					
					StyleRange style = new StyleRange(token.pos - 1 + event.lineOffset, token.text.length()+1, color, null);
					if (token.type == TokenType.KEYWORD) {
						style.fontStyle = SWT.BOLD;
					}
					if (styles.isEmpty()) {
						styles.addElement(style);
					} else {
						// Merge similar styles. Doing so will improve
						// performance.
						lastStyle = (StyleRange) styles.lastElement();
						if (lastStyle.similarTo(style) && (lastStyle.start + lastStyle.length == style.start)) {
							lastStyle.length += style.length;
						} else {
							styles.addElement(style);
						}
					}
				}
			
		}
		event.styles = new StyleRange[styles.size()];
		styles.copyInto(event.styles);
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}




}
