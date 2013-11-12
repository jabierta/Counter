library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Radix5Counter is
	port(
		Clock, Reset, Down, Load : in std_logic;
		Input : in std_logic_vector(14 downto 0);
		Output : buffer std_logic_vector(14 downto 0)
	);
end entity;

architecture Behaviour of Radix5Counter is
begin
	Counter: process(Clock, Reset, Load, Down)
	begin
		if Reset = '1' then
			-- Asynchronous reset active HIGH. Sets counter to 0.
			Output <= (others => '0');
		elsif rising_edge(Clock) then
			if Load = '1' and Input >= "000000000000000" and Input <= "011000100001001" then
				Output <= Input;
			elsif Down = '0' then
				-- Up counter when Down is LOW. Down is active HIGH.
				if Output = "011000100001001" then
					-- Counter has reached 30411, reset to 0.
					Output <= (others => '0');
				elsif Output(11 downto 0) = "100100100100" then
					-- Check for 4444.
					Output(14 downto 12) <= Output(14 downto 12) + 1;
					Output(11 downto 0) <= (others => '0');
				elsif Output(8 downto 0) = "100100100" then
					-- Check for 444.
					Output(11 downto 9) <= Output(11 downto 9) + 1;
					Output(8 downto 0) <= (others => '0');
				elsif Output(5 downto 0) = "100100" then
					-- Check for 44.
					Output(8 downto 6) <= Output(8 downto 6) + 1;
					Output(5 downto 0) <= (others => '0');
				elsif Output(2 downto 0) = "100" then
					-- Check for 4.
					Output(5 downto 3) <= Output(5 downto 3) + 1;
					Output(2 downto 0) <= (others => '0');
				else
					Output <= Output + 1;
				end if;
			else
				-- Down counter when Down is HIGH.
				if Output = "000000000000000" then
					-- Counter has reached minimum value. Reset to maximum value.
					Output <= "011000100001001";
				elsif Output(11 downto 0) = "000000000000" then
					-- Check for 0000.
					Output(14 downto 12) <= Output(14 downto 12) - 1;
					Output(11 downto 0) <= "100100100100";
				elsif Output(8 downto 0) = "000000000" then
					-- Check for 000.
					Output(11 downto 9) <= Output(11 downto 9) - 1;
					Output(8 downto 0) <= "100100100";
				elsif Output(5 downto 0) = "000000" then
					-- Check for 00.
					Output(8 downto 6) <= Output(8 downto 6) - 1;
					Output(5 downto 0) <= "100100";
				elsif Output(2 downto 0) = "000" then
					-- Check for 0
					Output(5 downto 3) <= Output(5 downto 3) - 1;
					Output(2 downto 0) <= "100";
				else
					Output <= Output - 1;
				end if;
			end if;
		end if;
	end process;
end architecture;