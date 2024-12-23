--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:36:40 01/27/2016
-- Design Name:   
-- Module Name:   C:/Users/selim/Desktop/Research_Doc_All/PM_PD_PA_MM_new_old_add/TB_mod_mult_new_TOP.vhd
-- Project Name:  PM_256_K_NEW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mod_mult_new_TOP
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
------------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
library std;
use std.textio.all; --include package textio.vhd
 
ENTITY TB_mod_mult_new_TOP IS
END TB_mod_mult_new_TOP;
 
ARCHITECTURE behavior OF TB_mod_mult_new_TOP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mod_mult_new_TOP
    PORT(
         A : IN  std_logic_vector(255 downto 0);
         B : IN  std_logic_vector(255 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         start : IN  std_logic;
         done : OUT  std_logic;
         C : OUT  std_logic_vector(255 downto 0)
        );
    END COMPONENT;
	 
    

   --Inputs
   signal A : std_logic_vector(255 downto 0) := (others => '0');
   signal B : std_logic_vector(255 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal start : std_logic := '0';

 	--Outputs
   signal done : std_logic;
   signal C : std_logic_vector(255 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mod_mult_new_TOP PORT MAP (
          A => A,
          B => B,
          clk => clk,
          rst => rst,
          start => start,
          done => done,
          C => C
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
    file_open (fstatus, file1, "TB_MM_256_saj.txt",write_mode);
	 
      rst <= '1';	
      wait for clk_period;
      rst <= '0';
		start <= '1';
--	A <= x"9BAE2D5BAC61E6EA5DE635BCA754B2564B7D78C45277CAD67E45C4CBBEA6E706"; 
--	B <= x"9BAE2D5BAC61E6EA5DE635BCA754B2564B7D78C45277CAD67E45C4CBBEA6E706";

		A <= x"34FB8147EED1C0FBE29EAD4D6C472EB4EF7B2191FDE09E494B2A9845FE3F605E"; --4px,y,z
	B <= x"C327B5D2636B32F27B051E4742B1BBD5324432C1000BFEDCA4368A29F6654152";

 --  A <= x"0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F";
--	   B <= x"F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F";

		
 --  A <= x"B6F3C24C9E58802468FACF3F5A9ABE5ECCCED41C4BA16CA4A5FC4C1DDA1CC0C5";
-- B <= x"B6F3C24C9E58802468FACF3F5A9ABE5ECCCED41C4BA16CA4A5FC4C1DDA1CC0C5";

--		A <= x"79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798";
--		B <= x"483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8";		
		
--	A <= x"34FB8147EED1C0FBE29EAD4D6C472EB4EF7B2191FDE09E494B2A9845FE3F605E"; --4px,y,z
--	B <= x"34FB8147EED1C0FBE29EAD4D6C472EB4EF7B2191FDE09E494B2A9845FE3F605E"; --4px,y,z
	
--	A <= x"9BAE2D5BAC61E6EA5DE635BCA754B2564B7D78C45277CAD67E45C4CBBEA6E706";
--	B <= x"483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8";

--	A <= x"7D152C041EA8E1DC2191843D1FA9DB55B68F88FEF695E2C791D40444B365AFC2";
--	B <= x"56915849F52CC8F76F5FD7E4BF60DB4A43BF633E1B1383F85FE89164BFADCBDB"; --2px,y,z

 --A <= x"56915849F52CC8F76F5FD7E4BF60DB4A43BF633E1B1383F85FE89164BFADCBDB"; --2px,y,z
--	B <= x"9075B4EE4D4788CABB49F7F81C221151FA2F68914D0AA833388FA11FF621A970";
	
-- A <= x"7D152C041EA8E1DC2191843D1FA9DB55B68F88FEF695E2C791D40444B365AFC2";
--	B <= x"9075B4EE4D4788CABB49F7F81C221151FA2F68914D0AA833388FA11FF621A970";
		
--	A <= x"0CA90EF9B06D7EB51D650E9145E3083CBD8DF8759168862036F97A358F089848";
--	B <= x"435AFE76017B8D55D04FF8A98DD60B2BA7EB6F87F6B28182CA4493D7165DD127"; --3px,y,z
	
--   A <= x"9242FA9C0B9F23A3BFEA6A0EB6DBCFCBC4853FE9A25EE948105DC66A2A9B5BAA";
--	B <= x"34FB8147EED1C0FBE29EAD4D6C472EB4EF7B2191FDE09E494B2A9845FE3F605E"; --4px,y,z
--	
--	A <= x"3EFB8147EED1C0FBE29EAD4D6C472EB4EF7B2191FDE09E494B2A9845FE3F60FE"; --4px,y,z
--	B <= x"3EFB8147EED1C0FBE29EAD4D6C472EB4EF7B2191FDE09E494B2A9845FE3F60FE"; --4px,y,z
--	
--	A <= x"FFF2FA9C0B9F23A3BFEA6A0EB6DBCFCBC4853FE9A25EE948105DC66A2A9B5BAA"; --4px,y,z
--	B <= x"AAFB8147EED1C0FBE29EAD4D6C472EB4EF7B2191FDE09E494B2A9845FE3F605E"; --4px,y,z
	
	--A <= x"ABCDEF9C0B9F23A3BFEA6A0EB6DBCFCBC4853FE9A25EE948105DC66A2A9B5BAF"; --4px,y,z
	--B <= x"5AFB8147EED1C0FBE29EAD4D6C472EB4EF7B2191FDE09E494B2A9845FECF6D5E"; --4px,y,z



--		B <= x"C327B5D2636B32F27B051E4742B1BBD5324432C1000BFEDCA4368A29F6654152";
		
		wait for clk_period;
		start <= '0';
		wait for clk_period*257;
		
		write (buff, string '("A="));
      write (buff, A);
		writeline (file1, buff);
		
		write (buff, string '("B="));
      write (buff, B);
		writeline (file1, buff);
				
wait for 256 ns;
		
		write (buff, string '("C="));
      write (buff, C);
		writeline (file1, buff);
		
		wait for clk_period;
		
		start <= '1';
		wait for clk_period;
		start <= '0';
--		wait for clk_period*257;
		
		wait for clk_period;
		
		start <= '1';
		
		
A <= x"34FB8147EED1C0FBE29EAD4D6C472EB4EF7B2191FDE09E494B2A9845FE3F605E"; --4px,y,z
 B <= x"C327B5D2636B32F27B051E4742B1BBD5324432C1000BFEDCA4368A29F6654152";
--
	--	A <= x"9BAE2D5BAC61E6EA5DE635BCA754B2564B7D78C45277CAD67E45C4CBBEA6E706";
	--	B <= x"9BAE2D5BAC61E6EA5DE635BCA754B2564B7D78C45277CAD67E45C4CBBEA6E706";
	  -- A <= x"0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F";
	  -- B <= x"F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F";
		wait for clk_period;
		start <= '0';
--		wait for clk_period*256;
		
		wait for clk_period;
		
		start <= '1';
		wait for clk_period;		
		
		write (buff, string '("A="));
      write (buff, A);
		writeline (file1, buff);
				
wait for 256 ns;
		
		write (buff, string '("C="));
      write (buff, C);
		writeline (file1, buff);
		
      wait;
   end process;	

END;




 