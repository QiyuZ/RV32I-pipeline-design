--
-- VHDL Architecture lab1_lib.Fetch.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 23:35:01 2018/02/ 8
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.all;

ENTITY Fetch IS
  GENERIC(width : NATURAL RANGE 1 TO 64 := 32);
  PORT( Jaddr, Mdata : IN std_ulogic_vector(width - 1 DOWNTO 0);
        Address, Inst : OUT std_ulogic_vector(width - 1 DOWNTO 0);
        Clock, Jmp, Reset, Delay : IN std_ulogic;
        read : out std_ulogic); 
END ENTITY Fetch;

--
ARCHITECTURE Structure OF Fetch IS
  signal JR, DJR :std_ulogic;
  signal zer :std_ulogic_vector(width - 1 downto 0):="00000000000000000000000000000000";
  signal NOP :std_ulogic_vector(width - 1 downto 0):= "00000000000000000000000000010011";
  SIGNAL Mux1Out : std_ulogic_vector(width - 1 downto 0);
  SIGNAL CounterOut : std_ulogic_vector(width - 1 downto 0);
  SIGNAL Mux2Out : std_ulogic_vector(width - 1 downto 0);
BEGIN
  Mux1: ENTITY work.Mux2(M2)
    GENERIC MAP (width => width)
    PORT MAP (In0=>Jaddr,In1=>zer,tmp=>Reset,Q=>Mux1Out);
  JR <= Jmp or Reset;
  Counter: ENTITY work.Counter(Structure)
    GENERIC MAP (width => width)
    PORT MAP (D=>Mux1Out,Clock=>Clock,enable=>(not Delay),Reset=>JR, Q=> CounterOut);
  Address <= CounterOut;
  DJR <= JR or Delay;
  Mux2: ENTITY work.Mux2(M2)
    GENERIC MAP (width => width)
    PORT MAP (In0=>Mdata,In1=>NOP,tmp=>DJR,Q=>Mux2Out);
  Inst <= Mux2Out;
  read <= not JR;
END ARCHITECTURE Structure;

