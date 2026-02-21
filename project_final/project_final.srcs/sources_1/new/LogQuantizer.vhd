----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2024 11:45:44 PM
-- Design Name: 
-- Module Name: LogQuantizer - Behavioral
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

entity LogQuantizerCNN is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        input_pixel : in  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit fixed-point input
        kernel_val  : in  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit fixed-point kernel value
        output_pixel: out STD_LOGIC_VECTOR(15 downto 0)  -- 16-bit fixed-point output
    );
end LogQuantizerCNN;

architecture Behavioral of LogQuantizerCNN is
    -- Constants for fixed-point scaling
    constant SCALE_FACTOR : INTEGER := 256;  -- Assuming input is scaled by 256
    constant LOG_BASE2_INV : INTEGER := 144; -- Approximation for 1 / log(2) in Q8.8 format (1.442695)

    -- Function to approximate log2 using Taylor series
    function taylor_approx(x : INTEGER; n_terms : INTEGER) return INTEGER is
        variable result : INTEGER := 0;
        variable mantissa : INTEGER := x - SCALE_FACTOR;  -- Subtract 1.0 in Q8.8 format
        variable term : INTEGER;
        variable sign : INTEGER := 1;
    begin
        for k in 1 to n_terms loop
            term := (mantissa**k) / (k * SCALE_FACTOR);
            if (k mod 2) = 0 then
                result := result - term * LOG_BASE2_INV / SCALE_FACTOR;
            else
                result := result + term * LOG_BASE2_INV / SCALE_FACTOR;
            end if;
        end loop;
        return result;
    end function;

    -- Function to perform log quantization
    function log_quantize(input_val : STD_LOGIC_VECTOR(7 downto 0)) return STD_LOGIC_VECTOR is
        variable input_int : INTEGER := to_integer(unsigned(input_val));
        variable log2_result : INTEGER;
    begin
        if input_int < (SCALE_FACTOR / 100) then -- Check if input is below 0.01 in Q8.8 format
            log2_result := 0; -- Avoid undefined behavior for very small values
        else
            log2_result := taylor_approx(input_int, 3); -- Use 3 terms of Taylor approximation
        end if;

        -- Return result as 8-bit fixed-point number
        return std_logic_vector(to_signed(log2_result, 8));
    end function;

    -- Signal for intermediate results
    signal log_pixel, log_kernel : STD_LOGIC_VECTOR(7 downto 0);
    signal conv_result : INTEGER;

begin
    process(clk, reset)
    begin
        if reset = '1' then
            output_pixel <= (others => '0');
        elsif rising_edge(clk) then
            -- Log quantization of input and kernel values
            log_pixel <= log_quantize(input_pixel);
            log_kernel <= log_quantize(kernel_val);

            -- Perform convolution (multiplication)
            conv_result <= to_integer(signed(log_pixel)) * to_integer(signed(log_kernel));

            -- Convert convolution result back to fixed-point output
            output_pixel <= std_logic_vector(to_signed(conv_result, 16));
        end if;
    end process;
end Behavioral;



