
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PM is
	 generic ( K : integer := 256);
    Port ( 
           key : in  std_logic_vector(k-1 downto 0);
           QX : out  std_logic_vector(k-1 downto 0);
           QY : out  std_logic_vector(k-1 downto 0);
		   QZ : out  std_logic_vector(k-1 downto 0);
		   clk : in  std_logic;
		--   start : in  std_logic;
           rst : in  std_logic);
end PM;

architecture Behavioral of PM is

signal sQX : std_logic_vector(k-1 downto 0);
signal sQY : std_logic_vector(k-1 downto 0);
signal sQZ : std_logic_vector(k-1 downto 0);
signal Q2pX, Q2pY, Q2pZ : std_logic_vector(k-1 downto 0);
signal Q2X, Q2Y, Q2Z : std_logic_vector(k-1 downto 0);
signal  count: integer range 0 to k;
signal  done1, done2, done3: std_logic; 
signal  start1, rst1: std_logic; 
signal   check: std_logic; 

--constant PX : std_logic_vector(k-1 downto 0):= x"216936D3CD6E53FEC0A4E231FDD6DC5C692CC7609525A7B2C9562D608F25D51A";
--constant PY : std_logic_vector(k-1 downto 0):= x"6666666666666666666666666666666666666666666666666666666666666658";
--constant PZ : std_logic_vector(k-1 downto 0):= x"0000000000000000000000000000000000000000000000000000000000000001";

constant PX : std_logic_vector(k-1 downto 0):= x"79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798";
constant PY : std_logic_vector(k-1 downto 0):= x"483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8";
constant PZ : std_logic_vector(k-1 downto 0):= x"0000000000000000000000000000000000000000000000000000000000000001";

component PF_PD_256_Jac_new1
    Port (X1 : in STD_LOGIC_vector(k-1 downto 0);
           Y1 : in  STD_LOGIC_vector(k-1 downto 0);
			  Z1 : in  STD_LOGIC_vector(k-1 downto 0);
			  X3 : out  STD_LOGIC_VECTOR (k-1 downto 0);
           Y3 : out  STD_LOGIC_VECTOR (k-1 downto 0);
           Z3 : out  STD_LOGIC_VECTOR (k-1 downto 0);         
			  clk  : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  start : in STD_LOGIC;
			  done : out std_logic);
end component;

component PA_256
    Port (  X1 : in STD_LOGIC_vector(k-1 downto 0);
           Y1 : in  STD_LOGIC_vector(k-1 downto 0);
		   Z1 : in STD_LOGIC_vector(k-1 downto 0);
		   X2 : in STD_LOGIC_vector(k-1 downto 0);
           Y2 : in  STD_LOGIC_vector(k-1 downto 0);
           Z2 : in  STD_LOGIC_vector(k-1 downto 0);
           X3 : out  STD_LOGIC_vector(k-1 downto 0);
           Y3 : out  STD_LOGIC_vector(k-1 downto 0);
		     Z3 : out STD_LOGIC_vector(k-1 downto 0);
			  clk  : in  STD_LOGIC;
              rst : in  STD_LOGIC;
			  done : out STD_LOGIC;
			  start : in STD_LOGIC);
end component;

begin
point_double : PF_PD_256_Jac_new1 port map (X1=>sQX, Y1=>sQY, Z1=>sQZ, X3=>Q2X, Y3=>Q2Y, Z3=>Q2Z, clk=>clk, rst=>rst1,  done=>done1, start=>start1);
point_addition : PA_256 port map (X1=>PX, Y1=>PY, Z1=>PZ, X2=>Q2X, Y2=>Q2Y, Z2=>Q2Z, X3=>Q2pX, Y3=>Q2pY, Z3=>Q2pZ, clk=>clk, rst=>rst1, done=>done2, start=>done1);

control_unit: process(clk, rst)
begin
if (rst = '1') then
	rst1 <= '1';
	count <= k;
	QX <= x"0000000000000000000000000000000000000000000000000000000000000000";
	QY <= x"0000000000000000000000000000000000000000000000000000000000000000";
	QZ <= x"0000000000000000000000000000000000000000000000000000000000000000";
	sQX <= x"0000000000000000000000000000000000000000000000000000000000000000";
	sQY <= x"0000000000000000000000000000000000000000000000000000000000000000";
	sQZ <= x"0000000000000000000000000000000000000000000000000000000000000000";
	check <= '1';	
elsif(rst1 = '1') then
	rst1 <= '0';
	start1 <= '1';
	done3 <= '0';
elsif (clk'event and clk = '1') then
	if(done3 = '0') then
		if (key(count-1) = '1') then
			if(check = '1') then
				sQX <= PX;
				sQY <= PY;
				sQZ <= PZ;
				check <= '0';
			end if;		
			if(count = 0 or check = '1')then
				done3 <= '1';
			else
				done3 <= done2;
			end if;	
		else
			if(sQX = x"0000000000000000000000000000000000000000000000000000000000000000" and 
			sQY = x"0000000000000000000000000000000000000000000000000000000000000000" and 
			sQZ = x"0000000000000000000000000000000000000000000000000000000000000000")then
				done3 <= '1';
			else
				done3 <= done1;
			end if;
		end if;	
	else
		if(count-1 > 0) then
			if(key(count-1) = '1')then
				sQX <= Q2pX;
				sQY <= Q2pY;
				sQZ <= Q2pZ;
			else
				sQX <= Q2X;
				sQY <= Q2Y;
            sQZ <= Q2Z;					
			end if;
			count <= count - 1;
			rst1 <= '1';
		else
			if(key(count-1) = '1')then
				QX <= Q2pX;
				QY <= Q2pY;
				QZ <= Q2pZ;
			else
				QX <= Q2X;
				QY <= Q2Y;	
				QZ <= Q2Z;
			end if;
		end if;
	end if;
end if;
end process control_unit;
end Behavioral;


