library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity alu_control_tb is 
end alu_control_tb;

architecture arc_alu_control_tb of alu_control_tb is

	component alu_control is
		port (
		  funct_in : in std_logic_vector (5 downto 0);
			alu_op_in : in std_logic_vector (1 downto 0);
			alu_op_out : out std_logic_vector (2 downto 0));
	end component;

	signal funct_in : std_logic_vector (5 downto 0);
	signal alu_op_in : std_logic_vector (1 downto 0);
	signal alu_op_out : std_logic_vector (2 downto 0);

begin

	uut: alu_control port map (funct_in => funct_in, alu_op_in => alu_op_in, alu_op_out => alu_op_out);

	assert_process: process
	begin
		alu_op_in <= "01";
		funct_in <= "000000";
		wait for 1 ns;
		assert alu_op_out = "110" report "fallo op x01" severity failure;
		alu_op_in <= "00";
		wait for 1 ns;
		assert alu_op_out = "010" report "fallo op x01" severity failure;
		funct_in <= "100010";
		wait for 1 ns;
		assert alu_op_out = "010" report "fallo op x01" severity failure;	
		alu_op_in <= "10";
		wait for 1 ns;
		assert alu_op_out = "110" report "fallo op x01" severity failure;
		funct_in <= "100000";
		wait for 1 ns;
		assert alu_op_out = "010" report "fallo op x01" severity failure;	
		funct_in <= "100100";
		wait for 1 ns;
		assert alu_op_out = "000" report "fallo op x01" severity failure;	
	  funct_in <= "100101";
		wait for 1 ns;
		assert alu_op_out = "001" report "fallo op x01" severity failure;	
	  funct_in <= "101010";
		wait for 1 ns;
		assert alu_op_out = "111" report "fallo op x01" severity failure;	
		wait;
	end process;

end arc_alu_control_tb;