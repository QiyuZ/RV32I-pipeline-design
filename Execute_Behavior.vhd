--
-- VHDL Architecture lab1_lib.Execute.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 18:48:36 2018/03/20
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

ENTITY Execute_ALU IS

  port(left, right : IN std_ulogic_vector(31 DOWNTO 0);
       control : IN ALU_Op;
       Data : OUT std_ulogic_vector(31 DOWNTO 0);
       flag : OUT std_ulogic);
END ENTITY Execute_ALU;

--
ARCHITECTURE Behavior OF Execute_ALU IS
BEGIN
  ------------------------------------------------------------
  process (left, right, control)
  begin
    if (control = aADD) then Data <= left + right; 
    elsif (control = aSUB) then Data <= left - right;
    elsif (control = aAND) then Data <= left and right;
    elsif (control = aOR) then  Data <= left or right;
    elsif (control = aXOR) then Data <= left XOR right;
    elsif (control = sSL) then Data <= std_ulogic_vector(UNSIGNED(left) SLL TO_INTEGER(UNSIGNED(right(4 downto 0)))); 
    elsif (control = aSRL) then Data <= std_ulogic_vector(UNSIGNED(left) SRL TO_INTEGER(UNSIGNED(right(4 downto 0))));
    elsif (control = sSRA) then Data <= std_ulogic_vector(SIGNED(left) SRA TO_INTEGER(UNSIGNED(right(4 downto 0)))); 
    end if;
    end process;
  -------------------------------------------------------------
  process (Data)
  begin
    if (Data = "00000000000000000000000000000000") then flag <= '1';
    else flag  <= '0';
    end if;
    end process;
  -------------------------------------------------------------
END ARCHITECTURE Behavior;

