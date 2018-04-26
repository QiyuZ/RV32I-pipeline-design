--
-- VHDL Architecture lab1_lib.memory_data.behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 22:31:55 2018/04/ 4
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
USE work.RV32I.all;
use ieee.numeric_std.all;

ENTITY memory_data IS
  port (funct : IN RV32I_Op;
        data_in : IN std_ulogic_vector(31 DOWNTO 0);
        data_w : OUT std_ulogic_vector(31 DOWNTO 0);
        data_e : IN std_ulogic_vector(31 DOWNTO 0));
END ENTITY memory_data;

--
ARCHITECTURE behavior OF memory_data IS
BEGIN
  process (data_in, funct, data_e)
  begin
    if (funct = LB or funct = SB) then 
      data_w <= std_ulogic_vector(resize(signed(data_in(7 downto 0)), data_w'length));
      --if (data_in(7 downto 7) = '1') then data_w <= "111111111111111111111111"&data_in(7 downto 0);
      --else data_w <= "000000000000000000000000"&data_in(7 downto 0);
      --end if;
   elsif (funct = LBU) then 
      data_w <= std_ulogic_vector(resize(unsigned(data_in(7 downto 0)), data_w'length));
      --data_w <= "000000000000000000000000"&data_in(7 downto 0);
   elsif (funct = LH or funct = SH) then 
      data_w <= std_ulogic_vector(resize(signed(data_in(15 downto 0)), data_w'length));
      --if (data_in(15 downto 15) = '1') then data_w <= "1111111111111111" & data_in(15 downto 0);
      --else data_w <= "0000000000000000" & data_in(15 downto 0);
      --end if;
   elsif (funct = LHU) then 
      data_w <= std_ulogic_vector(resize(unsigned(data_in(15 downto 0)), data_w'length));
      --data_w <= "0000000000000000" & data_in(15 downto 0);
   elsif (funct = LW or funct = SW) then data_w <= data_in;
   else data_w <= data_e;
   end if;
   end process; 
END ARCHITECTURE behavior;

