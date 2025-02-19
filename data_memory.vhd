----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 03:52:09 PM
-- Design Name: 
-- Module Name: data_memory - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_memory is
  Port (
    clk: in std_logic;
    address: in std_logic_vector(15 downto 0);
    wd: in std_logic_vector(15 downto 0);
    memwrite: in std_logic;
    rd:  out std_logic_vector(15 downto 0));
end data_memory;

architecture Behavioral of data_memory is
type rammem is array(0 to 65536) of std_logic_vector(15 downto 0);
signal ram: rammem:=(
x"0001",
x"0002",
x"0003",
x"0004",
x"0005",
x"0006",
x"0007",
x"0008",
x"0009",
x"000A",
x"000B",
x"000C",
x"000D",
x"000E",
x"000F",
others =>x"0000"
);
begin
process(clk,memwrite)
begin
if falling_edge(CLK) then
    if(memwrite='1') then
        ram(conv_integer(address))<=wd;
     end if;
end if;
rd<=ram(conv_integer(address));
end process;

end Behavioral;
