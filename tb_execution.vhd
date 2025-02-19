----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 03:37:10 PM
-- Design Name: 
-- Module Name: tb_execution - Behavioral
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


----------------------------------------------------------------------------------
-- Testbench for Execution Unit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_execution is
end tb_execution;

architecture Behavioral of tb_execution is
    -- Component Declaration for the Unit Under Test (UUT)
    component execution
        Port (
            pc1       : in std_logic_vector(15 downto 0);
            rd1       : in std_logic_vector(15 downto 0);
            rd2       : in std_logic_vector(15 downto 0);
            ext_imm   : in std_logic_vector(15 downto 0);
            func      : in std_logic_vector(2 downto 0);
            wa0       : in std_logic_vector(2 downto 0);
            wa1       : in std_logic_vector(2 downto 0);
            sa        : in std_logic;
            aluop     : in std_logic_vector(2 downto 0);
            alusrc    : in std_logic;
            regdst    : in std_logic;
            branchA   : out std_logic_vector(15 downto 0);
            aluRes    : out std_logic_vector(15 downto 0);
            zero      : out std_logic;
            wd_mem    : out std_logic_vector(15 downto 0);
            wa        : out std_logic_vector(2 downto 0)
        );
    end component;

    -- Signals for connecting to UUT ports
    signal pc1       : std_logic_vector(15 downto 0) := (others => '0');
    signal rd1       : std_logic_vector(15 downto 0) := (others => '0');
    signal rd2       : std_logic_vector(15 downto 0) := (others => '0');
    signal ext_imm   : std_logic_vector(15 downto 0) := (others => '0');
    signal func      : std_logic_vector(2 downto 0) := "000";
    signal wa0       : std_logic_vector(2 downto 0) := "000";
    signal wa1       : std_logic_vector(2 downto 0) := "001";
    signal sa        : std_logic := '0';
    signal aluop     : std_logic_vector(2 downto 0) := "000";
    signal alusrc    : std_logic := '0';
    signal regdst    : std_logic := '0';
    signal branchA   : std_logic_vector(15 downto 0);
    signal aluRes    : std_logic_vector(15 downto 0);
    signal zero      : std_logic;
    signal wd_mem    : std_logic_vector(15 downto 0);
    signal wa        : std_logic_vector(2 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: execution
        Port map (
            pc1       => pc1,
            rd1       => rd1,
            rd2       => rd2,
            ext_imm   => ext_imm,
            func      => func,
            wa0       => wa0,
            wa1       => wa1,
            sa        => sa,
            aluop     => aluop,
            alusrc    => alusrc,
            regdst    => regdst,
            branchA   => branchA,
            aluRes    => aluRes,
            zero      => zero,
            wd_mem    => wd_mem,
            wa        => wa
        );

    -- Stimulus process
    STIM_PROC: process
    begin
        -- Test case 1: Basic add operation with `regdst=0` and `alusrc=0`
        pc1 <= x"0001";
        rd1 <= x"0003";
        rd2 <= x"0002";
        ext_imm <= x"0004";
        func <= "011";        -- Function code for add
        aluop <= "000";       -- ALU operation
        alusrc <= '0';        -- Select rd2 as second operand
        regdst <= '0';        -- Select wa0 for write address
        wait for 10 ns;

        -- Test case 2: Subtract operation with immediate value
        func <= "100";        -- Function code for sub
        aluop <= "000";       -- ALU operation
        alusrc <= '1';        -- Select ext_imm as second operand
        regdst <= '1';        -- Select wa1 for write address
        wait for 10 ns;

        -- Test case 3: Bitwise OR operation
        rd1 <= x"00FF";
        rd2 <= x"0F0F";
        func <= "010";        -- Function code for OR
        aluop <= "000";
        alusrc <= '0';
        wait for 10 ns;

        -- Test case 4: Branch address calculation
        pc1 <= x"0100";
        ext_imm <= x"0008";   -- Branch offset
        func <= "110";        -- Function code for branch
        aluop <= "110";       -- Branch operation
        wait for 10 ns;

        -- Test case 5: Shift left logical (SLL) with `sa=1`
        rd1 <= x"0001";
        func <= "101";        -- Function code for SLL
        aluop <= "000";
        sa <= '1';
        wait for 10 ns;

        -- Test case 6: Set ALU operation to default
        aluop <= "111";       -- Default case (jump)
        wait for 10 ns;

        -- Stop the simulation
        wait;
    end process;

end Behavioral;
