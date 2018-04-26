--
-- VHDL Architecture lab1_lib.Count.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 22:39:23 2018/02/ 2
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.all;

ENTITY Counter IS
  GENERIC(width : NATURAL RANGE 1 TO 64 := 32);
  PORT( D : IN std_ulogic_vector(width - 1 DOWNTO 0);
  Q : OUT std_ulogic_vector(width - 1 DOWNTO 0);
  Clock, enable, reset : IN std_ulogic);
END ENTITY Counter;

--
ARCHITECTURE Structure OF Counter IS
  SIGNAL RegOut : std_ulogic_vector(width - 1 downto 0);
  SIGNAL IncOut : std_ulogic_vector(width - 1 downto 0);
  SIGNAL MuxOut : std_ulogic_vector(width - 1 downto 0);
BEGIN
  Incre: ENTITY work.Increment(Behavior)
    GENERIC MAP (width => width)
    PORT MAP (D=>RegOut,Q=>IncOut,Inc=>'0'&enable);--此处根据每次所需要加的值进行改变
  Mux: ENTITY work.Mux2(M2)
    GENERIC MAP (width => width)
    PORT MAP (In0=>IncOut,In1=>D,tmp=>reset,Q=>MuxOut);
  Reg: ENTITY work.Reg(Behavior)
    GENERIC MAP (width => width)
    PORT MAP (D=>MuxOut,Q=>RegOut,Clock=>Clock,enable=>'1',reset=>'0'); 

Q<=RegOut;
END ARCHITECTURE Structure;

