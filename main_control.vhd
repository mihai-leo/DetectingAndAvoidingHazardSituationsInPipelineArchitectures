----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 01:51:16 PM
-- Design Name: 
-- Module Name: main_control - Behavioral
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

entity main_control is
  Port ( 
  instr3: in std_logic_vector(2 downto 0);
  
  jump: out std_logic;
  memtoreg: out std_logic;
  regwrite: out std_logic;
  memwrite: out std_logic;
  branch: out std_logic;
  aluop: out std_logic_vector(2 downto 0);
  alusrc: out std_logic;
  regdst: out std_logic;
  extop: out std_logic

  );
end main_control;

architecture Behavioral of main_control is
begin
process(instr3)
begin
aluop<=instr3;
case instr3 is
    when "000" =>-- r type
        regdst<='1';
        extop <='0';
        alusrc<='0';
        branch<='0';
        jump  <='0';
        memwrite<='0';
        memtoreg<='0';
        regwrite<='1';
    when "001" => -- xori
        regdst<='0';
        extop <='1';
        alusrc<='1';
        branch<='0';
        jump  <='0';
        memwrite<='0';
        memtoreg<='0';
        regwrite<='1';
    when "010" => -- andi
        regdst<='0';
        extop <='1';
        alusrc<='1';
        branch<='0';
        jump  <='0';
        memwrite<='0';
        memtoreg<='0';
        regwrite<='1';
    when "011" => --ori
        regdst<='0';
        extop <='1';
        alusrc<='1';
        branch<='0';
        jump  <='0';
        memwrite<='0';
        memtoreg<='0';
        regwrite<='1';
     when "100" => --lw
        regdst<='0';
        extop <='1';
        alusrc<='1';
        branch<='0';
        jump  <='0';
        memwrite<='0';
        memtoreg<='1';
        regwrite<='1';
     when "101" => --sw
        regdst<='0';
        extop <='1';
        alusrc<='1';
        branch<='0';
        jump  <='0';
        memwrite<='1';
        memtoreg<='0';
        regwrite<='0';
     when "110" => -- beq
        regdst<='0';
        extop <='1';
        alusrc<='0';
        branch<='1';
        jump  <='0';
        memwrite<='0';
        memtoreg<='0';
        regwrite<='0';
     when "111" => --jump
        regdst<='0';
        extop <='1';
        alusrc<='0';
        branch<='0';
        jump  <='1';
        memwrite<='0';
        memtoreg<='0';
        regwrite<='0';
    when others =>
        regdst<='0';
        extop <='0';
        alusrc<='0';
        branch<='0';
        jump  <='0';
        memwrite<='0';
        memtoreg<='0';
        regwrite<='0';
    
end case;         
end process;
end Behavioral;
