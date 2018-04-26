--
-- VHDL Architecture lab1_lib.Decoder_pip_tb.testbench
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 00:54:44 2018/03/16
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;
USE std.textio.all;
use work.RV32I.all;

ENTITY Decoder_pip_tb IS
END ENTITY Decoder_pip_tb;

--
ARCHITECTURE testbench OF Decoder_pip_tb IS
  FILE test_vectors : text OPEN read_mode IS "Decoder_tb.txt";
  signal instruction, PC, DataA, DataB : std_ulogic_vector(31 DOWNTO 0);
  signal Funct, Funct1 : RV32I_Op;
  signal RS1, RS2, RD, RS11, RS21, RD1 : std_ulogic_vector(4 DOWNTO 0);
  signal left, left1, right, right1, extra, extra1 : std_ulogic_vector(31 DOWNTO 0);
  signal Clock : std_ulogic;
  SIGNAL vecno : NATURAL := 0;
BEGIN
  DUV: ENTITY work.decoderp(s)
    port map(clock => clock, instruction=>instruction,pc=>PC,rfda=>DataA,rfdb=>DataB,rfaa=>RS1,rfab=>RS2,dest=>RD,left=>left,right=>right,extra=>extra,func=>Funct);
  -------------------------------------------------------
  Stim : PROCESS
    VARIABLE L : LINE;
    VARIABLE FunName : Func_Name;
    VARIABLE instrval,PCv,leftv,rightv,extrav : std_ulogic_vector(31 DOWNTO 0);
    VARIABLE RS1val, RS2val, RDval : std_ulogic_vector(4 DOWNTO 0);
    VARIABLE DataAv, DataBv : std_ulogic_vector(31 DOWNTO 0); 
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
        read(L, PCv);
        PC <= PCv;
        read(L, DataAv);
        DataA <= DataAv;
        read(L, DataBv);
        DataB <= DataBv;
        read(L, RS1val);
        RS11 <= RS1val;
        read(L, RS2val);
        RS21 <= RS2val;
        read(L, RDval);
        RD1 <= RDval;
        read(L, leftv);
        left1 <= leftv;
        read(L, rightv);
        right1 <= rightv;
        read(L, extrav);
        extra1 <= extrav;
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
      assert left = left1
        REPORT "ERROR: left Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
      assert right = right1
        REPORT "ERROR: right Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
      assert extra = extra1
        REPORT "ERROR: extra Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
        vecno <= vecno + 1;
      end if;
    end process;
END ARCHITECTURE testbench;

