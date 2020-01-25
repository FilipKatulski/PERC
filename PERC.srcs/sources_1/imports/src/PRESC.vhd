library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity PRESCALER is
	port(
		CLK 	: in STD_LOGIC;
		CE 		: in STD_LOGIC;
		RESET 	: in STD_LOGIC;
		CEO 	: out STD_LOGIC
		);
end PRESCALER;

architecture Behavioral of PRESCALER is
	signal divider 			: std_logic_vector (11 downto 0) :=(others=>'0');
	constant divide_factor 	: integer := 2268;
begin
	process (CLK, RESET)
	begin
		if RESET = '1' then
			divider <= (others => '0');
		elsif rising_edge(CLK) then
			if CE = '1' then
				if divider = (divide_factor-1) then
					divider <= (others => '0');
				else
					divider <= divider + 1;
				end if;
			end if;
		end if;
	end process;
	
CEO <= '1' when divider = (divide_factor-1) and CE = '1' else '0';
	
end Behavioral;
