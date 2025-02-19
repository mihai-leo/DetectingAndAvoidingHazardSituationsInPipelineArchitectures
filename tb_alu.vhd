----------------------------------------------------------------------------------
-- Testbench for ALU
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_alu is
end tb_alu;

architecture Behavioral of tb_alu is
    -- Component Declaration for the Unit Under Test (UUT)
    component alu
        Port (
            rd1     : in std_logic_vector(15 downto 0);
            rd2     : in std_logic_vector(15 downto 0);
            alucont : in std_logic_vector(3 downto 0);
            sa      : in std_logic;
            zero    : out std_logic;
            alures  : out std_logic_vector(15 downto 0)
        );
    end component;

    -- Signals for connecting to UUT ports
    signal rd1     : std_logic_vector(15 downto 0) := (others => '0');
    signal rd2     : std_logic_vector(15 downto 0) := (others => '0');
    signal alucont : std_logic_vector(3 downto 0) := "0000";
    signal sa      : std_logic := '0';
    signal zero    : std_logic;
    signal alures  : std_logic_vector(15 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: alu
        Port map (
            rd1     => rd1,
            rd2     => rd2,
            alucont => alucont,
            sa      => sa,
            zero    => zero,
            alures  => alures
        );

    -- Stimulus process
    STIM_PROC: process
    begin
        -- Test XOR operation (alucont = "0000")
        rd1 <= x"0F0F";
        rd2 <= x"F0F0";
        alucont <= "0000";
        wait for 10 ns;
        
        -- Test AND operation (alucont = "0001")
        alucont <= "0001";
        wait for 10 ns;
        
        -- Test OR operation (alucont = "0010")
        alucont <= "0010";
        wait for 10 ns;

        -- Test ADD operation (alucont = "0011")
        alucont <= "0011";
        rd1 <= x"0001";
        rd2 <= x"0002";
        wait for 10 ns;

        -- Test SUB operation (alucont = "0100")
        alucont <= "0100";
        rd1 <= x"0003";
        rd2 <= x"0001";
        wait for 10 ns;

        -- Test SLL operation with sa='1' (alucont = "0101")
        alucont <= "0101";
        rd1 <= x"000F";
        sa <= '1';
        wait for 10 ns;

        -- Test SRL operation with sa='1' (alucont = "0110")
        alucont <= "0110";
        rd1 <= x"000F";
        wait for 10 ns;

        -- Test SRA operation with sa='1' (alucont = "0111")
        alucont <= "0111";
        rd1 <= x"8000";  -- Test with a negative number
        wait for 10 ns;

        -- Test BEQ operation (alucont = "1000")
        alucont <= "1000";
        rd1 <= x"0005";
        rd2 <= x"0005";
        wait for 10 ns;
        
                -- Test SRA operation with sa='1' (alucont = "0111")
        alucont <= "0111";
        rd1 <= x"8000";  -- Test with a negative number
        wait for 10 ns;
        -- Test a default case (alucont = "1111")
        alucont <= "1111";
        rd2 <= x"1234";
        wait for 10 ns;

        -- Stop the simulation
        wait;
    end process;
    
end Behavioral;
