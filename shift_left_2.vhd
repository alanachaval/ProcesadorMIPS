library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;

entity shift_left_2 is
	Port(
	  sl_in : in std_logic_vector (31 downto 0);
		sl_out : out std_logic_vector (31 downto 0));
end shift_left_2;

architecture arc_shift_left_2 of shift_left_2 is

begin

	process(sl_in)
	begin
			sl_out(31 downto 2) <= sl_in (29 downto 0);
			sl_out(1 downto 0) <= "00";
	end process;

end arc_shift_left_2;
