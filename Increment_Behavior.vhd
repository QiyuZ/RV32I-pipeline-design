--
-- VHDL Architecture lab1_lib.Increment.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 13:51:15 2018/02/ 1
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Increment IS
 GENERIC(width : NATURAL RANGE 1 TO 64 := 32);
 PORT(D : IN std_ulogic_vector(width - 1 DOWNTO 0);
      Q : OUT std_ulogic_vector(width - 1 DOWNTO 0);
      Inc : IN std_ulogic_vector(1 DOWNTO 0));
END ENTITY Increment;

ARCHITECTURE Behavior OF Increment IS
BEGIN
Process(D, Inc)
VARIABLE Sum : UNSIGNED(width - 1 DOWNTO 0); 
 BEGIN
  if(Inc = "00") then Sum := UNSIGNED(D);
  ELSIF(Inc = "01") then Sum := UNSIGNED(D) + 4; --ÐÞ¸ÄÁË
  --ELSIF (Inc = "10") then Sum := UNSIGNED(D) + 2;
  --elsif (Inc = "11") then Sum := UNSIGNED(D) + 4;
  END IF;
  Q <= std_ulogic_vector(Sum);
 END PROCESS;
END ARCHITECTURE Behavior; 


