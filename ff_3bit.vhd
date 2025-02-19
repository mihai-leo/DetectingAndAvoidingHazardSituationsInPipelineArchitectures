----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2024 11:29:28 PM
-- Design Name: 
-- Module Name: ff_3bit - Behavioral
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

entity ff_3bit is
 Port ( 
   clk: in std_logic;
   t:in std_logic_vector(2 downto 0);
    q: out std_logic_vector(2 downto 0)
    );
end ff_3bit;

architecture Behavioral of ff_3bit is
  signal aux       : std_logic_vector(2 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if rising_edge(clk) then
      aux<=t;
      end if;
  end process;
q<=aux;
end Behavioral;
