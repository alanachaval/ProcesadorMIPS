library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;

entity registro_EX_MEM is
	port(clk, rst, we : in std_logic;
		wb_in : in std_logic_vector (1 downto 0);
		mem_in : in std_logic_vector (2 downto 0);
		pc_in : in std_logic_vector (31 downto 0);
		zero_in : in std_logic;
		alu_res_in : in std_logic_vector (31 downto 0);
		write_data_in : in std_logic_vector (31 downto 0);
		reg_dest_in : in std_logic_vector (4 downto 0);
		wb_out : out std_logic_vector (1 downto 0);
		mem_out : out std_logic_vector (2 downto 0);
		pc_out : out std_logic_vector (31 downto 0);		
		zero_out : out std_logic;
		alu_res_out : out std_logic_vector (31 downto 0);
		write_data_out : out std_logic_vector (31 downto 0);
		reg_dest_out : out std_logic_vector (4 downto 0));
end registro_EX_MEM;

architecture arc_registro_EX_MEM of registro_EX_MEM is

begin 

	process (clk,rst)
	begin
		if rst='1' then
			wb_out <= "00";
			mem_out <= "000";
			pc_out <= x"00000000";
			zero_out <= '0';
			alu_res_out <= x"00000000";
			write_data_out <= x"00000000";
			reg_dest_out <= "00000";
		elsif (clk'event and clk = '1' and we = '1') then
      wb_out <= wb_in;
			mem_out <= mem_in;
			pc_out <= pc_in;
			zero_out <= zero_in;
			alu_res_out <= alu_res_in;
			write_data_out <= write_data_in;
			reg_dest_out <= reg_dest_in;
		end if;
	end process;

end arc_registro_EX_MEM;
