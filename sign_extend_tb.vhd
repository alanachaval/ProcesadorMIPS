library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity sign_extend_tb is 
end sign_extend_tb;	

architecture arc_sign_extend_tb of sign_extend_tb is

	component sign_extend
		Port(
			se_in : in std_logic_vector (15 downto 0);
			se_out : out std_logic_vector (31 downto 0));
	end component;

	signal 			se_in : std_logic_vector (15 downto 0);
  signal    se_out : std_logic_vector (31 downto 0);

begin 

	uut: sign_extend port map(se_in => se_in, se_out => se_out);

	assert_process: process
	begin
		se_in <= x"0000";
		wait for 1 ns;
		assert se_out = x"00000000" report "fallo op 000" severity failure;
		se_in <= x"0015";
		wait for 1 ns;
		assert se_out = x"00000015" report "fallo op 001" severity failure;
		se_in <= x"8015";
		wait for 1 ns;
		assert se_out = x"FFFF8015" report "fallo op 010" severity failure;
		wait;
	end process;

end arc_sign_extend_tb;

