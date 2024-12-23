--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:12:21 01/20/2016
-- Design Name:   
-- Module Name:   C:/Users/selim/Desktop/Research_Doc_All/PM_256_K_NEW/TB_PA.vhd
-- Project Name:  PM_256_K_NEW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PA_PF_256_bit_new1
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
--use work.ECC_package_PF.all;
library std;
use std.textio.all; --include package textio.vhd
 
ENTITY TB_PA IS
END TB_PA;
 
ARCHITECTURE behavior OF TB_PA IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PA_256
    PORT(
         X1 : IN  std_logic_vector(255 downto 0);
         Y1 : IN  std_logic_vector(255 downto 0);
         Z1 : IN  std_logic_vector(255 downto 0);
         X2 : IN  std_logic_vector(255 downto 0);
         Y2 : IN  std_logic_vector(255 downto 0);
         Z2 : IN  std_logic_vector(255 downto 0);
         X3 : OUT  std_logic_vector(255 downto 0);
         Y3 : OUT  std_logic_vector(255 downto 0);
         Z3 : OUT  std_logic_vector(255 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         --done : OUT  std_logic;
         start : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X1 : std_logic_vector(255 downto 0) := (others => '0');
   signal Y1 : std_logic_vector(255 downto 0) := (others => '0');
   signal Z1 : std_logic_vector(255 downto 0) := (others => '0');
   signal X2 : std_logic_vector(255 downto 0) := (others => '0');
   signal Y2 : std_logic_vector(255 downto 0) := (others => '0');
   signal Z2 : std_logic_vector(255 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal start : std_logic := '0';

 	--Outputs
   signal X3 : std_logic_vector(255 downto 0);
   signal Y3 : std_logic_vector(255 downto 0);
   signal Z3 : std_logic_vector(255 downto 0);
  -- signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PA_256 PORT MAP (
          X1 => X1,
          Y1 => Y1,
          Z1 => Z1,
          X2 => X2,
          Y2 => Y2,
          Z2 => Z2,
          X3 => X3,
          Y3 => Y3,
          Z3 => Z3,
          clk => clk,
          rst => rst,
        --  done => done,
          start => start
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 


-- Stimulus process
   stim_proc: process
	file file1: text;
	variable fstatus : File_open_status;
	variable buff : line;
	
   begin		
    file_open (fstatus, file1, "TB_PA.txt",write_mode);
	 
      rst <= '1';	
      wait for clk_period;
      rst <= '0';
		start <= '1';
		
	--	X1 <= x"79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798";
		--Y1 <= x"483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8"; --1px,y,z
		--Z1 <= x"9BAE2D5BAC61E6EA5DE635BCA754B2564B7D78C45277CAD67E45C4CBBEA6E706";
		
		X1 <= x"79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798";
		Y1 <= x"483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8"; --1px,y,z
	   Z1 <= x"0000000000000000000000000000000000000000000000000000000000000001";		
		
		X2 <= x"7D152C041EA8E1DC2191843D1FA9DB55B68F88FEF695E2C791D40444B365AFC2";
		Y2 <= x"56915849F52CC8F76F5FD7E4BF60DB4A43BF633E1B1383F85FE89164BFADCBDB"; --2px,y,z
		Z2 <= x"9075B4EE4D4788CABB49F7F81C221151FA2F68914D0AA833388FA11FF621A970";
		
		wait for clk_period;
		start <= '0';
		wait for clk_period*1550;
--		
--		start <= '1';
--		X1 <= x"7D152C041EA8E1DC2191843D1FA9DB55B68F88FEF695E2C791D40444B365AFC2";
--		Y1 <= x"56915849F52CC8F76F5FD7E4BF60DB4A43BF633E1B1383F85FE89164BFADCBDB"; --2px,y,z
--		Z1 <= x"9075B4EE4D4788CABB49F7F81C221151FA2F68914D0AA833388FA11FF621A970";		
--		
--		
--		--start <= '1';
--		X2 <= x"0CA90EF9B06D7EB51D650E9145E3083CBD8DF8759168862036F97A358F089848";
--		Y2 <= x"435AFE76017B8D55D04FF8A98DD60B2BA7EB6F87F6B28182CA4493D7165DD127"; --3px,y,z
--		Z2 <= x"9242FA9C0B9F23A3BFEA6A0EB6DBCFCBC4853FE9A25EE948105DC66A2A9B5BAA";
--		--wait for clk_period;
--		
		
--		X2 <= x"9BAE2D5BAC61E6EA5DE635BCA754B2564B7D78C45277CAD67E45C4CBBEA6E706";
--		Y2 <= x"34FB8147EED1C0FBE29EAD4D6C472EB4EF7B2191FDE09E494B2A9845FE3F605E"; --4px,y,z
--		Z2 <= x"C327B5D2636B32F27B051E4742B1BBD5324432C1000BFEDCA4368A29F6654152";
		

		wait for clk_period;		
		
		write (buff, string '("X1="));
      write (buff, X1);
		writeline (file1, buff);
		
		write (buff, string '("Y1="));
      write (buff, Y1);
		writeline (file1, buff);
		
		write (buff, string '("Z1="));
      write (buff, Z1);
		writeline (file1, buff);
		
		write (buff, string '("X2="));
      write (buff, X2);
		writeline (file1, buff);
		
		write (buff, string '("Y2="));
      write (buff, Y2);
		writeline (file1, buff);
		
		write (buff, string '("Z2="));
      write (buff, Z2);
		writeline (file1, buff);
		
wait for 200000 ns;
		
		write (buff, string '("X3="));
      write (buff, X3);
		writeline (file1, buff);
		
		write (buff, string '("Y3="));
      write (buff, Y3);
		writeline (file1, buff);
		
		write (buff, string '("Z3="));
      write (buff, Z3);
		writeline (file1, buff);
					
      wait;
   end process;	

END;

