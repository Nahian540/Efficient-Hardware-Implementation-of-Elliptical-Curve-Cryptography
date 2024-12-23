----------------------------------------------------------------------------------
-- Company: Macquarie University
-- Engineer: MD SELIM HOSSAIN
-- Supervisor: Dr Yinan Kong
-- Create Date:    21:52:22 01/20/2016 
-- Design Name: comp1 mean comparator 1 for 256 bit ECC over PF
-- Module Name:    comp1 - Behavioral 
-- Project Name: mult for Hardware Implementation of ECC over PF_256 bit
-- Description: using latest TB and secp256k1 or koblitz curve.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use work.ECC_package_PF.all; 

entity comp1 is
    generic (k : integer := 256);
    Port ( C1 : in  STD_LOGIC_VECTOR (k+1 downto 0);
           sel1: out std_logic);
end comp1;

architecture arch_comp1 of comp1 is

begin
process (C1)
begin
	if C1 >= P then
	   sel1 <='1';
	else
      sel1 <= '0';
   end if;
end process;

end arch_comp1;

