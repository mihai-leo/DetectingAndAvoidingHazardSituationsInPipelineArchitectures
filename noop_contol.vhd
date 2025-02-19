----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2024 02:50:38 PM
-- Design Name: 
-- Module Name: noop_control - Behavioral
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

entity noop_control is
  Port ( 
    loud_ct : in std_logic;
    branch_ct : in std_logic;
    flush: in std_logic;
    pc1: in std_logic_vector(15 downto 0);
    pc11: in std_logic_vector(15 downto 0);
    instruction: in std_logic_vector(15 downto 0);
    instruction_c: in std_logic_vector(15 downto 0);
    instruction1: out std_logic_vector(15 downto 0);
    instruction_c0: out std_logic_vector(15 downto 0);
    pc_c0: out std_logic_vector(15 downto 0)
  );
end noop_control;

architecture Behavioral of noop_control is
signal noop_ct,noop2_ct:std_logic:='0';
begin
noop_ct<=loud_ct or branch_ct ;
noop2_ct<= loud_ct and branch_ct;--add case for ld op beq
instruction1 <= "111" & pc11(12 downto 0)-x"0001" when noop2_ct='1'  else "111" & pc11(12 downto 0) when noop_ct = '1' else instruction_c; -- add jump for loud
instruction_c0 <=x"0001" when instruction_c(15 downto 13)="111" or noop2_ct='1' or flush='1' else instruction_c when noop_ct = '1' else instruction; -- add the instruction bach into thhe sistem
pc_c0 <= pc11 when noop_ct = '1' else pc1;


end Behavioral;
