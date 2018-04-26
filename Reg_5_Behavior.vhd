--
-- VHDL Architecture lab1_lib.Reg_5.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 13:26:19 2018/04/12
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Reg_5 IS
  PORT( D : IN std_logic_vector(31 DOWNTO 0);
        Q : OUT std_logic_vector(31 DOWNTO 0);
        Clock, enable : IN std_ulogic);
END ENTITY Reg_5;

--
ARCHITECTURE Behavior OF Reg_5 IS
BEGIN
PROCESS(Clock)
 BEGIN
 --IF(reset = '1') THEN Q <= (others => '0');
 IF(rising_edge(Clock) AND enable = '1') THEN Q <= D;
 END IF;
 END PROCESS; 
END ARCHITECTURE Behavior;

