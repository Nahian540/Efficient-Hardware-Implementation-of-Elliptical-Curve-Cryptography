----------------------------------------------------------------------------------
-- Company: Macquarie University
-- Engineer: MD SELIM HOSSAIN
-- Supervisor: Dr Yinan Kong
-- Create Date:    21:52:22 01/20/2016 
-- Design Name: mult module for 256 bit ECC over PF
-- Module Name:    mult_PF_256_bit_new1 - Behavioral 
-- Project Name: mult for Hardware Implementation of ECC over PF_256 bit
-- Description: using latest TB and secp256k1 or koblitz curve.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity adder is
    generic (k : integer := 256);
    Port ( Cin : in  STD_LOGIC_VECTOR (k downto 0);
           Iin : in  STD_LOGIC_VECTOR (k-1 downto 0);
           Cout : out  STD_LOGIC_VECTOR (k+1 downto 0));
end adder;

architecture arch_adder of adder is

begin
Cout <= ('0'&Cin) + ("00"& Iin); 
end arch_adder;