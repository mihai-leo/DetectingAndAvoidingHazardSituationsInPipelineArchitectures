----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2024 02:01:28 AM
-- Design Name: 
-- Module Name: load_init - Behavioral
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

entity load_init is
  Port (
  clk: in std_logic;
  memtoreg: in std_logic;
  opcode: in std_logic_vector(2 downto 0);
  rd1: in std_logic_vector(2 downto 0);
  rd2: in std_logic_vector(2 downto 0);
  wd: in std_logic_vector(2 downto 0);
  

  en: out std_logic 
   
   );
end load_init;

architecture Behavioral of load_init is
begin
en<='0' when memtoreg ='0' else '1' when ((rd1=wd) and opcode/="000") else '1' when ((rd1=wd) or (rd2=wd)) else '0';  

end Behavioral;
