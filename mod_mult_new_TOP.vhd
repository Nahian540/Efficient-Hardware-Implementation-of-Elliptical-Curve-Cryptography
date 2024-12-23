----------------------------------------------------------------------------------
-- Engineer: MD SELIM HOSSAIN
-- Supervisor: Dr Yinan Kong
-- Create Date:    19:48:10 01/27/2016 
-- modified Date:    19:48:10 04/02/2016 
-- Further Modified: 11 Feb 2016
-- Design Name: final improved interleaved MM alg mod_mult for 256 bit ECC over PF
-- Module Name:    mod_mult_new_TOP - arch_mod_mult_new_TOP
-- Project Name: mult for Hardware Implementation of ECC over PF_256 bit
-- Description: For koblitz curve.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.ECC_package_PF.all;

entity mod_mult_new_TOP is
    generic (k : integer := 256);
    Port ( A : in  STD_LOGIC_VECTOR (k-1 downto 0);
           B : in  STD_LOGIC_VECTOR (k-1 downto 0);
           clk,rst : in  STD_LOGIC;
           start : in  STD_LOGIC;
           done : out  STD_LOGIC;
           C : out  STD_LOGIC_VECTOR (k-1 downto 0));
end mod_mult_new_TOP;

architecture arch_mod_mult_new_TOP of mod_mult_new_TOP is
--constant A: std_logic_vector(n-1 downto 0):= x"0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F";
--constant B: std_logic_vector(n-1 downto 0):= x"F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F";
signal Css : std_logic_vector(k-1 downto 0);
signal c1, I1s : std_logic_vector(k-1 downto 0);
signal c4: std_logic_vector(k downto 0);
signal c5,c8: std_logic_vector(k+1 downto 0);
signal c6 : std_logic_vector(k downto 0);
--signal  count_3: integer range 0 to 3;
signal  count_MM: integer range 0 to k-1;
signal  count_new: std_logic_vector(7 downto 0);
signal As : std_logic;

signal done_Flag : std_logic;

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

component comp1
    generic (k : integer := 256);
    Port ( C1 : in  STD_LOGIC_VECTOR (k downto 0);
	           So1 : out  STD_LOGIC_VECTOR (k downto 0));
          
end component;

 component comp2
 generic (k : integer := 256);
    Port ( C2 : in  STD_LOGIC_VECTOR (k+1 downto 0);
	           So2 : out  STD_LOGIC_VECTOR (k+1 downto 0));
    
 end component;



begin

uut_Reg_MM_new_C: Reg_MM_new generic map(k=>256) port map (D=>Css, Q=>c1, clk=>clk, rst =>rst,start=>start);

count_new <= std_logic_vector(to_unsigned(count_MM, 8));
uut_MUX_sel: MUX generic map(k=>256) port map (Ain=>A, sel=>count_new, Aout=>As); 
uut_and_gate: and_mult generic map(k=>256) port map (X=>As, Y=>B, I1=>I1s);

uut_left_shift: mult_by_2 generic map(k=>256) port map (Ci=>c1, Co=>c4);
uut_comp1: comp1 generic map(k=>256) port map (C1=>c4, So1=>c6);

uut_add: adder generic map(k=>256) port map (Cin=>c6, Iin=>I1s, Cout=>c5);
uut_comp2: comp2 generic map(k=>256) port map (C2=>c5, So2=>c8);
Css <= c8(k-1 downto 0);

CU_MM: process(clk,rst)
begin        
if rst = '1' then 
	   count_MM <= 0;
		done <= '0';
      C <= zero;	
		done_Flag <= '0';
ELSIF (clk'EVENT AND clk = '1') THEN
	  done <= '0';
	if (count_MM = 0) then	
		if done_Flag='1' then
			done <= '1';
			C <=Css ;
			done_Flag <= '0';
		end if;
		--C <=Css ;	  
		if  (start = '1') then
			count_MM <= k-1;				
		end if;
	else
		done_Flag <= '1';
		count_MM <= count_MM - 1;
		done <= '0';
	end if;		
end if;	
end process;
end arch_mod_mult_new_TOP;
