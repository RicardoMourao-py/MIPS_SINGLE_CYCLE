library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  --Soma (esta biblioteca =ieee)

entity somaConstante2 is
    generic
    (
        larguraDados : natural := 32
    );
    port
    (
        entrada1: in  STD_LOGIC_VECTOR((larguraDados-1) downto 0);
		  entrada2: in  STD_LOGIC_VECTOR((larguraDados-1) downto 0);
        saida:   out STD_LOGIC_VECTOR((larguraDados-1) downto 0)
    );
end entity;

architecture comportamento of somaConstante2 is
    begin
        saida <= std_logic_vector(unsigned(entrada1) + unsigned(entrada2));
end architecture;