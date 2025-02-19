----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 05:01:32 PM
-- Design Name: 
-- Module Name: pipe - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_v4 is
  Port ( 
  clk: in std_logic;
  en: in std_logic;
  reset: in std_logic;
  
  instruction_output: out std_logic_vector(15 downto 0);
  rd1_output: out std_logic_vector(15 downto 0);
  rd2_output: out std_logic_vector(15 downto 0);
  alures_output: out std_logic_vector(15 downto 0);
  wb_output: out std_logic_vector(15 downto 0);
  mem_output: out std_logic_vector(15 downto 0);
  wd_mem_output: out std_logic_vector(15 downto 0)
  );
end control_v4;

architecture Behavioral of control_v4 is
component instruction_fetch2 is
  Port (        clk: in std_logic;
        predict:in std_logic_vector(15 downto 0);
        branchA: in std_logic_vector(15 downto 0);
        jumpA: in std_logic_vector(15 downto 0);
        branch: in std_logic;
        jump: in std_logic;
        PCSrc: in std_logic;
        msb1: in std_logic;
        en: in std_logic;
        reset: in std_logic;
        instruction: out std_logic_vector(15 downto 0);
        PC1: out std_logic_vector(15 downto 0));
end component;

component instruction_decode is
  Port (
  clk: in std_logic;
  instruction: in std_logic_vector(15 downto 0);
  pc1: in std_logic_vector(15 downto 0);
  wd: in std_logic_vector(15 downto 0);
  wa: in std_logic_vector(2 downto 0);
  regwrite: in std_logic;
  extop: in std_logic;
  
  jumpa: out std_logic_vector(15 downto 0);
  pc1_out: out std_logic_vector(15 downto 0);
  rd1: out std_logic_vector(15 downto 0);
  rd2: out std_logic_vector(15 downto 0);
  ext_imm: out std_logic_vector(15 downto 0);
  func: out std_logic_vector(2 downto 0);
  wa0:out std_logic_vector(2 downto 0);
  wa1: out std_logic_vector(2 downto 0);
  sa: out std_logic );
  
  end component;

component main_control is
  Port ( 
  instr3: in std_logic_vector(2 downto 0);
  
  jump: out std_logic;
  memtoreg: out std_logic;
  regwrite: out std_logic;
  memwrite: out std_logic;
  branch: out std_logic;
  aluop: out std_logic_vector(2 downto 0);
  alusrc: out std_logic;
  regdst: out std_logic;
  extop: out std_logic

  );
end component;

component execution is
  Port (
  pc1: in std_logic_vector(15 downto 0);
  rd1: in std_logic_vector(15 downto 0);
  rd2: in std_logic_vector(15 downto 0);
  ext_imm: in std_logic_vector(15 downto 0);
  func: in std_logic_vector(2 downto 0);
  wa0:in std_logic_vector(2 downto 0);
  wa1: in std_logic_vector(2 downto 0);
  sa: in std_logic;
  
  aluop:in std_logic_vector(2 downto 0);
  alusrc: in std_logic;
  regdst: in std_logic;
 
  branchA: out std_logic_vector(15 downto 0);
  aluRes: out std_logic_vector(15 downto 0);
  zero: out std_logic;
  wd_mem: out std_logic_vector(15 downto 0);
  wa:out std_logic_vector(2 downto 0)

   );
end component;

component memory is
  Port (
  
    clk: in std_logic;
    alures: in std_logic_vector(15 downto 0);
    zero:in std_logic;
    wd_mem: in std_logic_vector(15 downto 0);
    wa_in: in std_logic_vector(2 downto 0);
    branch: in std_logic;
    memwrite: in std_logic;
    
    pcsrc: out std_logic;
    rd_mem:  out std_logic_vector(15 downto 0);
    alures_out:  out std_logic_vector(15 downto 0) ;
    wa_out: out std_logic_vector(2 downto 0)
  );
end component;


component if_id is
  Port (
  clk: in std_logic;
  pc1_in: in std_logic_vector(15 downto 0);
  instruction_in: in std_logic_vector(15 downto 0);
    pc1_out: out std_logic_vector(15 downto 0);
  instruction_out: out std_logic_vector(15 downto 0)
   );
