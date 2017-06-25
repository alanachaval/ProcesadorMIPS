library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;

entity sign_extend is
	Port(
		se_in : in std_logic_vector (15 downto 0);
		se_out : out std_logic_vector (31 downto 0));
end sign_extend;

architecture arc_sign_extend of sign_extend is

begin

	process(se_in)
	begin
		se_out <= (others => se_in(15));
		se_out(15 downto 0) <= se_in;
	end process;

end arc_sign_extend;
