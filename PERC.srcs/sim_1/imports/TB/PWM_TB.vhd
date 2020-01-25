library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use ieee.STD_LOGIC_UNSIGNED.all;


entity PWM_TB is
end PWM_TB;

architecture TB_ARCHITECTURE of PWM_TB is
		component PWM
		port(
		CLK : 		in std_logic;
		DATA : 		in std_logic_vector(15 downto 0);
		RESET : 	in std_logic;
		PWM_OUT : 	out std_logic
		);
		end component;
	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : 		std_logic 						:='0';
	signal DATA : 		std_logic_vector(15 downto 0)	:= (others => '0');
	signal RESET : 		std_logic						:='0';
	signal PWM_OUT : 	std_logic;
	
	
begin
	-- Unit Under Test port map
	UUT : PWM
	port map (
		CLK => CLK,
		DATA => DATA,
		RESET => RESET,
		PWM_OUT => PWM_OUT
		);
	
	CLK_STIMULUS : process	  --clock 100Mhz -> PWM freq = 390,625kHz, 100Mhz/2268 = 44,1kHz
	begin
		wait for 5ns;
		CLK <= '1';
		wait for 5ns;
		CLK <= '0'; 
	end process;
	
	
	DATA_STIMULUS: process
	begin
		--DATA<= DATA + 1;
		DATA<="0110100001000000";
		wait for 10ns;
	end process;
	
end TB_ARCHITECTURE;