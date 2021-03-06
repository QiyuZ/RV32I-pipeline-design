--
-- VHDL Architecture lab1_lib.write_back.behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 23:20:08 2018/04/ 4
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.ALU32I.all;
USE work.RV32I.all;

ENTITY write_back IS
  port(rd : IN std_ulogic_vector(4 DOWNTO 0);
       funct : IN RV32I_Op;
       data: IN std_ulogic_vector(31 DOWNTO 0);
       clock : in std_ulogic;
       dest : OUT std_ulogic_vector(4 DOWNTO 0);
       output : OUT std_ulogic_vector(31 DOWNTO 0);
       write : out std_ulogic);
END ENTITY write_back;

--
ARCHITECTURE behavior OF write_back IS
  signal datar : std_ulogic_vector(31 DOWNTO 0);
  signal functr : RV32I_Op;
  signal rdr : std_ulogic_vector(4 DOWNTO 0);
BEGIN
  -----------------------------------------------------
  Reg0: ENTITY work.Reg(Behavior)
    PORT MAP (Clock => Clock, Reset => '0', Enable => '1', D => data, Q => datar);
  Reg3: entity work.Reg_rd(Behavior)
    port map (Clock => Clock, Reset => '0', Enable => '1', D => rd, Q => rdr);
  Reg4: ENTITY work.Reg_funct(Behavior)
    port map (Clock => Clock, Reset => '0', Enable => '1', D => funct, Q => functr);
  -----------------------------------------------------
  dest <= rdr;
  output <= datar;
  ----------------------------------------------------
  deter_write: entity work.control_write(behavior)
    port map (funct => functr, write => write);
END ARCHITECTURE behavior;

