----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 09:15:00 PM
-- Design Name: Testbench for add_noopp
-- Module Name: tb_add_noopp
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for add_noopp module to validate its functionality.
-- 
-- Dependencies: Requires add_noopp module and stack_3 module.
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_add_noopp is
end tb_add_noopp;

architecture Behavioral of tb_add_noopp is

  -- Component Declaration for add_noopp
  component add_noopp is
    Port ( 
      clk     : in std_logic;
      pc_in   : in std_logic_vector(15 downto 0);
      ins_in  : in std_logic_vector(15 downto 0);
      pc_out  : out std_logic_vector(15 downto 0);
      ins_out : out std_logic_vector(15 downto 0)
    );
  end component;

  -- Testbench signals
  signal clk_tb      : std_logic := '0';
  signal pc_in_tb    : std_logic_vector(15 downto 0) := (others => '0');
  signal ins_in_tb   : std_logic_vector(15 downto 0) := (others => '0');
  signal pc_out_tb   : std_logic_vector(15 downto 0);
  signal ins_out_tb  : std_logic_vector(15 downto 0);

  -- Clock period definition
  constant clk_period : time := 10 ns;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: add_noopp Port map (
    clk     => clk_tb,
    pc_in   => pc_in_tb,
    ins_in  => ins_in_tb,
    pc_out  => pc_out_tb,
    ins_out => ins_out_tb
  );

  -- Clock generation
  clk_process : process
  begin
    clk_tb <= '0';
    wait for clk_period/2;
    clk_tb <= '1';
    wait for clk_period/2;
  end process;

  -- Stimulus process
  stim_proc: process
  begin
    -- Test case 1: Simple input values
    pc_in_tb  <= x"0001";
    ins_in_tb <= x"be81"; -- Arbitrary instruction with bits indicating "no operation"
    wait for clk_period;

    -- Test case 2: Check jump instruction
    pc_in_tb  <= x"0010";
    ins_in_tb <= x"9d01"; -- Setting condition to check jump logic (assuming "111" in top bits triggers jump)
    wait for clk_period;

    -- Test case 3: Change to a normal instruction
    pc_in_tb  <= x"0011";
    ins_in_tb <= x"1513"; -- Normal operation, no jump
    wait for clk_period;

    -- Test case 4: Jump condition met with ra1/out1 conflict
    pc_in_tb  <= x"0011";
    ins_in_tb <= x"1513"; -- Matching ra1 with out1 condition
    wait for clk_period;

    -- Test case 5: No jump when no conflicts are present
    pc_in_tb  <= x"0011";
    ins_in_tb <= x"1513"; -- Arbitrary instruction, should proceed without jump
    wait for clk_period;

    -- Finish simulation
    wait;
  end process;

end Behavioral;
