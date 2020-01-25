----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2019 01:27:41
-- Design Name: 
-- Module Name: Top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top is
    Port (
        BUTTONS  : in STD_LOGIC_VECTOR (3 downto 0);
        CE       : in STD_LOGIC;
        CLK      : in STD_LOGIC;
        RESET    : in STD_LOGIC;
        FE       : in STD_LOGIC;
        AUD_SD   : out STD_LOGIC;
        PWM_OUT  : out STD_LOGIC
        );
end Top;

architecture Behavioral of Top is

component LUT
  port (
       ADDRESS  : in STD_LOGIC_VECTOR(15 downto 0);
       CLK      : in STD_LOGIC;
       N        : in STD_LOGIC_VECTOR(1 downto 0);
       RE       : in STD_LOGIC;
       DATA     : out STD_LOGIC_VECTOR(15 downto 0)
      );
end component;
component PER
  port (
       BUTTONS  : in STD_LOGIC_VECTOR(3 downto 0);
       CE       : in STD_LOGIC;
       CLK      : in STD_LOGIC;
       FE       : in STD_LOGIC;
       RESET    : in STD_LOGIC;
       ADDRESS  : out STD_LOGIC_VECTOR(15 downto 0);
       AUD_SD   : out STD_LOGIC;
       N        : out STD_LOGIC_VECTOR(1 downto 0);
       RE       : out STD_LOGIC
      );
end component;
component PWM
  port (
       CLK      : in STD_LOGIC;
       DATA     : in STD_LOGIC_VECTOR(15 downto 0);
       RESET    : in STD_LOGIC;
       PWM_OUT  : out STD_LOGIC
  );
end component;
component PRESCALER
  port (
       CE       : in STD_LOGIC;
       CLK      : in STD_LOGIC;
       RESET    : in STD_LOGIC;
       CEO      : out STD_LOGIC
  );
end component;

---- Signal declarations used on the diagram ----

signal CEO      : STD_LOGIC;
signal RE       : STD_LOGIC;
signal ADDRESS  : STD_LOGIC_VECTOR(15 downto 0);
signal DATA     : STD_LOGIC_VECTOR(15 downto 0);
signal N        : STD_LOGIC_VECTOR(1 downto 0);

begin

----  Component instantiations  ----

U1 : PER
  port map(
       ADDRESS => ADDRESS,
       AUD_SD => AUD_SD,
       BUTTONS => BUTTONS,
       CE => CEO,
       CLK => CLK,
       N => N,
       RE => RE,
       FE => FE,
       RESET => RESET
  );

U2 : PWM
  port map(
       CLK => CLK,
       DATA => DATA,
       PWM_OUT => PWM_OUT,
       RESET => RESET
  );

U3 : LUT
  port map(
       ADDRESS => ADDRESS,
       CLK => CLK,
       DATA => DATA,
       N => N,
       RE => RE
  );

U4 : PRESCALER
  port map(
       CE => CE,
       CEO => CEO,
       CLK => CLK,
       RESET => RESET
  );


end Behavioral;






