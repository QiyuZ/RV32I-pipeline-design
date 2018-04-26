--
-- VHDL Architecture lab1_lib.Reg_rd.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 12:45:27 2018/03/30
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Reg_rd IS
    PORT( D : IN std_ulogic_vector(4 DOWNTO 0);
          Q : OUT std_ulogic_vector(4 DOWNTO 0);
          Clock, reset, enable : IN std_ulogic);
END ENTITY Reg_rd;

--
ARCHITECTURE Behavior OF Reg_rd IS
BEGIN
PROCESS(Clock,reset)
 BEGIN
 IF(reset = '1') THEN Q <= (others => '0');
 ELSIF(rising_edge(Clock) AND enable = '1') THEN Q <= D;
 END IF;
 END PROCESS; 
END ARCHITECTURE Behavior;

