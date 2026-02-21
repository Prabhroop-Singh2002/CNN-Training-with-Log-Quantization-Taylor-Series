----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2024 05:24:23 AM
-- Design Name: 
-- Module Name: tb_log_quantize - Behavioral
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

entity tb_log_quantize is
end entity tb_log_quantize;

architecture behavioral of tb_log_quantize is
    component log_quantize
        port (
            x : in REAL;
            log2_x : out REAL;
            clk : in std_logic
        );
    end component;

    signal x : REAL;
    signal log2_x : REAL;
    signal clk : std_logic := '0';

begin
    clock_process : process
    begin
        clk <= NOT clk;
        wait for 10 ns;
    end process;

    UUT: log_quantize
        port map (x => x, log2_x => log2_x, clk => clk);

    stimulus: process
    begin
        x <= 0.0; 
        wait for 20 ns;

        x <= 1.0; 
        wait for 20 ns;

        x <= 2.0; 
        wait for 20 ns;

        x <= 3.0; 
        wait for 20 ns;

        x <= 4.0; 
        wait for 20 ns;

        x <= 5.0; 
        wait for 20 ns;

        x <= 6.0; 
        wait for 20 ns;

        x <= 7.0; 
        wait for 20 ns;

        x <= 8.0; 
        wait for 20 ns;

        x <= 9.0; 
        wait for 20 ns;

        x <= 10.0; 
        wait for 20 ns;

        x <= 11.0; 
        wait for 20 ns;

        x <= 12.0; 
        wait for 20 ns;

        x <= 13.0; 
        wait for 20 ns;

        x <= 14.0; 
        wait for 20 ns;

        x <= 15.0; 
        wait for 20 ns;

        x <= 16.0; 
        wait for 20 ns;

        x <= 17.0; 
        wait for 20 ns;

        x <= 18.0; 
        wait for 20 ns;

        x <= 19.0; 
        wait for 20 ns;

        x <= 20.0; 
        wait for 20 ns;

        wait;
    end process;
end architecture behavioral;

