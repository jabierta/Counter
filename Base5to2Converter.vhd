library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Base5to2Converter is 
	port(
		Input : in std_logic_vector(14 downto 0);  
		Output : buffer std_logic_vector (14 downto 0)
	); 
end entity; 

architecture Behaviour of Base5to2Converter is
begin 
	-- Convert Input to Binary.
	Output <= (Input(14 downto 12) * "001001110001") + (Input(11 downto 9) * "1111101") + (Input(8 downto 6) * "11001") + (Input(5 downto 3) * "101") + Input(2 downto 0);
end architecture;