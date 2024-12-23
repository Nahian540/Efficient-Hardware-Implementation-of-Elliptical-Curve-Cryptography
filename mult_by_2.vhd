----------------------------------------------------------------------------------
-- Engineer: MD SELIM HOSSAIN
-- Supervisor: Dr Yinan Kong
-- Create Date:    17:48:10 01/20/2016 
-- Design Name: mult module for 256 bit ECC over PF
-- Module Name:    mult_by_2 - arch_mult_by_2 
-- Project Name: mult for Hardware Implementation of ECC over PF_256 bit
-- Description: For koblitz curve.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mult_by_2 is
    generic (k : integer := 256);
    Port ( Ci : in  STD_LOGIC_VECTOR (k-1 downto 0);
           Co : out  STD_LOGIC_VECTOR (k downto 0));
end mult_by_2;

architecture arch_mult_by_2 of mult_by_2 is

begin

Co <= Ci(k-1 downto 0) & '0';

end arch_mult_by_2;

