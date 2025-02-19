library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc_tb is
end pc_tb;

architecture Behavioral of pc_tb is
    -- Component declaration for the Unit Under Test (UUT)
    component pc is
        Port (
            CLK      : in  STD_LOGIC;
            RESET    : in  STD_LOGIC;
            DATA_IN  : in  STD_LOGIC_VECTOR(15 downto 0);
            DATA_OUT : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal CLK       : STD_LOGIC := '0';
    signal RESET     : STD_LOGIC := '0';
    signal DATA_IN   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal DATA_OUT  : STD_LOGIC_VECTOR(15 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: pc
        Port map (
            CLK      => CLK,
            RESET    => RESET,
            DATA_IN  => DATA_IN,
            DATA_OUT => DATA_OUT
        );


    STIM_PROC: process
    begin
  
  clk<='1';
   wait for 10 ns;
  clk<='0';
   wait for 10 ns;
  clk<='1';
   wait for 10 ns;
  clk<='0';
   wait for 10 ns;
  clk<='1';
    end process;
    pe : process
    begin
    data_in<=x"2000";
    wait for 2 ns;
    data_in<=x"892A";
    wait for 3 ns;
    data_in<=x"8AAA";

     wait for 4 ns;
    
    end process;
end Behavioral;
