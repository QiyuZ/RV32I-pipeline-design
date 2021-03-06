--
-- VHDL Architecture lab1_lib.Decoder.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 22:56:58 2018/02/22
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY Decoder IS
  PORT( instruction : IN std_ulogic_vector(31 DOWNTO 0);
        Funct : OUT RV32I_Op; -- Refer to package for enumeration type definition
        RS1, RS2, RD : OUT std_ulogic_vector(4 DOWNTO 0); -- Register IDs
        RS1v, RS2v, RDv : OUT std_ulogic; -- Valid indicators for Register IDs
        Immediate : OUT std_ulogic_vector(31 DOWNTO 0)); -- Immediate value
END ENTITY;

--
ARCHITECTURE Behavior OF Decoder IS

BEGIN
  Process (instruction)
    variable op :std_ulogic_vector(4 downto 0);
    variable two :std_ulogic_vector(1 downto 0);
    variable func3 :std_ulogic_vector(2 downto 0);
    variable func7 :std_ulogic_vector(6 downto 0);
  begin
    func3 := instruction(14 downto 12);
    func7 := instruction(31 downto 25);
    op := instruction(6 downto 2);
    two := instruction(1 downto 0);
    if (two = "11") then 
      if (op = RV32I_OP_LUI) then
        Funct <= LUI;
        Immediate <= instruction(31 downto 12)&"000000000000";
        RS1v <= '0';
        RS2v <= '0';
        RDv <= '1';
      elsif (op = RV32I_OP_AUIPC) then
        Funct <= AUIPC;
        Immediate <= instruction(31 downto 12)&"000000000000";
        RS1v <= '0';
        RS2v <= '0';
        RDv <= '1';
      elsif (op = RV32I_OP_JAL) then
        Funct <= JAL;
        Immediate(20 downto 0) <= instruction(31 downto 31)&instruction(19 downto 12)&instruction(20 downto 20)&instruction(30 downto 21);
        Immediate(31 downto 21) <= (others => instruction(31));
        RS1v <= '0';
        RS2v <= '0';
        RDv <= '1';
      elsif (op = RV32I_OP_JALR) then
        Funct <= JALR;
        Immediate(11 downto 0) <= instruction(31 downto 20);
        Immediate(31 downto 21) <= (others => instruction(31));
        RS1v <= '1';
        RS2v <= '0';
        RDv <= '1';
      elsif (op = RV32I_OP_BRANCH) then
        Immediate(12 downto 0) <= instruction(31 downto 31)&instruction(7 downto 7)&instruction(30 downto 25)&instruction(11 downto 8)&'0';
        Immediate(31 downto 13) <= (others => instruction(31));
        RS1v <= '1';
        RS2v <= '1';
        RDv <= '0';
        if (func3 = RV32I_FN3_BRANCH_EQ) then Funct <= BEQ;
        elsif (func3 = RV32I_FN3_BRANCH_NE) then Funct <= BNE;
        elsif (func3 = RV32I_FN3_BRANCH_GEU) then Funct <= BGEU;
        elsif (func3 = RV32I_FN3_BRANCH_LT) then Funct <= BLT;
        elsif (func3 = RV32I_FN3_BRANCH_GE) then Funct <= BGE;
        elsif (func3 = RV32I_FN3_BRANCH_LTU) then Funct <= BLTU;
        end if;
      elsif (op = RV32I_OP_LOAD) then
        Immediate(11 downto 0) <= instruction(31 downto 20);
        Immediate(31 downto 12) <= (others => instruction(31));
        RS1v <= '1';
        RS2v <= '0';
        RDv <= '1';
        if (func3 = RV32I_FN3_LOAD_B) then Funct <= LB;
        elsif (func3 = RV32I_FN3_LOAD_H) then Funct <= LH;
        elsif (func3 = RV32I_FN3_LOAD_W) then Funct <= LW;
        elsif (func3 = RV32I_FN3_LOAD_B) then Funct <= LB;
        elsif (func3 = RV32I_FN3_LOAD_BU) then Funct <= LBU;
        elsif (func3 = RV32I_FN3_LOAD_HU) then Funct <= LHU;
        end if;
      elsif (op = RV32I_OP_STORE) then
        Immediate(11 downto 0) <= instruction(31 downto 25)&instruction(11 downto 7);
        Immediate(31 downto 12) <= (others => instruction(31));
        RS1v <= '1';
        RS2v <= '1';
        RDv <= '0';
        if (func3 = RV32I_FN3_STORE_B) then Funct <= SB;
        elsif (func3 = RV32I_FN3_STORE_H) then Funct <= SH;
        elsif (func3 = RV32I_FN3_STORE_W) then Funct <= SW;
        end if;
      elsif (op = RV32I_OP_ALUI) then
        RS1v <= '1';
        RS2v <= '0';
        RDv <= '1';
        if (func3 = RV32I_FN3_ALU_SRL or func3 = RV32I_FN3_ALU_SRA or func3 = RV32I_FN3_ALU_SLL) then
          Immediate(4 downto 0) <= instruction(24 downto 20);
          Immediate(31 downto 5) <= (others => instruction(31));
          if (func3 = RV32I_FN3_ALU_SLL) then Funct <= SLLI;
          elsif (func3 = RV32I_FN3_ALU_SRL and func7 = RV32I_FN7_ALU) then Funct <= SRLI;
          elsif (func3 = RV32I_FN3_ALU_SRA and func7 = RV32I_FN7_ALU_SA) then Funct <= SRAI;
          end if;
        else
          Immediate(11 downto 0) <= instruction(31 downto 20);
          Immediate(31 downto 12) <= (others => instruction(31));
          if (func3 = RV32I_FN3_ALU_ADD) then Funct <= ADDI;
          elsif (func3 = RV32I_FN3_ALU_SLT) then Funct <= SLTI;
          elsif (func3 = RV32I_FN3_ALU_SLTU) then Funct <= SLTIU;
          elsif (func3 = RV32I_FN3_ALU_XOR) then Funct <= XORI;
          elsif (func3 = RV32I_FN3_ALU_OR) then Funct <= ORI;
          elsif (func3 = RV32I_FN3_ALU_AND) then Funct <= ANDI;
          end if;
        end if;
      elsif (op = RV32I_OP_ALU) then
        Immediate <= ZEROS_32;
        RS1v <= '1';
        RS2v <= '1';
        RDv <= '1';
        if (func3 = RV32I_FN3_ALU_ADD and func7 = RV32I_FN7_ALU) then Funct <= ADDr;
        elsif (func3 = RV32I_FN3_ALU_SUB and func7 = RV32I_FN7_ALU_SUB) then Funct <= SUBr;
        elsif (func3 = RV32I_FN3_ALU_SLL and func7 = RV32I_FN7_ALU_SUB) then Funct <= SLLr;
        elsif (func3 = RV32I_FN3_ALU_SLT and func7 = RV32I_FN7_ALU) then Funct <= SLTr;
        elsif (func3 = RV32I_FN3_ALU_SLTU and func7 = RV32I_FN7_ALU) then Funct <= SLTUr;
        elsif (func3 = RV32I_FN3_ALU_XOR and func7 = RV32I_FN7_ALU) then Funct <= XORr;
        elsif (func3 = RV32I_FN3_ALU_SRL and func7 = RV32I_FN7_ALU) then Funct <= SRLr;
        elsif (func3 = RV32I_FN3_ALU_SRA and func7 = RV32I_FN7_ALU_SA) then Funct <= SRAr;
        elsif (func3 = RV32I_FN3_ALU_OR and func7 = RV32I_FN7_ALU) then Funct <= ORr;
        elsif (func3 = RV32I_FN3_ALU_AND and func7 = RV32I_FN7_ALU) then Funct <= ANDr;
        end if;
      else
        Funct <= BAD;
        RS1v <= '0';
        RS2v <= '0';
        RDv <= '0';
      end if;
    else
      Funct <= BAD;
      RS1v <= '0';
      RS2v <= '0';
      RDv <= '0';
    end if;
    RS1 <= instruction(19 downto 15);
    RS2 <= instruction(24 downto 20);
    RD <= instruction(11 downto 7);
  end process;
END ARCHITECTURE Behavior;

