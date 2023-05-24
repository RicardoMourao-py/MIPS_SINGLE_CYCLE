library ieee;
use ieee.std_logic_1164.all;

entity unidadeControle is
  generic (
    larguraOpCode: natural := 6;
    larguraFunct: natural := 6;
    larguraSinaisControle: natural := 17
  );

  port ( opcode : in std_logic_vector(larguraOpCode-1 downto 0);
         funct : in std_logic_vector(larguraFunct-1 downto 0);
         saida : out std_logic_vector(larguraSinaisControle-1 downto 0)
  );
end entity;

architecture comportamento of unidadeControle is

  constant op_AND: std_logic_vector(larguraFunct-1 downto 0) := "100100";
  constant op_OR : std_logic_vector(larguraFunct-1 downto 0) := "100101";
  constant op_ADD : std_logic_vector(larguraFunct-1 downto 0) := "100000";
  constant op_SUB : std_logic_vector(larguraFunct-1 downto 0) := "100010";
  constant op_SLT : std_logic_vector(larguraFunct-1 downto 0) := "101010";

  constant op_LW  : std_logic_vector(larguraOpCode-1 downto 0) := "100011";
  constant op_SW  : std_logic_vector(larguraOpCode-1 downto 0) := "101011";
  constant op_BEQ : std_logic_vector(larguraOpCode-1 downto 0) := "000100";
  constant op_JMP : std_logic_vector(larguraOpCode-1 downto 0) := "000010";

  constant op_LUI  : std_logic_vector(larguraOpCode-1 downto 0) := "001111";
  constant op_ORI  : std_logic_vector(larguraOpCode-1 downto 0) := "001101";
  
  begin
    saida <="01100000000100000" when (opcode = "000000" and funct = op_AND) else
            "01100000000100000" when (opcode = "000000" and funct = op_OR) else
				"01100000000100000" when (opcode = "000000" and funct = op_ADD) else
				"01100000000100000" when (opcode = "000000" and funct = op_SUB) else
				"01100000000100000" when (opcode = "000000" and funct = op_SLT) else
            "00101100011001010" when (opcode = op_LW) else
            "00001101011000001" when (opcode = op_SW) else
            "00000000100000100" when (opcode = op_BEQ) else
				"10000000010000000" when (opcode = op_JMP) else
				"00100001111011000" when (opcode = op_LUI) else
				"00111001101000000" when (opcode = op_ORI) else
            "00000000000000000";

              
end architecture;