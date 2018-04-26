--
-- VHDL Architecture lab1_lib.Execute.Structure
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 10:57:12 2018/03/28
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.ALU32I.all;
USE work.RV32I.all;

ENTITY Execute IS
  port(left, right, extra : IN std_ulogic_vector(31 DOWNTO 0);
       rd : IN std_ulogic_vector(4 DOWNTO 0);
       funct : IN RV32I_Op;
       clock, stall : IN std_ulogic;
       data, address, jaddr : OUT std_ulogic_vector(31 DOWNTO 0);
       dest : OUT std_ulogic_vector(4 DOWNTO 0);
       dest_fun : OUT RV32I_Op;
       jump : OUT std_ulogic);
END ENTITY Execute;

--
ARCHITECTURE Structure OF Execute IS
  signal leftr, rightr, extrar, alu_output : std_ulogic_vector(31 DOWNTO 0);
  signal flag : std_ulogic;
  signal control_op : ALU_Op;
  signal rdr : std_ulogic_vector(4 DOWNTO 0);
  signal functr, functm : RV32I_Op;
  --signal no : RV32I_Op := NOP;
  signal control_data : std_ulogic_vector(1 DOWNTO 0);
BEGIN
  -----------------------------------------------------------------------------
  Reg0: ENTITY work.Reg(Behavior)
    PORT MAP (Clock => Clock, Reset => '0', Enable => not stall, D => left, Q => leftr);
  Reg1: ENTITY work.Reg(Behavior)
    PORT MAP (Clock => Clock, Reset => '0', Enable => not stall, D => right, Q => rightr);
  Reg2: ENTITY work.Reg(Behavior)
    PORT MAP (Clock => Clock, Reset => '0', Enable => not stall, D => extra, Q => extrar);
  Reg3: entity work.Reg_rd(Behavior)
    port map (Clock => Clock, Reset => '0', Enable => not stall, D => rd, Q => rdr);
  Reg4: ENTITY work.Reg_funct(Behavior)
    port map (Clock => Clock, Reset => '0', Enable => not stall, D => funct, Q => functm);
  mux: entity work.Mux_funct(Behavior)
    port map (Sel => stall, In0 => functm, In1 => NOP, Q => functr);
  ------------------------------------------------------------------------------
  control: entity work.control_execute(behavior)
    port map (left => leftr, right => rightr, funct => functr, control_op => control_op, control_data => control_data);
  alu: entity work.Execute_ALU(Behavior)
    port map (left => leftr, right => rightr, control => control_op, Data => alu_output, flag => flag);
  --------------------------------------------------------------------------------------------
  address <= alu_output;
  dest <= rdr;
  dest_fun <= functr;
  --------------------------------------------------------------------------------------------
  data_mux: entity work.Mux4(M4)
    port map (Sel => control_data, In0 => extrar, In1 => alu_output, In2 =>"00000000000000000000000000000001", In3 =>"00000000000000000000000000000000", Q => data);
  --------------------------------------------------------------------------------------------
  branch: entity work.compare(behavior)
    port map (left => leftr, right => rightr, extra => extrar, funct => functr, jump => jump, jaddr => jaddr);
  --------------------------------------------------------------------------------------------
  --SLT: ENTITY work.execute_slt(behavior)
    --port map (left => leftr, right => rightr, funct => functr, data => data);

END ARCHITECTURE Structure;