end component;

component id_ex is
  Port ( 
  clk: in std_logic;
  
  memtoreg_in:in std_logic;
  regwrite_in:in std_logic;
  
  memwrite_in:in std_logic;
  branch_in:in std_logic;
  
  aluop_in:in std_logic_vector(2 downto 0);
  alusrc_in:in std_logic;
  regdst_in:in std_logic;
  
  pc1_in: in std_logic_vector(15 downto 0);
  rd1_in: in std_logic_vector(15 downto 0);
  rd2_in: in std_logic_vector(15 downto 0);
  ext_imm_in: in std_logic_vector(15 downto 0);
  func_in: in std_logic_vector(2 downto 0);
  wa0_in: in std_logic_vector(2 downto 0);
  wa1_in: in std_logic_vector(2 downto 0);
  sa_in: in std_logic ;
  
    memtoreg_out  : out std_logic;
    regwrite_out  : out std_logic;
    memwrite_out  : out std_logic;
    branch_out    : out std_logic;
    aluop_out     : out std_logic_vector(2 downto 0);
    alusrc_out    : out std_logic;
    regdst_out    : out std_logic;
    pc1_out       : out std_logic_vector(15 downto 0);
    rd1_out       : out std_logic_vector(15 downto 0);
    rd2_out       : out std_logic_vector(15 downto 0);
    ext_imm_out   : out std_logic_vector(15 downto 0);
    func_out      : out std_logic_vector(2 downto 0);
    wa0_out       : out std_logic_vector(2 downto 0);
    wa1_out       : out std_logic_vector(2 downto 0);
    sa_out        : out std_logic
  
  );
end component;

component ex_mem is
 Port (
   clk: in std_logic;
  
  memtoreg_in:in std_logic;
  regwrite_in:in std_logic;
  
  memwrite_in:in std_logic;
  branch_in:in std_logic;
  
  branchA_in: in std_logic_vector(15 downto 0);
  aluRes_in: in std_logic_vector(15 downto 0);
  zero_in: in std_logic;
  wd_mem_in: in std_logic_vector(15 downto 0);
  wa_in:in std_logic_vector(2 downto 0);
  
   memtoreg_out   : out std_logic;
   regwrite_out   : out std_logic;
   memwrite_out   : out std_logic;
   branch_out     : out std_logic;
   branchA_out    : out std_logic_vector(15 downto 0);
   aluRes_out     : out std_logic_vector(15 downto 0);
   zero_out       : out std_logic;
   wd_mem_out     : out std_logic_vector(15 downto 0);
   wa_out         : out std_logic_vector(2 downto 0)
  );
end component;

component mem_wb is
  Port (
  clk: in std_logic;
  
  memtoreg_in:in std_logic;
  regwrite_in:in std_logic;
  
    rd_mem_in:  in std_logic_vector(15 downto 0);
    alures_out_in:  in std_logic_vector(15 downto 0) ;
    wa_int: in std_logic_vector(2 downto 0);
    
    memtoreg_out       : out std_logic;
    regwrite_out       : out std_logic;
    rd_mem_out         : out std_logic_vector(15 downto 0);
    alures_out_out         : out std_logic_vector(15 downto 0);
    wa_out             : out std_logic_vector(2 downto 0)
   );
end component;
component forwording_unit is
  Port (
  clk:in std_logic;
  ra1: in std_logic_vector(2 downto 0);
  ra2: in std_logic_vector(2 downto 0);
  wa1: in std_logic_vector(2 downto 0);
  wa2: in std_logic_vector(2 downto 0);
  ct1: out std_logic_vector(1 downto 0);
  ct2: out std_logic_vector (1 downto 0)
   );
end component;

component ff_3bit is
 Port ( 
   clk: in std_logic;
   t:in std_logic_vector(2 downto 0);
    q: out std_logic_vector(2 downto 0)
    );
