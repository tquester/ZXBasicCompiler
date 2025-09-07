package editor;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.eclipse.swt.custom.StyledText;

public class SearchReplaceEngine {
	/*
    private StyledText editor;
    private ArrayList<Integer> searchResults = new ArrayList<>();
    private int currentResultIndex = -1;
    private String lastSearchText;
    private boolean lastCaseSensitive;
    private boolean lastWholeWord;
    
    public SearchReplaceEngine(StyledText editor) {
        this.editor = editor;
    }
    
    public void find(String searchText, boolean caseSensitive, boolean wholeWord) {
        this.lastSearchText = searchText;
        this.lastCaseSensitive = caseSensitive;
        this.lastWholeWord = wholeWord;
        
        searchResults.clear();
        String text = editor.getText();
        
        if (text == null || text.isEmpty() || searchText.isEmpty()) {
            currentResultIndex = -1;
            return;
        }
        
        Pattern pattern = createSearchPattern(searchText, caseSensitive, wholeWord);
        Matcher matcher = pattern.matcher(text);
        
        while (matcher.find()) {
            searchResults.add(matcher.start());
        }
        
        currentResultIndex = searchResults.isEmpty() ? -1 : 0;
        selectCurrentResult();
    }
    
    private Pattern createSearchPattern(String searchText, boolean caseSensitive, boolean wholeWord) {
        String regex = wholeWord ? "\\b" + Pattern.quote(searchText) + "\\b" : Pattern.quote(searchText);
        return caseSensitive ? 
            Pattern.compile(regex) : 
            Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
    }
    
    public void findNext() {
        if (!searchResults.isEmpty()) {
            currentResultIndex = (currentResultIndex + 1) % searchResults.size();
            selectCurrentResult();
        } else if (lastSearchText != null) {
            // Erneute Suche mit den letzten Parametern
            find(lastSearchText, lastCaseSensitive, lastWholeWord);
        }
    }
    
    public void findPrevious() {
        if (!searchResults.isEmpty()) {
            currentResultIndex = (currentResultIndex - 1 + searchResults.size()) % searchResults.size();
            selectCurrentResult();
        } else if (lastSearchText != null) {
            find(lastSearchText, lastCaseSensitive, lastWholeWord);
        }
    }
    
    public void replace(String searchText, String replaceText, boolean replaceAll) {
        if (replaceAll) {
            String text = editor.getText();
            Pattern pattern = createSearchPattern(searchText, lastCaseSensitive, lastWholeWord);
            String newText = pattern.matcher(text).replaceAll(replaceText);
            editor.setText(newText);
        } else if (currentResultIndex != -1) {
            int start = searchResults.get(currentResultIndex);
            editor.replaceTextRange(start, searchText.length(), replaceText);
            // Nach Replace neu suchen
            find(lastSearchText, lastCaseSensitive, lastWholeWord);
        }
    }
    
    private void selectCurrentResult() {
        if (currentResultIndex >= 0 && currentResultIndex < searchResults.size()) {
            int start = searchResults.get(currentResultIndex);
            int end = start + lastSearchText.length();
            editor.setSelection(start, end);
            editor.showSelection();
        }
    }
    
    public boolean hasResults() {
        return !searchResults.isEmpty();
    }
    
    public int getResultCount() {
        return searchResults.size();
    }
    
    public int getCurrentResultIndex() {
        return currentResultIndex;
    }
    */
}
