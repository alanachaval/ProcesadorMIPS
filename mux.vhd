library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;

entity mux is
	Port(
		a,b:std_logic_vector(31 downto 0);
		c: in std_logic ;
		s : out std_logic_vector(31 downto 0);
end mux;

architecture arc_mux of mux is

begin

	process(a, b , c)
	begin
		if (c == '1') then
			s <= a
		else
			s <= b		
		end if;
	end process;

end arc_mux;
