
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use ieee.numeric_std.all;
use work.ECC_package_PF.all;
entity PA_256 is
	 generic ( k : integer := 256);
    Port ( X1 : in STD_LOGIC_vector(k-1 downto 0);
           Y1 : in  STD_LOGIC_vector(k-1 downto 0);
		   Z1 : in STD_LOGIC_vector(k-1 downto 0);
		   X2 : in STD_LOGIC_vector(k-1 downto 0);
           Y2 : in  STD_LOGIC_vector(k-1 downto 0);
           Z2 : in  STD_LOGIC_vector(k-1 downto 0);
           X3 : out  STD_LOGIC_vector(k-1 downto 0);
           Y3 : out  STD_LOGIC_vector(k-1 downto 0);
		     Z3 : out STD_LOGIC_vector(k-1 downto 0);

			  CLK  : in  STD_LOGIC;
              rst : in  STD_LOGIC;
			  done : out STD_LOGIC;
			  start : in STD_LOGIC);
end PA_256;
architecture arch_PA_256 of PA_256 is

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
--signal for Level 1
signal  SQ1, SQ2: STD_LOGIC_vector(k-1 downto 0);
signal d1, d2 : STD_LOGIC;

--signal for Level 2

signal  M1,M2,M3,M4,M5: STD_LOGIC_vector(k-1 downto 0);
signal d3,d4,d5,d6,d7: STD_LOGIC;

--signal for Level 3
signal  M6,S1,M7: STD_LOGIC_vector(k-1 downto 0);
signal d8,d9: STD_LOGIC;

--signal for Level 4
signal S2,M7s: STD_LOGIC_vector(k-1 downto 0);
signal d10: STD_LOGIC;
--level5
signal SQ3,SQ4: STD_LOGIC_vector(k-1 downto 0);
signal d11,d12: STD_LOGIC;
--level 6
signal M8,M9,M10: STD_LOGIC_vector(k-1 downto 0);
signal d13,d14,d15: STD_LOGIC;
---level 7
signal S3,A,M8s: STD_LOGIC_vector(k-1 downto 0);
signal d16: STD_LOGIC;

---signal for Level 8
signal S4,S4s,M8ss: STD_LOGIC_vector(k-1 downto 0);
signal d17,d16s : std_logic;

---signal for Level 9
signal S5,S5s,M8sss: STD_LOGIC_vector(k-1 downto 0);
signal d18,d17s: STD_LOGIC;
--level 10
signal M12,M13: STD_LOGIC_vector(k-1 downto 0);
signal d19,d20: STD_LOGIC;


---signal for Level 11
signal S6: STD_LOGIC_vector(k-1 downto 0);

begin
uut_MSQ1_PA : mod_mult_new_TOP generic map(k=>256)  port map (A=>Z1, B=>Z1, C=>SQ1, CLK=>CLK, rst=>rst, start=>start, done=>d1);
uut_MSQ2_PA : mod_mult_new_TOP generic map(k=>256)  port map (A=>Z2,B=>Z2, C=>SQ2, CLK=>CLK, rst=>rst, start=>start, done=>d2);
---------------------------------------------------------------------------------------------------------
uut_MM1_PA : mod_mult_new_TOP generic map(k=>256) port map (A=>SQ1, B=>Z1, C=>M1, CLK=>CLK, rst=>rst, start=>d1, done=>d3);
uut_MM2_PA : mod_mult_new_TOP generic map(k=>256) port map (A=>SQ1, B=>X2, C=>M2, CLK=>CLK, rst=>rst, start=>d1, done=>d4);
uut_MM3_PA : mod_mult_new_TOP generic map(k=>256) port map (A=>SQ2, B=>X1, C=>M3, CLK=>CLK, rst=>rst, start=>d2, done=>d5);
uut_MM4_PA : mod_mult_new_TOP generic map(k=>256) port map (A=>SQ2, B=>Z2, C=>M4, CLK=>CLK, rst=>rst, start=>d2, done=>d6);
uut_MM5_PA : mod_mult_new_TOP  generic map(k=>256)port map (A=>Z1, B=>Z2, C=>M5, CLK=>CLK, rst=>rst, start=>d2, done=>d7);
--------------------------------------------------------------------------------------------------------------------------------
uut_MM6_PA : mod_mult_new_TOP generic map(k=>256) port map (A=>M1, B=>Y2, C=>M6, CLK=>CLK, rst=>rst, start=>d3,done=>d8);
uut_MS1_PA : sub_PF_256_bit_new1 generic map(k=>256) port map (A=>M2, B=>M3, C=>S1, CLK=>CLK, rst=>rst,  start=>d4);

uut_MM7_PA : mod_mult_new_TOP  generic map(k=>256)port map (A=>Y1, B=>M4, C=>M7, CLK=>CLK, rst=>rst, start=>d6,done=>d9);
-----------------------------------------------------------------------------------------------------------
uut_MS2_PA : sub_PF_256_bit_new1 generic map(k=>256) port map (A=>M6, B=>M7, C=>S2, CLK=>CLK, rst=>rst,  start=>d9);
uut_uut_M7s : Reg_PDPA_new generic map(k=>256) port map (D=>M7, Q=>M7s, CLK=>CLK, rst=>rst, start=>d9, done=>d10);

-----------------------------------------------------------------------------------------------------------------
uut_MSQ3_PA : mod_SQ_new_TOP generic map(k=>256)  port map (A=>S2, C=>SQ3, CLK=>CLK, rst=>rst, start=>d10, done=>d11);
uut_MSQ4_PA : mod_SQ_new_TOP generic map(k=>256) port map (A=>S1, C=>SQ4, CLK=>CLK, rst=>rst, start=>d10, done=>d12);

