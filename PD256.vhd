library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ECC_package_PF.all;

entity PF_PD_256_Jac_new1 is
    generic (k : integer := 256);
    Port ( X1 : in STD_LOGIC_vector(k-1 downto 0);
           Y1 : in  STD_LOGIC_vector(k-1 downto 0);
			  Z1 : in  STD_LOGIC_vector(k-1 downto 0);
			  X3 : out  STD_LOGIC_VECTOR (k-1 downto 0);
           Y3 : out  STD_LOGIC_VECTOR (k-1 downto 0);
           Z3 : out  STD_LOGIC_VECTOR (k-1 downto 0);
           
			  clk  : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  start : in STD_LOGIC;
			  done : out std_logic

			  );
end PF_PD_256_Jac_new1;

architecture arch_PF_PD_256_Jac_new1 of PF_PD_256_Jac_new1 is

signal  SQ1, SQ2, M1: STD_LOGIC_vector(k-1 downto 0);
signal d1, d2, d3: STD_LOGIC;

--signal for Level 2
signal  A1,M2,SQ3: STD_LOGIC_vector(k-1 downto 0);
signal d4,d5: STD_LOGIC;
--level 3
signal  A2,A3,A4,M2ds: STD_LOGIC_vector(k-1 downto 0);
signal d6: STD_LOGIC;

--signal for Level 4
signal  SQ4,A5,A6,A7,A8,A5s,A7s,A6s: STD_LOGIC_vector(k-1 downto 0);
signal d7,d6s,d7s,d7ss: STD_LOGIC;

--signal for Level 5
signal S1,SQ4s: STD_LOGIC_vector(k-1 downto 0);
signal d8: STD_LOGIC;
--level 6
signal SQ4ss,S2: STD_LOGIC_vector(k-1 downto 0);
signal d9: STD_LOGIC;
--level 7
signal M3,A9: STD_LOGIC_vector(k-1 downto 0);
signal d10: STD_LOGIC;
--level 8
signal S3: STD_LOGIC_vector(k-1 downto 0);

component add_PF_256_bit_new1 
generic (k : integer := 256);
	PORT(A, B : IN std_logic_vector(k-1 downto 0);
	        clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  start: in  STD_LOGIC;
	C : OUT std_logic_vector(k-1 downto 0));
end component;

component sub_PF_256_bit_new1 
generic (k : integer := 256);
	PORT(A, B : IN std_logic_vector(k-1 downto 0);
	        clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  start: in  STD_LOGIC;
	        C : OUT std_logic_vector(k-1 downto 0));
end component;

component mod_mult_new_TOP 
    generic (k : integer := 256);
    Port ( A : in  STD_LOGIC_VECTOR (k-1 downto 0);
           B : in  STD_LOGIC_VECTOR (k-1 downto 0);
           clk,rst : in  STD_LOGIC;
           start: in  STD_LOGIC;
           done : out  STD_LOGIC;
           C : out  STD_LOGIC_VECTOR (k-1 downto 0));
end component;

component mod_SQ_new_TOP 
    generic (k : integer := 256);
    Port ( A : in  STD_LOGIC_VECTOR (k-1 downto 0);
           clk,rst : in  STD_LOGIC;
           start : in  STD_LOGIC;
           done : out  STD_LOGIC;
           C : out  STD_LOGIC_VECTOR (k-1 downto 0));
end component;

component Reg_PDPA_new 
    generic (k : integer := 256);
    Port ( D : in  STD_LOGIC_VECTOR (k-1 downto 0);
           clk, rst : in  STD_LOGIC;
			  start: in std_logic;
			  done : out std_logic;
           Q : out  STD_LOGIC_VECTOR (k-1 downto 0));
end component;

--constant A : std_logic_vector(k-1 downto 0):=x"7D152C041EA8E1DC2191843D1FA9DB55B68F88FEF695E2C791D40444B365AFC2";
--constant B : std_logic_vector(k-1 downto 0):=x"56915849F52CC8F76F5FD7E4BF60DB4A43BF633E1B1383F85FE89164BFADCBDB";
--signal for Level 1





begin

MSQ1_PD : mod_mult_new_TOP generic map(k=>256) port map (A=>X1, B=>X1, C=>SQ1, CLK=>CLK, rst=>rst, start=>start, done=>d1);
MSQ2_PD : mod_mult_new_TOP generic map(k=>256) port map (A=>Y1, B=>Y1, C=>SQ2, CLK=>CLK, rst=>rst, start=>start, done=>d2);
MM1_PD : mod_mult_new_TOP generic map(k=>256) port map (A=>Y1, B=>Z1, C=>M1, CLK=>CLK, rst=>rst,  start=>start,done=>d3);
--------------------------------------------------------------------------------------------------------------------------------


MA1_PD : add_PF_256_bit_new1 generic map(k=>256) port map (A=>SQ1, B=>SQ1, C=>A1, CLK=>CLK, rst=>rst, start=>d3);
MM2_PD : mod_mult_new_TOP generic map(k=>256) port map (A=>SQ2, B=>X1, C=>M2, CLK=>CLK, rst=>rst,  start=>d3,done=>d4);
MSQ3_PD : mod_mult_new_TOP generic map(k=>256) port map (A=>SQ2, B=>SQ2, C=>SQ3, CLK=>CLK, rst=>rst, start=>d3, done=>d5);


