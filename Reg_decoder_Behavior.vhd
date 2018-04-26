--
-- VHDL Architecture lab1_lib.Reg_decoder.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 14:32:10 2018/04/12
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

ENTITY Reg_decoder IS
  PORT(sel : IN std_logic_vector(4 DOWNTO 0);
       OneHot : OUT std_logic_vector(31 DOWNTO 0);
       enable : IN std_ulogic);
END ENTITY Reg_decoder;

--
ARCHITECTURE Behavior OF Reg_decoder IS
BEGIN
  PROCESS(sel, enable)
    VARIABLE selection : NATURAL RANGE 0 TO 31;
    VARIABLE result : std_logic_vector(31 DOWNTO 0);
    CONSTANT zero : std_logic_vector(31 DOWNTO 0) := (others=>'0');
    BEGIN
      result := zero;
      IF(enable = '1') THEN
        selection := To_Integer(unsigned(sel));
        result(selection) := '1';
      END IF;
      OneHot <= result;
    END PROCESS;
  END ARCHITECTURE Behavior;

