----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2024 05:17:20 AM
-- Design Name: 
-- Module Name: taylor_approx - Behavioral
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

entity taylor_approx is
    port (
        frac_part : in REAL;  
        log2_frac_out : out REAL 
    );
end entity taylor_approx;

architecture behavioral of taylor_approx is
    constant log2_inv : REAL := 1.442;  
begin
    process(frac_part)
        variable scaled_result : REAL;
    begin
        scaled_result := frac_part * log2_inv;
        log2_frac_out <= scaled_result;
    end process;
end architecture behavioral;

