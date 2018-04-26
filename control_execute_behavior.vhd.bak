--
-- VHDL Architecture lab1_lib.control_execute.behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 17:13:26 2018/03/29
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;
USE work.ALU32I.all;
USE work.RV32I.all;

ENTITY control_execute IS
  port(left, right : IN std_ulogic_vector(31 DOWNTO 0);
       funct : IN RV32I_Op;
       control_op : OUT ALU_Op;
       control_data : out std_ulogic_vector(1 DOWNTO 0));
END ENTITY control_execute;

--
ARCHITECTURE behavior OF control_execute IS
BEGIN
  process(funct)
  begin
    if (funct = AUIPC or funct = JAL or funct = JALr or funct = LB or funct = LH or funct = LW or funct = LBU or funct = LHU OR funct = SB or funct = SH or funct = SW OR funct = ADDI or funct = ADDr) 
    then control_op <= aADD;
    elsif (funct = SUBr) then control_op <= aSUB;
    elsif (funct = ANDI or funct = ANDr) then control_op <= aAND;
    elsif (funct = ORI or funct = ORr) then control_op <= aOR; 
    elsif (funct = XORI or funct = XORr) then control_op <= aXOR; 
    elsif (funct = SLLI or funct = SLLr) then control_op <= sSL;
    elsif (funct = SRLI or funct = SRLr) then control_op <= aSRL;
    elsif (funct = SRAI or funct = SRAr) then control_op <= sSRA;
    else control_op <= aADD;
    end if;
  end process;
  ----------------------------------------------------------
  process (funct, left, right)
  begin
    if (funct = LUI or funct = JAL or funct = JALr or funct = SB or funct = SH or funct = SW or funct = BEQ or funct = BNE or funct = BLT or funct = BGE or funct = BLTU or funct = BGEU) then control_data <= "00";
    elsif (funct = AUIPC or funct = ADDI or funct = XORI or funct = ORI or funct = ANDI or funct = SLLI or funct = SRLI or funct = SRAI 
           or funct = ADDr or funct = SUBr or funct = SLLr or funct = XORr or funct = SRLr or funct = SRAr or funct = ORr or funct = ANDr) then control_data <= "01";
    elsif (funct = SLTI or funct = SLTr) then
      if (SIGNED(left) < SIGNED(right)) then control_data <= "10";
      else control_data <= "11";
      end if;
    elsif (funct = SLTIU or funct = SLTUr) then
      if (UNSIGNED(left) < UNSIGNED(right)) then control_data <= "10";
      else control_data <= "11";
      end if;
    --ELSE control_data <= NULL;
    END IF;
  end process;
END ARCHITECTURE behavior;

