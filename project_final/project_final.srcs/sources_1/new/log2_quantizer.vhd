----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2024 06:50:59 PM
-- Design Name: 
-- Module Name: log2_quantizer - Behavioral
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

entity log2_quantizer is
    Generic (
        DATA_WIDTH : integer := 16;  -- Input data width
        FRACTIONAL_BITS : integer := 8  -- Number of fractional bits
    );
    Port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        x_in     : in  unsigned(DATA_WIDTH-1 downto 0);  -- Input data
        log2_out : out signed(DATA_WIDTH-1 downto 0)  -- Output log2(x) result
    );
end log2_quantizer;

architecture Behavioral of log2_quantizer is

    -- Internal signals
    signal x_clipped     : unsigned(DATA_WIDTH-1 downto 0);
    signal exponent      : integer range -128 to 127;
    signal mantissa      : real;
    signal mantissa_shifted : real;
    signal taylor_result : real;

    -- Constants
    constant LOOKUP_MIN : real := 0.01;  -- Minimum input value to avoid invalid log
    constant LN2 : real := 0.6931471806;  -- Natural logarithm of 2

begin

    process(clk, rst)
        variable x_real       : real;
        variable exponent_var : integer;
        variable mantissa_var : real;
        variable shifted_var  : real;
        variable taylor_sum   : real;
        variable term         : real;
        variable k            : integer;
    begin
        if rst = '1' then
            log2_out <= (others => '0');
        elsif rising_edge(clk) then
           
            if real(to_integer(x_in)) < LOOKUP_MIN then
                x_real := LOOKUP_MIN;
            else
                x_real := real(to_integer(x_in)) / 2.0**FRACTIONAL_BITS;
            end if;

            
            exponent_var := integer(log2(x_real));
            mantissa_var := x_real / (2.0**exponent_var);

            
            shifted_var := mantissa_var - 1.0;

            taylor_sum := 0.0;
            for k in 1 to 3 loop 
                term := ((-1.0)**(k+1)) * (shifted_var**k) / (real(k) * LN2);
                taylor_sum := taylor_sum + term;
            end loop;

            taylor_result <= real(exponent_var) + taylor_sum;
            log2_out <= to_signed(integer(taylor_result * (2.0**FRACTIONAL_BITS)), DATA_WIDTH);
        end if;
    end process;

end Behavioral;

