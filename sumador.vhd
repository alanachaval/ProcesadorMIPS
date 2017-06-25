library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;

entity sumador is
	Port(
		a, b : in std_logic_vector (31 downto 0);
		s : out std_logic_vector (31 downto 0));
end sumador;

architecture arc_sumador of sumador is

begin

	process(a, b)
	begin
			s <= signed(a) + signed(b);
	end process;

end arc_sumador;