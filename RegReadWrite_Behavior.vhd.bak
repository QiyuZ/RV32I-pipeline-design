--
-- VHDL Architecture lab1_lib.RegReadWrite.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 13:33:11 2018/04/12
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY RegReadWrite IS
  PORT(D : IN std_logic_vector(31 DOWNTO 0);
       Q0, Q1 : OUT std_logic_vector(31 DOWNTO 0);
       Clk, LE, OE0, OE1 : IN std_ulogic);
END ENTITY RegReadWrite;

--
ARCHITECTURE Behavior OF RegReadWrite IS
  SIGNAL Qval: std_logic_vector(31 DOWNTO 0);
  CONSTANT HiZ : std_logic_vector(31 DOWNTO 0) := (others => 'Z');
BEGIN
  store0 : ENTITY work.Reg_5(Behavior)
    PORT MAP(D => D, Q => Qval, clock => Clk, enable => LE);
  Q0 <= Qval WHEN OE0 = '1' ELSE HiZ;
  Q1 <= Qval WHEN OE1 = '1' ELSE HiZ;
  END ARCHITECTURE Behavior;

