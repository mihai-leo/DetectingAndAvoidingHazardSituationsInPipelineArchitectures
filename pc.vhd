----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2024 10:45:00 PM
-- Design Name: 
-- Module Name: pc - Behavioral
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

entity pc is
  Port (
    		CLK		: in	STD_LOGIC;					
		RESET		: in	STD_LOGIC;			
		DATA_IN		: in	STD_LOGIC_VECTOR(15 downto 0);	
		DATA_OUT	: out	STD_LOGIC_VECTOR(15 downto 0)	
		 );
end pc;

architecture Behavioral of pc is

begin
	process(CLK,RESET,DATA_IN)
		begin
			if(RESET = '1') then
				DATA_OUT <= (others => '0');
			elsif rising_edge(CLK) then
				DATA_OUT <= DATA_IN;
			end if;
		end process; 

end Behavioral;
