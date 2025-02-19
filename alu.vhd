----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 02:21:45 PM
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
 Port (
  rd1: in std_logic_vector(15 downto 0);
  rd2: in std_logic_vector(15 downto 0);
  alucont: in std_logic_vector(3 downto 0);
  sa: in std_logic;
  zero: out std_logic;
  alures: out  std_logic_vector(15 downto 0)
  );
end alu;

architecture Behavioral of alu is
 signal zero_aux: std_logic :='0';
 signal alu:std_logic_vector(15 downto 0) :=(others =>'1');
begin
zero<=zero_aux;
alures<=alu;
process(alucont,rd1,rd2)
begin
case (alucont) is   
    when "0000" => alu<=rd1 xor rd2;zero_aux<='0'; -- xor and xori
    when "0001" => alu<=rd1 and rd2;zero_aux<='0'; -- and and and1
    when "0010" => alu<=rd1 or rd2;zero_aux<='0'; -- or and ori
    when "0011" => alu<=rd1 + rd2;zero_aux<='0'; -- ad and lw,sw
    when "0100" => alu<=rd1 - rd2;zero_aux<='0'; -- sub and sub i
    when "0101" => if(sa='0') then --sll
                   alu<=rd1;
                   else
                   alu<=rd1(14 downto 0) & "0";
                   end if; 
                   zero_aux<='0';
    when "0110" => if(sa='0') then --srl
                   alu<=rd1;
                   else
                   alu<="0" & rd1(15 downto 1);
                   end if; 
                   zero_aux<='0';
    when "0111" => if(sa='0') then --sra
                   alu<=rd1;
                   else
                   alu<=rd1(15) & rd1(15 downto 1);
                   end if; 
                   zero_aux<='0';
    when "1000" => if(rd1=rd2) then --beq
                   alu<=x"1111";
                   zero_aux<='0';
                   else
                   alu<=x"1111";
                   zero_aux<='1';
                   end if;
    when others=> alu<=rd2;
end case;
end process;

end Behavioral;
