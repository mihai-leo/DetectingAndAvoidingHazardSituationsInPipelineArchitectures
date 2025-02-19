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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipe is
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
end pipe;

architecture Behavioral of pipe is
component instruction_fetch is
  Port (        clk: in std_logic;
        branchA: in std_logic_vector(15 downto 0);
        jumpA: in std_logic_vector(15 downto 0);
        jump: in std_logic;
        PCSrc: in std_logic;
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
  rs:out std_logic_vector(2 downto 0);
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
  rs_in: in std_logic_vector(2 downto 0);
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
    rs_out       : out std_logic_vector(2 downto 0);
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

signal   jump,memtoreg,regwrite,memwrite,branch,alusrc,regdst,extop  ,memtoreg1,regwrite1,memwrite1,branch1,alusrc1,regdst1  ,memtoreg2,regwrite2,memwrite2,branch2  ,memtoreg3,regwrite3: std_logic :='0';
signal aluop,aluop1: std_logic_vector(2 downto 0):=(others =>'0');
signal instruction,instruction1,pc1,pc11,pc1_out,pc1_out1: std_logic_vector(15 downto 0):=(others =>'0');
signal jumpa,brancha,brancha1,rd1,rd2,rd11,rd21,ext_imm,ext_imm1  ,alures,alures1,alures_out,alures_out1,  wd_mem,wd_mem1,rd_mem,rd_mem1,  wd_reg: std_logic_vector(15 downto 0):=(others =>'0');
signal func,wa0,wa1,func1,wa01,wa11  , wa_reg,wa_reg1,wa_reg_out,wa_reg_out1 , rs,rs1: std_logic_vector(2 downto 0):=(others =>'0');
signal sa,sa1 ,zero,zero1,  pcsrc: std_logic:='0'; 
begin

inf: instruction_fetch port map(clk,brancha1,jumpa,jump,pcsrc,en,reset,instruction,pc1);
ifid: if_id port map(clk,pc1,instruction,pc11,instruction1);
mc: main_control port map(instruction1(15 downto 13),jump,memtoreg,regwrite,memwrite,branch,aluop,alusrc,regdst,extop);
ind: instruction_decode port map(clk,instruction1,pc11,wd_reg,wa_reg_out1,regwrite3,extop,jumpa,pc1_out,rd1,rd2,ext_imm,func,rs,wa0,wa1,sa);
idex: id_ex port map (clk,memtoreg,regwrite,memwrite,branch,aluop,alusrc,regdst,pc1_out,rd1,rd2,ext_imm,func,rs,wa0,wa1,sa, memtoreg1,regwrite1,memwrite1,branch1,aluop1,alusrc1,regdst1,pc1_out1,rd11,rd21,ext_imm1,func1,rs1,wa01,wa11,sa1);
ex: execution port map(pc1_out1,rd11,rd21,ext_imm1,func1,wa01,wa11,sa1, aluop1,alusrc1,regdst1, brancha,alures,zero,wd_mem,wa_reg);
exmem: ex_mem port map(clk,memtoreg1,regwrite1,memwrite1,branch1,brancha,alures,zero,wd_mem,wa_reg  ,memtoreg2,regwrite2,memwrite2,branch2,  brancha1,alures1,zero1,wd_mem1,wa_reg1);
mem: memory port map(clk,alures1,zero1,wd_mem1,wa_reg1,branch2,memwrite2,  pcsrc,rd_mem,alures_out,wa_reg_out  );
memwx: mem_wb port map(clk,memtoreg2,regwrite2,rd_mem,alures_out,wa_reg_out,  memtoreg3,regwrite3, rd_mem1,alures_out1,wa_reg_out1 );
wd_reg<=rd_mem1 when memtoreg3 = '1' else alures_out1;

  instruction_output<=instruction1;
  rd1_output<=rd11;
  rd2_output<=rd21;
  alures_output<=alures1;
  wb_output<=wd_reg;
  mem_output<=ext_imm;
  wd_mem_output<=pc1;
end Behavioral;
