--
-- VHDL Architecture lab1_lib.control_decoder.behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 22:13:31 2018/03/16
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY control_decoder IS
  PORT(Fun : IN RV32I_Op;
    control_left, control_extra, control_right : OUT std_ulogic_vector(1 DOWNTO 0)); 
    --control_right : OUT std_ulogic); 
END ENTITY control_decoder;

--
ARCHITECTURE behavior OF control_decoder IS
BEGIN
  process(Fun)
  begin
    if (Fun /= BAD and Fun /= NOP) then
      if (Fun = LUI) then
        --extra <= Immediate;
        control_extra <= "00";
      elsif (Fun = AUIPC) then
        --left <= PC;
        --right <= Immediate;
        control_left <= "00";
        control_right <= "00";
      elsif (Fun = JAL) then
        --left <= PC;
        --right <= Immediat+e;
        --extra <= PC1;
        control_left <= "00";
        control_right <="00";
        control_extra <= "01";
      elsif (Fun = JALR) then
        --left <= DataA;
        --right <= Immediate;
        --extra <= PC1;
        control_left <= "10";
        control_right <= "00";
        control_extra <= "01";
      elsif (Fun = BEQ or Fun = BNE or Fun = BLT or Fun =BGE or Fun = BLTU or Fun = BGEU) then
        --left <= DataA;
        --right <= DataB;
        --extra <= SUM;
        control_left <= "10";
        control_right <= "01";
        control_extra <= "10";
      elsif (Fun = LB or Fun = LH or Fun = LW or Fun = LBU or Fun = LHU) then
        --left <= DataA;
        --right <= Immediate;
        control_left <= "10";
        control_right <= "00";
      elsif (Fun = SB or Fun = SH or Fun = SW) then
        --left <= DataA;
        --right <= Immediate;
        --extra <= DataB;
        control_left <= "10";
        control_right <= "00";
        control_extra <= "11";
      elsif (Fun = ADDI or Fun = SLTI or Fun = SLTIU or Fun = XORI or Fun = ORI or Fun = ANDI or Fun = SLLI or Fun = SRLI or Fun = SRAI) then
        --left <= DataA;
        --right <= Immediate;
        control_left <= "10";
        control_right <= "00";
      elsif (Fun = ADDr or Fun = SUBr or Fun = SLLr or Fun = SLTr or Fun = SLTUr or Fun = XORr or Fun = SRLr or Fun = SRAr or Fun = ORr or Fun = ANDr) then
        --left <= DataA;
        --right <= DataB;
        control_left <= "10";
        control_right <= "01";
      end if;
    end if;
  end process;  
END ARCHITECTURE behavior;

