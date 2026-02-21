----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2024 06:53:09 PM
-- Design Name: 
-- Module Name: testbench1 - Behavioral
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
use IEEE.MATH_REAL.ALL;

entity log2_quantizer_tb is
end log2_quantizer_tb;

architecture Behavioral of log2_quantizer_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component log2_quantizer
        Generic (
            DATA_WIDTH      : integer := 16;
            FRACTIONAL_BITS : integer := 8
        );
        Port (
            clk      : in  std_logic;
            rst      : in  std_logic;
            x_in     : in  unsigned(DATA_WIDTH-1 downto 0);
            log2_out : out signed(DATA_WIDTH-1 downto 0)
        );
    end component;

    -- Signals
    constant CLK_PERIOD : time := 10 ns;
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';
    signal x_in     : unsigned(15 downto 0) := (others => '0');
    signal log2_out : signed(15 downto 0);

    -- Simulation Control
    signal done : boolean := false;

begin

    -- Instantiate the UUT
    uut: log2_quantizer
        Generic map (
            DATA_WIDTH      => 16,
            FRACTIONAL_BITS => 8
        )
        Port map (
            clk      => clk,
            rst      => rst,
            x_in     => x_in,
            log2_out => log2_out
        );

    -- Clock Generation
    clk_process: process
    begin
        while not done loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus Process
    stim_process: process
        variable input_value : integer := 1;
        variable max_value   : integer := 256;  -- Range of input values for test
    begin
        -- Reset the UUT
        rst <= '1';
        wait for CLK_PERIOD * 2;
        rst <= '0';
        wait for CLK_PERIOD;

        -- Apply Test Inputs
        report "Starting Log2 Quantization Test";
        for input_value in 1 to max_value loop
            x_in <= to_unsigned(input_value, 16);
            wait for CLK_PERIOD;

            -- Print Results to Console
            report "Input Value: " & integer'image(input_value) &
                   " => Log2 Output: " & integer'image(to_integer(log2_out));

        end loop;

        -- Finish Simulation
        done <= true;
        report "Test Completed Successfully";
        wait;
    end process;

end Behavioral;


begin


end Behavioral;
