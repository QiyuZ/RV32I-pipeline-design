--
-- VHDL Architecture lab1_lib.Memory.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 15:57:06 2018/04/ 4
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.ALU32I.all;
USE work.RV32I.all;

ENTITY Memory IS
  port(data, address, data_in : IN std_ulogic_vector(31 DOWNTO 0);
       funct : IN RV32I_Op;
       rd : IN std_ulogic_vector(4 DOWNTO 0);
       mdelay, clock : IN std_ulogic;
       address_m, data_out, data_w : OUT std_ulogic_vector(31 DOWNTO 0);
       dest : OUT std_ulogic_vector(4 DOWNTO 0);
       dest_funct : OUT RV32I_Op;
       stall, read, write : OUT std_ulogic;
       control_type : OUT std_ulogic_vector(1 DOWNTO 0));
END ENTITY Memory;

--
ARCHITECTURE Behavior OF Memory IS
  signal datar, addressr: std_ulogic_vector(31 DOWNTO 0);
  signal functm, functr : RV32I_Op;
  signal rdr : std_ulogic_vector(4 DOWNTO 0);
BEGIN
  -----------------------------------------------------------------------------
  Reg0: ENTITY work.Reg(Behavior)
    PORT MAP (Clock => Clock, Reset => '0', Enable => not mdelay, D => data, Q => datar);
  Reg1: ENTITY work.Reg(Behavior)
    PORT MAP (Clock => Clock, Reset => '0', Enable => not mdelay, D => address, Q => addressr);
  Reg3: entity work.Reg_rd(Behavior)
    port map (Clock => Clock, Reset => '0', Enable => not mdelay, D => rd, Q => rdr);
  Reg4: ENTITY work.Reg_funct(Behavior)
    port map (Clock => Clock, Reset => '0', Enable => not mdelay, D => funct, Q => functm);
  mux: entity work.Mux_funct(Behavior)
    port map (Sel => mdelay, In0 => functm, In1 => NOP, Q => functr);
  ------------------------------------------------------------------------------
  address_m <= addressr;
  data_out <= datar;
  dest <= rdr;
  dest_funct <= functr;
  ------------------------------------------------------------------------------
  control: entity work.control_memory(behavior)
    port map (funct => functr, mdelay => mdelay, control_w => write, control_r => read, control_s => stall, control_type => control_type);
  -------------------------------------------------------------------------------
  deter_data: entity work.memory_data(behavior)
    port map (funct => functr, data_in => data_in, data_w => data_w, data_e => datar);
  
END ARCHITECTURE Behavior;

