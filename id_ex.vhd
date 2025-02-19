----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 04:32:24 PM
-- Design Name: 
-- Module Name: id_ex - Behavioral
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

entity id_ex is
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
end id_ex;

architecture Behavioral of id_ex is
  signal memtoreg_reg  : std_logic := '0';
  signal regwrite_reg  : std_logic := '0';
  signal memwrite_reg  : std_logic := '0';
  signal branch_reg    : std_logic := '0';
  signal aluop_reg     : std_logic_vector(2 downto 0) := (others => '0');
  signal alusrc_reg    : std_logic := '0';
  signal regdst_reg    : std_logic := '0';
  signal pc1_reg       : std_logic_vector(15 downto 0) := (others => '0');
  signal rd1_reg       : std_logic_vector(15 downto 0) := (others => '0');
  signal rd2_reg       : std_logic_vector(15 downto 0) := (others => '0');
  signal ext_imm_reg   : std_logic_vector(15 downto 0) := (others => '0');
  signal func_reg      : std_logic_vector(2 downto 0) := (others => '0');
  signal rs_reg       : std_logic_vector(2 downto 0) := (others => '0');
  signal wa0_reg       : std_logic_vector(2 downto 0) := (others => '0');
  signal wa1_reg       : std_logic_vector(2 downto 0) := (others => '0');
  signal sa_reg        : std_logic := '0';
begin

  process(clk)
  begin
    if rising_edge(clk) then
      memtoreg_reg  <= memtoreg_in;
      regwrite_reg  <= regwrite_in;
      memwrite_reg  <= memwrite_in;
      branch_reg    <= branch_in;
      aluop_reg     <= aluop_in;
      alusrc_reg    <= alusrc_in;
      regdst_reg    <= regdst_in;
      pc1_reg       <= pc1_in;
      rd1_reg       <= rd1_in;
      rd2_reg       <= rd2_in;
      ext_imm_reg   <= ext_imm_in;
      func_reg      <= func_in;
      rs_reg       <= rs_in;
      wa0_reg       <= wa0_in;
      wa1_reg       <= wa1_in;
      sa_reg        <= sa_in;
    end if;
  end process;

  memtoreg_out  <= memtoreg_reg;
  regwrite_out  <= regwrite_reg;
  memwrite_out  <= memwrite_reg;
  branch_out    <= branch_reg;
  aluop_out     <= aluop_reg;
  alusrc_out    <= alusrc_reg;
  regdst_out    <= regdst_reg;
  pc1_out       <= pc1_reg;
  rd1_out       <= rd1_reg;
  rd2_out       <= rd2_reg;
  ext_imm_out   <= ext_imm_reg;
  func_out      <= func_reg;
  rs_out       <= rs_reg;
  wa0_out       <= wa0_reg;
  wa1_out       <= wa1_reg;
  sa_out        <= sa_reg;

end Behavioral;
