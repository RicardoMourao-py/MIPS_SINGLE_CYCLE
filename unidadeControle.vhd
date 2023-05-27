library ieee;
use ieee.std_logic_1164.all;

entity unidadeControle is
  generic (
    larguraOpCode: natural := 6;
    larguraFunct: natural := 6;
    larguraSinaisControle: natural := 20
  );

  port ( opcode : in std_logic_vector(larguraOpCode-1 downto 0);
         funct : in std_logic_vector(larguraFunct-1 downto 0);
         saida : out std_logic_vector(larguraSinaisControle-1 downto 0)
  );
end entity;

architecture comportamento of unidadeControle is
	
  -- Tipo R 
  constant op_AND: std_logic_vector(larguraFunct-1 downto 0) := "100100";
  constant op_OR : std_logic_vector(larguraFunct-1 downto 0) := "100101";
  constant op_ADD : std_logic_vector(larguraFunct-1 downto 0) := "100000";
  constant op_SUB : std_logic_vector(larguraFunct-1 downto 0) := "100010";
  constant op_SLT : std_logic_vector(larguraFunct-1 downto 0) := "101010";
  constant op_JR : std_logic_vector(larguraFunct-1 downto 0) := "001000";
  
  constant op_LW  : std_logic_vector(larguraOpCode-1 downto 0) := "100011";
  constant op_SW  : std_logic_vector(larguraOpCode-1 downto 0) := "101011";
  constant op_BEQ : std_logic_vector(larguraOpCode-1 downto 0) := "000100";
  constant op_JMP : std_logic_vector(larguraOpCode-1 downto 0) := "000010";

  constant op_LUI  : std_logic_vector(larguraOpCode-1 downto 0) := "001111";
  constant op_ORI  : std_logic_vector(larguraOpCode-1 downto 0) := "001101";
  constant op_ADDI  : std_logic_vector(larguraOpCode-1 downto 0) := "001000";
  constant op_ANDI : std_logic_vector(larguraOpCode-1 downto 0) := "001100";
  constant op_SLTI : std_logic_vector(larguraOpCode-1 downto 0) := "001010";
  constant op_BNE : std_logic_vector(larguraOpCode-1 downto 0) := "000101";
  constant op_JAL : std_logic_vector(larguraOpCode-1 downto 0) := "000011";
  
  begin
    saida <="00011000000001000000" when (opcode = "000000" and funct = op_AND) else
            "00011000000001000000" when (opcode = "000000" and funct = op_OR) else
				"00011000000001000000" when (opcode = "000000" and funct = op_ADD) else
				"00011000000001000000" when (opcode = "000000" and funct = op_SUB) else
				"00011000000001000000" when (opcode = "000000" and funct = op_SLT) else
				"10000000000001000000" when (opcode = "000000" and funct = op_JR) else    
            "00001011000110010010" when (opcode = op_LW) else
            "00000011010110000001" when (opcode = op_SW) else
            "00000000001000001000" when (opcode = op_BEQ) else
				"01000000000100000000" when (opcode = op_JMP) else
				"00001000011110110000" when (opcode = op_LUI) else
				"00001110011010000000" when (opcode = op_ORI) else
				"00001010010000000000" when (opcode = op_ADDI) else -- verificar
				"00001110011000000000" when (opcode = op_ANDI) else -- verificar
				"00001010010100000000" when (opcode = op_SLTI) else -- verificar
				"00000000001010000100" when (opcode = op_BNE) else   -- verificar
				"01101000000110100000" when (opcode = op_JAL) else   -- verificar
            "00000000000000000000";

              
end architecture;