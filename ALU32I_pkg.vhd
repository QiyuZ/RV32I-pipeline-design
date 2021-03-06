--
-- VHDL Package Header lab1_lib.ALU32I
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 21:48:56 2018/03/22
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE std.textio.all;

PACKAGE ALU32I IS
  ATTRIBUTE enum_encoding : string;
  TYPE ALU_Op IS (aADD, aSUB, aAND, aOR, aXOR, sSL, aSRL, sSRA);
-- note that the shifts are parameterized to shift different numbers of bits
  ATTRIBUTE enum_encoding OF ALU_Op : type is "000 001 010 011 100 101 110 111";
  SUBTYPE Func_Name IS STRING(4 DOWNTO 1);
  FUNCTION Ftype(Func : Func_Name) RETURN ALU_Op;
END ALU32I;
