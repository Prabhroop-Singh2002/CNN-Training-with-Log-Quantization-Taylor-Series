----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2024 11:56:11 PM
-- Design Name: 
-- Module Name: LogQuantizerCNN_tb - Behavioral
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

entity LogQuantizerCNN_tb is
-- Testbench has no ports
end LogQuantizerCNN_tb;

architecture Behavioral of LogQuantizerCNN_tb is

    -- Component declaration for the Unit Under Test (UUT)
    component LogQuantizerCNN
        Port (
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            input_pixel : in  STD_LOGIC_VECTOR(7 downto 0);
            kernel_val  : in  STD_LOGIC_VECTOR(7 downto 0);
            output_pixel: out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    -- Signals for connecting to UUT
    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '0';
    signal input_pixel : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal kernel_val  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal output_pixel: STD_LOGIC_VECTOR(15 downto 0);

    -- Clock period constant
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: LogQuantizerCNN
        Port map (
            clk => clk,
            reset => reset,
            input_pixel => input_pixel,
            kernel_val => kernel_val,
            output_pixel => output_pixel
        );

    -- Clock generation process
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
    stimulus_process : process
    begin
        -- Apply reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Test case 1: Input = 64 (0.25 in Q8.8), Kernel = 128 (0.5 in Q8.8)
        input_pixel <= std_logic_vector(to_unsigned(64, 8));
        kernel_val <= std_logic_vector(to_unsigned(128, 8));
        wait for clk_period * 2;

        -- Test case 2: Input = 200 (0.78125 in Q8.8), Kernel = 50 (0.1953125 in Q8.8)
        input_pixel <= std_logic_vector(to_unsigned(200, 8));
        kernel_val <= std_logic_vector(to_unsigned(50, 8));
        wait for clk_period * 2;

        -- Test case 3: Input = 255 (0.99609375 in Q8.8), Kernel = 100 (0.390625 in Q8.8)
        input_pixel <= std_logic_vector(to_unsigned(255, 8));
        kernel_val <= std_logic_vector(to_unsigned(100, 8));
        wait for clk_period * 2;

        -- Test case 4: Input = 0 (edge case), Kernel = 128 (0.5 in Q8.8)
        input_pixel <= std_logic_vector(to_unsigned(0, 8));
        kernel_val <= std_logic_vector(to_unsigned(128, 8));
        wait for clk_period * 2;

        -- Test case 5: Input = 10 (0.0390625 in Q8.8), Kernel = 20 (0.078125 in Q8.8)
        input_pixel <= std_logic_vector(to_unsigned(10, 8));
        kernel_val <= std_logic_vector(to_unsigned(20, 8));
        wait for clk_period * 2;

        -- Stop simulation
        wait;
    end process;

end Behavioral;
