----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 04:45:00 PM
-- Design Name: 
-- Module Name: if_id_tb - Testbench for if_id Flip-Flop Module
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench to verify if_id flip-flop functionality by simulating 
--              input signals and observing outputs.
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
use IEEE.NUMERIC_STD.ALL;

-- Testbench entity does not have ports
entity if_id_tb is
end if_id_tb;

architecture Behavioral of if_id_tb is

    -- Component Declaration of the Unit Under Test (UUT)
    component if_id
      Port (
        clk            : in  std_logic;
        pc1_in         : in  std_logic_vector(15 downto 0);
        instruction_in : in  std_logic_vector(15 downto 0);
        pc1_out        : out std_logic_vector(15 downto 0);
        instruction_out: out std_logic_vector(15 downto 0)
      );
    end component;

    -- Signal declarations for testbench
    signal clk            : std_logic := '0';
    signal pc1_in         : std_logic_vector(15 downto 0) := (others => '0');
    signal instruction_in : std_logic_vector(15 downto 0) := (others => '0');
    signal pc1_out        : std_logic_vector(15 downto 0);
    signal instruction_out: std_logic_vector(15 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: if_id Port map (
        clk            => clk,
        pc1_in         => pc1_in,
        instruction_in => instruction_in,
        pc1_out        => pc1_out,
        instruction_out => instruction_out
    );

    -- Clock generation process
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus process
    stimulus: process
    begin
        -- Test Case 1: Apply initial values
        pc1_in         <= x"0001";
        instruction_in <= x"AAAA";
        wait for CLK_PERIOD;

        -- Test Case 2: Change inputs and observe output on next clock
        pc1_in         <= x"0002";
        instruction_in <= x"BBBB";
        wait for CLK_PERIOD;

        -- Test Case 3: Further change inputs
        pc1_in         <= x"0003";
        instruction_in <= x"CCCC";
        wait for CLK_PERIOD;

        -- Test Case 4: Check the reset effect on the following clock edge
        pc1_in         <= x"0000";
        instruction_in <= x"0000";
        wait for CLK_PERIOD;

        -- Stop simulation
        wait;
    end process;

end Behavioral;
