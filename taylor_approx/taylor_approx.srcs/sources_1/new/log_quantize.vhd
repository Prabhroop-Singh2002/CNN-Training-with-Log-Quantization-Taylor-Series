----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2024 05:17:55 AM
-- Design Name: 
-- Module Name: log_quantize - Behavioral
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

entity log_quantize is
    port (
        x : in REAL;  
        log2_x : out REAL := 0.0;  
        clk : in std_logic  
    );
end entity log_quantize;

architecture behavioral of log_quantize is
    -- Intermediate signals
    signal int_part : Integer;
    signal frac_part : REAL;
    signal log2_int_part : REAL;
    signal log2_frac_part : REAL;
    signal log2_sum : REAL;
begin
    -- Instantiate the components
    part_1: entity work.int_frac port map(x => x, int_part => int_part, frac_part => frac_part);
    part_2: entity work.log2_lookup port map(int_part => int_part, log2_out => log2_int_part);
    part_3: entity work.taylor_approx port map(frac_part => frac_part, log2_frac_out => log2_frac_part);

    process(clk)
    begin
        if rising_edge(clk) then
            log2_sum <= log2_int_part + log2_frac_part;
            log2_x <= log2_sum;
        end if;
    end process;
end architecture behavioral;

