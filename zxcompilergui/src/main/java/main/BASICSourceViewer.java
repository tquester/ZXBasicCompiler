package main;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

//import org.eclipse.jface.text.*;
//import org.eclipse.jface.text.contentassist.*;
//import org.eclipse.jface.text.presentation.IPresentationReconciler;
//import org.eclipse.jface.text.presentation.PresentationReconciler;
//import org.eclipse.jface.text.rules.DefaultDamagerRepairer;
//import org.eclipse.jface.text.source.ISourceViewer;
//import org.eclipse.jface.text.source.SourceViewer;
//import org.eclipse.jface.text.source.SourceViewerConfiguration;
import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.events.KeyAdapter;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.events.MouseAdapter;
import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Monitor;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Table;
import org.eclipse.swt.widgets.TableItem;
import org.eclipse.swt.widgets.Text;

import zxcompiler.ZXToken;

public class BASICSourceViewer {

	private ZXToken tokens = new ZXToken();
	private EditManager mEditManager;
	private StyledText editor;
	private Shell shell;
	private Composite parent;
	private Table completionTable;
	private TreeSet<String> allProposals;
	private Pattern wordPattern = Pattern.compile("\\b[a-zA-Z_][a-zA-Z0-9_]*\\b");
	private int lastSearchIndex;
	private String mSearchString;
	private boolean mMatchCase;

	public BASICSourceViewer(Shell shell, Composite parent, int style, ZXToken tokens) {
		this.tokens = tokens;
		this.shell = shell;
		this.parent = parent;
		tokens.addExtendTokens();
		setupEditor();
		// setupProposals();
	}

