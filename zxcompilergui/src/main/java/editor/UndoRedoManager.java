package editor;

import java.util.Stack;

import org.eclipse.swt.custom.StyledText;

public class UndoRedoManager {
	
	public class EditorState {
	    public final String text;
	    public final int caretOffset;
	    public final int selectionStart;
	    public final int selectionEnd;
	    
	    public EditorState(String text, int caretOffset, int selectionStart, int selectionEnd) {
	        this.text = text;
	        this.caretOffset = caretOffset;
	        this.selectionStart = selectionStart;
	        this.selectionEnd = selectionEnd;
	    }
	}
	
    private Stack<EditorState> undoStack = new Stack<>();
    private Stack<EditorState> redoStack = new Stack<>();
    private StyledText editor;
    
  
    
    public UndoRedoManager(StyledText editor) {
        this.editor = editor;
    }
    
    public void saveState() {
        EditorState state = new EditorState(
            editor.getText(),
            editor.getCaretOffset(),
            editor.getSelection().x,
            editor.getSelection().y
        );
        undoStack.push(state);
        redoStack.clear();
    }
    
    public void undo() {
        if (!undoStack.isEmpty()) {
            EditorState current = new EditorState(
                editor.getText(),
                editor.getCaretOffset(),
                editor.getSelection().x,
                editor.getSelection().y
            );
            redoStack.push(current);
            
            EditorState previous = undoStack.pop();
            applyState(previous);
        }
    }
    
    public void redo() {
        if (!redoStack.isEmpty()) {
            EditorState current = new EditorState(
                editor.getText(),
                editor.getCaretOffset(),
                editor.getSelection().x,
                editor.getSelection().y
            );
            undoStack.push(current);
            
            EditorState next = redoStack.pop();
            applyState(next);
        }
    }
    
    private void applyState(EditorState state) {
        editor.setText(state.text);
        editor.setSelection(state.selectionStart, state.selectionEnd);
        editor.setCaretOffset(state.caretOffset);
        editor.showSelection();
    }
    
}