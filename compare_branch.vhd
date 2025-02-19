----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2024 08:56:48 PM
-- Design Name: 
-- Module Name: compare_branch - Behavioral
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

entity compare_branch is
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
end compare_branch;

architecture Behavioral of compare_branch is

component forwording_unit_bp is
  Port ( 
      clk:in std_logic;
  ra1: in std_logic_vector(2 downto 0);
  ra2: in std_logic_vector(2 downto 0);
  wa: in std_logic_vector(2 downto 0);
  ct1: out std_logic;
  ct2: out std_logic
  );
end component;
signal ct1,ct2: std_logic:='0';
signal mux1,mux2: std_logic_vector(15 downto 0);
begin
fu: forwording_unit_bp port map(clk,ra1,ra2,wa,ct1,ct2);
mux1<= wd when ct1='1' else rd1;
mux2<= wd when ct2='1' else rd2;
en<= '1' when mux1/=mux2 else '0';
end Behavioral;
