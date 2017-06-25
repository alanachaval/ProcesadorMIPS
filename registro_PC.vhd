
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;

entity registro_PC is
	port(clk, rst, we : in std_logic;
		pc_in : in std_logic_vector (31 downto 0);
    pc_out : out std_logic_vector (31 downto 0));
end registro_PC;

architecture arc_registro_PC of registro_PC is

begin 

	process (clk,rst)
	begin
		if rst='1' then
			pc_out <= x"00000000";
		elsif (clk'event and clk = '1' and we = '1') then
			pc_out <= pc_in;
		end if;
	end process;

end arc_registro_PC;