-----------------------------------------------------------------------------------------------------------------------------------
M2ds_PD : Reg_PDPA_new generic map(k=>256) port map (D=>M2, Q=>M2ds, start=>d4, done=>d6, clk=>clk, rst=>rst);
MA2_PD : add_PF_256_bit_new1 generic map(k=>256) port map (A=>SQ1, B=>A1, C=>A2, CLK=>CLK, rst=>rst, start=>d4);
MA3_PD : add_PF_256_bit_new1 generic map(k=>256) port map (A=>M2, B=>M2, C=>A3, CLK=>CLK, rst=>rst, start=>d4);
MA4_PD : add_PF_256_bit_new1 generic map(k=>256) port map (A=>SQ3, B=>SQ3, C=>A4, CLK=>CLK, rst=>rst, start=>d5);
----------------------------------------------------------------------------------------------------------------------------------
MSQ4_PD : mod_mult_new_TOP generic map(k=>256) port map (A=>A2, B=>A2, C=>SQ4, CLK=>CLK, rst=>rst, start=>d6, done=>d7);
MA5_PD : add_PF_256_bit_new1 generic map(k=>256) port map (A=>A3, B=>A3, C=>A5, CLK=>CLK, rst=>rst, start=>d6);
MA5s_PD : Reg_PDPA_new generic map(k=>256) port map (D=>A5, Q=>A5s, start=>d7, done=>d6s, clk=>clk, rst=>rst);
MA6_PD : add_PF_256_bit_new1 generic map(k=>256) port map (A=>A5s, B=>A5s, C=>A6, CLK=>CLK, rst=>rst, start=>d6s);
MA7_PD : add_PF_256_bit_new1 generic map(k=>256) port map (A=>A4, B=>A4, C=>A7, CLK=>CLK, rst=>rst, start=>d6);
MA7s_PD : Reg_PDPA_new generic map(k=>256) port map (D=>A7, Q=>A7s, start=>d7, done=>d7s, clk=>clk, rst=>rst);
MA6s_PD : Reg_PDPA_new generic map(k=>256) port map (D=>A7s, Q=>A6s, start=>d7s, done=>d7ss, clk=>clk, rst=>rst);
MA8_PD : add_PF_256_bit_new1 generic map(k=>256) port map (A=>A7s, B=>A7s, C=>A8, CLK=>CLK, rst=>rst, start=>d7s);
---------------------------------------------------------------------------------------------------------------------------------
MS1_PD : sub_PF_256_bit_new1 generic map(k=>256) port map (A=>SQ4, B=>A6, C=>S1, CLK=>CLK, rst=>rst,  start=>d7ss);
SQ4s_PD : Reg_PDPA_new generic map(k=>256) port map (D=>SQ4, Q=>SQ4s, start=>d7ss, done=>d8, clk=>clk, rst=>rst);
-------------------------------------------------------------------------------------------------------------------------
MS2_PD : sub_PF_256_bit_new1 generic map(k=>256) port map (A=>A5, B=>S1, C=>S2, CLK=>CLK, rst=>rst,  start=>d8);
SQ4ss_PD : Reg_PDPA_new generic map(k=>256) port map (D=>SQ4s, Q=>SQ4ss, start=>d8, done=>d9, clk=>clk, rst=>rst);
-----------------------------------------------------------------------------------------------------------------
MM3_PD : mod_mult_new_TOP generic map(k=>256) port map (A=>A2, B=>S2, C=>M3, CLK=>CLK, rst=>rst, start=>d9, done=>d10);
MA9_PD : add_PF_256_bit_new1 generic map(k=>256) port map (A=>M1, B=>M1, C=>A9, CLK=>CLK, rst=>rst, start=>d9);
-----------------------------------------------------------------------------------------------------------
MS3_PD : sub_PF_256_bit_new1 generic map(k=>256) port map (A=>M3, B=>A8, C=>S3, CLK=>CLK, rst=>rst,  start=>d10);
-----------------------------------------------------------------------------------------------------------------
control_PD:process(X1, Y1, Z1, S1, S3, A9, rst, d10)
begin	
		if(X1 = x"0000000000000000000000000000000000000000000000000000000000000000" and 	
		Y1 = x"0000000000000000000000000000000000000000000000000000000000000000" and 
		Z1 = x"0000000000000000000000000000000000000000000000000000000000000000" )then
			X3 <= x"0000000000000000000000000000000000000000000000000000000000000000";
			Y3 <= x"0000000000000000000000000000000000000000000000000000000000000000";
			Z3 <= x"0000000000000000000000000000000000000000000000000000000000000000";
			done <= '0';
		else 
 
			X3 <= S1;
		 Y3 <= S3;
		 Z3 <= A9;
		done <=d10;
	end if;
end process;
		 
		 end arch_PF_PD_256_Jac_new1;