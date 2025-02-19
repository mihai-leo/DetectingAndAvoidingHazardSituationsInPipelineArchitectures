----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 02:17:17 PM
-- Design Name: 
-- Module Name: alu_control - Behavioral
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

entity alu_control is
  Port (
  func:in std_logic_vector(2 downto 0);
  aluop:in std_logic_vector(2 downto 0);
  alucont:out std_logic_vector(3 downto 0)
   );
end alu_control;

architecture Behavioral of alu_control is

begin
process(func,aluop)--alu contorl
begin
case (aluop) is
    when "000"=>
        case(func) is
            when "000" => alucont<="0000"; --xor
            when "001" => alucont<="0001"; --and
            when "010" => alucont<="0010"; --or
            when "011" => alucont<="0011"; --add
            when "100" => alucont<="0100"; --sub
            when "101" => alucont<="0101"; --sll
            when "110" => alucont<="0110"; --srl
            when "111" => alucont<="0111"; --sra
            when others=> alucont<="0000";
        end case;
    when "001" => alucont<="0000"; --xori
    when "010" => alucont<="0001"; --andi
    when "011" => alucont<="0010"; --ori
    when "100" => alucont<="0011"; --lw
    when "101" => alucont<="0011"; --sw
    when "110" => alucont<="1000"; --beq
    when others=> alucont<="1111"; --jump
end case;
end process;

end Behavioral;
