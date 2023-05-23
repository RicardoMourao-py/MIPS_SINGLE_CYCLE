library ieee;
use ieee.std_logic_1164.all;

entity ULAMIPS is
  generic ( 
		larguraEndereco : natural := 32
	 );
  port (
		A, B: in std_logic_vector(larguraEndereco-1 downto 0);
      inverteB: in std_logic;
      resultado32: out std_logic_vector(larguraEndereco-1 downto 0);
      saidaZero: out std_logic;
      sel: in std_logic_vector(1 downto 0)
    );
end entity;

architecture comportamento of ULAMIPS is
	--------------------------- Sinais da ULA ----------------------------------
	signal vaiUm: std_logic_vector(larguraEndereco-1 downto 0);
	signal result: std_logic_vector(larguraEndereco-1 downto 0);
	signal overflow: std_logic;

begin

------------------------------------ Instanciando os componentes --------------------------------

Bit0: entity work.ULAUmBit 
		  port map (
				A => A(0), B => B(0), SLT => overflow, inverteB => inverteB, 
				C_in => inverteB, resultado => result(0), sel => sel, C_out => vaiUm(0)
		  );
		  
Bit1: entity work.ULAUmBit 
		  port map (
				A => A(1), B => B(1), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(0), resultado => result(1), sel => sel, C_out => vaiUm(1)
		  );

Bit2: entity work.ULAUmBit 
		  port map (
				A => A(2), B => B(2), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(1), resultado => result(2), sel => sel, C_out => vaiUm(2)
		  );

Bit3: entity work.ULAUmBit 
		  port map (
				A => A(3), B => B(3), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(2), resultado => result(3), sel => sel, C_out => vaiUm(3)
		  );

Bit4: entity work.ULAUmBit 
		  port map (
				A => A(4), B => B(4), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(3), resultado => result(4), sel => sel, C_out => vaiUm(4)
		  );		  

Bit5: entity work.ULAUmBit 
		  port map (
				A => A(5), B => B(5), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(4), resultado => result(5), sel => sel, C_out => vaiUm(5)
		  );
		  
Bit6: entity work.ULAUmBit 
		  port map (
				A => A(6), B => B(6), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(5), resultado => result(6), sel => sel, C_out => vaiUm(6)
		  );

Bit7: entity work.ULAUmBit 
		  port map (
				A => A(7), B => B(7), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(6), resultado => result(7), sel => sel, C_out => vaiUm(7)
		  );		  

Bit8: entity work.ULAUmBit 
		  port map (
				A => A(8), B => B(8), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(7), resultado => result(8), sel => sel, C_out => vaiUm(8)
		  );

Bit9: entity work.ULAUmBit 
		  port map (
				A => A(9), B => B(9), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(8), resultado => result(9), sel => sel, C_out => vaiUm(9)
		  );

Bit10: entity work.ULAUmBit 
		  port map (
				A => A(10), B => B(10), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(9), resultado => result(10), sel => sel, C_out => vaiUm(10)
		  );

Bit11: entity work.ULAUmBit 
		  port map (
				A => A(11), B => B(11), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(10), resultado => result(11), sel => sel, C_out => vaiUm(11)
		  );

Bit12: entity work.ULAUmBit 
		  port map (
				A => A(12), B => B(12), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(11), resultado => result(12), sel => sel, C_out => vaiUm(12)
		  );

Bit13: entity work.ULAUmBit 
		  port map (
				A => A(13), B => B(13), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(12), resultado => result(13), sel => sel, C_out => vaiUm(13)
		  );

Bit14: entity work.ULAUmBit 
		  port map (
				A => A(14), B => B(14), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(13), resultado => result(14), sel => sel, C_out => vaiUm(14)
		  );

Bit15: entity work.ULAUmBit 
		  port map (
				A => A(15), B => B(15), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(14), resultado => result(15), sel => sel, C_out => vaiUm(15)
		  );

Bit16: entity work.ULAUmBit 
		  port map (
				A => A(16), B => B(16), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(15), resultado => result(16), sel => sel, C_out => vaiUm(16)
		  );

Bit17: entity work.ULAUmBit 
		  port map (
				A => A(17), B => B(17), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(16), resultado => result(17), sel => sel, C_out => vaiUm(17)
		  );		  
		  
Bit18: entity work.ULAUmBit 
		  port map (
				A => A(18), B => B(18), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(17), resultado => result(18), sel => sel, C_out => vaiUm(18)
		  );

Bit19: entity work.ULAUmBit 
		  port map (
				A => A(19), B => B(19), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(18), resultado => result(19), sel => sel, C_out => vaiUm(19)
		  );

Bit20: entity work.ULAUmBit 
		  port map (
				A => A(20), B => B(20), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(19), resultado => result(20), sel => sel, C_out => vaiUm(20)
		  );

Bit21: entity work.ULAUmBit 
		  port map (
				A => A(21), B => B(21), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(20), resultado => result(21), sel => sel, C_out => vaiUm(21)
		  );

Bit22: entity work.ULAUmBit 
		  port map (
				A => A(22), B => B(22), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(21), resultado => result(22), sel => sel, C_out => vaiUm(22)
		  );
		  
Bit23: entity work.ULAUmBit 
		  port map (
				A => A(23), B => B(23), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(22), resultado => result(23), sel => sel, C_out => vaiUm(23)
		  );

Bit24: entity work.ULAUmBit 
		  port map (
				A => A(24), B => B(24), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(23), resultado => result(24), sel => sel, C_out => vaiUm(24)
		  );
		  
Bit25: entity work.ULAUmBit 
		  port map (
				A => A(25), B => B(25), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(24), resultado => result(25), sel => sel, C_out => vaiUm(25)
		  );
		  
Bit26: entity work.ULAUmBit 
		  port map (
				A => A(26), B => B(26), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(25), resultado => result(26), sel => sel, C_out => vaiUm(26)
		  );
		  
Bit27: entity work.ULAUmBit 
		  port map (
				A => A(27), B => B(27), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(26), resultado => result(27), sel => sel, C_out => vaiUm(27)
		  );
		  
Bit28: entity work.ULAUmBit 
		  port map (
				A => A(28), B => B(28), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(27), resultado => result(28), sel => sel, C_out => vaiUm(28)
		  );

Bit29: entity work.ULAUmBit 
		  port map (
				A => A(29), B => B(29), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(28), resultado => result(29), sel => sel, C_out => vaiUm(29)
		  );

Bit30: entity work.ULAUmBit 
			port map (
				A => A(30), B => B(30), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(29), resultado => result(30), sel => sel, C_out => vaiUm(30)
			);
			
Bit31: entity work.ULA31Bit 
		  port map (
				A => A(31), B => B(31), SLT => '0', inverteB => inverteB, 
				C_in => vaiUm(30), resultado => result(31), sel => sel, C_out => vaiUm(31), 
				overflow => overflow
		  );

resultado32 <= result;
saidaZero <= not(result(31) or result(30) or result(29) or result(28) or result(27) or result(26) or result(25) or result(24) or result(23) or result(22) or result(21) or result(20) or result(19) or result(18) or result(17) or result(16) or result(15) or result(14) or result(13) or result(12) or result(11) or result(10) or result(9) or result(8) or result(7) or result(6) or result(5) or result(4) or result(3) or result(2) or result(1) or result(0));
end architecture;