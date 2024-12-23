----------------------------------------------------------------------------------
-- Company: Macquarie University
-- Engineer: MD SELIM HOSSAIN
-- Supervisor: Dr Yinan Kong
-- Create Date:    20:50:22 01/20/2016 
--Modified: 04 Feb 2016
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ECC_package_PF.all;

entity Reg_MM_new is
    generic (k : integer := 256);
    Port ( D : in  STD_LOGIC_VECTOR (k-1 downto 0);
           clk, rst : in  STD_LOGIC;
			  start: in std_logic;
           Q : out  STD_LOGIC_VECTOR (k-1 downto 0));
end Reg_MM_new;

architecture arch_Reg_MM_new of Reg_MM_new is
begin
CU: process(clk,rst)
 begin        
if rst = '1' then 
	   Q <= (OTHERS=>'0');	
	ELSIF (clk'EVENT AND clk = '1') THEN
	if start = '1' then
	   Q <= (OTHERS=>'0');	   
   else
    	Q <= D;	
	end if;
end if;	
end process;

end arch_Reg_MM_new;
