library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

ENTITY dds IS PORT(
	--entrées
	clk50 : IN std_logic;
	dn : IN std_logic_vector(31 downto 0);
	--sorties
	Q : OUT std_logic);
END dds;

ARCHITECTURE DDS OF dds is

signal c : std_logic_vector(31 downto 0);
signal Q32 : std_logic_vector(31 downto 0);
signal toto : std_logic;
BEGIN
	process(clk50) begin
		if (rising_edge(clk50)) then
			c <= ('0' & Q32(30 downto 0)) + dn;
			Q32 <= c;
		END if;
	END process;
	process(clk50) begin
		if rising_edge(clk50) then
			if Q32(31) = '1' then
				toto <= not toto;
			end if;
		end if;
	end process;
	Q <= toto;
END DDS;