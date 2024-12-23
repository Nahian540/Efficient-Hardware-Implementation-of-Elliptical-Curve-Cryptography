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

entity comp2 is
    generic (k : integer := 256);
    Port ( C2 : in  STD_LOGIC_VECTOR (k+1 downto 0);
	           So2 : out  STD_LOGIC_VECTOR (k+1 downto 0));
          
end comp2;

architecture arch_comp2 of comp2 is

begin
process (C2)
begin
	if C2 >= P then
	So2 <= (C2) + (not("00"&P)) + '1';
    else
	So2 <=( C2) ;
	
   end if;
end process;

end arch_comp2;

