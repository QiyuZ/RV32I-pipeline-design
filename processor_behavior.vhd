--
-- VHDL Architecture lab1_lib.processor.behavior
--
-- Created:
--          by - iceco.UNKNOWN (DESKTOP-V8M1DDA)
--          at - 21:44:21 2018/04/18
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY processor IS
  port(clock, reset : IN std_ulogic);
END ENTITY processor;

--
--naming rule: name+?->?   g means a group of value; t : tracker: R :reg file; s : memory system
ARCHITECTURE behavior OF processor IS
  ------------fetch-----------
  signal instr_fd, address_fa, jaddr_ef, mdata_af : std_ulogic_vector(31 DOWNTO 0);
  signal jmp_ef: std_ulogic;
  signal stall_tf : std_ulogic := '0';
  signal stall_mf : std_ulogic := '0';
  signal stall_af : std_ulogic := '0';
  signal read_fm : std_ulogic;
  ------------decode----------
  signal dataA_rd, dataB_rd, left_de, right_de, extra_de : std_ulogic_vector(31 DOWNTO 0);
  signal rs1_dr, rs2_dr, rd_de : std_ulogic_vector(4 DOWNTO 0);
  signal func_de : RV32I_Op;
  signal rs1v_dt, rs2v_dt, rdv_dt : std_ulogic;
  ------------execute---------
  signal data_em, address_em : std_ulogic_vector(31 DOWNTO 0);
  signal rd_em : std_ulogic_vector(4 DOWNTO 0);
  signal func_em : RV32I_Op;
  ------------memory----------
  signal data_sm, address_ma, data_ma, data_mw : std_ulogic_vector(31 DOWNTO 0);
  signal delay_sm, read_ma, write_ma : std_ulogic;
  signal rd_mw : std_ulogic_vector(4 DOWNTO 0);
  signal func_mw : RV32I_Op;
  ------------wb--------------
  signal rd_wr : std_ulogic_vector(4 DOWNTO 0);
  signal data_wr : std_ulogic_vector(31 DOWNTO 0);
  signal write_wr : std_ulogic;
  --------------arbiter--------
  signal address_as : std_ulogic_vector(31 DOWNTO 0); 
BEGIN
  ---------------------fetch------------------------------
  fetch : entity work.Fetch(Structure)
    port map(Jaddr => jaddr_ef, Mdata => mdata_af, Address => address_fa, Inst => instr_fd, Clock=>clock, Jmp=>jmp_ef, read => read_fm, Reset=>reset, Delay=>(stall_af or stall_tf or stall_mf));
  ----------------------decode------------------------------
  decoder : entity work.decoderp(s)
    port map (instruction => instr_fd, pc => address_fa, rfda => dataA_rd, rfdb => dataB_rd, left => left_de, right => right_de, extra => extra_de, jump=>jmp_ef,
            rfaa => rs1_dr, rfab => rs2_dr, dest => rd_de, func => func_de, clock => clock, rs1v => rs1v_dt, rs2v => rs2v_dt, rdv => rdv_dt, stall => (stall_tf or stall_mf));
  ----------------------execute-----------------------------
  execut : entity work.Execute(Structure)
    port map (left => left_de, right => right_de, extra => extra_de, rd => rd_de, funct => func_de, clock => clock, stall => stall_mf, data => data_em, address => address_em, 
              jaddr => jaddr_ef, dest => rd_em, dest_fun => func_em, jump => jmp_ef);
  ----------------------memory------------------------------
  memory : entity work.Memory(Behavior)
    port map(data => data_em, address => address_em, data_in => data_sm, funct => func_em, rd => rd_em, mdelay => delay_sm, clock =>clock, address_m => address_ma, 
            data_out => data_ma, data_w => data_mw, dest => rd_mw, dest_funct => func_mw, stall => stall_mf, read => read_ma, write => write_ma);
  ----------------------write back--------------------------
  wb : entity work.write_back(behavior)
    port map(rd => rd_mw, funct => func_mw, data => data_mw, clock => clock, dest => rd_wr, output => data_wr, write => write_wr);
  ----------------------Reg files---------------------------
  reg_file : entity work.Reg_file(Behavior)
    port map(addressA => rs1_dr, addressB => rs2_dr, rd => rd_wr, data => data_wr, clock => clock, write => write_wr, dataA => dataA_rd, dataB => dataB_rd);
  ----------------------Reg tracker-------------------------
  tracker : entity work.Reg_tracker(Behavior)
    port map(addressA => rs1_dr, addressB => rs2_dr, rd => rd_de, wa => rd_wr, readA => rs1v_dt, readB => rs2v_dt, reserve => rdv_dt, free => write_wr, clock => clock, stall => stall_tf);
  ----------------------arbiter-----------------------------
  reg_arbiter : entity work.arbiter(Behavior)
    port map(address_fm => address_ma, read => read_ma, write => write_ma, address_ff => address_fa, data_tf => mdata_af, control => stall_af, address_tm => address_as, data_ta => data_sm); --data_tm => , data_ta
  -----------------------system-----------------------------
  system : entity work.MemorySystem(Behavior)
    port map(Addr => address_as, DataIn => data_ma, clock => clock, we => write_ma, re => read_ma or read_fm, mdelay => delay_sm, DataOut => data_sm);
END ARCHITECTURE behavior;

