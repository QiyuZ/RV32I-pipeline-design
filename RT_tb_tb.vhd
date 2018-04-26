--
-- VHDL Architecture lab1_lib.RT_tb.tb
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 22:00:47 2018/04/13
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE std.textio.all;

ENTITY RT_tb IS
END ENTITY RT_tb;

--
ARCHITECTURE tb OF RT_tb IS
  FILE test_vectors : text open read_mode is "RT_tb.txt";
  signal addressA, addressB, rd, wa : std_ulogic_vector(4 DOWNTO 0);
  signal readA, readB, reserve, free, clock : std_ulogic;
  signal stall0, stall1 : std_ulogic;
  SIGNAL vecno : NATURAL := 0;
BEGIN
  DUV : Entity work.Reg_tracker(Behavior)
    port map(addressA => addressA, addressB => addressB, rd => rd, wa => wa,
      clock => clock, readA => readA, readB => readB, reserve => reserve, free => free, stall => stall0);
  -----------------------------------------------
  Stim : PROCESS
     variable L : LINE;
     variable ada, adb,rdval, wval : std_ulogic_vector(4 DOWNTO 0);
     variable ra, rb, rs, f, st : std_ulogic;
     BEGIN
      Clock <= '0';
      wait for 40 ns;
      readline(test_vectors, L);
      while not endfile(test_vectors) loop
        readline(test_vectors, L);
        read(L, ada);
        addressA <= ada;
        read(L, adb);
        addressB <= adb;
        read(L, rdval);
        rd <= rdval;
        read(L, wval);
        wa <= wval;
        read(L, ra);
        readA <= ra;
        read(L, rb);
        readB <= rb;
        read(L, rs);
        reserve <= rs;
        read(L, f);
        free <= f;
        read(L, st);
        stall1 <= st;
        wait for 10 ns;
        Clock <= '1';
        wait for 40 ns;
        Clock <= '0';
        wait for 50 ns;
      end loop;
      report "That's it";
      std.env.finish;
    end process;
    -----------------------------
    Check : process(Clock)
    begin
      if (falling_edge(Clock)) then
        ASSERT stall0 = stall1
        REPORT "ERROR: stall Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
        vecno <= vecno + 1;
      END IF;
    END PROCESS;
END ARCHITECTURE tb;

