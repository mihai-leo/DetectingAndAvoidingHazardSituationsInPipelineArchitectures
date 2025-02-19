library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity tb_data_memory is
end tb_data_memory;

architecture Behavioral of tb_data_memory is

    -- Component declaration for the data_memory module
    component data_memory
        Port (
            clk       : in  std_logic;
            address   : in  std_logic_vector(15 downto 0);
            wd        : in  std_logic_vector(15 downto 0);
            memwrite  : in  std_logic;
            rd        : out std_logic_vector(15 downto 0)
        );
    end component;

    -- Testbench signals
    signal clk      : std_logic := '0';
    signal address  : std_logic_vector(15 downto 0) := (others => '0');
    signal wd       : std_logic_vector(15 downto 0) := (others => '0');
    signal memwrite : std_logic := '0';
    signal rd       : std_logic_vector(15 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the data_memory module
    uut: data_memory
        Port map (
            clk       => clk,
            address   => address,
            wd        => wd,
            memwrite  => memwrite,
            rd        => rd
        );

    -- Clock generation process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Test process
    stimulus : process
    begin
        -- Test Case 1: Read initial memory content at address 0
        address <= x"0000";
        memwrite <= '0';
        wait for clk_period;

        -- Test Case 2: Write to address 1 and then read back
        address <= x"0001";
        wd <= x"1234";
        memwrite <= '1';
        wait for clk_period;

        -- Disable write and read from the same address
        memwrite <= '0';
        wait for clk_period;

        -- Test Case 3: Write to a different address (address 2)
        address <= x"0002";
        wd <= x"ABCD";
        memwrite <= '1';
        wait for clk_period;

        -- Disable write and read from the same address
        memwrite <= '0';
        wait for clk_period;

        -- Test Case 4: Read uninitialized address
        address <= x"1000";
        memwrite <= '0';
        wait for clk_period;

        -- End of test
        wait;
    end process;

end Behavioral;