	private void setupEditor() {
		editor = new StyledText(parent, SWT.BORDER | SWT.V_SCROLL | SWT.H_SCROLL | SWT.MULTI);
		// editor.setLayoutData(new FillLayout());

		// Ctrl-Space Listener
		editor.addKeyListener(new KeyAdapter() {
			@Override
			public void keyPressed(KeyEvent e) {

				if ((e.stateMask & SWT.CTRL) != 0) {
					switch (e.keyCode) {
					case SWT.SPACE:
						showCompletion();
						e.doit = false;
						break;
					case 'a':
					case 'A':
						editor.selectAll();
						break;
					case 'F':
					case 'f':
						openSearchDialog();
						break;
					default:
						System.out.println("keyCode=" + e.keyCode);
						break;
					}
				} else {
					switch (e.keyCode) {
					case SWT.F3:
						findNext();
						break;
					}
					if (completionTable != null && !completionTable.isDisposed() && completionTable.isVisible()) {
						handleCompletionNavigation(e);
					}
				}
			}
		});

		// Click outside to close completion
		editor.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseDown(MouseEvent e) {
				hideCompletion();
			}
		});
	}

	private void updateProposalsFromText() {
		if (allProposals == null)
			allProposals = new TreeSet<String>();
		String text = editor.getText();
		if (text == null || text.isEmpty())
			return;

		allProposals.clear();
		Matcher matcher = wordPattern.matcher(text);
		while (matcher.find()) {
			String word = matcher.group();
			// Nur sinnvolle Wörter hinzufügen (mindestens 2 Zeichen)
			if (word.length() > 1 && Character.isJavaIdentifierStart(word.charAt(0))) {
				allProposals.add(word);
			}
		}
		allProposals.addAll(tokens.mMapRTokens.keySet());
	}

	private void showCompletion() {
		hideCompletion(); // Vorheriges Popup schließen

		updateProposalsFromText();

		int offset = editor.getCaretOffset();
		String text = editor.getText();
		String currentWord = getCurrentWord(text, offset);

		List<String> filteredProposals = filterProposals(currentWord);

		if (!filteredProposals.isEmpty()) {
			showCompletionPopup(filteredProposals, offset - currentWord.length(), currentWord);
		}
	}

	private void showCompletionPopup(List<String> proposals, int replacementOffset, String currentWord) {
		completionTable = new Table(editor, SWT.SINGLE | SWT.V_SCROLL | SWT.BORDER);
		completionTable.setHeaderVisible(false);

		for (String proposal : proposals) {
			TableItem item = new TableItem(completionTable, SWT.NONE);
			item.setText(proposal);
		}

		// Position berechnen
		Point caretPos = getCaretScreenPosition();
		completionTable.setLocation(caretPos.x, caretPos.y + editor.getLineHeight());

		// Größe anpassen
		completionTable.pack();
		Rectangle tableBounds = completionTable.getBounds();

		// Sicherstellen, dass das Popup innerhalb des Bildschirms bleibt
		Monitor monitor = shell.getMonitor();
		Rectangle monitorBounds = monitor.getBounds();

		if (tableBounds.x + tableBounds.width > monitorBounds.width) {
			tableBounds.x = monitorBounds.width - tableBounds.width;
		}
		if (tableBounds.y + tableBounds.height > monitorBounds.height) {
			tableBounds.y = caretPos.y - tableBounds.height;
		}

		completionTable.setBounds(tableBounds);
		completionTable.setVisible(true);

		// Event-Handler für Auswahl
		completionTable.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
				applySelectedProposal(replacementOffset, currentWord.length());
			}
		});

		// Tastaturnavigation im Popup
		completionTable.addKeyListener(new KeyAdapter() {
			@Override
			public void keyPressed(KeyEvent e) {
				switch (e.keyCode) {
				case SWT.ESC:
					hideCompletion();
					break;
				case SWT.CR:
				case SWT.KEYPAD_CR:
					applySelectedProposal(replacementOffset, currentWord.length());
					break;
				case SWT.ARROW_UP:
					if (completionTable.getSelectionIndex() == 0) {
						editor.setFocus();
					}
					break;
				}
			}
		});

		// Automatische Auswahl des ersten Elements
		if (completionTable.getItemCount() > 0) {
			completionTable.setSelection(0);
		}
	}

	private void handleCompletionNavigation(KeyEvent e) {
		switch (e.keyCode) {
		case SWT.ARROW_DOWN:
			completionTable.setFocus();
			if (completionTable.getSelectionIndex() == -1) {
				completionTable.setSelection(0);
			}
			e.doit = false;
			break;
		case SWT.ARROW_UP:
			if (completionTable.getSelectionIndex() == 0) {
				editor.setFocus();
			}
			e.doit = false;
			break;
		case SWT.ESC:
			hideCompletion();
			e.doit = false;
			break;
		}
	}

	private void applySelectedProposal(int offset, int length) {
		if (completionTable.getSelectionIndex() != -1) {
			int oldCaretOffset = editor.getCaretOffset();
			String selected = completionTable.getSelection()[0].getText();
			editor.replaceTextRange(offset, length, selected);
			// Cursor korrekt nach dem eingefügten Text positionieren
			int newCaretOffset = offset + selected.length();
			editor.setCaretOffset(newCaretOffset);

			// Sicherstellen, dass der Cursor sichtbar ist
			editor.showSelection();
		}
		hideCompletion();
	}

	private void hideCompletion() {
		if (completionTable != null && !completionTable.isDisposed()) {
			completionTable.dispose();
			completionTable = null;
		}
	}

	private Point getCaretScreenPosition() {
		try {
			int offset = editor.getCaretOffset();
			Point location = editor.getLocationAtOffset(offset);
			return location;
			// return editor.toDisplay(location);
		} catch (IllegalArgumentException e) {
			// Fallback: Position oben links im Editor
			return editor.toDisplay(0, 0);
		}
	}

	private String getCurrentWord(String text, int offset) {
		if (text.isEmpty() || offset == 0)
			return "";

		int start = offset;
		while (start > 0 && isWordChar(text.charAt(start - 1))) {
			start--;
		}

		int end = offset;
		while (end < text.length() && isWordChar(text.charAt(end))) {
			end++;
		}

		return text.substring(start, Math.min(end, text.length()));
	}

	private boolean isWordChar(char c) {
		return Character.isJavaIdentifierPart(c) || c == '.';
	}

	private List<String> filterProposals(String prefix) {
		List<String> result = new ArrayList<>();
		String lowerPrefix = prefix.toLowerCase();

		for (String proposal : allProposals) {
			if (proposal.toLowerCase().startsWith(lowerPrefix)) {
				result.add(proposal);
			}
		}

		// Sortieren für bessere UX
		result.sort(String::compareToIgnoreCase);
		return result;
	}

	public StyledText getEditor() {
		return editor;
	}
	/*
	 * // Beispiel für die Verwendung public static void main(String[] args) {
	 * Display display = new Display(); Shell shell = new Shell(display);
	 * shell.setLayout(new FillLayout()); shell.setSize(800, 600);
	 * 
	 * PureSWTCompletion completion = new PureSWTCompletion(shell);
	 * 
	 * shell.open(); while (!shell.isDisposed()) { if (!display.readAndDispatch()) {
	 * display.sleep(); } } display.dispose(); }
	 */

	public EditManager getEditManager() {
		return mEditManager;
	}

	public void setEditManager(EditManager man) {
		mEditManager = man;
	}

	public String getText() {
		return editor.getText();
	}

	public void setText(String text) {
		editor.setText(text);

	}

	public StyledText getTextWidget() {
		return editor;
	}

	public void openSearchDialog() {
		Shell dialog = new Shell(shell, SWT.RESIZE | SWT.DIALOG_TRIM | SWT.APPLICATION_MODAL);
		dialog.setText("Suchen");
		dialog.setLayout(new GridLayout(2, false));

		// Suchfeld
		Label label = new Label(dialog, SWT.NONE);
		label.setText("Suchbegriff:");
		Text searchText = new Text(dialog, SWT.BORDER);
		searchText.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true, false));

		Label replaceLabel = new Label(dialog, SWT.NONE);
		replaceLabel.setText("Ersetzen mit:");
		Text replaceText = new Text(dialog, SWT.BORDER);
		replaceText.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true, false));

		// Suchoptionen
		Button caseSensitive = new Button(dialog, SWT.CHECK);
		caseSensitive.setText("Groß-/Kleinschreibung beachten");
		caseSensitive.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, false, false, 2, 1));

		// Suchbuttons
		Button findButton = new Button(dialog, SWT.PUSH);
		findButton.setText("Suchen");
		findButton.setLayoutData(new GridData(SWT.LEFT, SWT.CENTER, false, false));

		Button replaceButton = new Button(dialog, SWT.PUSH);
		replaceButton.setText("Ersetzen");
		replaceButton.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, false, false));

		Button cancelButton = new Button(dialog, SWT.PUSH);
		cancelButton.setText("Abbrechen");
		cancelButton.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, false, false));

		// Event-Handler
		findButton.addListener(SWT.Selection, e -> {
			String searchString = searchText.getText();
			boolean matchCase = caseSensitive.getSelection();
			findText(editor, searchString, matchCase);
		});

		// Event-Handler für Ersetzen
		replaceButton.addListener(SWT.Selection, e -> {
			String searchStr = searchText.getText();
			String replaceStr = replaceText.getText();
			boolean matchCase = caseSensitive.getSelection();
			replaceText(editor, searchStr, replaceStr, matchCase);
		});

		cancelButton.addListener(SWT.Selection, e -> dialog.close());

		// Enter-Taste im Suchfeld
		searchText.addKeyListener(new KeyAdapter() {
			@Override
			public void keyPressed(KeyEvent e) {
				if (e.keyCode == SWT.CR || e.keyCode == SWT.KEYPAD_CR) {
					String searchString = searchText.getText();
					boolean matchCase = caseSensitive.getSelection();
					findText(editor, searchString, matchCase);
				}
			}
		});

		dialog.pack();
		dialog.open();
	}

	private void replaceText(StyledText styledText, String searchString, String replaceString, boolean matchCase) {
		if (styledText.getSelectionCount() > 0) {
			String selected = styledText.getSelectionText();
			boolean matches = matchCase ? selected.equals(searchString) : selected.equalsIgnoreCase(searchString);
			if (matches) {
				styledText.replaceTextRange(styledText.getSelectionRange().x, searchString.length(), replaceString);
			}
		}
		findText(styledText, searchString, matchCase);
	}

	private void findNext() {
		findText(editor, mSearchString, mMatchCase);
	}

	public void findText(StyledText styledText, String searchString, boolean matchCase) {
		mSearchString = searchString;
		mMatchCase = matchCase;
		if (searchString.isEmpty())
			return;

		String content = styledText.getText();
		if (!matchCase) {
			content = content.toLowerCase();
			searchString = searchString.toLowerCase();
		}

		// Suche ab aktueller Position fortsetzen
		int start = lastSearchIndex + 1;
		if (start >= content.length())
			start = 0;

		int foundIndex = content.indexOf(searchString, start);

		// Falls nicht gefunden, von vorne suchen
		if (foundIndex == -1 && start > 0) {
			foundIndex = content.indexOf(searchString, 0);
		}

		if (foundIndex != -1) {
			// Text markieren und anzeigen
			styledText.setSelection(foundIndex, foundIndex + searchString.length());
			styledText.showSelection();
			lastSearchIndex = foundIndex;
		} else {
			MessageBox mb = new MessageBox(styledText.getShell(), SWT.ICON_INFORMATION | SWT.OK);
			mb.setMessage("Text nicht gefunden: " + searchString);
			mb.open();
		}
	}

}
