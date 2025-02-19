----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 12:30:57 AM
-- Design Name: 
-- Module Name: instruction_decode - Behavioral
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

entity instruction_decode is
  Port (
  clk: in std_logic;
  instruction: in std_logic_vector(15 downto 0);
  pc1: in std_logic_vector(15 downto 0);
  wd: in std_logic_vector(15 downto 0);
  wa: in std_logic_vector(2 downto 0);
  regwrite: in std_logic;
  extop: in std_logic;
  
  jumpa: out std_logic_vector(15 downto 0);
  pc1_out: out std_logic_vector(15 downto 0);
  rd1: out std_logic_vector(15 downto 0);
  rd2: out std_logic_vector(15 downto 0);
  ext_imm: out std_logic_vector(15 downto 0);
  func: out std_logic_vector(2 downto 0);
  rs:out std_logic_vector(2 downto 0);
  wa0:out std_logic_vector(2 downto 0);
  wa1: out std_logic_vector(2 downto 0);
  sa: out std_logic );
end instruction_decode;

architecture Behavioral of instruction_decode is
component reg_file is
  Port ( 
     clk : in std_logic;
     regwrite : in std_logic;
    ra1 : in std_logic_vector (2 downto 0);
    ra2 : in std_logic_vector (2 downto 0);
    wa : in std_logic_vector (2 downto 0);
    wd : in std_logic_vector (15 downto 0);
   
    rd1 : out std_logic_vector (15 downto 0);
    rd2 : out std_logic_vector (15 downto 0)
  );
end component ;
signal rda1,rda2: std_logic_vector(2 downto 0):=(others =>'0');


begin
rf: reg_file port map(clk,regwrite,rda1,rda2,wa,wd,rd1,rd2);
jumpa<=pc1(15 downto 13)&instruction(12 downto 0);
rda1<=instruction(12 downto 10);
rs<=instruction(12 downto 10);
rda2<=instruction(9 downto 7);
wa0<=instruction(9 downto 7);
wa1<=instruction(6 downto 4);
ext_imm<="000000000"&instruction(6 downto 0) when extop='0' else--ext unit
    "000000000"&instruction(6 downto 0) when instruction(6)='0' else "111111111"&instruction(6 downto 0) ;
pc1_out<=pc1;
func<=instruction(2 downto 0);
sa<=instruction(3);
end Behavioral;
