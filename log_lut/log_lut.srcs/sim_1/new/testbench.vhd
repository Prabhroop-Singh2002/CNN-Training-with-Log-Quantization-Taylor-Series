----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2024 08:29:04 AM
-- Design Name: 
-- Module Name: testbench - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_compare_manual is
end entity tb_compare_manual;

architecture sim of tb_compare_manual is
    signal a, b               : integer range 0 to 255 := 0;
    signal lut_log_result     : std_logic_vector(7 downto 0);
    signal standard_mul_result : std_logic_vector(15 downto 0);

    component combined_lut_log
        port (
            a, b       : in  integer range 0 to 255;
            log_result : out std_logic_vector(7 downto 0)
        );
    end component;

    component standard_multiplication
        port (
            a, b       : in  integer range 0 to 255;
            result_mul : out std_logic_vector(15 downto 0)
        );
    end component;

begin
    -- Instantiate the LUT-based log addition module
    uut_lut: combined_lut_log
        port map (
            a => a,
            b => b,
            log_result => lut_log_result
        );

    -- Instantiate the standard multiplication module
    uut_mul: standard_multiplication
        port map (
            a => a,
            b => b,
            result_mul => standard_mul_result
        );

    -- Testbench process with manual inputs
    process
    begin
        -- Test Case 1
        a <= 5; 
        b <= 3;
        wait for 10 ns;
         

        -- Test Case 2
        a <= 10; 
        b <= 20;
        wait for 10 ns;
 

        -- Test Case 3
        a <= 50; 
        b <= 2;
        wait for 10 ns;
        
        -- Test Case 4
        a <= 100; 
        b <= 150;
        wait for 10 ns;
        
        -- Test Case 5
        a <= 255; 
        b <= 255;
        wait for 10 ns;
         
        wait;
    end process;
end architecture sim;



