library ieee;
use ieee.std_logic_1164.all;

entity TopLevel is
  -- Total de bits das entradas e saidas
  generic ( 
		larguraEndereco : natural := 32;
		larguraSinaisControle : natural := 15;
		simulacao       : boolean := TRUE
	 );
  port (
		CLOCK_50 : in std_logic;
		KEY: in std_logic_vector(3 downto 0);
		ROM_OUT: out std_logic_vector(larguraEndereco-1 downto 0);
		ULA_OUT: out std_logic_vector(larguraEndereco-1 downto 0);
		PC_OUT: out std_logic_vector(larguraEndereco-1 downto 0);
		SINAIS_CONTROLE: out std_logic_vector(larguraSinaisControle-1 downto 0)
    );
end entity;

architecture comportamento of TopLevel is

--------------------------- Sinais do Clock ----------------------------------
signal CLK : std_logic;

--------------------------- Sinais do Incrementa ----------------------------------
signal saidaIncrementa : std_logic_vector (larguraEndereco-1 downto 0);

--------------------------- Sinais do Incrementa2 ----------------------------------
signal saidaIncrementa2 : std_logic_vector (larguraEndereco-1 downto 0);

--------------------------- Sinais do muxProxPC ----------------------------------
signal proxPC : std_logic_vector (larguraEndereco-1 downto 0);

--------------------------- Sinais do muxProxPC2 ----------------------------------
signal proxPC2 : std_logic_vector (larguraEndereco-1 downto 0);
signal imediatoShiftDois : std_logic_vector (25 downto 0);

--------------------------- Sinais do PC ----------------------------------
signal saidaPC : std_logic_vector (larguraEndereco-1 downto 0);

--------------------------- Sinais da ROM ----------------------------------
signal saidaROM : std_logic_vector (larguraEndereco-1 downto 0);

--------------------------- Sinais do Banco de Regs ----------------------------------
signal saidaREG1 : std_logic_vector (larguraEndereco-1 downto 0);
signal saidaREG2 : std_logic_vector (larguraEndereco-1 downto 0);
signal REG1 : std_logic_vector (4 downto 0);
signal REG2 : std_logic_vector (4 downto 0);
signal REG3 : std_logic_vector (4 downto 0);

--------------------------- Sinais de EstendeSinal ----------------------------------
signal saidaEstendeSinal : std_logic_vector (larguraEndereco-1 downto 0);
signal imediato : std_logic_vector (15 downto 0);

--------------------------- Sinais do muxEntraRegs ----------------------------------
signal saidaMuxEntraRegs : std_logic_vector (4 downto 0);

--------------------------- Sinais do muxSaiRegs ----------------------------------
signal saidaMuxSaiRegs : std_logic_vector (larguraEndereco-1 downto 0);

--------------------------- Sinais do MuxSaiRAM ----------------------------------
signal saidaMuxSaiRAM : std_logic_vector (larguraEndereco-1 downto 0);

--------------------------- Sinais da ULA ----------------------------------
signal saidaZeroULA : std_logic;
signal saidaULA : std_logic_vector (larguraEndereco-1 downto 0);
signal ULActrl : std_logic_vector(2 downto 0);

--------------------------- Sinais da RAM ----------------------------------
signal saidaRAM : std_logic_vector (larguraEndereco-1 downto 0);

--------------------------- Sinais da Unidade de Controle ----------------------------------
signal sinaisControle : std_logic_vector (larguraSinaisControle-1 downto 0);

signal funct_UC : std_logic_vector (5 downto 0);
signal opCode_UC : std_logic_vector (5 downto 0);

signal muxBEQJMP : std_logic;
signal rt_rd : std_logic;
signal habilitaEscritaReg : std_logic;
signal rt_imediato : std_logic;
signal opCode : std_logic_vector (5 downto 0);
signal tipoR : std_logic;	
signal ULA_mem : std_logic;
signal BEQ : std_logic;
signal habLeituraMEM : std_logic;
signal habEscritaMEM : std_logic;

begin

------------------------------------ Instanciando os componentes --------------------------------
gravar:  if simulacao generate
CLK <= KEY(0);
else generate
detectorSub0: work.edgeDetector(bordaSubida)
        port map (clk => CLOCK_50, entrada => (not KEY(0)), saida => CLK);
end generate;

-- O port map completo do incrementa 
incrementa :  entity work.somaConstante  generic map (larguraDados => larguraEndereco, constante => 4)
						port map( entrada => saidaPC, saida => saidaIncrementa);
						
-- O port map completo do incrementa2 
incrementa2 :  entity work.somaConstante2  generic map (larguraDados => larguraEndereco)
						port map( entrada1 => saidaIncrementa, entrada2 => saidaEstendeSinal(29 downto 0) & "00", saida => saidaIncrementa2);
						
-- O port map completo do Program Counter
PC : entity work.registradorGenerico   generic map (larguraDados => larguraEndereco)
				 port map (DIN => proxPC2, DOUT => saidaPC, ENABLE => '1', CLK => CLK, RST => '0');

