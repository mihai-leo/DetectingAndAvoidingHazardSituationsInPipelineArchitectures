----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2024 12:25:44 AM
-- Design Name: 
-- Module Name: fu_muxes - Behavioral
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

entity fu_muxes is
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
end fu_muxes;

architecture Behavioral of fu_muxes is

begin
out1<=wd2 when ct1="01" else wd1 when ct1="10" else rd1;
out2<=wd2 when ct2="01" else wd1 when ct2="10" else rd2;

end Behavioral;
