----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2024 08:26:52 AM
-- Design Name: 
-- Module Name: multiply - Behavioral
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

entity standard_multiplication is
    port (
        a, b       : in  integer range 0 to 255;    -- 8-bit inputs
        result_mul : out std_logic_vector(15 downto 0) -- 16-bit multiplication result
    );
end entity standard_multiplication;


architecture rtl of standard_multiplication is
begin
    process(a, b)
        variable a_int, b_int : integer;
        variable product      : integer;
    begin
        a_int := a; -- Convert std_logic_vector to integer
        b_int := b;
        product := a_int * b_int; -- Perform multiplication
        result_mul <= std_logic_vector(to_unsigned(product, 16)); -- Convert back to std_logic_vector
    end process;
end architecture rtl;


