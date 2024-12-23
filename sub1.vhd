----------------------------------------------------------------------------------
-- Company: Macquarie University
-- Engineer: MD SELIM HOSSAIN
-- Supervisor: Dr Yinan Kong
-- Create Date:    21:52:22 01/27/2016 
-- Design Name: sub1 for 256 bit ECC over PF
-- Module Name:    sub1 - Behavioral 
-- Project Name: mult for Hardware Implementation of ECC over PF_256 bit
-- Description: using latest TB and secp256k1 or koblitz curve.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use work.ECC_package_PF.all; 

entity sub1 is
    generic (k : integer := 256);
    Port ( S1 : in  STD_LOGIC_VECTOR (k+1 downto 0);
           So1 : out  STD_LOGIC_VECTOR (k+1 downto 0));
end sub1;

architecture arch_sub1 of sub1 is

begin

-- So1 <= S1 - ("00"&P);
 
 So1 <= S1 + (not("00"&P)) + '1';

end arch_sub1;

