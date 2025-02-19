----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 04:39:27 PM
-- Design Name: 
-- Module Name: ex_mem - Behavioral
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

entity ex_mem is
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
end ex_mem;

architecture Behavioral of ex_mem is
  signal memtoreg_reg   : std_logic := '0';
  signal regwrite_reg   : std_logic := '0';
  signal memwrite_reg   : std_logic := '0';
  signal branch_reg     : std_logic := '0';
  signal branchA_reg    : std_logic_vector(15 downto 0) := (others => '0');
  signal aluRes_reg     : std_logic_vector(15 downto 0) := (others => '0');
  signal zero_reg       : std_logic := '0';
  signal wd_mem_reg     : std_logic_vector(15 downto 0) := (others => '0');
  signal wa_reg         : std_logic_vector(2 downto 0) := (others => '0');

begin

 process(clk)
  begin
    if rising_edge(clk) then
      memtoreg_reg   <= memtoreg_in;
      regwrite_reg   <= regwrite_in;
      memwrite_reg   <= memwrite_in;
      branch_reg     <= branch_in;
      branchA_reg    <= branchA_in;
      aluRes_reg     <= aluRes_in;
      zero_reg       <= zero_in;
      wd_mem_reg     <= wd_mem_in;
      wa_reg         <= wa_in;
    end if;
  end process;
  memtoreg_out   <= memtoreg_reg;
  regwrite_out   <= regwrite_reg;
  memwrite_out   <= memwrite_reg;
  branch_out     <= branch_reg;
  branchA_out    <= branchA_reg;
  aluRes_out     <= aluRes_reg;
  zero_out       <= zero_reg;
  wd_mem_out     <= wd_mem_reg;
  wa_out         <= wa_reg;

end Behavioral;
