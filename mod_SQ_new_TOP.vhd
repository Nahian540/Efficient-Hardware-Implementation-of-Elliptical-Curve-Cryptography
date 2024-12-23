----------------------------------------------------------------------------------
-- Engineer: MD SELIM HOSSAIN
-- Supervisor: Dr Yinan Kong
-- Create Date:    19:48:10 01/27/2016 
--Modified : 04/02/2016
--Further Modified: 11 Feb 2016
-- Design Name: final improved interleaved MM alg mod_mult for 256 bit ECC over PF
-- Module Name:    mod_SQ_new_TOP - arch_mod_SQ_new_TOP
-- Project Name: mult for Hardware Implementation of ECC over PF_256 bit
-- Description: For koblitz curve.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.std_logic_unsigned.ALL;
--unsigned and numeric together not good, 
--to perform + - use unsigned value using numeric library
use work.ECC_package_PF.all;
use ieee.numeric_std.all; 

entity mod_SQ_new_TOP is
    generic (k : integer := 256);
    Port ( 
	        A : in  STD_LOGIC_VECTOR (k-1 downto 0);
           clk,rst : in  STD_LOGIC;
           start: in  STD_LOGIC;
           done : out  STD_LOGIC;
           C : out  STD_LOGIC_VECTOR (k-1 downto 0));
end mod_SQ_new_TOP;

architecture arch_mod_SQ_new_TOP of mod_SQ_new_TOP is
--constant A : std_logic_vector(k-1 downto 0):=x"79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798";

component Reg_MM_new is
    generic (k : integer := 256);
    Port ( D : in  STD_LOGIC_VECTOR (k-1 downto 0);
           clk, rst : in  STD_LOGIC;
			  start: in std_logic;
           Q : out  STD_LOGIC_VECTOR (k-1 downto 0));
end component;

component MUX 
    generic (k : integer := 256);
    Port ( Ain : in  STD_LOGIC_VECTOR (k-1 downto 0);
	        sel : in  STD_LOGIC_VECTOR (7 downto 0);
           Aout : out  STD_LOGIC);
end component;

component and_mult
generic (k : integer := 256);
    Port ( X : in  STD_LOGIC;
           Y : in  STD_LOGIC_VECTOR (k-1 downto 0);
           I1 : out  STD_LOGIC_VECTOR (k-1 downto 0));
end component;

component mult_by_2
generic (k : integer := 256);
    Port ( Ci : in  STD_LOGIC_VECTOR (k-1 downto 0);
           Co : out  STD_LOGIC_VECTOR (k downto 0));
end component;

component adder
generic (k : integer := 256);
    Port ( Cin : in  STD_LOGIC_VECTOR (k downto 0);
           Iin : in  STD_LOGIC_VECTOR (k-1 downto 0);
           Cout : out  STD_LOGIC_VECTOR (k+1 downto 0));
end component;

component sub1 
    generic (k : integer := 256);
    Port ( S1 : in  STD_LOGIC_VECTOR (k+1 downto 0);
           So1 : out  STD_LOGIC_VECTOR (k+1 downto 0));
end component;

component sub2
    generic (k : integer := 256);
    Port ( S2 : in  STD_LOGIC_VECTOR (k+1 downto 0);
           So2 : out  STD_LOGIC_VECTOR (k+1 downto 0));
end component;

component comp1
    generic (k : integer := 256);
    Port ( C1 : in  STD_LOGIC_VECTOR (k+1 downto 0);
           sel1: out std_logic);
end component;

component comp2
    generic (k : integer := 256);
    Port ( C2 : in  STD_LOGIC_VECTOR (k+1 downto 0);
           sel2: out std_logic);
end component;

component MUX_comp 
   generic (k : integer := 256);
    Port ( c5s : in  STD_LOGIC_VECTOR (k+1 downto 0);
           c6s : in  STD_LOGIC_VECTOR (k+1 downto 0);
           c7s : in  STD_LOGIC_VECTOR (k+1 downto 0);
           sel3 : in  STD_LOGIC_VECTOR (1 downto 0);
           c8s : out  STD_LOGIC_VECTOR (k+1 downto 0));
end component;
signal Css : std_logic_vector(k-1 downto 0);
signal c1, I1s : std_logic_vector(k-1 downto 0);
signal c4: std_logic_vector(k downto 0);
signal c5, c6, c7, c8: std_logic_vector(k+1 downto 0);
--signal  count_MM: integer range 0 to k-1; --use std_logic_vector instead of integer
--signal  count_new: std_logic_vector(7 downto 0);
signal  count_MM: std_logic_vector(7 downto 0);
signal As : std_logic;
signal sel1s, sel2s : std_logic;
signal  sel3s: std_logic_vector(1 downto 0);
signal done_Flag : std_logic;

begin

uut_Reg_MM_new_C: Reg_MM_new generic map(k=>256) port map (D=>Css, Q=>c1, clk=>clk, rst =>rst, start=>start);

--count_new <= std_logic_vector(to_unsigned(count_MM, 8)); --integr to unsigned conversion
--uut_MUX_sel: MUX generic map(k=>256) port map (Ain=>A, sel=>count_new, Aout=>As); --now no need this one bcz now directly using count_MM
 
uut_MUX_sel: MUX generic map(k=>256) port map (Ain=>A, sel=>count_MM, Aout=>As);

uut_left_shift: mult_by_2 generic map(k=>256) port map (Ci=>c1, Co=>c4);
uut_and_gate: and_mult generic map(k=>256) port map (X=>As, Y=>A, I1=>I1s);

uut_add: adder generic map(k=>256) port map (Cin=>c4, Iin=>I1s, Cout=>c5);

uut_sub1: sub1 generic map(k=>256) port map (S1=>c5, So1=>c6);
uut_sub2: sub2 generic map(k=>256) port map (S2=>c5, So2=>c7);

uut_comp1: comp1 generic map(k=>256) port map (C1=>c5, sel1=>sel1s);
uut_comp2: comp2 generic map(k=>256) port map (C2=>c5, sel2=>sel2s);
sel3s <= sel1s&sel2s;
uut_MUX_comp1: MUX_comp generic map(k=>256) port map (c5s=>c5, c6s=>c6, c7s=>c7, sel3=>sel3s, c8s=>c8);

Css <= c8(k-1 downto 0);

CU_MM: process(clk,rst)
begin        
if rst = '1' then 
		count_MM <= (OTHERS=>'0');
		done <= '0';
      C <= zero;	
		done_Flag <= '0';
ELSIF (clk'EVENT AND clk = '1') THEN
	  done <= '0';
	--if (count_MM = 0) then	
	if (count_MM = std_logic_vector(to_unsigned(0,8))) then --convert 0 to 8bit std_logic_vector
		if done_Flag='1' then
			done <= '1';
			C <=Css ;
			done_Flag <= '0';
		end if;
--		C <=Css ;	  
		if  (start = '1') then
			--count_MM <= k-1;
         count_MM <= std_logic_vector(to_unsigned(k-1,8));	--convert integer to unsigend then std_logic_vector		
		end if;
	else
		done_Flag <= '1';
		--count_MM <= count_MM - 1;
		count_MM <= std_logic_vector(unsigned(count_MM) - 1); --perform operation in unsigned then converting std_logic_vector
		done <= '0';
	end if;		
end if;	
end process;

end arch_mod_SQ_new_TOP;
