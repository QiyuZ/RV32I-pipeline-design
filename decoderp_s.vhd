--
-- VHDL Architecture lab1_lib.decoderp.s
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 12:35:21 2018/03/19
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY decoderp IS
  port( instruction : IN std_ulogic_vector(31 downto 0);
        pc : IN std_ulogic_vector(31 downto 0);
        rfda, rfdb : IN std_ulogic_vector(31 downto 0);
        left, right, extra : OUT std_ulogic_vector(31 downto 0);
        rfaa, rfab, dest : OUT std_ulogic_vector(4 downto 0);
        func : OUT RV32I_Op;
        clock, stall, jump : IN std_ulogic;
        rs1v, rs2v, rdv : out std_ulogic);
END ENTITY decoderp;

--
ARCHITECTURE s OF decoderp IS
signal rs1o, rs2o, rdo : std_ulogic_vector(4 downto 0);
signal immediateo, instr, pcc : std_ulogic_vector(31 downto 0);
signal rs1vo, rs2vo, rdvo : std_ulogic;
signal funcm, funco: RV32I_Op;
signal Oinc, Oinc2 : std_ulogic_vector(31 downto 0);

--variable sum : UNSIGNED(31 downto 0);
  
BEGIN

  regins: entity work.Reg(Behavior)
    port map(clock => clock, reset=> '0',enable=> not stall, d=>instruction,q=>instr);

  regpc: entity work.Reg(Behavior)
    port map(clock => clock, reset=> '0',enable=> not stall,d=>pc,q=>pcc);

  decoder: entity work.decoder(Behavior)
    port map(instruction=>instr, funct=>funcm, rs1=>rs1o, rs2=>rs2o,rd=>rdo,rs1v=>rs1vo,rs2v=>rs2vo,rdv=>rdvo,immediate=>immediateo);
  
  mux: entity work.Mux_funct(behavior)
    port map(Sel => stall or jump, In0 => funcm, In1 => NOP, Q =>funco );

  inc: entity work.ADD(Behavior)
    port map(d0 => immediateo, d1 => pcc, q => Oinc);
  
  inc2: entity work.ADD(Behavior)
    port map(d0 => pcc, d1 =>"00000000000000000000000000000100", q => Oinc2);

  


func <= funco;
rfaa <= rs1o;
rfab <= rs2o;
dest <= rdo;
  muxv0 : entity work.Mux_1(behavior)
    port map (Sel => jump, In0 => rs1vo, In1 => '0', Q => rs1v);
  muxv1 : entity work.Mux_1(behavior)
    port map (Sel => jump, In0 => rs2vo, In1 => '0', Q => rs2v);
  muxv2 : entity work.Mux_1(behavior)
    port map (Sel => jump, In0 => rdvo, In1 => '0', Q => rdv);


--right <= rfda when s-type & i-type & b-type & r-type & jalr
--      <= pc when auipc
--      <= pc + 4 when jal
right <= rfdb when funco = BEQ or funco = BNE or funco = BLT or funco =BGE or funco = BLTU or funco = BGEU or funco = ADDr or funco = SUBr or funco = SLLr or funco = SLTr or funco = SLTUr or 
        funco = XORr or funco = SRLr or funco = SRAr or funco = ORr or funco = ANDr else
      -------------------------------------------------
      immediateo when funco = AUIPC OR funco = JAL OR funco = JALR or funco = LB or funco = LH 
      or funco = LW or funco = LBU or funco = LHU or funco = SB or funco = SH or funco = SW or funco = ADDI or funco = SLTI or funco = SLTIU or funco = XORI 
        or funco = ORI or funco = ANDI or funco = SLLI or funco = SRLI or funco = SRAI;


      
--right <= rfdb when b-type& r-type
--      <= immediate when s-type & i-type & u-type & j-type
left <= rfda when funco = JALR or funco = BEQ or funco = BNE or funco = BLT or funco =BGE or funco = BLTU or funco = BGEU or funco = LB or funco = LH 
        or funco = LW or funco = LBU or funco = LHU or funco = SB or funco = SH or funco = SW or funco = ADDI or funco = SLTI or funco = SLTIU or funco = XORI 
        or funco = ORI or funco = ANDI or funco = SLLI or funco = SRLI or funco = SRAI or funco = ADDr or funco = SUBr or funco = SLLr or funco = SLTr or funco = SLTUr or 
        funco = XORr or funco = SRLr or funco = SRAr or funco = ORr or funco = ANDr else
      pcc when funco = AUIPC OR funco = JAL;

--extra <= rfdb when s - type
--      <= immediate + pc when b -type
--      <= pc + 4 when jalr
extra <= rfdb when funco = SB or funco = SH or funco = SW else
      immediateo when funco = LUI else
      Oinc2 when funco = JAL  or funco = JALR else
      Oinc when funco = BEQ or funco = BNE or funco = BLT or funco =BGE or funco = BLTU or funco = BGEU;
       
      

END ARCHITECTURE s;


