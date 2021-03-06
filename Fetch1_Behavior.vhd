--
-- VHDL Architecture lab1_lib.Fetch1.Behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 19:10:40 2018/02/11
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Fetch1 IS
  GENERIC(width : NATURAL RANGE 1 TO 64 := 32);
  PORT( Jaddr, Mdata : IN std_ulogic_vector(width - 1 DOWNTO 0);
  Address, Inst : OUT std_ulogic_vector(width - 1 DOWNTO 0);
  Clock, Jmp, Reset, Delay : IN std_ulogic;
  Read : OUT std_ulogic);
END ENTITY Fetch1;

--
ARCHITECTURE Behavior OF Fetch1 IS
  signal NOP :std_ulogic_vector(width - 1 downto 0):= "00000000000000000000000000010011";
  signal JR, DJR:std_ulogic;
BEGIN
  process(Clock)
    variable in0, out0 : UNSIGNED(31 downto 0);
    begin
      if (Reset = '1') then in0 := "00000000000000000000000000000000";
      elsif (Jmp = '1') then in0 := UNSIGNED(Jaddr);
      elsif ((Reset = '0') and (Jmp = '0')) then in0 := out0 + 4;
      end if;
      if (rising_edge(Clock)) then
        if(Delay = '0') then out0 := in0;
        end if;
      end if;
      Address <= std_ulogic_vector(out0);
  end process;
  
  process (Reset,Jmp,Delay)
  begin
    --JR <= Jmp or Reset;
    --DJR <= JR or Delay;
    if(Jmp or Delay or Reset) then 
      Inst<=NOP;
    else Inst <= Mdata;
    end if;
  end process;
  Read <= not(Reset or Jmp);
  
END ARCHITECTURE Behavior;

