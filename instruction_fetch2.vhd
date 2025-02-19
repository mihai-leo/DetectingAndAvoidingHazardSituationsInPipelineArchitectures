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


entity instruction_fetch2 is
  Port (        clk: in std_logic;
        predict:in std_logic_vector(15 downto 0);
        branchA: in std_logic_vector(15 downto 0);
        jumpA: in std_logic_vector(15 downto 0);
        branch: in std_logic;
        jump: in std_logic;
        PCSrc: in std_logic;
        msb1: in std_logic;
        en: in std_logic;
        reset: in std_logic;
        instruction: out std_logic_vector(15 downto 0);
        PC1: out std_logic_vector(15 downto 0));
end instruction_fetch2;

architecture Behavioral of instruction_fetch2 is
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
 signal mux1,mux2,mux3 : std_logic_vector(15 downto 0):= (others => '0');
 signal address,address1,address2,brancha_bp : std_logic_vector (15 downto 0):= (others => '0');
 signal predict1: std_logic_vector(15 downto 0):=(others=>'0');
begin

process(clk)
begin
    if rising_edge(clk) then
        predict1<=predict;
     end if;
end process;
brancha_bp<=brancha+x"0001" when (pcsrc='1' and msb1='1') else brancha;-- predict 

mux1<=brancha_bp when pcsrc= '1' else mux3;
mux2<= jumpa when jump='1' else mux1;
mux3<=address when msb1='1' else predict when branch='1'  else address1;

pcounr: pc port map(clk,reset,mux2,address);
im: instruction_memory port map (clk,en,address2,instruction);
address2<= predict1 when branch='1'  else address;
address1<=address+x"0001";
pc1<=address1;


end Behavioral;
