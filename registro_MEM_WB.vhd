library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;

entity registro_MEM_WB is
	port(clk, rst, we : in std_logic;
		wb_in : in std_logic_vector (1 downto 0);
		read_data_in : in std_logic_vector (31 downto 0);
		alu_res_in : in std_logic_vector (31 downto 0);
		reg_dest_in : in std_logic_vector (4 downto 0);
		wb_out : out std_logic_vector (1 downto 0);
		read_data_out : out std_logic_vector (31 downto 0);
		alu_res_out : out std_logic_vector (31 downto 0);
		reg_dest_out : out std_logic_vector (4 downto 0));
end registro_MEM_WB;

architecture arc_registro_MEM_WB of registro_MEM_WB is

begin 

	process (clk,rst)
	begin
		if rst='1' then
			wb_out <= "00";
			read_data_out <= x"00000000";
			alu_res_out <= x"00000000";
			reg_dest_out <= "00000";
		elsif (clk'event and clk = '1' and we = '1') then
      wb_out <= wb_in;
			read_data_out <= read_data_in;
			alu_res_out <= alu_res_in;
			reg_dest_out <= reg_dest_in;
		end if;
	end process;

end arc_registro_MEM_WB;

