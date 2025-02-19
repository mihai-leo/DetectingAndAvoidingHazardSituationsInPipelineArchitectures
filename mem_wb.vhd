----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 04:44:38 PM
-- Design Name: 
-- Module Name: mem_wb - Behavioral
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

entity mem_wb is
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
end mem_wb;

architecture Behavioral of mem_wb is
  signal memtoreg_reg   : std_logic := '0';
  signal regwrite_reg   : std_logic := '0';
  signal rd_mem_reg     : std_logic_vector(15 downto 0) := (others => '0');
  signal alures_out_reg : std_logic_vector(15 downto 0) := (others => '0');
  signal wa_reg         : std_logic_vector(2 downto 0) := (others => '0');

begin
  process(clk)
  begin
    if rising_edge(clk) then
      memtoreg_reg   <= memtoreg_in;
      regwrite_reg   <= regwrite_in;
      rd_mem_reg     <= rd_mem_in;
      alures_out_reg <= alures_out_in;
      wa_reg         <= wa_int;
    end if;
  end process;

  memtoreg_out       <= memtoreg_reg;
  regwrite_out       <= regwrite_reg;
  rd_mem_out         <= rd_mem_reg;
  alures_out_out         <= alures_out_reg;
  wa_out             <= wa_reg;

end Behavioral;
