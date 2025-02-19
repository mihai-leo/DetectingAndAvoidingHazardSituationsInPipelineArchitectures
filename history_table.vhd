----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2024 08:15:51 AM
-- Design Name: 
-- Module Name: history_table - Behavioral
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

entity history_table is
 Port ( 
    clk: in std_logic;
    en: in std_logic;
    inc: in std_logic;
    ra: in std_logic_vector(15 downto 0);
    wd: in std_logic_vector(15 downto 0);
    msb: out std_logic;
    msb1: out std_logic;
    rd: out std_logic_vector(15 downto 0)
    
     );
end history_table;

architecture Behavioral of history_table is
type ROM1 is array(0 to 65536) of std_logic_vector(15 downto 0);
type ROM2 is array(0 to 65536) of std_logic_vector(1 downto 0);
signal predict:ROM1:=(others=>x"0000");
signal state:ROM2:=(others=>"01");
signal ls_ra,ra1: std_logic_vector(15 downto 0):=(x"0000");
begin
ra1<=ra-"0001";
process(clk)
begin
    if rising_edge( clk) then
        ls_ra<=ra-x"0001";
    end if;
end process;
 process(clk)
  begin
    if rising_edge(clk) and en='1' then
        if predict(conv_integer(ls_ra))=wd then
            if inc = '1' then
                case state(conv_integer(ls_ra)) is
                    when "00" => state(conv_integer(ls_ra))<="01";
                    when "01" => state(conv_integer(ls_ra))<="11";
                    when "10" => state(conv_integer(ls_ra))<="11";
                    when "11" => state(conv_integer(ls_ra))<="11";
                    when others => state(conv_integer(ls_ra))<="10";
                 end case;
            elsif inc='0' then 
                case state(conv_integer(ls_ra)) is
                    when "00" => state(conv_integer(ls_ra))<="00";
                    when "01" => state(conv_integer(ls_ra))<="00";
                    when "10" => state(conv_integer(ls_ra))<="00";
                    when "11" => state(conv_integer(ls_ra))<="10";
                    when others => state(conv_integer(ls_ra))<="10";
                end case;
            end if;
         else 
            predict(conv_integer(ls_ra))<=wd;
            state(conv_integer(ls_ra))<="01";
         end if;
    end if;
  end process;
rd<=predict(conv_integer(ra1))when state(conv_integer(ra1))(1)='1' else ra;

msb<=state(conv_integer(ra1))(1);
msb1<=state(conv_integer(ls_ra))(1);

end Behavioral;
