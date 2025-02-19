----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2024 03:10:42 PM
-- Design Name: 
-- Module Name: predictor_2_bit - Behavioral
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

entity predictor_2_bit is
 Port ( 
   clk: in std_logic;
  en: in std_logic;
  reset: in std_logic;
  taken: in std_logic;
  predict: out std_logic
  
 );
end predictor_2_bit;

architecture Behavioral of predictor_2_bit is
signal state: std_logic_vector(1 downto 0):=("01");
begin
 process(clk)
  begin
    if rising_edge(clk) and en='1' then
        if taken = '1' then
            case state is
                when "00" => state<="01";
                when "01" => state<="11";
                when "10" => state<="11";
                when "11" => state<="11";
                when others => state<="10";
             end case;
        elsif taken='0' then 
            case state is
                when "00" => state<="00";
                when "01" => state<="00";
                when "10" => state<="00";
                when "11" => state<="10";
                when others => state<="10";
            end case;
        end if;
    end if;
  end process;
predict<=state(1);
end Behavioral;
