----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2024 05:28:37 PM
-- Design Name: 
-- Module Name: forwording_unit_bp - Behavioral
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

entity forwording_unit_bp is
  Port ( 
      clk:in std_logic;
  ra1: in std_logic_vector(2 downto 0);
  ra2: in std_logic_vector(2 downto 0);
  wa: in std_logic_vector(2 downto 0);
  ct1: out std_logic;
  ct2: out std_logic
  );
end forwording_unit_bp;

architecture Behavioral of forwording_unit_bp is

begin
ct1<= '1' when ra1=wa else '0';
ct2<= '1' when ra2=wa else '0';

end Behavioral;
