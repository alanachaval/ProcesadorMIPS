library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unit_control is
	port (
	   wb_out : out std_logic_vector (1 downto 0);
		 mem_out: out std_logic_vector (2 downto 0);
		 ex_out : out std_logic_vector (3 downto 0);
		 ins_in : in std_logic_vector(5 downto 0)
		 );
		
end unit_control;

architecture arc_unit_control of unit_control is

begin

	decode_process: process(ins_in)
	begin
	  --(31 downto 26)
		case ins_in is
			--beq
			when "000100" => 
			   wb_out <= "00";
			   mem_out <= "100";
         ex_out <= "0010";
			-- lui
			when "001111" => 
			   wb_out <= "10";
			   mem_out <= "000";
         ex_out <= "1100";
			
			-- sw
			when "101011" => 
			   wb_out <= "01";
			   mem_out <= "010";
         ex_out <= "1000";
			   
			-- lw
			when "100011" => 
			   wb_out <= "11";
			   mem_out <= "001";
         ex_out <= "1000";
	   
	   -- tipo r
			when others => 
			   wb_out <= "10";
			   mem_out <= "000";
         ex_out <= "0111";
			  			    			   
		end case;
	end process;

end arc_unit_control;



