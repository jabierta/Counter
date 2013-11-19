library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Base5to12Converter is
        port(
                Input : in std_logic_vector(14 downto 0);
                Output : buffer std_logic_vector(15 downto 0)
        );
end entity;

architecture Behaviour of Base5to12Converter is
        signal Binary : std_logic_vector(12 downto 0);
        signal Remainder0, Remainder1, Remainder2, Remainder3 : unsigned(3 downto 0);
        signal Quotient0, Quotient1, Quotient2 : std_logic_vector(12 downto 0);
begin
        -- Convert Input to Binary.
        Binary <= (Input(14 downto 12) * "1001110001") + (Input(11 downto 9) * "1111101") + (Input(8 downto 6) * "11001") + (Input(5 downto 3) * "101") + Input(2 downto 0);
        
        -- Convert to base 12.
        Remainder0 <= resize(unsigned(Binary) mod 12, 4);
        Quotient0 <= std_logic_vector(unsigned(Binary) / 12);
        
        Remainder1 <= resize(unsigned(Quotient0) mod 12, 4);
        Quotient1 <= std_logic_vector(unsigned(Quotient0) / 12);
        
        Remainder2 <= resize(unsigned(Quotient1) mod 12, 4);
        Quotient2 <= std_logic_vector(unsigned(Quotient1) / 12);
        
        Remainder3 <= resize(unsigned(Quotient2) mod 12, 4);
        
        -- Concatenate remainders into a 16 bit logic vector.
        Output <= std_logic_vector(Remainder3) & std_logic_vector(Remainder2) & std_logic_vector(Remainder1) & std_logic_vector(Remainder0);
end architecture;