end component;
component fu_muxes is
  Port ( 
  
  rd1: in std_logic_vector(15 downto 0);
  rd2: in std_logic_vector(15 downto 0);
  wd1: in std_logic_vector(15 downto 0);
  wd2: in std_logic_vector(15 downto 0);
  ct1: in std_logic_vector(1 downto 0); 
  ct2: in std_logic_vector(1 downto 0); 

  out1: out std_logic_vector(15 downto 0);
  out2: out std_logic_vector(15 downto 0)

  );
end component;
component load_init is
  Port (
    clk: in std_logic;
  memtoreg: in std_logic;
    opcode: in std_logic_vector(2 downto 0);
  rd1: in std_logic_vector(2 downto 0);
  rd2: in std_logic_vector(2 downto 0);
  wd: in std_logic_vector(2 downto 0);
  

  en: out std_logic 
   
   );
end component;
component predictor_2_bit is
 Port ( 
   clk: in std_logic;
  en: in std_logic;
  reset: in std_logic;
  taken: in std_logic;
  predict: out std_logic
  
 );
end component;
component branch_init is
  Port ( 
    clk: in std_logic;
    opcode: in std_logic_vector(2 downto 0);
  rd1: in std_logic_vector(2 downto 0);
  rd2: in std_logic_vector(2 downto 0);
  wd: in std_logic_vector(2 downto 0);
  

  en: out std_logic 
  );
end component;

component compare_branch is
  Port (
        clk:in std_logic;
  ra1: in std_logic_vector(2 downto 0);
  ra2: in std_logic_vector(2 downto 0);
  wa: in std_logic_vector(2 downto 0);
  rd1: in std_logic_vector(15 downto 0);
  rd2: in std_logic_vector(15 downto 0);
  wd: in std_logic_vector(15 downto 0);
  en: out std_logic
   );
end component;
component history_table is
 Port ( 
    clk: in std_logic;
    en: in std_logic;
    inc: in std_logic;
    ra: in std_logic_vector(15 downto 0);
    wd: in std_logic_vector(15 downto 0);
    msb: out std_logic;
    msb1: out std_logic;
    rd: out std_logic_vector(15 downto 0)
    
     );
end component;
signal   jump,memtoreg,regwrite,memwrite,branch,alusrc,regdst,extop  ,memtoreg1,regwrite1,memwrite1,branch1,alusrc1,regdst1  ,memtoreg2,regwrite2,memwrite2,branch2  ,memtoreg3,regwrite3: std_logic :='0';
signal aluop,aluop1: std_logic_vector(2 downto 0):=(others =>'0');
signal instruction,  instruction_lc,instruction_lc0,pc_lc0  ,pc1,pc11,pc1_out,pc1_out1  ,fu_mux1,fu_mux2: std_logic_vector(15 downto 0):=(others =>'0');
signal jumpa,brancha, brancha_bp,brancha_bp2,brancha1,rd1,rd2,rd11,rd21,ext_imm,ext_imm1  ,alures,alures1,alures_out,alures_out1,  wd_mem,wd_mem1,rd_mem,rd_mem1,  wd_reg: std_logic_vector(15 downto 0):=(others =>'0');
signal func,wa0,wa1,func1,wa01,wa11  , wa_reg,wa_reg1,wa_reg_out,wa_reg_out1  ,rs: std_logic_vector(2 downto 0):=(others =>'0');
signal sa,sa1 ,zero,zero1,  pcsrc,  pcsrc_bp,   noop_ct, noop2_ct,noop3_ct, loud_ct, branch_ct, compare, flush : std_logic:='0'; 
signal msb,msb1: std_logic;
signal ct1,ct2: std_logic_vector(1 downto 0):=(others =>'0');
signal instruction1, predict:std_logic_vector(15 downto 0):=(others =>'U');
signal taken: std_logic:='0';

begin

