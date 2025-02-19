----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 04:03:46 PM
-- Design Name: 
-- Module Name: memory - Behavioral
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

entity memory is
  Port (
  
    clk: in std_logic;
    alures: in std_logic_vector(15 downto 0);
    zero:in std_logic;
    wd_mem: in std_logic_vector(15 downto 0);
    wa_in: in std_logic_vector(2 downto 0);
    branch: in std_logic;
    memwrite: in std_logic;
    
    pcsrc: out std_logic;
    rd_mem:  out std_logic_vector(15 downto 0);
    alures_out:  out std_logic_vector(15 downto 0) ;
    wa_out: out std_logic_vector(2 downto 0)
  );
end memory;

architecture Behavioral of memory is
component data_memory is
  Port (
    clk: in std_logic;
    address: in std_logic_vector(15 downto 0);
    wd: in std_logic_vector(15 downto 0);
    memwrite: in std_logic;
    rd:  out std_logic_vector(15 downto 0));
end component;

begin
pcsrc<= branch and zero;
datam: data_memory port map(clk,alures,wd_mem,memwrite,rd_mem);
alures_out<=alures;
wa_out<=wa_in;
end Behavioral;
