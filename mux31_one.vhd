--
-- VHDL Architecture lab1_lib.mux31.one
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 11:59:03 2018/02/ 1
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY  IEEE;
USe  IEEE.STD_LOGIC_1164.ALL;

ENTITY mux31a IS
  GENERIC (width : NATURAL RANGE 1 TO 64 := 32);
  PORT ( In0, In1, In2 : IN std_ulogic_vector(width - 1 DOWNTO 0);
         Q : OUT std_ulogic_vector(width - 1 DOWNTO 0);
         tmp : IN std_ulogic_vector(1 downto 0));
END ENTITY mux31a;

ARCHITECTURE one OF mux31a IS
BEGIN 
PROCESS(tmp,In0, In1, In2)  
  BEGIN
  CASE tmp IS
     WHEN "00"=>
      Q<=In0;
     WHEN "01"=>
      Q<=In1;
     WHEN "10"=>
      Q<=In2;
     WHEN OTHERS=>Q<=(others => 'X');
  END CASE;
END PROCESS;
END ARCHITECTURE one;

