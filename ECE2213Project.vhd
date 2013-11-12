library ieee;
use ieee.std_logic_1164.all;

entity ECE2213Project is
	port(
		Clk, Resetn, D, L : in std_logic;
		Q : in std_logic_vector(14 downto 0);
		Seg1, Seg2, Seg3, Seg4 : out std_logic_vector(6 downto 0)
	);
end entity;

architecture Behaviour of ECE2213Project is
	component Radix5Counter is
		port(
			Clock, Reset, Down, Load : in std_logic;
			Input : in std_logic_vector(14 downto 0);
			Output : buffer std_logic_vector(14 downto 0)
		);
	end component;
	
	component Base5to12Converter is
		port(
			Input : in std_logic_vector(14 downto 0);
			Output : buffer std_logic_vector(15 downto 0)
		);
	end component;
	
	component SevenSegment is
		port(
			HexData : in std_logic_vector(3 downto 0);
			Display : out std_logic_vector(0 to 6)
		);
	end component;
	
	signal Count : std_logic_vector(14 downto 0);
	signal Converted : std_logic_vector(15 downto 0);
begin
	-- Step 1: Initialize the counter.
	Counter: Radix5Counter port map(Clk, Resetn, D, L, Q, Count);
	
	-- Step 2: Convert the current base 5 count value into base 12.
	ConvertBase: Base5to12Converter port map(Count, Converted);
	
	-- Step 3: Assign the converted values to one of the seven segment displays.
	Display4: SevenSegment port map(Converted(15 downto 12), Seg4);
	Display3: SevenSegment port map(Converted(11 downto 8), Seg3);
	Display2: SevenSegment port map(Converted(7 downto 4), Seg2);
	Display1: SevenSegment port map(Converted(3 downto 0), Seg1);
end architecture;