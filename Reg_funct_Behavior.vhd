--
-- VHDL Architecture lab1_lib.Reg_funct.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 12:45:50 2018/03/30
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY Reg_funct IS
      PORT( D : IN RV32I_Op;
          Q : OUT RV32I_Op;
          Clock, reset, enable : IN std_ulogic);
END ENTITY Reg_funct;

--
ARCHITECTURE Behavior OF Reg_funct IS
BEGIN
  PROCESS(Clock,reset)
  BEGIN
  IF(reset = '1') THEN Q <= NOP;
  ELSIF(rising_edge(Clock) AND enable = '1') THEN Q <= D;
  END IF;
  END PROCESS; 
END ARCHITECTURE Behavior;

