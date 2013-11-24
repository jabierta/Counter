library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Base2to5Converter is
	port(
		Input : in std_logic_vector(10 downto 0);
		Output : buffer std_logic_vector(14 downto 0)
	);
end entity;

architecture Behaviour of Base2to5Converter is
	signal Remainder0, Remainder1, Remainder2, Remainder3, Remainder4 : unsigned(2 downto 0);
	signal Quotient0, Quotient1, Quotient2, Quotient3 : std_logic_vector(10 downto 0); 
begin 
	-- Convert to base 12.
	Remainder0 <= resize(unsigned(Input) mod 5, 3);
	Quotient0 <= std_logic_vector(unsigned(Input) / 5);

	Remainder1 <= resize(unsigned(Quotient0) mod 5, 3);
	Quotient1 <= std_logic_vector(unsigned(Quotient0) / 5);
			  
	Remainder2 <= resize(unsigned(Quotient1) mod 5, 3);
	Quotient2 <= std_logic_vector(unsigned(Quotient1) / 5);
			  
	Remainder3 <= resize(unsigned(Quotient2) mod 5, 3);
	Quotient3 <= std_logic_vector(unsigned(Quotient2) / 5);

	Remainder4 <= resize(unsigned(Quotient3) mod 5, 3);

	-- Concatenate remainders into a 15 bit logic vector.
	Output <= std_logic_vector(Remainder4) & std_logic_vector(Remainder3) & std_logic_vector(Remainder2) & std_logic_vector(Remainder1) & std_logic_vector(Remainder0);
end architecture;