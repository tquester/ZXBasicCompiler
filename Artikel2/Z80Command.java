package zxcompiler;

public class Z80Command {
	public Z80Command(String label, String command2, String param1, String param2, String comment) {
		this.label = label;
		this.command = command2;
		this.par1 = param1;
		this.par2 = param2;
		this.comment = comment;
	}
	public Z80Command(String command2, String param1, String param2, String comment) {
		this.label = label=null;
		this.command = command2;
		this.par1 = param1;
		this.par2 = param2;
		this.comment = comment;
	}
	public String label=null;
	public String command=null;
	public String par1=null;
	public String par2=null;
	public String comment=null;;
	public String toString() {
		String s = command;
		if (par1 != null) s += " "+par1;
		if (par2 != null) s += ", "+par2;
		s+=String.format(" cmd=%s par1=%s par2=%s", command,par1,par2);
		return s;
	}
	public String toZ80() {
		if (command == null && comment == null && label == null)
			return null;
		String s="";
		if (label != null) {
			s += label+":";
		}
		if (command != null) {
			s += "\t"+command;
			if (par1 != null) s += " "+par1;
			if (par2 != null) s += ","+par2;
			if (comment != null) s += "\t;"+comment;
		} else {
			if (comment != null)
				s+="; "+comment;
		}
		
		// TODO Auto-generated method stub
		return s;
	}
}