--
-- VHDL Architecture lab1_lib.control_memory.behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 16:41:34 2018/04/ 4
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.ALU32I.all;
USE work.RV32I.all;

ENTITY control_memory IS
  port (funct : IN RV32I_Op;
        mdelay: IN std_ulogic;
        control_w, control_r, control_s : OUT std_ulogic;
        control_type : OUT std_ulogic_vector(1 DOWNTO 0));
END ENTITY control_memory;

--
ARCHITECTURE behavior OF control_memory IS
  signal control_wv, control_rv, control_sv : std_ulogic := '0';
BEGIN
  PROCESS (mdelay)
  begin
    if (mdelay = '1') then control_sv <= '1';
    else control_sv <= '0';
    end if;
  end process;
  control_s <= control_sv;
  ------------------------------------------
  process (funct)
  begin
    if (funct = LB or funct = LH or funct =  LW or funct = LBU or funct = LHU) then
      control_rv <= '1';
      control_wv <= '0';
      if (funct = LB or funct = LBU) then control_type <= "00";
      elsif (funct = LH or funct = LHU) then control_type <= "01";
      elsif (funct = LW) then control_type <= "10";
      end if;
    elsif (funct = SB or funct = SH or funct = SW) then
      control_rv <= '0';
      control_wv <= '1';
      if (funct = SB) then control_type <= "00";
      elsif (funct = SH) then control_type <= "01";
      elsif (funct = SW) then control_type <= "10";
      end if;
    else
      control_rv <= '0';
      control_wv<= '0';
    end if;
    end process;
    control_r <= control_rv;
    control_w <= control_wv;
END ARCHITECTURE behavior;

