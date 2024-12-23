
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
library std;
use std.textio.all; --include package textio.vhd
 
ENTITY TB_PM IS
END TB_PM;
 
ARCHITECTURE behavior OF TB_PM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PM
    PORT(
         key : IN  std_logic_vector(255 downto 0);
         QX : OUT  std_logic_vector(255 downto 0);
         QY : OUT  std_logic_vector(255 downto 0);
         QZ : OUT  std_logic_vector(255 downto 0);
         clk : IN  std_logic;
         --start : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal key : std_logic_vector(255 downto 0) := (others => '0');
   signal clk : std_logic := '0';
 --  signal start : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal QX : std_logic_vector(255 downto 0);
   signal QY : std_logic_vector(255 downto 0);
   signal QZ : std_logic_vector(255 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PM PORT MAP (
          key => key,
          QX => QX,
          QY => QY,
          QZ => QZ,
          clk => clk,
	--	    start=> start,
          rst => rst
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
    file_open (fstatus, file1, "TB_PM_Jac.txt",write_mode);
	 
      rst <= '1';	
      wait for clk_period;
      rst <= '0';
	--  start <= '1';
	
     key <= x"0000000000000000000000000000000000000000000000000000000000000002";
	  --key <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141";
		
		

		wait for clk_period;		
--	start <= '0';

		write (buff, string '("key="));
      write (buff, key);
		writeline (file1, buff);
						
wait for 5900900 ns;
		
		write (buff, string '("QX="));
      write (buff, QX);
		writeline (file1, buff);
		
		write (buff, string '("QY="));
      write (buff, QY);
		writeline (file1, buff);
		
		write (buff, string '("QZ="));
      write (buff, QZ);
		writeline (file1, buff);
					
      wait;
   end process;	

END;
