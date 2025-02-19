----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2024 11:45:02 PM
-- Design Name: 
-- Module Name: instruction_fetch - Behavioral
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

entity instruction_fetch is
  Port (        clk: in std_logic;
        branchA: in std_logic_vector(15 downto 0);
        jumpA: in std_logic_vector(15 downto 0);
        jump: in std_logic;
        PCSrc: in std_logic;
        en: in std_logic;
        reset: in std_logic;
        instruction: out std_logic_vector(15 downto 0);
        PC1: out std_logic_vector(15 downto 0));
end instruction_fetch;

architecture Behavioral of instruction_fetch is
component pc is
  Port (
    		CLK		: in	STD_LOGIC;					
		RESET		: in	STD_LOGIC;			
		DATA_IN		: in	STD_LOGIC_VECTOR(15 downto 0);	
		DATA_OUT	: out	STD_LOGIC_VECTOR(15 downto 0)	
		 );
end component;
component instruction_memory is
 Port ( 
  clk: in std_logic;
  en: in std_logic;
  address: in std_logic_vector(15 downto 0);
  instruction: out std_logic_vector(15 downto 0)
  );
 end component; 
 signal mux1,mux2 : std_logic_vector(15 downto 0):= (others => '0');
 signal address,address1 : std_logic_vector (15 downto 0):= (others => '0');
begin
--m1: process(brancha,address1,pcsrc)
--    begin
--    if pcsrc = '1' then 
--        mux1<=brancha;
--    else
--        mux1<=address1;
--    end if;
--    end process;
--m2: process(jumpa,mux1,jump)
--    begin
--    if jump = '1' then 
--        mux2<=jumpa;
--    else
--        mux2<=mux1;
--    end if;
--    end process;
mux1<=brancha when pcsrc= '1' else address1;
mux2<= jumpa when jump='1' else mux1;
pcounr: pc port map(clk,reset,mux2,address);
im: instruction_memory port map (clk,en,address,instruction);
address1<=address+x"0001";
pc1<=address1;

end Behavioral;
