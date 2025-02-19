----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2024 10:51:50 PM
-- Design Name: 
-- Module Name: forwording_unit - Behavioral
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

entity forwording_unit is
  Port (
  clk:in std_logic;
  ra1: in std_logic_vector(2 downto 0);
  ra2: in std_logic_vector(2 downto 0);
  wa1: in std_logic_vector(2 downto 0);
  wa2: in std_logic_vector(2 downto 0);
  wc1:in std_logic;
  wc2:in std_logic;
  ct1: out std_logic_vector(1 downto 0);
  ct2: out std_logic_vector (1 downto 0)
   );
end forwording_unit;

architecture Behavioral of forwording_unit is

begin
ct1<="01" when ra1=wa2 and wc2='1' else "10" when ra1=wa1 and wc1='1' else "00";
ct2<="01" when ra2=wa2 and wc2='1' else "10" when ra2=wa1 and wc1='1' else "00";

end Behavioral;
