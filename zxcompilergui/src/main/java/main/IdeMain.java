package main;
import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;

public class IdeMain {

	public static void main(String[] args) {
	      Display display = new Display();
	        Shell shell = new Shell(display);
	        shell.setText("Chip8 Disassembler");
	        //shell.setImage(SWTResourceManager.getImage(MainClass.class,"disass.gif"));
	        shell.setLayout(new FillLayout(SWT.VERTICAL));
	        shell.setBounds(0,0,10,10);
	        shell.open();
	        CDialogIDEMain mainDialog = new CDialogIDEMain(shell, SWT.TITLE + SWT.MAX + SWT.RESIZE + SWT.CLOSE);
	        mainDialog.open();
	}

}
