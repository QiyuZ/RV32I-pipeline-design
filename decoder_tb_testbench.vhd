--
-- VHDL Architecture lab1_lib.decoder_tb.testbench
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 11:00:44 2018/03/ 1
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;
USE std.textio.all;
use work.RV32I.all;

ENTITY decoder_tb IS
END ENTITY decoder_tb;

--
ARCHITECTURE testbench OF decoder_tb IS
  FILE test_vectors : text OPEN read_mode IS "Decoder_tb.txt";
  signal instruction : std_ulogic_vector(31 DOWNTO 0);
  signal Funct, Funct1 : RV32I_Op;
  signal RS1, RS2, RD, RS11, RS21, RD1 : std_ulogic_vector(4 DOWNTO 0);
  signal RS1v, RS2v, RDv, RS1v1, RS2v1, RDv1, Clock : std_ulogic; 
  signal Immediate, Immediate1 : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL vecno : NATURAL := 0;
BEGIN
  DUV : ENTITY work.Decoder(Behavior)
    PORT MAP(instruction => instruction, Funct => Funct, RS1 => RS1, RS2 => RS2, RD => RD, 
    RS1v => RS1v, RS2v => RS2v, RDv => RDv, Immediate => Immediate);
    -----------------------------------------------------------------------
  Stim : PROCESS
    VARIABLE L : LINE;
    VARIABLE FunName : Func_Name;
    VARIABLE instrval : std_ulogic_vector(31 DOWNTO 0);
    VARIABLE RS1val, RS2val, RDval : std_ulogic_vector(4 DOWNTO 0);
    VARIABLE RS1vval, RS2vval, RDvval : std_ulogic; 
    VARIABLE Immediateval : std_ulogic_vector(31 DOWNTO 0); 
    begin
      Clock <= '0';
      wait for 40 ns;
      readline(test_vectors, L);
      while not endfile(test_vectors)loop
        readline(test_vectors, L);  
        read(L, FunName);
        Funct1 <= Ftype(FunName);
        read(L, instrval);
        instruction <= instrval;
        read(L, RS1val);
        RS11 <= RS1val;
        read(L, RS2val);
        RS21 <= RS2val;
        read(L, RDval);
        RD1 <= RDval;
        read(L, RS1vval);
        RS1v1 <= RS1vval;
        read(L, RS2vval);
        RS2v1 <= RS2vval;
        read(L, RDvval);
        RDv1 <= RDvval;
        read(L, Immediateval);
        Immediate1 <= Immediateval;
        wait for 10 ns;
        Clock <= '1';
        wait for 40 ns;
        Clock <= '0';
        wait for 50 ns;
      end loop;
      report "End of Testbench.";
      std.env.finish;
    end process;
    --------------------------------------------------------------------
    Check : PROCESS(Clock)
    begin
      if (falling_edge(Clock)) then
      assert RS1 = RS11
        REPORT "ERROR: RS1 Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
      assert RS2 = RS21
        REPORT "ERROR: RS2 Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
      assert RD = RD1
        REPORT "ERROR: RD Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
      assert Funct = Funct1
        REPORT "ERROR: Funct Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
      assert RS1v = RS1v1
        REPORT "ERROR: RS1v Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
      assert RS2v = RS2v1
        REPORT "ERROR: RS2v Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
      assert RDv = RDv1
        REPORT "ERROR: RDv Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
      assert Immediate = Immediate1
        REPORT "ERROR: Immediate Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
        vecno <= vecno + 1;
      end if;
    end process;
END ARCHITECTURE testbench;

