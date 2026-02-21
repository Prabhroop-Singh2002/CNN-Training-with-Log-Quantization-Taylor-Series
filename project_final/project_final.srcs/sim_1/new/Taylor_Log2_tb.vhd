----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2024 04:15:26 PM
-- Design Name: 
-- Module Name: Taylor_Log2_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity Taylor_Log2_tb is
end Taylor_Log2_tb;

architecture Behavioral of Taylor_Log2_tb is
    -- Component declaration for the Unit Under Test (UUT)
    component Taylor_Log2
        Port (
            clk       : in  STD_LOGIC;              -- Clock signal
            reset     : in  STD_LOGIC;              -- Reset signal
            input_val : in  UNSIGNED(15 downto 0);  -- Input value (fixed-point representation)
            log2_val  : out UNSIGNED(15 downto 0)   -- Output log2 value (fixed-point representation)
        );
    end component;

    -- Testbench signals
    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '0';
    signal input_val : UNSIGNED(15 downto 0) := (others => '0');
    signal log2_val  : UNSIGNED(15 downto 0);

    -- Clock period constant
    constant clk_period : time := 10 ns;
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Taylor_Log2
        Port map (
            clk       => clk,
            reset     => reset,
            input_val => input_val,
            log2_val  => log2_val
        );

    -- Clock generation
    clk_process : process
    begin
        while True loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Apply reset
        reset <= '1';
        wait for 2 * clk_period;
        reset <= '0';

        -- Test case 1: Minimum value
        input_val <= to_unsigned(1, 16); -- log2(1) = 0
        wait for 10 * clk_period;
        report "Test Case 1: Input = " & integer'image(to_integer(input_val)) &
               " Output = " & integer'image(to_integer(log2_val));

        -- Test case 2: Small value
        input_val <= to_unsigned(2, 16); -- log2(2) = 1
        wait for 10 * clk_period;
        report "Test Case 2: Input = " & integer'image(to_integer(input_val)) &
               " Output = " & integer'image(to_integer(log2_val));

        -- Test case 3: Medium value
        input_val <= to_unsigned(16, 16); -- log2(16) = 4
        wait for 10 * clk_period;
        report "Test Case 3: Input = " & integer'image(to_integer(input_val)) &
               " Output = " & integer'image(to_integer(log2_val));

        -- Test case 4: Maximum value
        input_val <= to_unsigned(256, 16); -- log2(256) = 8
        wait for 10 * clk_period;
        report "Test Case 4: Input = " & integer'image(to_integer(input_val)) &
               " Output = " & integer'image(to_integer(log2_val));

        -- End simulation
        wait;
    end process;

end Behavioral;


