--
-- VHDL Architecture lab1_lib.Reg.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 16:33:28 2018/02/ 1
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Reg IS
  GENERIC(width : NATURAL RANGE 1 TO 64 := 32);
  PORT( D : IN std_ulogic_vector(width - 1 DOWNTO 0);
        Q : OUT std_ulogic_vector(width - 1 DOWNTO 0);
        Clock, reset, enable : IN std_ulogic);
END ENTITY Reg;

--
ARCHITECTURE Behavior OF Reg IS
BEGIN
PROCESS(Clock,reset)
 BEGIN
 IF(reset = '1') THEN Q <= (others => '0');
 ELSIF(rising_edge(Clock) AND enable = '1') THEN Q <= D;
 END IF;
 END PROCESS; 
END ARCHITECTURE Behavior;

