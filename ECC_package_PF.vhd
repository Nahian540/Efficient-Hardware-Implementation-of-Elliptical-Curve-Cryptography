library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
--use IEEE.std_logic_unsigned.all;
package ECC_package_PF is  

constant n: integer := 256;
constant M: std_logic_vector(n-1 downto 0):= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"; --for 256 bit
constant o2: std_logic_vector(n+1 downto 0):= "00" & x"0000000000000000000000000000000000000000000000000000000000000000";	 -- for 258 bit
constant o: std_logic_vector(n-1 downto 0):= x"0000000000000000000000000000000000000000000000000000000000000000"; -- for 256 bit

constant k: integer := 256;
constant P: std_logic_vector(k-1 downto 0):=x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"; --for 256 bit
constant P2: std_logic_vector(k downto 0):= '1'&x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFF85E";
constant zero_plus: std_logic_vector(k downto 0):= '0' & x"0000000000000000000000000000000000000000000000000000000000000000";	 -- for 257 bit
constant zero_plus_plus: std_logic_vector(k+1 downto 0):= "00" & x"0000000000000000000000000000000000000000000000000000000000000000";	 -- for 258 bit
constant zero: std_logic_vector(k-1 downto 0):= x"0000000000000000000000000000000000000000000000000000000000000000"; -- for 256 bit
constant Z1 : std_logic_vector(k-1 downto 0):= x"0000000000000000000000000000000000000000000000000000000000000001";

--constant key : std_logic_vector(k-1 downto 0):= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";

constant Con_A: std_logic_vector(k-1 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
--constant three: std_logic_vector(k-1 downto 0) := conv_std_logic_vector(3, k);
--constant two: std_logic_vector(k-1 downto 0) := conv_std_logic_vector(2, k);

constant  P2X: STD_LOGIC_vector(k-1 downto 0):=x"7D152C041EA8E1DC2191843D1FA9DB55B68F88FEF695E2C791D40444B365AFC2";
constant  P2Y: STD_LOGIC_vector(k-1 downto 0):=x"56915849F52CC8F76F5FD7E4BF60DB4A43BF633E1B1383F85FE89164BFADCBDB";
constant  P2Z: STD_LOGIC_vector(k-1 downto 0):=x"9075B4EE4D4788CABB49F7F81C221151FA2F68914D0AA833388FA11FF621A970";

constant  Q2X: STD_LOGIC_vector(k-1 downto 0):=x"7D152C041EA8E1DC2191843D1FA9DB55B68F88FEF695E2C791D40444B365AFC2";
constant  Q2Y: STD_LOGIC_vector(k-1 downto 0):=x"56915849F52CC8F76F5FD7E4BF60DB4A43BF633E1B1383F85FE89164BFADCBDB";
constant  Q2Z: STD_LOGIC_vector(k-1 downto 0):=x"9075B4EE4D4788CABB49F7F81C221151FA2F68914D0AA833388FA11FF621A970";

constant PX : std_logic_vector(k-1 downto 0):= x"79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798";
constant PY : std_logic_vector(k-1 downto 0):= x"483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8";
constant PZ : std_logic_vector(k-1 downto 0):= x"0000000000000000000000000000000000000000000000000000000000000001";

--type regArray is array(0 to 769) of std_logic_vector(255 downto 0);
type regArray is array(0 to 256) of std_logic_vector(255 downto 0);
end ECC_package_PF;