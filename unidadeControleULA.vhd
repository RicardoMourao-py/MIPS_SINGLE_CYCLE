library ieee;
use ieee.std_logic_1164.all;

entity unidadeControleULA is
  generic (
    larguraOpCode: natural := 6;
    larguraFunct: natural := 6;
    larguraEndereco: natural := 3
  );

  port ( opcode : in std_logic_vector(larguraOpCode-1 downto 0);
         funct : in std_logic_vector(larguraFunct-1 downto 0);
			tipoR : in std_logic;
         saida : out std_logic_vector(larguraEndereco-1 downto 0)
  );
end entity;

architecture comportamento of unidadeControleULA is
	-- constantes
	constant op_AND: std_logic_vector(larguraFunct-1 downto 0) := "100100";
	constant op_OR : std_logic_vector(larguraFunct-1 downto 0) := "100101";
	constant op_ADD : std_logic_vector(larguraFunct-1 downto 0) := "100000";
	constant op_SUB : std_logic_vector(larguraFunct-1 downto 0) := "100010";
	constant op_SLT : std_logic_vector(larguraFunct-1 downto 0) := "101010";
	constant op_LW  : std_logic_vector(larguraOpCode-1 downto 0) := "100011";
	constant op_SW  : std_logic_vector(larguraOpCode-1 downto 0) := "101011";
	constant op_BEQ : std_logic_vector(larguraOpCode-1 downto 0) := "000100";
	constant op_ORI  : std_logic_vector(larguraOpCode-1 downto 0) := "001101";
	-- sinais
	signal functOUopcode: std_logic_vector(larguraFunct-1 downto 0);
begin
	functOUopcode <= funct when (tipoR='1') else opcode;
	
	saida(0) <= '1' when (functOUopcode = op_OR or functOUopcode = op_SLT or functOUopcode = op_ORI) else '0';
	saida(1) <= '1' when (functOUopcode = op_ADD or functOUopcode = op_SUB or functOUopcode = op_SLT 
								 or functOUopcode = op_LW or functOUopcode = op_SW or functOUopcode = op_BEQ)
								 else '0';
	saida(2) <= '1' when (functOUopcode = op_BEQ or functOUopcode = op_SUB or functOUopcode = op_SLT) else '0' ;
end architecture;