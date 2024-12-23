----------------------------------------------------------------------------------
-- Company: Macquarie University
-- Engineer: MD SELIM HOSSAIN
-- Supervisor: Dr Yinan Kong
-- Create Date:    21:52:22 01/21/2016 
-- Design Name: MUX module for 256 bit ECC over PF
-- Module Name:    mult_PF_256_bit_new1 - Behavioral 
-- Project Name: mult for Hardware Implementation of ECC over PF_256 bit
-- Description: using latest TB and secp256k1 or koblitz curve.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity MUX is
    generic (k : integer := 256);
    Port ( Ain : in  STD_LOGIC_VECTOR (k-1 downto 0);
	        sel : in  STD_LOGIC_VECTOR (7 downto 0);
           Aout : out  STD_LOGIC);
end MUX;

architecture arch_MUX of MUX is

begin
process(sel, Ain)
begin

Aout <= Ain(to_integer( unsigned(sel)) );--convert std_logic_vector to integer
                                         --1st step slv to unsigned then unsigned to integer;
end process;

end arch_MUX;
