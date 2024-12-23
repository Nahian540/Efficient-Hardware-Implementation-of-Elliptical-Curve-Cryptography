--MD Selim Hossain
--09 February 2016
--Modified: 11 Feb 2016
--mod_add seperate new design
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; -- for addtiply operation
use work.ECC_package_PF.all;

entity add_PF_256_bit_new1 is
generic (k : integer := 256);
	PORT(A, B : IN std_logic_vector(k-1 downto 0);
	        clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  start: in  STD_LOGIC;
	C : OUT std_logic_vector(k-1 downto 0));
end add_PF_256_bit_new1;

architecture arch_add_PF_256_bit_new1 of add_PF_256_bit_new1 is

begin

add_pf: process (clk,rst)
variable temp, Xtemp : std_logic_vector(k downto 0);
begin
if rst = '1' then
		temp := zero_plus;
		Xtemp := zero_plus;
		C <= zero;
elsif (clk'event and clk = '1') then
if (start = '1') then
     temp := ('0' & A) + ('0' & B);
	  --Xtemp := temp + (not ('0' & P)) + '1' ; --here not good in ASIC
	  if (temp(k)= '0') then
         Xtemp := temp;      
     else
	      Xtemp := temp + (not ('0' & P)) + '1';--this is good in terms of area
     end if;
   C <= Xtemp(k-1 downto 0);	
end if;
end if;
end process add_pf;
end arch_add_PF_256_bit_new1;
