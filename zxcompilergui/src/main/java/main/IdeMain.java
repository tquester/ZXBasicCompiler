package main;
import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;

public class IdeMain {

	public static void main(String[] args) {
		System.out.println("Classpath: " + System.getProperty("java.class.path"));
		
		
			

        //shell.setImage(SWTResourceManager.getImage(MainClass.class,"disass.gif"));
			
	      Display display = new Display();
	      
	        Shell shell = new Shell(display);
	        shell.setText("ZX Compiler");
	        shell.setLayout(new FillLayout(SWT.VERTICAL));
	        shell.setBounds(0,0,10,10);
	        shell.open();
	        shell.setVisible(false); // Wichtig: Unsichtbar machen
	        
	        CDialogIDEMain mainDialog = new CDialogIDEMain(shell, SWT.TITLE + SWT.MAX + SWT.RESIZE + SWT.CLOSE);
	        mainDialog.open();
	}

}
