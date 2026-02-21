----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2024 07:43:28 AM
-- Design Name: 
-- Module Name: log_lut_tb - Behavioral
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

entity log_lut_tb is
end entity log_lut_tb;

architecture sim of log_lut_tb is
    signal addr    : integer range 0 to 255 := 0;
    signal log_val : std_logic_vector(7 downto 0);

    component log_lut
        generic (
            PRECISION : integer := 8;
            LUT_SIZE  : integer := 256
        );
        port (
            addr    : in  integer range 0 to LUT_SIZE-1;
            log_val : out std_logic_vector(PRECISION-1 downto 0)
        );
    end component;
begin
    uut: log_lut
        port map (
            addr    => addr,
            log_val => log_val
        );

    process
    begin
        for i in 0 to 255 loop
            addr <= i;
            wait for 10 ns;
        end loop;
        wait;
    end process;
end architecture sim;
