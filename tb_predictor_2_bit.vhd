library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_predictor_2_bit is
-- Testbench does not have ports
end tb_predictor_2_bit;

architecture Behavioral of tb_predictor_2_bit is
    -- Component Declaration
    component predictor_2_bit
        Port (
            clk     : in std_logic;
            en      : in std_logic;
            reset   : in std_logic;
            taken   : in std_logic;
            predict : out std_logic
        );
    end component;

    -- Signals to connect to the DUT
    signal clk     : std_logic := '0';
    signal en      : std_logic := '0';
    signal reset   : std_logic := '0';
    signal taken   : std_logic := '0';
    signal predict : std_logic;

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: predictor_2_bit
        Port map (
            clk     => clk,
            en      => en,
            reset   => reset,
            taken   => taken,
            predict => predict
        );

    -- Clock generation process
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Reset the predictor
        reset <= '1';
        en <= '0';
        taken <= '0';
        wait for 20 ns;

        reset <= '0';
        en <= '1';
        wait for clk_period;

        -- Case 1: Branch not taken initially
        taken <= '0';
        wait for 40 ns;

        -- Case 2: Branch taken repeatedly
        taken <= '1';
        wait for 40 ns;

        -- Case 3: Branch not taken after being taken
        taken <= '0';
        wait for 40 ns;

        -- Case 4: Random switching of branch outcomes
        taken <= '1';
        wait for clk_period * 2;

        taken <= '0';
        wait for clk_period * 2;

        taken <= '1';
        wait for clk_period * 2;

        -- End simulation
        wait for 50 ns;
        assert false report "Simulation finished" severity note;
        wait;
    end process;
end Behavioral;