-- O port map completo da ROM
ROM : entity work.ROMMIPS 
          port map (Endereco => saidaPC, Dado => saidaROM);				 
				 
-- O port map completo do banco de registradores.
REGS : entity work.bancoReg   generic map (larguraDados => larguraEndereco)
				 port map (clk => CLK, enderecoA => REG1,
							  enderecoB => REG2, enderecoC => saidaMuxEntraRegs, dadoEscritaC => saidaMuxSaiRAM, 
							  escreveC => habilitaEscritaReg, saidaA => saidaREG1, saidaB =>saidaREG2);

-- O port map completo da ULA:
ULA  : entity work.ULAMIPS  generic map(larguraEndereco => larguraEndereco)
				 port map (A => saidaREG1, B => saidaMuxSaiRegs, resultado32 => saidaULA, 
				 saidaZero => saidaZeroULA, sel => ULActrl(1 downto 0), inverteB => ULActrl(2));

-- O port map completo da RAM:
RAM  : entity work.RAMMIPS
				 port map (clk => CLK,
							  Endereco => saidaULA,
                       Dado_in  => saidaREG2,
                       Dado_out => saidaRAM,
                       we => habEscritaMEM, re => habLeituraMEM, habilita => '1'
							  );

-- O port map completo do Extensor de Sinal:
Extensor  : entity work.estendeSinalGenerico
					 port map (
								  estendeSinal_IN => imediato,
								  estendeSinal_OUT => saidaEstendeSinal
								  );

-- O port map completo do muxProxPC:			  
muxProxPC: entity work.muxGenerico2x1
					 port map (
						entradaA_MUX => saidaIncrementa, entradaB_MUX => saidaIncrementa2,
						seletor_MUX => saidaZeroULA and BEQ,
						saida_MUX => proxPC
					 );
					 
-- O port map completo do muxProxPC2:			  
muxProxPC2: entity work.muxGenerico2x1
					 port map (
						entradaA_MUX => proxPC, entradaB_MUX => saidaIncrementa(31 downto 28) & imediatoShiftDois & "00",
						seletor_MUX => muxBEQJMP,
						saida_MUX => proxPC2
					 );
					 
-- O port map completo do muxEntraRegs:			  
muxEntraRegs: entity work.muxEntraRegsGenerico2x1
					 port map (
						entradaA_MUX => REG2, entradaB_MUX => REG3,
						seletor_MUX => rt_rd,
						saida_MUX => saidaMuxEntraRegs
					 );

-- O port map completo do muxSaiRegs:			  
muxSaiRegs: entity work.muxGenerico2x1
					 port map (
						entradaA_MUX => saidaREG2, entradaB_MUX => saidaEstendeSinal,
						seletor_MUX => rt_imediato,
						saida_MUX => saidaMuxSaiRegs
					 );

-- O port map completo do muxSaiRAM:			  
muxSaiRAM: entity work.muxGenerico2x1
					 port map (
						entradaA_MUX => saidaULA, entradaB_MUX => saidaRAM,
						seletor_MUX => ULA_mem,
						saida_MUX => saidaMuxSaiRAM
					 );

-- O port map completo da Unidade de Controle:			  
UNIDADE_CONTROLE: entity work.unidadeControle
							port map (
								opcode => opCode_UC,
								funct  => funct_UC,
								saida => sinaisControle
							);
-- O port map completo da Unidade de Controle da ULA:			  
UNIDADE_CONTROLE_ULA: entity work.unidadeControleULA
							port map (
								opcode => opCode,
								funct  => funct_UC,
								tipoR => tipoR,
								saida => ULActrl
							);				

-- Ligando sinais da Unidade de controle
SINAIS_CONTROLE <= sinaisControle;
muxBEQJMP <= sinaisControle(14);
rt_rd <= sinaisControle(13);
habilitaEscritaReg <= sinaisControle(12); 
rt_imediato <= sinaisControle(11);
opCode <= sinaisControle(10 downto 5);  -- opCode = opCode_UC
tipoR <= sinaisControle(4);
ULA_mem <= sinaisControle(3);
BEQ <= sinaisControle(2);
habLeituraMEM <= sinaisControle(1); 
habEscritaMEM <= sinaisControle(0);

-- Ligando sinais da ROM
ROM_OUT  <= saidaROM;
imediato <= saidaROM(15 downto 0);
imediatoShiftDois <= saidaROM(25 downto 0);	
REG1       <=	saidaROM(25 downto 21);	
REG2       <= saidaROM(20 downto 16);	
REG3       <= saidaROM(15 downto 11);	
opCode_UC   <= saidaROM(31 downto 26);
funct_UC    <= saidaROM(5 downto 0);

-- Ligando sinais do PC
PC_OUT  <= saidaPC;

-- Ligando sinais da ULA
ULA_OUT <= saidaULA;

end architecture;