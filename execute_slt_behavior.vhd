--
-- VHDL Architecture lab1_lib.execute_slt.behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 12:10:20 2018/03/30
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;
USE work.ALU32I.all;
USE work.RV32I.all;

ENTITY execute_slt IS
  port (left, right : IN std_ulogic_vector(31 DOWNTO 0);
        funct : IN RV32I_Op;
        data : OUT std_ulogic_vector(31 DOWNTO 0));
END ENTITY execute_slt;

--
ARCHITECTURE behavior OF execute_slt IS
BEGIN
  process (left, right, funct)
  begin
    if (funct = SLTI or funct = SLTr) then
      if (SIGNED(left) < SIGNED(right)) then data <= "00000000000000000000000000000001";
      else data <= "00000000000000000000000000000000";
      end if;
    elsif (funct = SLTIU or funct = SLTUr) then
      if (UNSIGNED(left) < UNSIGNED(right)) then data <= "00000000000000000000000000000001";
      else data <= "00000000000000000000000000000000";
      end if;
    END IF;
  END PROCESS;
END ARCHITECTURE behavior;

