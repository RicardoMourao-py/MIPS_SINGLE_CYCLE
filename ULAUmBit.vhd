library ieee;
use ieee.std_logic_1164.all;

entity ULAUmBit is
  port (
		A, B, SLT, C_in, inverteB : in std_logic;
		sel : in std_logic_vector(1 downto 0);
		C_out, resultado : out std_logic
		
    );
end entity;

architecture comportamento of ULAUmBit is
	signal saidaMUX1 : std_logic;
	signal saidaSomador : std_logic;
begin

-- O port map completo do MUX 2x1.
MUX2x1 :  entity work.muxGenerico2x1_ULA  generic map (larguraDados => 1)
				  port map( entradaA_MUX => B,
							  entradaB_MUX =>  not B,
							  seletor_MUX => inverteB,
							  saida_MUX => saidaMUX1);

-- O port map completo do somador.							  
SOMADOR : entity work.somadorCompleto
				port map(
					A => A,
					B => saidaMUX1,
					C_in => C_in,
					C_out => C_out,
					soma => saidaSomador
				 );

resultado <=  (A and saidaMUX1) when sel = "00" else
              (A or saidaMUX1) when sel = "01" else
              saidaSomador when sel = "10" else
              SLT;						  
end architecture;