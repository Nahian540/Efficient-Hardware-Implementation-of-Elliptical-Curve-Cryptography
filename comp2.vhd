----------------------------------------------------------------------------------
-- Company: Macquarie University
-- Engineer: MD SELIM HOSSAIN
-- Supervisor: Dr Yinan Kong
-- Create Date:    21:52:22 01/20/2016 
-- Design Name: comp2 mean comparator 2 for 256 bit ECC over PF
-- Module Name:    comp2 - Behavioral 
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
           sel2: out std_logic);
end comp2;

architecture arch_comp2 of comp2 is

begin
process (C2)
begin
	if C2 >= P2 then
	   sel2 <='1';
	else
      sel2 <= '0';
   end if;
end process;

end arch_comp2;

