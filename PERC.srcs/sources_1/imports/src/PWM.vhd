library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;


entity PWM is
	port(
		CLK		: in std_logic;						-- clock
		DATA	: in std_logic_vector(15 downto 0);	-- data input
		RESET	: in std_logic;                     -- asynch reset
		PWM_OUT : out std_logic						-- pwm output
		);
end PWM;

architecture Behavioral of PWM is
	signal cnt		: std_logic_vector(15 downto 0)	:= (others => '0');		-- counter output
	signal int_data	: std_logic_vector(15 downto 0)	:= (others => '0');		-- internal data stored in pipo register
	signal cnt_of	: std_logic 			   		:= '0';				    -- counter overflow signal
	signal comp_out : std_logic						:= '0';					-- comparator output
	signal q 		: std_logic						:= '0';					-- d flipflop output

begin

	counter: process(CLK, RESET)
	begin
		if RESET = '0' then
			if rising_edge(CLK) then
			    cnt_of <= '0';
				cnt<= cnt+128;
				if cnt = "1111111110000000" then
					cnt <= (others => '0');
					cnt_of <= '1';
				end if;
			end if;
		else
			cnt <= (others => '0');
		end if;
	end process;


	input_register: process(CLK, RESET)
	begin
	   if RESET = '1' then
	      int_data <= (others => '0');
	   elsif cnt_of = '1' then
		  int_data <= DATA;
	   end if;
	end process;


	comparator: process(int_data, cnt)
	begin
		if cnt = 0 then
			comp_out <= '0';
		elsif  int_data >= cnt then
			comp_out <= '1';
		else
			comp_out <= '0';
		end if;
	end process;


	d_flipflop: process (CLK, RESET)
	begin
		if RESET = '1' then
			q <= '0';
		elsif rising_edge(CLK) then
			q <= comp_out;
		end if;
	end process;

	PWM_OUT <= '0' when q = '0' else 'Z' ;

end Behavioral;