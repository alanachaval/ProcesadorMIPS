library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_control is
	port (funct_in : in std_logic_vector (5 downto 0);
			alu_op_in : in std_logic_vector (1 downto 0);
			alu_op_out : out std_logic_vector (2 downto 0));
end alu_control;

architecture arc_alu_control of alu_control is

begin

	decode_process: process(alu_op_in, funct_in)
	begin
		case alu_op_in is
			when "00" => alu_op_out <= "010";
			when "01" => alu_op_out <= "110";
			when others =>
		  case funct_in is
			 when "100000" => alu_op_out <= "010";
			 when "100010" => alu_op_out <= "110";
			 when "100100" => alu_op_out <= "000";
			 when "100101" => alu_op_out <= "001";
			 when others => alu_op_out <= "111";
			end case;
		end case;
	end process;

end arc_alu_control;

