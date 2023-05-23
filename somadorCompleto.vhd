library ieee;
use ieee.std_logic_1164.all;

entity somadorCompleto is
  port (
		A: in std_logic;
		B: in std_logic;
		C_in: in std_logic;
		C_out: out std_logic;
		soma: out std_logic
    );
end entity;

architecture comportamento of somadorCompleto is

	signal saidaXOR1 : std_logic;
	
begin
	saidaXOR1 <= A xor B;
	soma <= C_in xor saidaXOR1;
	C_out <= (C_in and saidaXOR1) or (A and B);
end architecture;