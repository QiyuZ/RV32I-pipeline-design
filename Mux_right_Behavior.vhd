--
-- VHDL Architecture lab1_lib.Mux_right.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 12:10:22 2018/03/19
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Mux_right IS
    PORT ( In0, In1 : IN std_ulogic_vector(31 DOWNTO 0);
         Q : OUT std_ulogic_vector(31 DOWNTO 0);
         tmp : IN std_ulogic_vector(1 downto 0));
END ENTITY Mux_right;

--
ARCHITECTURE Behavior OF Mux_right IS
BEGIN
  PROCESS(tmp,In0, In1)  
  BEGIN
  CASE tmp IS
     WHEN "00"=>
      Q<=In0;
     WHEN "01"=>
      Q<=In1;
     WHEN OTHERS=>Q<=(others => 'X');
  END CASE;
END PROCESS;
END ARCHITECTURE Behavior;

