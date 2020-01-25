library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity PER is
	port (
		CLK 	: in std_logic;						   -- clock
		CE		: in std_logic;						   -- clock enable
		BUTTONS : in std_logic_vector (3 downto 0);	   -- signal from buttons
		FE      : in std_logic;                        -- Sellen-Key Buttherworth filter enable input
		RESET	: in std_logic;                       -- asynch reset
		N		: out std_logic_vector (1 downto 0);   -- choose sample number 
		ADDRESS	: out std_logic_vector (15 downto 0);  -- address to read from LUT
		RE		: out std_logic;      				   -- read_enable signal	
		AUD_SD	: out std_logic                        -- Sellen-Key Buttherworth filter enable output
		);
end PER; 

architecture Behavioral of PER is
signal intadr 	: std_logic_vector(15 downto 0)  := (others => '0'); 
signal intre 	: std_logic                      := '0';
	
begin
	
	process(CLK, BUTTONS, CE, RESET)
	begin
	if RESET = '1' then
	   intadr <= (others => '0');
	   intre <= '0';
    elsif rising_edge(CLK) then
        if CE = '1' then
            case BUTTONS is				
                when "0001" =>
                    N <= "00";
                    intre<= '1';
                when "0010" =>
                    N <= "01";
                    intre<= '1';
                when "0100" =>
                    N <= "10";
                    intre<= '1';
                when "1000"	=>
                    N <= "11";
                    intre<= '1';
                when "0000" =>
                    if intadr = 0 then
                        intre<='0';
                    else
                        intre<='1';
                    end if;
                when others =>
                    intre<= '0';
            end case;
            
            if intre='1' then
                intadr <= intadr +1;
                if intadr = 8820 then
                    intadr <= (others => '0');
                    intre<='0';
                end if;
            else
                intadr <= (others => '0');
            end if;
        end if;
    end if;
	end process;
	
	AUD_SD <= '1' when (FE = '1' and RESET = '0') else '0';
	ADDRESS <= intadr;
    RE<= intre;
    
end Behavioral;
