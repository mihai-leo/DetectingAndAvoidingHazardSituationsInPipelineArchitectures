----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2024 06:44:32 PM
-- Design Name: 
-- Module Name: branch_init - Behavioral
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

entity branch_init is
  Port ( 
    clk: in std_logic;
    opcode: in std_logic_vector(2 downto 0);
  rd1: in std_logic_vector(2 downto 0);
  rd2: in std_logic_vector(2 downto 0);
  wd: in std_logic_vector(2 downto 0);
  

  en: out std_logic 
  );
end branch_init;

architecture Behavioral of branch_init is
signal p,aux: std_logic;
begin
aux<='0' when opcode /="110" or p='1' else '1' when ((rd1=wd) or (rd2=wd)) else '0';  
process (clk)
begin
    if rising_edge (clk ) then
        p<=aux;
    end if;
    end process;
en<=aux;
end Behavioral;
