----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2024 05:15:58 AM
-- Design Name: 
-- Module Name: log2_lookup - Behavioral
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

entity log2_lookup is
    port (
        int_part : in INTEGER;
        log2_out : out REAL 
    );
end entity log2_lookup;

architecture behavioral of log2_lookup is
    type lut_array is array (0 to 255) of REAL;
    constant log2_lut : lut_array := (
        0.0,             -- log2(0) 
        0.0,             -- log2(1) = 0
        1.0,             -- log2(2)
        1.58496250072,   -- log2(3)
        2.0,             -- log2(4)
        2.32192809489,   -- log2(5)
        2.58496250072,   -- log2(6)
        2.80735492206,   -- log2(7)
        3.0,             -- log2(8)
        3.16992500144,   -- log2(9)
        3.32192809489,   -- log2(10)
        3.45943161864,   -- log2(11)
        3.58496250072,   -- log2(12)
        3.70043971814,   -- log2(13)
        3.80735492206,   -- log2(14)
        3.90689059561,   -- log2(15)
        4.0,             -- log2(16)
        4.08746284125,   -- log2(17)
        4.16992500144,   -- log2(18)
        4.24792751344,   -- log2(19)
        4.32192809489,   -- log2(20)
        -- THIS LOOKUP NEEDS TO  BE FILLED WITH ENTRIES TILL LOG 256, FOR SIMPLICITY VALUES TILL LOG 20 ARE INCLUDED
        others => 0.0 
    );

begin
    process(int_part)
    begin
        if int_part >= 0 and int_part < log2_lut'length then
            log2_out <= log2_lut(int_part);  
        else
            log2_out <= 0.0; 
        end if;
    end process;
end architecture behavioral;


