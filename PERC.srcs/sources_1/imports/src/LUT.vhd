library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use std.textio.ALL;

entity LUT is
	
	port(
		CLK		: in std_logic;
		ADDRESS	: in std_logic_vector (15 downto 0);
		RE		: in std_logic;
		N		: in std_logic_vector (1 downto 0);
		DATA	: out std_logic_vector (15 downto 0)
		);
	
end LUT;

architecture beh of LUT is
type memory is array (0 to 8820) of bit_vector(15 downto 0);	--16 bits of 16bit words
signal dat : std_logic_vector (15 downto 0) := (others=>'0');
	
    impure function InitRamFromFile (RamFileName : in string) return memory is
    FILE RamFile : text is in RamFileName;
    variable RamFileLine : line;
    variable RAM : memory;
    begin
        for I in memory'range loop
            readline (RamFile, RamFileLine);
            read(RamFileLine, RAM(I));
        end loop;
        return RAM;
    end function;
	
	signal rom_block0 : memory := InitRamFromFile("C:/Users/czebi/FPGA/PERC/PERC.srcs/sources_1/imports/src/an.txt");
	signal rom_block1 : memory := InitRamFromFile("C:/Users/czebi/FPGA/PERC/PERC.srcs/sources_1/imports/src/bn.txt");
	signal rom_block2 : memory := InitRamFromFile("C:/Users/czebi/FPGA/PERC/PERC.srcs/sources_1/imports/src/cn.txt");
	signal rom_block3 : memory := InitRamFromFile("C:/Users/czebi/FPGA/PERC/PERC.srcs/sources_1/imports/src/dn.txt");
begin

	process(CLK)
	begin
		if rising_edge(CLK) and RE = '1' then
            case N is
                   when "00" => dat <= to_stdlogicvector(rom_block0(to_integer(unsigned(ADDRESS))));
                   when "01" => dat <= to_stdlogicvector(rom_block1(to_integer(unsigned(ADDRESS))));
                   when "10" => dat <= to_stdlogicvector(rom_block2(to_integer(unsigned(ADDRESS))));
                   when "11" => dat <= to_stdlogicvector(rom_block3(to_integer(unsigned(ADDRESS))));
                   when others => dat <= (others=>'0');
            end case;
		end if;
	end process;
	
	process(CLK)
	begin
	   if falling_edge(CLK) then
	       if RE = '1' then
	           DATA<=dat;
	       else
	           DATA<= (others => '0');
	       end if;
	   end if;
	end process;
		
end beh;