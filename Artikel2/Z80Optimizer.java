package zxcompiler;

import java.util.ArrayList;

public class Z80Optimizer {
	ArrayList<Z80Command> mCommands;
	public boolean COMMENTOUT=false; 
	
	// peep hole optimization

	public void optimize(ArrayList<Z80Command> commands) {
		mCommands = commands;
		int icmd=0;
		int count=1;
		int runs=0;
		while (count != 0) {
			if (runs > 0) {
				System.out.println(String.format("Optimize run %d, %d optimizations found",runs,count));
			}
			runs++;
			count = 0;
			icmd=0;
			while (icmd < mCommands.size()-3) {
				if (mCommands.get(icmd).command == null) {
					icmd++;
					continue;
				}
				int cmd1 = icmd;
				int cmd2 = next(cmd1);
				int cmd3 = next(cmd2);
				int cmd4 = next(cmd3);
				int cmd5 = next(cmd4);
				int cmd6 = next(cmd5);
				
				
				
				
				if (check(cmd1,"PUSH","HL") &&
					check(cmd2,"POP","HL")) {
						remove(cmd1);
						remove(cmd2);
						count++;
						continue;
					} 
					
				if (check(cmd1,"LD","HL") &&
				    check(cmd2,"LD","L","(HL)") &&
				    check(cmd3,"LD","H","0")) {
						Z80Command z80 = mCommands.get(cmd1);
						set(cmd1,"LD","A",String.format("(%s)",z80.par2));
						set(cmd2,"LD","L","A");
						icmd+=3;
						count++;
						continue;
				}
				if (check(cmd1,"LD","HL") &&
					check(cmd2,"PUSH","HL") &&
					check(cmd3,"LD","HL") &&
					check(cmd4,"POP","DE")) {
						Z80Command z80 = mCommands.get(cmd1);
						set(cmd1,"LD","DE",z80.par2);
						remove(cmd2);
						remove(cmd4);
						count++;
				}
				if (check(cmd1,"LD","L","A") &&
					check(cmd2,"LD","H","0") &&
					check(cmd3,"PUSH","HL") &&	
					check(cmd4,"LD","HL","256") &&
					check(cmd5,"POP","DE") &&
					check(cmd6,"CALL","runtimeMult16bit")) {	
					     set(cmd1,"LD","H","A");
					     set(cmd2,"LD","L","0");
					     remove(cmd3);
					     remove(cmd4);
					     remove(cmd5);
					     remove(cmd6);
					     count++;
					   
				}
				
				if (check(cmd1,"PUSH","HL") &&
					check(cmd2,"LD","HL") &&
					check(cmd3,"POP","DE")) {
					
					set(cmd1,"LD","DE","HL");
					remove(cmd3);
					count++;
					
				}
				
				
				if (check(cmd1,"LD","DE") &&
					check(cmd2,"LD","HL") &&
					check(cmd3,"EX","HL","DE")) {
					Z80Command z801 = mCommands.get(cmd1);
					Z80Command z802 = mCommands.get(cmd2);
					set(cmd1,"LD","HL",z801.par2);
					set(cmd2,"LD","DE",z802.par2);
					remove(cmd3);
					count++;
					
				}
				
				if (check(cmd1,"LD","DE","HL") &&
						check(cmd2,"LD","HL","1") &&
						check(cmd3,"ADD","HL","DE")) {
						
						set(cmd1,"INC","HL",null);
						remove(cmd2);
						remove(cmd3);
						count++;
						
					}
						
				if (check(cmd1,"LD","HL","HL")){
						remove(cmd1);
						count++;
					}
				
				if (check(cmd1,"LD","HL") &&
					check(cmd2,"LD","DE","1") &&
					check(cmd3,"ADD","HL","DE") &&
					check(cmd4,"LD",par2(cmd1),"HL") &&
					par2(cmd1).startsWith("(")) {
			     		String var = par2(cmd1);
			     		set(cmd1,"LD","HL",var);
			     		set(cmd2," INC","HL",null);
			     		set(cmd3,"LD",var,"HL");
			     		remove(cmd4);
			     		count++;
					count++;
				}

				if (check(cmd1,"LD","DE") &&
						check(cmd2,"LD","HL","1") &&
						check(cmd3,"ADD","HL","DE") &&
						check(cmd4,"LD",par2(cmd1),"HL") &&
						par2(cmd1).startsWith("(")) {
 				     		String var = par2(cmd1);
 				     		set(cmd1,"LD","HL",var);
 				     		set(cmd2,"INC","HL",null);
 				     		set(cmd3,"LD",var,"HL");
 				     		remove(cmd4);
 				     		count++;
					}

				if (check(cmd1,"LD","HL") &&
						check(cmd2,"LD","DE","1") &&
						check(cmd3,"SUB","HL","DE") &&
						check(cmd4,"LD",par2(cmd1),"HL") &&
						par2(cmd1).startsWith("(")) {
				     		String var = par2(cmd1);
				     		set(cmd1,"LD","HL",var);
				     		set(cmd2,"DEC","HL",null);
				     		set(cmd3,"LD",var,"HL");
				     		remove(cmd4);
				     		count++;
					}
						
				if (check(cmd1,"LD","DE") &&
						check(cmd2,"LD","HL","1") &&
						check(cmd3,"SUB","HL","DE") &&
						check(cmd4,"LD",par2(cmd1),"HL") &&
						par2(cmd1).startsWith("(")) {
			     		String var = par2(cmd1);
			     		set(cmd1,"LD","HL",var);
			     		set(cmd2,"DEC","HL",null);
			     		set(cmd3,"LD",var,"HL");
			     		remove(cmd4);
			     		count++;
					}
						
					
					
					
				icmd++;
			}		
		}

		
	}

	private String par2(int id) {
		String s = mCommands.get(id).par2;
		return s == null ? "" : s;
	}


	private String par1(int id) {
		String s = mCommands.get(id).par1;
		return s == null ? "" : s;
	}
	
	private String cmd(int id) {
		String s = mCommands.get(id).command;
		return s == null ? "" : s;
	}
	
private void remove(int cmd) {
		Z80Command c = mCommands.get(cmd);
		if (COMMENTOUT)
			c.comment = "\t\t\t\t"+c.toZ80();
		c.command = null;
		
	}

	private int next(int cmd1) {
		cmd1++;
		while (cmd1 < mCommands.size()) {
			if (mCommands.get(cmd1).command != null) return cmd1;
			cmd1++;
		}
		return 0;
	}

	private void set(int i, String cmd, String par1, String par2) {
		Z80Command z80 = mCommands.get(i);
		if (COMMENTOUT) 
			z80.comment = z80.toZ80();
		z80.command = cmd;
		z80.par1 = par1;
		z80.par2 = par2;
		
		
	}

	private boolean check(int icmd, String cmd, String par1) {
		Z80Command z80 = mCommands.get(icmd);
		if (z80.command == null) return false;
		return (z80.command.compareToIgnoreCase(cmd) == 0) &&
			   (z80.par1.compareToIgnoreCase(par1) == 0);
	}

	private boolean check(int icmd, String cmd, String par1, String par2) {
		Z80Command z80 = mCommands.get(icmd);
		if (z80.command == null) return false;
		return (z80.command.compareToIgnoreCase(cmd) == 0) &&
			   (z80.par1.compareToIgnoreCase(par1) == 0) &&
			   (z80.par2.compareToIgnoreCase(par2) == 0);
	}
}
