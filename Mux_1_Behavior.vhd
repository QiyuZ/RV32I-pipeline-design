--
-- VHDL Architecture lab1_lib.Mux_1.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 15:12:20 2018/04/22
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Mux_1 IS
    PORT ( In0, In1 : IN std_ulogic;
         Q : OUT std_ulogic;
         Sel : IN std_ulogic);
END ENTITY Mux_1;

--
ARCHITECTURE Behavior OF Mux_1 IS
BEGIN
  PROCESS(Sel, In0, In1)  
  BEGIN
    if (Sel = '0') then Q<= In0;
    else Q<= In1;
    end if;
END PROCESS;
END ARCHITECTURE Behavior;

