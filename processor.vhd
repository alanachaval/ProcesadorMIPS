library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity processor is
port(
	Clk         : in  std_logic;
	Reset       : in  std_logic;
	-- Instruction memory
	I_Addr      : out std_logic_vector(31 downto 0);
	I_RdStb     : out std_logic;
	I_WrStb     : out std_logic;
	I_DataOut   : out std_logic_vector(31 downto 0);
	I_DataIn    : in  std_logic_vector(31 downto 0);
	-- Data memory
	D_Addr      : out std_logic_vector(31 downto 0);
	D_RdStb     : out std_logic;
	D_WrStb     : out std_logic;
	D_DataOut   : out std_logic_vector(31 downto 0);
	D_DataIn    : in  std_logic_vector(31 downto 0));
end processor;

architecture processor_arq of processor is 
-- importamos los componentes

component registro_PC 
  port(clk, rst, we : in std_logic;
		pc_in : in std_logic_vector (31 downto 0);
    pc_out : out std_logic_vector (31 downto 0));
end component;

component mux port(
		a,b:in std_logic_vector(31 downto 0);
		c: in std_logic ;
		s : out std_logic_vector(31 downto 0)
		);
end component;

component sumador port(
		a, b : in std_logic_vector (31 downto 0);
		s : out std_logic_vector (31 downto 0));
end component;

component registro_IF_ID 
  port(
    clk, rst, we : in std_logic;
		pc_in : in std_logic_vector (31 downto 0);
		inst_in : in std_logic_vector (31 downto 0);
    pc_out : out std_logic_vector (31 downto 0);
		inst_out : out std_logic_vector (31 downto 0));
end component;

component unit_control port (
	   wb_out : out std_logic_vector (1 downto 0);
		 mem_out: out std_logic_vector (2 downto 0);
		 ex_out : out std_logic_vector (3 downto 0);
		 ins_in : in std_logic_vector(5 downto 0)
		 );	
end component;
 
component Registers port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           wr : in STD_LOGIC;
           reg1_dr : in STD_LOGIC_VECTOR (4 downto 0);
           reg2_dr : in STD_LOGIC_VECTOR (4 downto 0);
           reg_wr : in STD_LOGIC_VECTOR (4 downto 0);
           data_wr : in STD_LOGIC_VECTOR (31 downto 0);
           data1_rd : out STD_LOGIC_VECTOR (31 downto 0);
           data2_rd : out STD_LOGIC_VECTOR (31 downto 0));
end component;  

component sign_extend port(
		se_in : in std_logic_vector (15 downto 0);
		se_out : out std_logic_vector (31 downto 0));
end component;

component registro_ID_EX port(clk, rst, we : in std_logic;
		wb_in : in std_logic_vector (1 downto 0);
		mem_in : in std_logic_vector (2 downto 0);
		ex_in : in std_logic_vector (3 downto 0);
		pc_in : in std_logic_vector (31 downto 0);
		read_data_1_in : in std_logic_vector (31 downto 0);
		read_data_2_in : in std_logic_vector (31 downto 0);
		sign_extend_in : in std_logic_vector (31 downto 0);
		inst_20_16_in : in std_logic_vector (4 downto 0);
		inst_15_11_in : in std_logic_vector (4 downto 0);
		wb_out : out std_logic_vector (1 downto 0);
		mem_out : out std_logic_vector (2 downto 0);
		ex_out : out std_logic_vector (3 downto 0);
		pc_out : out std_logic_vector (31 downto 0);
		read_data_1_out : out std_logic_vector (31 downto 0);
		read_data_2_out : out std_logic_vector (31 downto 0);
		sign_extend_out : out std_logic_vector (31 downto 0);
		inst_20_16_out : out std_logic_vector (4 downto 0);
		inst_15_11_out : out std_logic_vector (4 downto 0));
end component;

