----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2024 05:16:31 AM
-- Design Name: 
-- Module Name: int_frac - Behavioral
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

entity int_frac is
    port (
        x : in REAL; 
        int_part : out INTEGER; 
        frac_part : out REAL 
    );
end entity int_frac;

architecture behavioral of int_frac is
begin
    process(x)
        variable int_result : INTEGER; 
        variable frac_result : REAL;
    begin
        int_result := INTEGER(x); 
        frac_result := x - REAL(int_result);  

        int_part <= int_result;
        frac_part <= frac_result;
    end process;
end architecture behavioral;

