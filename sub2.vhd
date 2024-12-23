----------------------------------------------------------------------------------
-- Company: Macquarie University
-- Engineer: MD SELIM HOSSAIN
-- Supervisor: Dr Yinan Kong
-- Create Date:    21:52:22 01/27/2016 
-- Design Name: sub2 for 256 bit ECC over PF
-- Module Name:    sub2 - Behavioral 
-- Project Name: mult for Hardware Implementation of ECC over PF_256 bit
-- Description: using latest TB and secp256k1 or koblitz curve.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use work.ECC_package_PF.all; 

entity sub2 is
    generic (k : integer := 256);
    Port ( S2 : in  STD_LOGIC_VECTOR (k+1 downto 0);
           So2 : out  STD_LOGIC_VECTOR (k+1 downto 0));
end sub2;

architecture arch_sub2 of sub2 is

begin

 --So2 <= S2 - ('0'&P2);
 
 So2 <= S2 + (not ('0'&P2)) + '1';

end arch_sub2;

