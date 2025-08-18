package zxcompiler;

import java.util.ArrayList;

public class Z80Optimizer {
	ArrayList<Z80Command> mCommands;
	public boolean COMMENTOUT=false; 
	public Z80Emitter mEmitter;
	
	// peep hole optimization

	public Z80Optimizer(Z80Emitter z80Emitter) {
		mEmitter = z80Emitter;
	}

	public void optimize(ArrayList<Z80Command> commands) {
		mCommands = commands;
		int icmd=0;
		int count=1;
		int runs=0;
		int total=0;
		while (count != 0) {
			
			if (runs > 0) {
				mEmitter.log(String.format("Optimize run %d, %d optimizations found",runs,count));
			}
			runs++;
			total+=count;
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
				
				
				if (check(cmd1,"CALL","runtimeCheckBreak") &&
						check(cmd2,"CALL","runtimeCheckBreak")) {
							remove(cmd2);
							count++;
							continue;
						} 
				
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
			
				if (check(cmd1,"DB","$38") &&
					check(cmd2,"RST","$28")) {
						remove(cmd1);
						remove(cmd2);
						count++;
					}
/*
 *  		LET zz=0.0{00 00 00 00 00 }
					LD HL,FLOAT_4	;0.0
					CALL runtimePushFloatVar
					LD HL,ZXBASIC_VAR_zz
					CALL runtimeStoreFloat			
 */
				if (check(cmd1,"LD","HL") &&
					check(cmd2,"CALL","runtimePushFloatVar") &&
					check(cmd3,"LD","HL") &&
					check(cmd4,"CALL","runtimeStoreFloat")) {
					set(cmd2,"LD","DE",par2(cmd3));
					set(cmd3,"LD","BC","5");
					set(cmd4,"LDIR",null,null);
					count++;
				}
				
				if (check(cmd1,"PUSH","HL") &&
						check(cmd2,"POP","DE"))  {
					set(cmd1,"LD",par1(cmd2),par1(cmd1));
					remove(cmd2);
					count++;
				}
				
				if (check(cmd1,"PUSH","DE") &&
						check(cmd2,"POP","HL"))  {
					set(cmd1,"LD",par1(cmd2),par1(cmd1));
					remove(cmd2);
					count++;
				}
				if (check(cmd1,"LD","HL") &&
						check(cmd2,"LD","DE","HL"))  {
					set(cmd1,"LD",par1(cmd2),par2(cmd1));
					remove(cmd2);
					count++;
				}
				
				if (check(cmd1,"LD","HL") &&
					check(cmd2,"LD",null,"HL") &&
					check(cmd3,"LD","HL",par2(cmd1))) {
					remove(cmd3);
					count++;
				}
				if (check(cmd1,"LD","HL") &&
					check(cmd2,"PUSH","HL") &&
					check(cmd2,"POP","BC")) {
					set(cmd1,"LD","BC",par1(cmd1));
					remove(cmd2);
					remove(cmd3);
					count++;
				}
						
				if (	check(cmd1,"PUSH","HL") &&
						check(cmd2,"POP","BC")) {
						set(cmd1,"LD","BC","HL");
						remove(cmd2);
						count++;
					}
						
				if (check(cmd1,"LD","HL") &&
					check(cmd2,"PUSH","HL") &&
					check(cmd3,"LD","HL") &&	
					check(cmd4,"POP","IX")) {	
					    set(cmd1,"LD","IX",par2(cmd1));
						remove(cmd2);
						remove(cmd4);
						     count++;
						   
					}
				if (check(cmd1,"LD","HL") &&
						check(cmd2,"LD","BC","HL")) {	
						    set(cmd1,"LD","BC",par2(cmd1));
							remove(cmd2);
							     count++;
							   
						}
				
					/*
				if (check(cmd1,"LD","HL","0") &&
					check(cmd2,"CALL","Z","HL1") &&
					check(cmd3,"LD","A","L") &&	
					check(cmd4,"CP","0") &&
					check(cmd5,"JP","Z")) {	
						    set(cmd1,"JP","Z",par2(cmd5));
							remove(cmd2);
							remove(cmd3);
							remove(cmd4);
							remove(cmd5);
							     count++;
							   
						}
					*/
				
				icmd++;
			}		
		}
		mEmitter.log(String.format("Total %d optimizations found",total));
//		optimizeRegisterBC();

		
	}

	private void optimizeRegisterBC() {
		int count=0;
		int icmd=0;
		// wir suchen:
		// push hl
		// ... code  code ..
		// pop de
		// und optimieren
		// ld bc,hl
		// .. code code .. 
		// ld de,bc
		// wenn zwischen push und pop kein label, kein bc, kein b, kein c und kein call vorkomme
		while (icmd < mCommands.size()-3) {
			if (mCommands.get(icmd).command == null) {
				icmd++;
				continue;
			}
			Z80Command z80 = mCommands.get(icmd);
			if (z80.command == null) {
				icmd++;
				continue;
			}
			if (check(icmd,"PUSH","HL")) {
				int icmd2 = icmd+1;
				while (icmd2 < mCommands.size()-3) {
					z80 = mCommands.get(icmd2);
					if (z80.command == null) { icmd2++; continue; }
					if (z80.label != null) {
						icmd = icmd2;
						break;
					}
					String cmd = z80.command.toLowerCase();
					String par1 = z80.par1;
					if (par1 == null) par1 = "";
					par1 = par1.toLowerCase();
					String par2 = z80.par1;
					if (par2 == null) par1 = "";
					par2 = par2.toLowerCase();
					if (cmd.compareTo("call") == 0 ||
					    par1.compareTo("bc") == 0 ||
					    par1.compareTo("b") == 0 ||
					    par1.compareTo("c") == 0 ||
					    par2.compareTo("bc") == 0 ||
					    par2.compareTo("b") == 0 ||
					    par2.compareTo("c") == 0) 
					{
						icmd = icmd2;
						break;
					}
					if (cmd.compareTo("pop") == 0) {
						mEmitter.log(String.format("Optimize line %d", icmd));
						set(icmd,"LD","BC","HL");
						set(icmd2,"LD",par1(icmd2),"BC");
						count++;
						icmd = icmd2;
					}
					
					
					
					icmd2++;
				}
			}
			icmd++;
		}
		if (count > 0)
			mEmitter.log(String.format("%d PUSH/POP optimiert", count));
		
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
		if (z80.par1 == null) return false;
		if (z80.par1 == null) return false;
		return (z80.command.compareToIgnoreCase(cmd) == 0) &&
			   (z80.par1.compareToIgnoreCase(par1) == 0);
	}

	private boolean check(int icmd, String cmd, String par1, String par2) {
		Z80Command z80 = mCommands.get(icmd);
		if (z80.command == null) return false;
		if (par1 != null)
			return (z80.command.compareToIgnoreCase(cmd) == 0) &&
				   (z80.par1.compareToIgnoreCase(par1) == 0) &&
				   (z80.par2.compareToIgnoreCase(par2) == 0);
		else
			return (z80.command.compareToIgnoreCase(cmd) == 0) &&
					   (z80.par2.compareToIgnoreCase(par2) == 0);
			
	}
}
