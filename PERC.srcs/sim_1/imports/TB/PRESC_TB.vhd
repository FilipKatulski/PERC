library ieee;
use ieee.std_logic_1164.ALL;
use ieee.STD_LOGIC_UNSIGNED.all;

entity PRESC_TB is
end PRESC_TB;

architecture sim of PRESC_TB is	
component PRESCALER is
	port(
		CLK 	: in STD_LOGIC;
		CE 		: in STD_LOGIC;
		RESET 	: in STD_LOGIC;
		CEO 	: out STD_LOGIC
		);
end component;

	signal CLK 		: STD_LOGIC;
	signal CE 		: STD_LOGIC;
	signal RESET 	: STD_LOGIC;
	signal CEO 		: STD_LOGIC;
		
begin  
	uut: PRESCALER
	port map(
		CLK=>CLK,
		CE=>CE,
		RESET=>RESET,
		CEO=>CEO
		);

	clk_process: process
	begin
		CLK <= '0';
		wait for 5ns;
		CLK <= '1';
		wait for 5ns;
	end process;
	
	pre: process
	begin
		RESET<='0';
		CE<='1';
		wait for 10ns;
	end process;


end sim;
