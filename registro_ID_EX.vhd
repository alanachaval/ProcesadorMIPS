library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;

entity registro_ID_EX is
	port(clk, rst, we : in std_logic;
		wb_in : in std_logic_vector (1 downto 0);
		mem_in : in std_logic_vector (2 downto 0);
		ex_in : in std_logic_vector (4 downto 0);
		pc_in : in std_logic_vector (31 downto 0);
		read_data_1_in : in std_logic_vector (31 downto 0);
		read_data_2_in : in std_logic_vector (31 downto 0);
		sign_extend_in : in std_logic_vector (31 downto 0);
		inst_20_16_in : in std_logic_vector (4 downto 0);
		inst_15_11_in : in std_logic_vector (4 downto 0);
		wb_out : out std_logic_vector (1 downto 0);
		mem_out : out std_logic_vector (2 downto 0);
		ex_out : out std_logic_vector (4 downto 0);
		pc_out : out std_logic_vector (31 downto 0);
		read_data_1_out : out std_logic_vector (31 downto 0);
		read_data_2_out : out std_logic_vector (31 downto 0);
		sign_extend_out : out std_logic_vector (31 downto 0);
		inst_20_16_out : out std_logic_vector (4 downto 0);
		inst_15_11_out : out std_logic_vector (4 downto 0));
end registro_ID_EX;

architecture arc_registro_ID_EX of registro_ID_EX is

begin 

	process (clk,rst)
	begin
		if rst='1' then
			wb_out <= "00";
			mem_out <= "000";
			ex_out <= "00000";
			pc_out <= x"00000000";
			read_data_1_out <= x"00000000";
			read_data_2_out <= x"00000000";
			sign_extend_out <= x"00000000";
			inst_20_16_out <= "00000";
			inst_15_11_out <= "00000";
		elsif (clk'event and clk = '1' and we = '1') then
      wb_out <= wb_in;
			mem_out <= mem_in;
			ex_out <= ex_in;
			pc_out <= pc_in;
			read_data_1_out <= read_data_1_in;
			read_data_2_out <= read_data_2_in;
			sign_extend_out <= sign_extend_in;
			inst_20_16_out <= inst_20_16_in;
			inst_15_11_out <= inst_15_11_in;
		end if;
	end process;

end arc_registro_ID_EX;
