----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 08:47:02 PM
-- Design Name: 
-- Module Name: add_noopp - Behavioral
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

entity add_noopp is
 Port ( 
    clk: in std_logic;
    pc_in: in std_logic_vector(15 downto 0);
    ins_in: in std_logic_vector(15 downto 0);
    pc_out: out std_logic_vector(15 downto 0);
    ins_out: out std_logic_vector(15 downto 0)
       
 );
end add_noopp;

architecture Behavioral of add_noopp is

component stack_3 is
  Port (
  clk: in std_logic;
  
  addr: in std_logic_vector(15 downto 0);
  out1: out std_logic_vector(15 downto 0);
  out2: out std_logic_vector(15 downto 0);
  out3: out std_logic_vector(15 downto 0)
   );
end component;
signal addr,ra1,ra2,ra0: std_logic_vector(15 downto 0):= (others => '0');
signal w1,w2,r1,r2: std_logic_vector(2 downto 0):= (others => '1');
signal out1,out2,out3: std_logic_vector (15 downto 0):= (others => '0');
signal jump,or1,or2: std_logic:='0';
signal pc: std_logic_vector (15 downto 0):= x"0000";
begin
addr<=ins_in;
w1<=out1(6 downto 4) when out1(15 downto 13) ="000" else out1(9 downto 7);
w2<=out2(6 downto 4) when out2(15 downto 13) ="000" else out2(9 downto 7);
r1<=addr(12 downto 10);
r2<=addr(9 downto 7) when addr(15 downto 13) ="000" else addr(12 downto 10);

st: stack_3 port map(clk,addr,out1,out2,out3);
jump<='0' when addr=x"0001" or addr(15 downto 13)="111" else '1' when (w1=r1 or w1=r2 or w2=r2 or w2=r1) else '0';
ins_out<=ins_in;-- when jump='0' else ra0;

--p1: process(jump)
--begin
--if  jump ='1' then
--if rising_edge (jump) then
-- pc<=pc_in;
-- ra1<="111"&pc(12 downto 0);
-- ra2<=x"0001";
-- end if;
-- if falling_edge(clk) then
-- ra0<=ra1;
-- ra1<=ra2;
-- end if;
 
-- end if;

--end process;
--p2: process(clk)
--begin
-- if falling_edge (clk)  then
-- if jump='1' then
-- ra0<=ra1;
-- end if;
 --ra2<=x"0001";
-- end if;
--end process;
pc_out<=x"000"&"000"&jump;--ra0(3 downto 0)&pc_in(7 downto 0)&"000"&jump;
end Behavioral;