--inf: instruction_fetch port map(clk,brancha1,jumpa,jump,pcsrc,en,reset,instruction,pc1);
inf: instruction_fetch2 port map(clk,predict,brancha_bp,jumpa,branch,jump,pcsrc_bp,msb1,en,reset,instruction,pc1);
ifid: if_id port map(clk,pc_lc0,instruction_lc0,pc11,instruction_lc);
mc: main_control port map(instruction1(15 downto 13),jump,memtoreg,regwrite,memwrite,branch,aluop,alusrc,regdst,extop);
ind: instruction_decode port map(clk,instruction1,pc11,wd_reg,wa_reg_out1,regwrite3,extop,jumpa,pc1_out,rd1,rd2,ext_imm,func,wa0,wa1,sa);
idex: id_ex port map (clk,memtoreg,regwrite,memwrite,branch,aluop,alusrc,regdst,pc1_out,rd1,rd2,ext_imm,func,wa0,wa1,sa, memtoreg1,regwrite1,memwrite1,branch1,aluop1,alusrc1,regdst1,pc1_out1,rd11,rd21,ext_imm1,func1,wa01,wa11,sa1);
ex: execution port map(pc1_out1,fu_mux1,fu_mux2,ext_imm1,func1,wa01,wa11,sa1, aluop1,alusrc1,regdst1, brancha,alures,zero,wd_mem,wa_reg);
exmem: ex_mem port map(clk,memtoreg1,regwrite1,memwrite1,branch1,brancha,alures,zero,wd_mem,wa_reg  ,memtoreg2,regwrite2,memwrite2,branch2,  brancha1,alures1,zero1,wd_mem1,wa_reg1);
mem: memory port map(clk,alures1,zero1,wd_mem1,wa_reg1,branch2,memwrite2,  pcsrc,rd_mem,alures_out,wa_reg_out  );
memwx: mem_wb port map(clk,memtoreg2,regwrite2,rd_mem,alures_out,wa_reg_out,  memtoreg3,regwrite3, rd_mem1,alures_out1,wa_reg_out1 );
wd_reg<=rd_mem1 when memtoreg3 = '1' else alures_out1;

ff: ff_3bit port map(clk,instruction1(12 downto 10),rs);
fuex: forwording_unit port map(clk,rs,wa01,wa_reg1,wa_reg_out1,ct1,ct2);
fumux: fu_muxes port map (rd11,rd21,alures_out,wd_reg,ct1,ct2,fu_mux1,fu_mux2);
noop_ct<=loud_ct or branch_ct ;
noop2_ct<= loud_ct and branch_ct;--add case for ld op beq
li: load_init port map(clk,memtoreg1,instruction_lc(15 downto 13),instruction_lc(12 downto 10),instruction_lc(9 downto 7),wa01,loud_ct);
bc: branch_init port map(clk,instruction_lc(15 downto 13),instruction_lc(12 downto 10),instruction_lc(9 downto 7),wa_reg,branch_ct);

comp: compare_branch port map(clk,instruction1(12 downto 10),instruction1(9 downto 7),wa_reg1,rd1,rd2,alures_out,compare);
pcsrc_bp<= compare and branch;



brancha_bp<=ext_imm+pc11+x"0001" when (pcsrc_bp='1' and msb1='1') else ext_imm+pc11;
brancha_bp2<=ext_imm+pc11;

noop3_ct<=msb1 and flush and branch;


ht: history_table  port map(clk,branch,compare,pc1,brancha_bp2,msb,msb1,predict);
flush<=(pcsrc_bp xor msb1) ;

instruction1 <= "111" & pc11(12 downto 0)-x"0001" when noop2_ct='1'  else "111" & pc11(12 downto 0) when noop_ct = '1' else instruction_lc; -- add jump for loud
instruction_lc0 <=x"0001" when instruction_lc(15 downto 13)="111" or noop2_ct='1' or flush='1' else instruction_lc when noop_ct = '1' else instruction; -- add the instruction bach into thhe sistem
pc_lc0 <= pc11 when noop_ct = '1' else pc1;

  instruction_output<=instruction1;
  rd1_output<=fu_mux1;
  rd2_output<=fu_mux2;
  alures_output<=instruction;--alures;
  wb_output<=pc1;--wd_reg;
  mem_output<=predict;
  wd_mem_output<="000"&pcsrc_bp&"000"&msb1&"000"&flush&"000"&branch;
end Behavioral;
