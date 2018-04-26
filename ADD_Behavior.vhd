--
-- VHDL Architecture lab1_lib.ADD.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 10:22:20 2018/03/19
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY ADD IS
  PORT(d0, d1 : IN std_ulogic_vector(31 DOWNTO 0);
      Q : OUT std_ulogic_vector(31 DOWNTO 0));
END ENTITY ADD;

--
ARCHITECTURE Behavior OF ADD IS
BEGIN
  process(d0, d1)
  VARIABLE Sum : UNSIGNED(31 DOWNTO 0);
  begin
  Sum := UNSIGNED(d0)+UNSIGNED(d1);
  Q <= std_ulogic_vector(Sum);
end process;
END ARCHITECTURE Behavior;

