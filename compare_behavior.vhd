--
-- VHDL Architecture lab1_lib.compare.behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 22:14:14 2018/03/29
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
USE work.ALU32I.all;
USE work.RV32I.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

ENTITY compare IS
  port (left, right, extra : IN std_ulogic_vector(31 DOWNTO 0);
        funct : IN RV32I_Op;
        jump : OUT std_ulogic;
        jaddr : OUT std_ulogic_vector(31 DOWNTO 0));
END ENTITY compare;

--
ARCHITECTURE behavior OF compare IS
  signal jumpv : std_ulogic := '0';
BEGIN
  PROCESS (left, right, extra, funct)
  begin
    if (funct = BEQ) then 
      if (left = right) then 
        jaddr <= extra;
        jumpv <= '1';
      else jumpv <= '0';
      end if;
    elsif (funct = BNE) then 
      if (left /= right) then
        jaddr <= extra;
        jumpv <= '1';
      else jumpv <= '0';
      end if;
    elsif (funct = BLT) then 
      if (SIGNED(left) < SIGNED(right)) then
        jaddr <= extra;
        jumpv <= '1';
      else jumpv <= '0';
      end if;
    elsif (funct = BLTU) then
      if (UNSIGNED(left) < UNSIGNED(right)) then
        jaddr <= extra;
        jumpv <= '1';
      else jumpv <= '0';
      end if;
    elsif (funct = BGE) then 
      if (SIGNED(left) >= SIGNED(right)) then
        jaddr <= extra;
        jumpv <= '1';
      else jumpv <= '0';
      end if;
    elsif (funct = BGEU) then 
      if (UNSIGNED(left) >= UNSIGNED(right)) then
        jaddr <= extra;
        jumpv <= '1';
        else jumpv <= '0';
      end if;
    else jumpv <= '0';
    end if;
    end process;
    jump <= jumpv;
END ARCHITECTURE behavior;

