library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity shift_left_2_tb is 
end shift_left_2_tb;

architecture arc_shift_left_2_tb of shift_left_2_tb is

	component shift_left_2 is
		port (
		  sl_in : in std_logic_vector (31 downto 0);
		  sl_out : out std_logic_vector (31 downto 0));
	end component;

	signal sl_in : std_logic_vector (31 downto 0);
	signal	sl_out : std_logic_vector (31 downto 0);

begin

	uut: shift_left_2 port map (sl_in => sl_in, sl_out => sl_out);

	assert_process: process
	begin
		sl_in <= x"00000000";
		wait for 1 ns;
		assert sl_out = x"00000000" report "fallo op x01" severity failure;
		sl_in <= x"00000100";
		wait for 1 ns;
		assert sl_out = x"00000400" report "fallo op x01" severity failure;		
		sl_in <= x"00011100";
		wait for 1 ns;
		assert sl_out = x"00044400" report "fallo op x01" severity failure;		
		sl_in <= x"00000001";
		wait for 1 ns;
		assert sl_out = x"00000004" report "fallo op x01" severity failure;		
		sl_in <= x"F0000000";
		wait for 1 ns;
		assert sl_out = x"C0000000" report "fallo op x01" severity failure;		
		sl_in <= x"00000000";
		wait for 1 ns;
		assert sl_out = x"00000000" report "fallo op x01" severity failure;
		wait;
	end process;

end arc_shift_left_2_tb;
