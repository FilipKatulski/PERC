library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use ieee.STD_LOGIC_UNSIGNED.all;

entity LUT_TB is 
end LUT_TB;

architecture sim of LUT_TB is 
	component LUT
		port(
			CLK		:	in std_logic;
			ADDRESS	:	in std_logic_vector (15 downto 0);
			RE		:	in std_logic;
			N 		:	in std_logic_vector (1 downto 0);
			DATA	:	out std_logic_vector (15 downto 0)
			);
	end component;
	
	signal CLK 		:std_logic;
	signal ADDRESS	:std_logic_vector (15 downto 0) := (others => '0');
	signal RE		:std_logic;
	signal N		:std_logic_vector (1 downto 0);
	signal DATA		:std_logic_vector (15 downto 0);
	
begin
	uut: LUT
	port map(
		CLK => CLK,
		DATA => DATA,
		ADDRESS => ADDRESS,
		N => N,
		RE => RE
		);
	
	clk_process: process
	begin
		CLK <= '0';
		wait for 5ns;
		CLK <= '1';
		wait for 5ns;
	end process;
	
	stim_process: process
	begin				
		RE<='1';
		N<="00";
		for k in 0 to 8819 loop
			ADDRESS <= std_logic_vector(to_unsigned(k,16));
			wait for 10ns;
		end loop;
		wait;
	end process;
	
	
end sim;




