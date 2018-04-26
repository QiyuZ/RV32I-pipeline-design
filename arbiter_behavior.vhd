--
-- VHDL Architecture lab1_lib.arbiter.behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 11:23:05 2018/04/ 5
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY arbiter IS
  port (---------for memory stage--------------
        address_fm : IN std_ulogic_vector(31 DOWNTO 0);
        read, write : IN std_ulogic;
        data_tm : OUT std_ulogic_vector(31 DOWNTO 0);
        ---------for fetch--------------------
        address_ff : IN std_ulogic_vector(31 DOWNTO 0);
        data_tf : OUT std_ulogic_vector(31 DOWNTO 0);
        control : OUT std_ulogic;
        ---------for memory-------------------
        address_tm : OUT std_ulogic_vector(31 DOWNTO 0);
        data_ta : IN std_ulogic_vector(31 DOWNTO 0)
        );
END ENTITY arbiter;

--
ARCHITECTURE behavior OF arbiter IS
    signal controlv : std_ulogic := '0';
BEGIN
  process (read, write, address_fm, address_ff, data_ta)
  begin 
    if (read = '1' or write = '1') then 
      address_tm <= address_fm;
      controlv <= '1';
    else 
    address_tm <= address_ff;
    controlv <= '0';
    end if;
  end process;
  control <= controlv;
  data_tm <= data_ta;
  data_tf <= data_ta;
END ARCHITECTURE behavior;

