
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity sumador_tb is 
end sumador_tb;	

architecture arc_sumador_tb of sumador_tb is

	component sumador
		Port(
			a, b : in std_logic_vector (31 downto 0);
			s : out std_logic_vector (31 downto 0));
	end component;

	signal a, b, s: std_logic_vector (31 downto 0);

begin 

	uut: sumador port map(a => a, b => b, s => s);

	assert_process: process
	begin
		a <= x"00000001";
		b <= x"00000003";
		wait for 1 ns;
		assert s = x"00000004" report "fallo op 000" severity failure;
		b <= x"00555555";
		wait for 1 ns;
		assert s = x"00555556" report "fallo op 001" severity failure;
		a <= x"FFFFFFFF";
		wait for 1 ns;
		assert s = x"00555554" report "fallo op 010" severity failure;
		wait;
	end process;

end arc_sumador_tb;




















