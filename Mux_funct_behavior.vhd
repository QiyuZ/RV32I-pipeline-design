--
-- VHDL Architecture lab1_lib.Mux_funct.behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 12:34:19 2018/04/ 6
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY Mux_funct IS
  port (Sel : IN std_ulogic;
        In0, In1 : IN RV32I_Op;
        Q : OUT RV32I_Op);
END ENTITY Mux_funct;

--
ARCHITECTURE behavior OF Mux_funct IS
BEGIN
  process (Sel, In0, In1)
  begin
    if (Sel = '0') then Q <= In0;
    else Q <= In1;
    end if;
  end process;
END ARCHITECTURE behavior;

