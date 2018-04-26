--
-- VHDL Architecture lab1_lib.Mux4.M4
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 11:35:48 2018/02/ 1
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Mux4 IS
  GENERIC (width : NATURAL RANGE 1 TO 64 := 32);
  PORT ( In0, In1 : IN std_ulogic_vector(width - 1 DOWNTO 0);
         In2, In3 : IN std_ulogic_vector(width - 1 DOWNTO 0);
         Q : OUT std_ulogic_vector(width - 1 DOWNTO 0);
         Sel : IN std_ulogic_vector(1 DOWNTO 0));
END ENTITY Mux4;

--
ARCHITECTURE M4 OF Mux4 IS
  BEGIN 
  PROCESS(Sel,In0,In1,In2, In3)  BEGIN
    CASE Sel IS
       WHEN "00"=>Q<=In0;
       WHEN "01"=>Q<=In1;
       WHEN "10"=>Q<=In2;
       WHEN "11"=>Q<=In3;
       WHEN OTHERS=>NULL;
    END CASE;
  END PROCESS;
END ARCHITECTURE M4;




