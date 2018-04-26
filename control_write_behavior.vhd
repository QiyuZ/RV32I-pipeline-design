--
-- VHDL Architecture lab1_lib.control_write.behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 23:28:58 2018/04/ 4
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY control_write IS
  port (funct : IN RV32I_Op;
        write : out std_ulogic);
END ENTITY control_write;

--
ARCHITECTURE behavior OF control_write IS
BEGIN
  process (funct)
  begin
    if (funct = BEQ or funct = BNE or funct = BLT or funct = BGE or funct = BLTU or funct = BGEU or funct =SB or funct = SH or funct = SW or funct = BAD OR funct = NOP) then write <= '0';
    else write <= '1';
    end if;
  end process;
END ARCHITECTURE behavior;