----------------------------------------------------------------------------------------------------------------------------------
uut_MM8_PA : mod_mult_new_TOP generic map(k=>256) port map (A=>M3, B=>SQ4, C=>M8, CLK=>CLK, rst=>rst, start=>d12, done=>d13);
uut_MM9_PA : mod_mult_new_TOP generic map(k=>256) port map (A=>S1, B=>SQ4, C=>M9, CLK=>CLK, rst=>rst, start=>d12, done=>d14);
uut_MM10_PA : mod_mult_new_TOP generic map(k=>256) port map (A=>M5, B=>S1, C=>M10, CLK=>CLK, rst=>rst, start=>d12, done=>d15);
-----------------------------------------------------------------------------------------------------------------------------------

uut_MA1_PA : add_PF_256_bit_new1 generic map(k=>256) port map (A=>M8, B=>M8, C=>A, CLK=>CLK, rst=>rst, start=>d13);
uut_MS3_PA : sub_PF_256_bit_new1 generic map(k=>256) port map (A=>SQ3, B=>M9, C=>S3, CLK=>CLK, rst=>rst,  start=>d14);
uut_M8s : Reg_PDPA_new generic map(k=>256) port map (D=>M8, Q=>M8s, CLK=>CLK, rst=>rst, start=>d13, done=>d16);

----------------------------------------------------------------------------------------------------------------------------------
uut_MS4_PA : sub_PF_256_bit_new1 generic map(k=>256)  port map (A=>S3, B=>A, C=>S4, CLK=>CLK, rst=>rst, start=>d16);
uut_Ms : Reg_PDPA_new generic map(k=>256) port map (D=>M8s, Q=>M8ss, CLK=>CLK, rst=>rst, start=>d16, done=>d16s);

uut_M8ss : Reg_PDPA_new generic map(k=>256) port map (D=>S4, Q=>S4s, CLK=>CLK, rst=>rst, start=>d16s, done=>d17);
-----------------------------------------------------------------------------------------------------------------------
uut_MS5_PA : sub_PF_256_bit_new1 generic map(k=>256) port map (A=>M8, B=>S4s, C=>S5, CLK=>CLK, rst=>rst, start=>d17);
uut_s : Reg_PDPA_new generic map(k=>256) port map (D=>M8ss, Q=>M8sss, CLK=>CLK, rst=>rst, start=>d17, done=>d17s);

uut_M8sss : Reg_PDPA_new generic map(k=>256) port map (D=>S5, Q=>S5s, CLK=>CLK, rst=>rst, start=>d17s, done=>d18);

----------------------------------------------------------------------------------------------------------------------------------
uut_MM12_PA : mod_mult_new_TOP generic map(k=>256) port map (A=>S5s, B=>S2, C=>M12, CLK=>CLK, rst=>rst, start=>d18,done=>d19);
--uut_s : Reg_PDPA_new generic map(k=>256) port map (D=>M8, Q=>M8s, CLK=>CLK, rst=>rst, start=>d13, done=>d16);

uut_MM11_PA : mod_mult_new_TOP generic map(k=>256) port map (A=>M9, B=>M7, C=>M13, CLK=>CLK, rst=>rst, start=>d18,done=>d20);
----------------------------------------------------------------------------------------------------------------------------------
uut_MS6_PA : sub_PF_256_bit_new1 generic map(k=>256) port map (A=>M12, B=>M13, C=>S6, CLK=>CLK, rst=>rst, start=>d20);
------------------------------------------------------------------------------------------------------------
control_PA_JAC:process(X1, X2, Y1, Y2, Z1, Z2, S4, S6, M10, rst, d20)
begin
	
if (rst = '0') then
	if (X1 = x"0000000000000000000000000000000000000000000000000000000000000000" and	
	Y1 = x"0000000000000000000000000000000000000000000000000000000000000000" and 
	Z1 = x"0000000000000000000000000000000000000000000000000000000000000000" and 
	X2 = x"0000000000000000000000000000000000000000000000000000000000000000" and	
	Y2 = x"0000000000000000000000000000000000000000000000000000000000000000" and 
	Z2 = x"0000000000000000000000000000000000000000000000000000000000000000") then		
		X3 <= x"0000000000000000000000000000000000000000000000000000000000000000";
		Y3 <= x"0000000000000000000000000000000000000000000000000000000000000000";
		Z3 <= x"0000000000000000000000000000000000000000000000000000000000000000";
      done <= '0';
	elsif (X1 = X2 and Y1 = Y2 and Z1 = Z2) then		
		X3 <= Q2X;
		Y3 <= Q2Y;
		Z3 <= Q2Z;
      done <= '1';
	elsif (X2 = x"0000000000000000000000000000000000000000000000000000000000000000" and
	Y2 = x"0000000000000000000000000000000000000000000000000000000000000000" and 
	Z2 = x"0000000000000000000000000000000000000000000000000000000000000000") then
		X3 <= X1;
		Y3 <= Y1;
		Z3 <= Z1;
		done <= '1';		
	elsif (X1 = x"0000000000000000000000000000000000000000000000000000000000000000" and
	Y1 = x"0000000000000000000000000000000000000000000000000000000000000000" and 
	Z1 = x"0000000000000000000000000000000000000000000000000000000000000000") then
		X3 <= X2;
		Y3 <= Y2;
		Z3 <= Z2;
		done <= '1';
	else
			X3 <=S4;
			Y3 <=S6;
			Z3 <=M10;
			done <= d20;
	end if;
    end if;
end process;
		--end if;
--end process;

end arch_PA_256;

