--Md Selim Hossain
--mod_sub new design
--09 Feb 2016
--Modified: 11 Feb 2016
----------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; -- for addtiply operation
use work.ECC_package_PF.all;

entity sub_PF_256_bit_new1 is
generic (k : integer := 256);
	PORT(A, B : IN std_logic_vector(k-1 downto 0);
	        clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  start: in  STD_LOGIC;
	        C : OUT std_logic_vector(k-1 downto 0));
end sub_PF_256_bit_new1;

architecture arch_sub_PF_256_bit_new1 of sub_PF_256_bit_new1 is
begin

sub_pf_new: process(clk, rst)
variable temp1, temp2 : std_logic_vector(k downto 0);
begin
if rst = '1' then
		C <= (OTHERS=>'0');
elsif (clk'event and clk = '1') then

if  (start = '1') then
		if A>=B then
		  temp2 := ('0' & A) + (not B) + '1';
		else
        temp2 := ('0' & A) + (not B) + '1' + ('0' & P) ;
      end if;		  		
		  C <= temp2(k-1 downto 0);	
end if;
		
end if;
end process sub_pf_new;
end arch_sub_PF_256_bit_new1;
