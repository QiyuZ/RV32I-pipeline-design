--
-- VHDL Architecture lab1_lib.Decoder_pip.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 21:44:57 2018/03/15
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY Decoder_pip IS
    PORT(instruction, PC : IN std_ulogic_vector(31 DOWNTO 0);
        DataA, DataB : IN std_ulogic_vector(31 DOWNTO 0);
        Functions : OUT RV32I_Op;
        clock : IN std_ulogic;
        RS1, RS2, RD : OUT std_ulogic_vector(4 DOWNTO 0);
        left, right, extra : OUT std_ulogic_vector(31 DOWNTO 0));
END ENTITY Decoder_pip;

--
ARCHITECTURE Behavior OF Decoder_pip IS
  signal RS1v, RS2v, RDv : std_ulogic; 
  signal Immediate, instr : std_ulogic_vector(31 DOWNTO 0);
  signal PC1,SUM : std_ulogic_vector(31 DOWNTO 0);
  signal control_left, control_extra, control_right : std_ulogic_vector(1 DOWNTO 0);
  --signal control_right : std_ulogic;
BEGIN
  Regsiter: ENTITY work.Reg(Behavior)
    PORT MAP (Clock => Clock, Reset => '0', Enable => '1', D => instruction, Q => instr);
  ---------------------------------------------------------------------------------------------
  Decode: ENTITY work.Decoder(Behavior)
    port map(instruction => instr, Funct => Functions, RS1 => RS1, RS2 => RS2,RD => RD, RS1v => RS1v, RS2v => RS2v, RDv => RDv, Immediate=>Immediate);
  ------------------------------------------------------------------------------------------------------------------------------
  Incre0: ENTITY work.ADD(Behavior)
    port map(d0=>PC,d1=>"00000000000000000000000000000100",Q=>PC1);
  --PC1 <= UNSIGNED(PC)+4; 
  --SUM <= UNSIGNED(Immediate) + UNSIGNED(PC);
  Incre1: ENTITY work.ADD(Behavior)
    port map(d0=>PC,d1=>Immediate,Q=>SUM);
  ---------------------------------------------------------------------
  control_deter: ENTITY work.control_decoder(behavior)
    port map(Fun => Functions, control_left => control_left, control_right => control_right, control_extra => control_extra);
  ---------------------------------------------------------------------
  MUX_left: ENTITY work.mux31a(one)
    port map(tmp => control_left, In0 => PC, In1 => PC1, In2 => DataA, Q => left);
  -------------------------------------------------------------------------------
  MUX_right: ENTITY work.Mux_right(Behavior)
    port map(tmp => control_right, In0 => Immediate, In1 => DataB, Q => right);
  --------------------------------------------------------------------------------
  MUX_extra: ENTITY work.Mux4(M4)
    port map(Sel => control_extra, In0 => Immediate, In1 => PC1, In2 => SUM, In3 => DataB, Q => extra);
END ARCHITECTURE Behavior;




