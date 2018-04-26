--
-- VHDL Package Body lab1_lib.ALU32I
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 11:27:42 2018/03/23
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
PACKAGE BODY ALU32I IS
    
  FUNCTION Ftype(Func : Func_Name) RETURN ALU_Op IS
    VARIABLE ret : ALU_Op;
  BEGIN
    CASE Func IS
      WHEN "aADD" => ret := aADD;
      WHEN "aSUB" => ret := aSUB;
      WHEN "aOR-" => ret := aOR;
      WHEN "aXOR" => ret := aXOR;
      WHEN "sSL-" => ret := sSL;
      WHEN "aSRL" => ret := aSRL;
      WHEN "sSRA" => ret := sSRA;
      when "aAND" => ret := aAND;
      WHEN OTHERS => ret := aADD;
    END CASE;
    RETURN ret;
  END;
  
END ALU32I;
