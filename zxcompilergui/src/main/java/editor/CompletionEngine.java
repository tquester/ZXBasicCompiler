package editor;

import java.util.Set;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.events.KeyAdapter;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Table;

public class CompletionEngine {
    private StyledText editor;
    private Composite parent;
    private Set<String> keywords;
    private Table completionTable;
    private TreeSet<String> allProposals;
    
    public CompletionEngine(StyledText editor, Composite parent, Set<String> keywords) {
        this.editor = editor;
        this.parent = parent;
        this.keywords = keywords;
        setupCompletion();
    }
    
    private void setupCompletion() {
        editor.addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                if ((e.stateMask & SWT.CTRL) != 0 && e.keyCode == SWT.SPACE) {
                    showCompletion();
                    e.doit = false;
                }
            }
        });
    }
    
    public void showCompletion() {
        updateProposalsFromText();
        // ... restliche Completion-Logik wie zuvor
    }
    
    private void updateProposalsFromText() {
        if (allProposals == null) {
            allProposals = new TreeSet<>(String.CASE_INSENSITIVE_ORDER);
        }
        allProposals.clear();
        
        // Text des Editors analysieren
        String text = editor.getText();
        if (text != null && !text.isEmpty()) {
            Matcher matcher = Pattern.compile("\\b[a-zA-Z_][a-zA-Z0-9_]*\\b").matcher(text);
            while (matcher.find()) {
                String word = matcher.group();
                if (word.length() > 1) {
                    allProposals.add(word);
                }
            }
        }
        
        // Keywords hinzufügen
        allProposals.addAll(keywords);
    }
    
    public void setKeywords(Set<String> newKeywords) {
        this.keywords = newKeywords;
    }
}