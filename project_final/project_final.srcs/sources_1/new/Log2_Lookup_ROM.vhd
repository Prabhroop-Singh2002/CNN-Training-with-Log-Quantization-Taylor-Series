----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2024 03:59:25 PM
-- Design Name: 
-- Module Name: Log2_Lookup_ROM - Behavioral
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

entity Log2_Lookup_ROM is
    Port (
        clk        : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        index      : in  INTEGER range 0 to 1023;  -- Input index for lookup
        log2_value : out INTEGER                  -- Output fixed-point log2 value
    );
end Log2_Lookup_ROM;

architecture Behavioral of Log2_Lookup_ROM is
    signal x_clipped     : unsigned(12-1 downto 0);
    -- Lookup table with precomputed log2 values
    constant LOG2_LOOKUP_TABLE : array (0 to 1023) of INTEGER := (
        -217705, -63639, -31788, -12930, 514, 10969, 19526, 26768, 33047, 38589,
        43549, 48038, 52137, 55909, 59402, 62655, 65698, 68557, 71253, 73803,
        -- Add the remaining values here up to index 1023
        262097, 262144  -- Example last values
    );

begin
    process(clk)
    begin
        if reset = '1' then
            log2_value <= 0;  -- Reset output to 0
        elsif rising_edge(clk) then
            log2_value <= LOG2_LOOKUP_TABLE(index);  -- Fetch value from table
        end if;
    end process;

end Behavioral;
