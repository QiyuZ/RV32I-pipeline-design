--
-- VHDL Architecture lab1_lib.Fetch_test.Testbench
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 21:30:54 2018/02/15
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE std.textio.all;
USE work.all;


ENTITY Fetch_test IS
END ENTITY Fetch_test;

--
ARCHITECTURE Testbench OF Fetch_test IS
  FILE test_vectors : text open read_mode is "fetch_tb.txt";
  signal Jaddr, Mdata : std_ulogic_vector(31 DOWNTO 0);
  signal Address, Inst, Addressv, Insv: std_ulogic_vector(31 DOWNTO 0);
  signal Clock, Jmp, Reset, Delay : std_ulogic;
  signal Read0, Readv : std_ulogic;
  SIGNAL vecno : NATURAL := 0;
BEGIN
  
  DUV : Entity work.Fetch1(Behavior)
    generic map(width => 32)
    port map(Jaddr=>Jaddr, Mdata=>Mdata, Address=>Address, Inst=>Inst,
     Clock=>Clock, Jmp=>Jmp, Reset=>Reset, Delay=>Delay, Read=>Read0);
   ----------------------------  
  Stim : PROCESS
    variable L : LINE;
    variable Ja, Md, Ad, Ins : std_ulogic_vector(31 DOWNTO 0);
    variable Jp, Rst, Dly : std_ulogic;
    variable Rd : std_ulogic;
    BEGIN
      Clock <= '0';
      wait for 40 ns;
      --readline(test_vectors, L);
      while not endfile(test_vectors) loop
        readline(test_vectors, L);
        read(L, Rst);
        Reset <= Rst;
        read(L, Jp);
        Jmp <= Jp;
        read(L, Dly);
        Delay <= Dly;
        read(L, Md);
        Mdata <= Md;
        read(L, Ja);
        Jaddr <= Ja;
        read(L, Ad);
        Addressv <= Ad;
        read(L, Ins);
        Insv <= Ins;
        read(L, Rd);
        Readv <= Rd;
        wait for 10 ns;
        Clock <= '1';
        wait for 40 ns;
        Clock <= '0';
        wait for 50 ns;
      end loop;
      report "That's it";
      std.env.finish;
    end process;
    -------------------------
    Check : process(Clock)
    begin
      if (falling_edge(Clock)) then
        ASSERT Address = Addressv
        REPORT "ERROR: Address Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
        ASSERT Inst = Insv
        REPORT "ERROR: Inst Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
        ASSERT Read0 = Readv
        REPORT "ERROR: Read0 Incorrect output for vector " & to_string(vecno)
        SEVERITY WARNING;
        vecno <= vecno + 1;
      END IF;
    END PROCESS;
    
END ARCHITECTURE Testbench;

