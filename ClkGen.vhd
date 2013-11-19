library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ClkGen is
	generic(
		n : integer := 25000;
           	n1 : integer := 2000
	);  
  	port( 
		Clock : in std_logic;
        	c_out : out std_logic
	);
end entity;

architecture Behavior of ClkGen is
  	signal count : integer := n;
  	signal scale : integer := n1; 	
  	signal c_val : std_logic := '0';
begin
  	process 
	begin
  		wait until( Clock'event and Clock = '1' );
  		if scale = 0 then
    			if count = 0 then
      				c_val <= not c_val;
      				count <= n - 1;
    			else
      				count <= count-1;
    			end if;
    			
			scale <= n1-1;
  		else
    			scale <= scale - 1;
  		end if;
  
		c_out <= c_val;
  	end process;
end architecture;
