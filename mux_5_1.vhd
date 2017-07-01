library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;

entity mux_5_1 is
	Port(
		a,b:in std_logic_vector(4 downto 0);
		c: in std_logic ;
		s : out std_logic_vector(4 downto 0)
		);
end mux_5_1;

architecture arc_mux_5_1 of mux_5_1 is
begin
	process(a, b , c)
	begin
		if (c = '1') then
			s <= a;
		else
			s <= b;	
		end if;
	end process;

end arc_mux_5_1;

