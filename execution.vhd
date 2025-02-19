----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 02:45:10 PM
-- Design Name: 
-- Module Name: execution - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity execution is
  Port (
  pc1: in std_logic_vector(15 downto 0);
  rd1: in std_logic_vector(15 downto 0);
  rd2: in std_logic_vector(15 downto 0);
  ext_imm: in std_logic_vector(15 downto 0);
  func: in std_logic_vector(2 downto 0);
  wa0:in std_logic_vector(2 downto 0);
  wa1: in std_logic_vector(2 downto 0);
  sa: in std_logic;
  
  aluop:in std_logic_vector(2 downto 0);
  alusrc: in std_logic;
  regdst: in std_logic;
 
  branchA: out std_logic_vector(15 downto 0);
  aluRes: out std_logic_vector(15 downto 0);
  zero: out std_logic;
  wd_mem: out std_logic_vector(15 downto 0);
  wa:out std_logic_vector(2 downto 0)

   );
end execution;

architecture Behavioral of execution is
component alu_control is
  Port (
  func:in std_logic_vector(2 downto 0);
  aluop:in std_logic_vector(2 downto 0);
  alucont:out std_logic_vector(3 downto 0)
   );
end component;
component alu is
 Port (
  rd1: in std_logic_vector(15 downto 0);
  rd2: in std_logic_vector(15 downto 0);
  alucont: in std_logic_vector(3 downto 0);
  sa: in std_logic;
  zero: out std_logic;
  alures: out  std_logic_vector(15 downto 0)
  );
end component;
signal mux: std_logic_vector(15 downto 0);
signal alucont: std_logic_vector(3 downto 0);

begin
brancha<=pc1+ext_imm;--adder

mux<=rd2 when alusrc='0' else ext_imm;
cont: alu_control port map(func,aluop,alucont);
al: alu port map(rd1,mux,alucont,sa,zero,alures);
wd_mem<=rd2;
wa<= wa0 when regdst='0' else wa1;
end Behavioral;
