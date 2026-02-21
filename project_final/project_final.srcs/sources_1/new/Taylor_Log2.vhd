----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2024 04:12:26 PM
-- Design Name: 
-- Module Name: Taylor_Log2 - Behavioral
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

entity Taylor_Log2 is
    Port (
        clk       : in  STD_LOGIC;              -- Clock signal
        reset     : in  STD_LOGIC;              -- Reset signal
        input_val : in  UNSIGNED(15 downto 0);  -- Input value (fixed-point representation)
        log2_val  : out UNSIGNED(15 downto 0)   -- Output log2 value (fixed-point representation)
    );
end Taylor_Log2; -- Entity end

architecture Behavioral of Taylor_Log2 is
    constant lookup_min : UNSIGNED(15 downto 0) := to_unsigned(1, 16); -- Minimum input value
    constant ln2        : UNSIGNED(15 downto 0) := to_unsigned(45426, 16); -- Approximation of ln(2) in fixed-point
    constant max_terms  : INTEGER := 3;         -- Number of Taylor series terms
begin
    process(clk, reset)
        -- Declare process variables
        variable x_clipped       : UNSIGNED(15 downto 0); -- Clipped input value
        variable exponent        : INTEGER := 0;         -- Calculated exponent
        variable mantissa        : UNSIGNED(15 downto 0); -- Extracted mantissa
        variable mantissa_shift  : SIGNED(15 downto 0);  -- Shifted mantissa (mantissa - 1)
        variable taylor_sum      : SIGNED(15 downto 0);  -- Accumulated Taylor series sum
        variable term            : SIGNED(15 downto 0);  -- Current Taylor series term
        variable k               : INTEGER;              -- Term counter
        variable temp_result     : SIGNED(15 downto 0);  -- Intermediate sum result
    begin
        if reset = '1' then
            -- Reset output value
            log2_val <= (others => '0');
        elsif rising_edge(clk) then
            -- Step 1: Clip the input value
            if input_val < lookup_min then
                x_clipped := lookup_min;
            elsif input_val > to_unsigned(256, 16) then
                x_clipped := to_unsigned(256, 16);
            else
                x_clipped := input_val;
            end if;

            -- Step 2: Placeholder for actual exponent and mantissa calculation
            exponent := 0;
            mantissa := x_clipped;
            mantissa_shift := signed(mantissa) - to_signed(1, 16);

            -- Step 3: Compute Taylor series for log2(mantissa)
            taylor_sum := (others => '0');
            term := mantissa_shift;
            for k in 1 to max_terms loop
                if k = 1 then
                    taylor_sum := term;
                else
                    term := (term * (-mantissa_shift)) srl 1; -- Shift right for division approximation
                    taylor_sum := taylor_sum + term;
                end if;
            end loop;

            -- Step 4: Add exponent to Taylor series result
            temp_result := to_signed(exponent, 16) + taylor_sum;
            log2_val <= unsigned(temp_result);
        end if;
    end process;
end Behavioral;  


