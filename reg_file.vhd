----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 12:20:45 AM
-- Design Name: 
-- Module Name: reg_file - Behavioral
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
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_file is
  Port ( 
     clk : in std_logic;
     regwrite : in std_logic;
    ra1 : in std_logic_vector (2 downto 0);
    ra2 : in std_logic_vector (2 downto 0);
    wa : in std_logic_vector (2 downto 0);
    wd : in std_logic_vector (15 downto 0);
   
    rd1 : out std_logic_vector (15 downto 0);
    rd2 : out std_logic_vector (15 downto 0)
  );
end reg_file;

architecture Behavioral of reg_file is
type reg_array is array (0 to 7) of std_logic_vector(15 downto 0);
signal reg_file : reg_array:=(
	x"0000",--0
	x"0002",--1
	x"0004",--2
	x"0006",--3
	x"0008",
	x"000A",
	x"0059",
	x"0001",
	others => x"0000"
);
begin

  process(clk,regwrite)
  begin
    if falling_edge(clk) then
      if regwrite = '1' then
      	reg_file(conv_integer(wa)) <= wd;
      end if;
    end if;
  end process;
  rd1 <= reg_file(conv_integer(ra1));
  rd2 <= reg_file(conv_integer(ra2));
end Behavioral;
