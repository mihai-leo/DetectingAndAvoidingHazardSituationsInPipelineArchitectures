----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2024 11:04:19 PM
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

component control_v5 is
--component pipe is
  Port ( 
  clk: in std_logic;
  en: in std_logic;
  reset: in std_logic;
  
  instruction_output: out std_logic_vector(15 downto 0);
  rd1_output: out std_logic_vector(15 downto 0);
  rd2_output: out std_logic_vector(15 downto 0);
  alures_output: out std_logic_vector(15 downto 0);
  wb_output: out std_logic_vector(15 downto 0);
    mem_output: out std_logic_vector(15 downto 0);
      wd_mem_output: out std_logic_vector(15 downto 0)

  );
end component;

    -- Signals to connect to the UUT
 signal clk         : std_logic := '0';

     signal  pc: std_logic_vector(15 downto 0);
   signal instruction:  std_logic_vector(15 downto 0);
   signal rd1: std_logic_vector(15 downto 0);
  signal rd2:  std_logic_vector(15 downto 0);
   signal alures: std_logic_vector(15 downto 0);
   signal wb_data:  std_logic_vector(15 downto 0);
   signal   mem:  std_logic_vector(15 downto 0);



begin
--pp: pipe port map(clk,'1','0',instruction,rd1,rd2,alures,wb_data,mem,pc);
pp: control_v5 port map(clk,'1','0',instruction,rd1,rd2,alures,wb_data,mem,pc);
--pp: p port map(clk,en,reset,instruction,rd1,rd2,alures,wb,mem,wd_mem);
    STIM_PROC: process
    begin
      clk<='1';
       wait for 1 ns;
      clk<='0';
       wait for 1 ns;
      clk<='1';
       wait for 1 ns;
      clk<='0';
       wait for 1 ns;
      clk<='1';
    end process;

end Behavioral;