--
-- VHDL Architecture lab1_lib.Reg_tracker.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 23:02:07 2018/04/12
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

ENTITY Reg_tracker IS
  port(addressA, addressB, rd, wa : IN std_ulogic_vector(4 DOWNTO 0);
       readA, readB, reserve, free, clock : IN std_ulogic;
       stall : OUT std_ulogic);
END ENTITY Reg_tracker;

--
ARCHITECTURE Behavior OF Reg_tracker IS
  TYPE matrix_index is array (31 downto 0) of Integer;
  SIGNAL value: matrix_index := (others => 0);
  --signal advalA, advalB, rdval, waval : Integer;
  signal stall0, stall1, stallv : std_ulogic := '0';
BEGIN

  ------------------------------------------------
  process(clock, rd, wa, reserve, free)
  begin
    if(rising_edge(clock)) then
      if (rd = wa and rd /= "00000") then 
        if (reserve = '1') then      
          if (free /= '1' and stall /= '1') then value(to_INTEGER(unsigned(rd))) <=  value(to_INTEGER(unsigned(rd))) + 1; 
          elsif (free = '1' and stall = '1') then value(to_INTEGER(unsigned(rd))) <=  value(to_INTEGER(unsigned(rd))) - 1; 
          end if;
        elsif (reserve = '0') then 
          if (free = '1') then value(to_INTEGER(unsigned(rd))) <= value(to_INTEGER(unsigned(rd))) - 1; end if;
        end if;
      elsif (rd /= wa) then
        if (reserve = '1' and stall /= '1' and rd /= "00000") then value(to_INTEGER(unsigned(rd))) <=  value(to_INTEGER(unsigned(rd))) + 1; end if;
        if (free = '1' and wa /= "00000") then value(to_INTEGER(unsigned(wa))) <=  value(to_INTEGER(unsigned(wa))) - 1; end if;
      end if;
    end if;
  end process;
  ------------------------------------------------------------------
  process(readA, readB, value, addressA, addressB)
  begin
      if (readA = '1') then 
        if (value(to_INTEGER(unsigned(addressA))) > 0) then stall0 <= '1';
        else stall0 <= '0';
        end if;
      else stall0 <= '0';
      end if;
      if (readB = '1') then 
        if (value(to_INTEGER(unsigned(addressB))) > 0) then stall1 <= '1';
        else stall1 <= '0';
        end if;
      else stall1 <= '0';
      end if;
    end process;
    stall <= stall0 or stall1;
END ARCHITECTURE Behavior;

