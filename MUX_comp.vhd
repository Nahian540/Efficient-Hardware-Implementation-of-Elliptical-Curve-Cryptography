----------------------------------------------------------------------------------
-- Company: Macquarie University
-- Engineer: MD SELIM HOSSAIN
--Supervisor: Dr Yinan Kong
-- Create Date:    27 Feb 2016 
-- Module Name:  MUX1_comp
--for checking 1P or 2P or PA output
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ECC_package_PF.all;

entity MUX_comp is
   generic (k : integer := 256);
    Port ( c5s : in  STD_LOGIC_VECTOR (k+1 downto 0);
           c6s : in  STD_LOGIC_VECTOR (k+1 downto 0);
           c7s : in  STD_LOGIC_VECTOR (k+1 downto 0);
--			  sel3 : in std_logic;
--			  sel4 : in std_logic;			  
           sel3 : in  STD_LOGIC_VECTOR (1 downto 0);
           c8s : out  STD_LOGIC_VECTOR (k+1 downto 0));
end MUX_comp;

architecture arch_MUX_comp of MUX_comp is
--signal sels: std_logic_vector (1 downto 0);
begin
process(c5s, c6s, c7s, sel3)
begin

case sel3 is
  when "00" =>   c8s <= c5s;
  when "10" =>   c8s <= c6s;
  when "01" =>   c8s <= c7s;
  when others => c8s <= c7s;
end case;


--case is better than if else condition
--if (sel3 = '0' and sel4 = '0') then
--    c8s <= c5s;
--elsif (sel3 = '1' and sel4 = '0') then
--	 c8s <= c6s;
--elsif (sel3 = '0' and sel4 = '1') then
--    c8s <= c7s;
--else
--    c8s <= c7s;	 
--end if;

end process;
end arch_MUX_comp;

