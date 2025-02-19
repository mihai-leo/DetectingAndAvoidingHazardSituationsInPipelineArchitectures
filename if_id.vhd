----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 04:24:30 PM
-- Design Name: 
-- Module Name: if_id - Behavioral
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

entity if_id is
  Port (
  clk: in std_logic;
  pc1_in: in std_logic_vector(15 downto 0);
  instruction_in: in std_logic_vector(15 downto 0);
    pc1_out: out std_logic_vector(15 downto 0);
  instruction_out: out std_logic_vector(15 downto 0)
   );
end if_id;

architecture Behavioral of if_id is
  signal pc1_reg         : std_logic_vector(15 downto 0) := (others => '0');
  signal instruction_reg : std_logic_vector(15 downto 0) := (others => '0');

begin
  process(clk)
  begin
    if rising_edge(clk) then
      pc1_reg <= pc1_in;               
      instruction_reg <= instruction_in; 
    end if;
  end process;


  pc1_out        <= pc1_reg;
  instruction_out <= instruction_reg;

end Behavioral;