component shift_left_2 port(
	  sl_in : in std_logic_vector (31 downto 0);
		sl_out : out std_logic_vector (31 downto 0));
end component;

component ALU port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           control : in STD_LOGIC_VECTOR (2 downto 0);
           zero : out STD_LOGIC;
           result : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component alu_control port (funct_in : in std_logic_vector (5 downto 0);
			alu_op_in : in std_logic_vector (1 downto 0);
			alu_op_out : out std_logic_vector (2 downto 0));
end component;

component mux_5_1 port(
		a,b:in std_logic_vector(4 downto 0);
		c: in std_logic ;
		s : out std_logic_vector(4 downto 0)
		);
end component;

component registro_EX_MEM port(clk, rst, we : in std_logic;
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
end component;

component registro_MEM_WB port(clk, rst, we : in std_logic;
		wb_in : in std_logic_vector (1 downto 0);
		read_data_in : in std_logic_vector (31 downto 0);
		alu_res_in : in std_logic_vector (31 downto 0);
		reg_dest_in : in std_logic_vector (4 downto 0);
		wb_out : out std_logic_vector (1 downto 0);
		read_data_out : out std_logic_vector (31 downto 0);
		alu_res_out : out std_logic_vector (31 downto 0);
		reg_dest_out : out std_logic_vector (4 downto 0));
end component;
  
-- ================
-- declaración de señales usadas 
-- se declara todo segun en que etapa tiene out
-- etapa if
signal if_mux_pc_out , if_mem_ins_out, if_sumador_pc_out, if_pc_out : std_logic_vector(31 downto 0);

-- etapa id
signal id_reg_if_id_pc_out, id_reg_if_id_instruccion_out : std_logic_vector(31 downto 0);
signal id_read_data_1_out , id_read_data_2_out : std_logic_vector(31 downto 0);
signal id_sign_extend_out: std_logic_vector(31 downto 0);
signal id_control_wb_out: std_logic_vector (1 downto 0);
signal id_control_mem_out:std_logic_vector (2 downto 0);
signal id_control_ex_out : std_logic_vector (3 downto 0);

--etapa ex
signal ex_reg_id_ex_wb_out: std_logic_vector (1 downto 0);
signal ex_reg_id_ex_mem_out:std_logic_vector (2 downto 0);
signal ex_reg_id_ex_ex_out : std_logic_vector (3 downto 0);
signal ex_reg_id_ex_pc_out: std_logic_vector(31 downto 0);
signal ex_reg_id_ex_rd_1_out: std_logic_vector(31 downto 0);
signal ex_reg_id_ex_rd_2_out: std_logic_vector(31 downto 0);
signal ex_reg_id_ex_sign_extend_out: std_logic_vector(31 downto 0);
signal ex_add_branch_out: std_logic_vector(31 downto 0);--este es el resultado del sumador para el salto
signal ex_read_data_2_out: std_logic_vector(31 downto 0);
signal ex_mux_alu_out: std_logic_vector(31 downto 0);
signal ex_alu_zero_out: std_logic;
signal ex_alu_result_out: std_logic_vector(31 downto 0);
signal ex_shift_left_out: std_logic_vector(31 downto 0);
signal ex_sign_extend_out: std_logic_vector(31 downto 0); -- este va al shiftleft y a la alu control
signal ex_alu_control_out: std_logic_vector (2 downto 0); -- salida del alu_control a la alu
signal ex_rt_instruction_out: std_logic_vector (4 downto 0); -- salida del registro_id_ex es instruction[20-16]
signal ex_rd_instruction_out: std_logic_vector (4 downto 0); -- salida del registro_id_ex es instruction[15-11] este es usado para los tipo r
signal ex_mux_rt_rd_out: std_logic_vector (4 downto 0); -- salida del mux entre el rd y el rt 

--etapa mem
signal mem_reg_ex_mem_wb_out: std_logic_vector (1 downto 0);
signal mem_reg_ex_mem_mem_out:std_logic_vector (2 downto 0);
signal mem_add_branch_out: std_logic_vector(31 downto 0);--este es el resultado del sumador para el salto
signal mem_zero_out: std_logic;
signal mem_branch_out : std_logic;
signal mem_alu_result_out: std_logic_vector(31 downto 0);
signal mem_read_data_2_out: std_logic_vector(31 downto 0);
signal mem_data_memory_read_out: std_logic_vector(31 downto 0); --salida de Data Memory
signal mem_mux_rt_rd_out: std_logic_vector (4 downto 0); -- salida del mux entre el rd y el rt 


--etapa wb
signal wb_reg_mem_wb_wb_out: std_logic_vector (1 downto 0);
signal wb_data_memory_read_out: std_logic_vector(31 downto 0); --salida de Data Memory
signal wb_alu_result_out: std_logic_vector(31 downto 0);
signal wb_mux_data_memoty_alu_result_out: std_logic_vector (31 downto 0); 
signal wb_mux_rt_rd_out: std_logic_vector (4 downto 0); -- salida del mux entre el rd y el rt de aca al write data de registers

-- fin declaracion de señalas por etapas del procesador

begin 	

--instanciacion de los componentes

--etapa IF
pc : registro_PC port map (clk => Clk, rst => Reset, we => '1', pc_in => if_mux_pc_out, pc_out => if_pc_out);
mux_pc : mux port map (a => mem_add_branch_out, b => if_sumador_pc_out,	c => mem_branch_out, s => if_mux_pc_out);
sumador_pc : sumador port map (a => if_pc_out, b => x"00000004", s => if_sumador_pc_out);
--CONECCIONES CON LA MEMORIA DE INSTRUCCIONES	
I_Addr <= if_pc_out;	
if_mem_ins_out <= I_DataIn;	
I_RdStb <= '1';
I_WrStb <= '0';
I_DataOut <= x"00000000";

--etapa ID
reg_if_id : registro_IF_ID port map(clk => Clk, rst => Reset, we => '1',
		pc_in => if_sumador_pc_out,	inst_in => if_mem_ins_out,
    inst_out => id_reg_if_id_instruccion_out, pc_out => id_reg_if_id_pc_out);
control :  unit_control port map (
	   wb_out => id_control_wb_out,
		 mem_out => id_control_mem_out,
		 ex_out => id_control_ex_out,
		 ins_in => id_reg_if_id_instruccion_out(31 downto 26));	
registros : Registers port map (clk => Clk, Reset => Reset, wr => wb_reg_mem_wb_wb_out(1),
           reg1_dr => id_reg_if_id_instruccion_out(25 downto 21),
           reg2_dr => id_reg_if_id_instruccion_out(20 downto 16),
           reg_wr => wb_mux_rt_rd_out,
           data_wr => wb_mux_data_memoty_alu_result_out,
           data1_rd => id_read_data_1_out,
           data2_rd => id_read_data_2_out);
extensor_signo : sign_extend port map(
		se_in => id_reg_if_id_instruccion_out(15 downto 0),
		se_out => id_sign_extend_out);
		
--etapa EX
reg_id_ex : registro_ID_EX port map(clk => Clk, rst => Reset, we => '1',
		wb_in => id_control_wb_out,
		mem_in => id_control_mem_out,
		ex_in => id_control_ex_out,
		pc_in => id_reg_if_id_pc_out,
		read_data_1_in => id_read_data_1_out,
		read_data_2_in => id_read_data_2_out,
		sign_extend_in => id_sign_extend_out,
		inst_20_16_in => id_reg_if_id_instruccion_out(20 downto 16),
		inst_15_11_in => id_reg_if_id_instruccion_out(15 downto 11),
		wb_out => ex_reg_id_ex_wb_out,
		mem_out => ex_reg_id_ex_mem_out,
		ex_out  => ex_reg_id_ex_ex_out, 
		pc_out => ex_reg_id_ex_pc_out,
		read_data_1_out => ex_reg_id_ex_rd_1_out,
		read_data_2_out => ex_reg_id_ex_rd_2_out,
		sign_extend_out => ex_reg_id_ex_sign_extend_out,
		inst_20_16_out => ex_rt_instruction_out,
		inst_15_11_out => ex_rd_instruction_out);
shift_left : shift_left_2 port map(sl_in => ex_reg_id_ex_sign_extend_out,	sl_out => ex_shift_left_out);
sumador_branch : sumador port map (a => ex_reg_id_ex_pc_out, b => ex_shift_left_out, s => ex_add_branch_out);
unidad_aritmetico_logica : ALU port map(
           a => ex_reg_id_ex_rd_1_out,
           b => ex_mux_alu_out,
           control => ex_alu_control_out,
           zero => ex_alu_zero_out,
           result => ex_alu_result_out);
mux_alu : mux port map (a => ex_reg_id_ex_sign_extend_out, b => ex_reg_id_ex_rd_2_out,	
          c => ex_reg_id_ex_ex_out(3), s => ex_mux_alu_out);
control_alu : alu_control port map(funct_in => ex_reg_id_ex_sign_extend_out(5 downto 0),
			alu_op_in => ex_reg_id_ex_ex_out(2 downto 1),
			alu_op_out => ex_alu_control_out);
mux_rt_rd : mux_5_1 port map (a => ex_rd_instruction_out, b => ex_rt_instruction_out,	
          c => ex_reg_id_ex_ex_out(0), s => ex_mux_rt_rd_out);
          
--etapa MEM
reg_ex_mem : registro_EX_MEM port map (clk => Clk, rst => Reset, we => '1',
		wb_in => ex_reg_id_ex_wb_out,
		mem_in => ex_reg_id_ex_mem_out,
		pc_in => ex_add_branch_out,
		zero_in => ex_alu_zero_out,
		alu_res_in => ex_alu_result_out,
		write_data_in => ex_reg_id_ex_rd_2_out,
		reg_dest_in => ex_mux_rt_rd_out,
		wb_out =>  mem_reg_ex_mem_wb_out,
		mem_out =>  mem_reg_ex_mem_mem_out,
		pc_out => mem_add_branch_out,
		zero_out => mem_zero_out,
		alu_res_out => mem_alu_result_out,
		write_data_out => mem_read_data_2_out,
		reg_dest_out => mem_mux_rt_rd_out);
process(mem_zero_out, mem_reg_ex_mem_mem_out(2))
	begin		
		mem_branch_out <= mem_zero_out AND mem_reg_ex_mem_mem_out(2);	
end process;
--CONECCIONES CON LA MEMORIA DE DATOS
	D_Addr <= mem_alu_result_out;
	D_RdStb <= mem_reg_ex_mem_mem_out(0);
	D_WrStb <= mem_reg_ex_mem_mem_out(1);
	D_DataOut <= mem_read_data_2_out;
	mem_data_memory_read_out <= D_DataIn;

--etapa WB
reg_mem_wb : registro_MEM_WB port map (clk => Clk, rst => Reset, we => '1',
		wb_in =>  mem_reg_ex_mem_wb_out,
		read_data_in => mem_data_memory_read_out,
		alu_res_in => mem_alu_result_out,
		reg_dest_in => mem_mux_rt_rd_out,
		wb_out => wb_reg_mem_wb_wb_out,
		read_data_out => wb_data_memory_read_out,
		alu_res_out => wb_alu_result_out,
		reg_dest_out => wb_mux_rt_rd_out);
mux_data_memoty_alu_result : mux port map (a => wb_data_memory_read_out, b => wb_alu_result_out,	
          c => wb_reg_mem_wb_wb_out(0), s => wb_mux_data_memoty_alu_result_out);
          
end processor_arq;
