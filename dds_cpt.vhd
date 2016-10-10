library ieee;
use ieee.std_logic_1164.all;
ENTITY dds IS PORT(
	--entrées
	clk50 : IN bit;
	dn : IN bit_vector(31 downto 0);
	d32 : IN bit_vector(31 downto 0);
	--sorties
	c : OUT bit_vector(31 downto 0);
	Q32 : OUT bit_vector(31 downto 0);
	Q : OUT bit);
END dds;

ARCHITECTURE DDS OF dds is
BEGIN
	process(clk50) begin
		if rising_edge(clk50) then
			c <= ('0' & Q32(30 downto 0)) + dn;
			Q32 <= c;
		END if;
	END process;
END DDS;