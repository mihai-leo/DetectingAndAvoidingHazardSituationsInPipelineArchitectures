----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 08:50:14 PM
-- Design Name: 
-- Module Name: stack_3 - Behavioral
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

entity stack_3 is
  Port (
  clk: in std_logic;
  
  addr: in std_logic_vector(15 downto 0);
  out1: out std_logic_vector(15 downto 0);
  out2: out std_logic_vector(15 downto 0);
  out3: out std_logic_vector(15 downto 0)
   );
end stack_3;

architecture Behavioral of stack_3 is
signal aux1,aux2,aux3: std_logic_vector(15 downto 0):=(others=>'0');
begin
p1: process(clk,addr)
begin
    if falling_edge(CLK) then
    aux1<=addr;
    aux2<=aux1;
    aux3<=aux2;
    end if;
end process;
out1<=aux1;
out2<=aux2;
out3<=aux3;
end Behavioral;
