library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use ieee.STD_LOGIC_UNSIGNED.all;

entity TOP_TB is
end TOP_TB;

architecture sim of TOP_TB is
	component Top is
		port(
			CE 		: in STD_LOGIC;
			CLK 	: in STD_LOGIC;
			RESET 	: in STD_LOGIC;
			BUTTONS : in STD_LOGIC_VECTOR(3 downto 0);
			FE      : in STD_LOGIC;
			PWM_OUT : out STD_LOGIC;
			AUD_SD  : out STD_LOGIC
			);
	end component;
	
	signal CE 		: STD_LOGIC;
	signal CLK 		: STD_LOGIC;
	signal RESET 	: STD_LOGIC;
	signal BUTTONS 	: STD_LOGIC_VECTOR(3 downto 0);
	signal PWM_OUT 	: STD_LOGIC;
	signal AUD_SD   : STD_LOGIC;
	signal FE       : STD_LOGIC;
	
begin
	uut: Top
	port map(
		CE=>CE,
		CLK=>CLK,
		RESET=>RESET,
		BUTTONS=>BUTTONS,
		PWM_OUT=>PWM_OUT,
		FE=>FE,
		AUD_SD => AUD_SD
		);	
	
	clk_process: process
	begin
		CLK <= '0';
		wait for 5ns;
		CLK <= '1';
		wait for 5ns;
	end process;
	
	reset_stim: process
	begin
	   RESET <= '0';
	   wait for 100us;
	   RESET <= '1';
	   wait for 10us;
	   RESET <= '0';
	   wait;
	end process;
	
	buttons_stim: process
	begin
	   BUTTONS <= "0000";
	   wait for 100us;
	   BUTTONS <= "0001";
	   wait for 100us;
	   BUTTONS <= "1111";
	   wait for 200us;
	   BUTTONS <= "0001";
	   wait;
	end process;
	
	ce_stim: process
	begin
        CE <= '1';
        wait for 220us;
        CE <= '0';
        wait for 20us;
        CE <= '1';
        wait;
	end process;
	
	fe_stim: process
	begin
        FE<='1';
        wait for 50us;
        FE <= '0';
        wait for 10us;
        FE <= '1';
        wait;
	end process;
	
end sim;
