----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2024 10:59:56 PM
-- Design Name: 
-- Module Name: instruction_memory - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_memory is
 Port ( 
  clk: in std_logic;
  en: in std_logic;
  address: in std_logic_vector(15 downto 0);
  instruction: out std_logic_vector(15 downto 0)
  );
end instruction_memory;
architecture Behavioral of instruction_memory is
type ROM is array(0 to 65536) of std_logic_vector(15 downto 0);
signal memory:ROM:= (
"0000000000000001",
"0000000000000001",
"1000010101111111",--lw $2 = MEM[$1-1]
"1000010111111110",--lw $3=MEM[$1-2]
"0000100111000011",--add $4=$2+$3
"1010011000000000",--sw $4=MEM[$1]		
"0000011110010011",--add $1=$1+$7		
"1100101101111010",--bneq $2 $6 -5
others=>x"0001");


begin
process(en,clk)--
begin
if(en='1') then
    if falling_edge(CLK) then
            instruction<=memory(conv_integer(address));
     end if;
end if;
end process;

end Behavioral;
