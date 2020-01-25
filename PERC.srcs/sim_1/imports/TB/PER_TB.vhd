library ieee;
use ieee.std_logic_1164.ALL;
use ieee.STD_LOGIC_UNSIGNED.all;

entity PER_TB is
end PER_TB;


architecture sim of PER_TB is  
	component PER
		port (
			CLK 	: in std_logic;						   --clock
			CE		: in std_logic;
			BUTTONS : in std_logic_vector (3 downto 0);	   --signal from buttons
			N		: out std_logic_vector (1 downto 0);   --choose sample number 
			ADDRESS	: out std_logic_vector (15 downto 0);  --address to read from LUT
			RE		: out std_logic						   --read_enable signal
			);
	end component;
	
	signal CLK 		: std_logic 					:= '0';
	signal CE		: std_logic;
	signal BUTTONS 	: std_logic_vector (3 downto 0) := (others => '0');	   
	signal N		: std_logic_vector (1 downto 0);
	signal ADDRESS	: std_logic_vector (15 downto 0);
	signal RE		: std_logic;	
	
begin
	uut: PER
	port map(
		CLK => CLK,
		BUTTONS => BUTTONS,
		ADDRESS => ADDRESS,
		N => N,
		RE => RE,
		CE => CE
		);
	
	clk_process: process
	begin
		CLK <= '0';
		wait for 5ns;
		CLK <= '1';
		wait for 5ns;
	end process;
	
	butt: process
	begin
		wait for 500us;
		BUTTONS<= BUTTONS+1;
	end process;
	
	
end sim;
