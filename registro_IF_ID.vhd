library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;

entity registro_IF_ID is
	port(clk, rst, we : in std_logic;
		pc_in : in std_logic_vector (31 downto 0);
		inst_in : in std_logic_vector (31 downto 0);
    pc_out : out std_logic_vector (31 downto 0);
		inst_out : out std_logic_vector (31 downto 0));
end registro_IF_ID;

architecture arc_registro_IF_ID of registro_IF_ID is

begin 

	process (clk,rst)
	begin
		if rst='1' then
			pc_out <= x"00000000";
			inst_out <= x"00000000";
		elsif (clk'event and clk = '1' and we = '1') then
			pc_out <= pc_in;
			inst_out <= inst_in;
		end if;
	end process;

end arc_registro_IF_ID;
