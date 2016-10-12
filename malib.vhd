library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

PACKAGE malib IS
COMPONENT dds IS PORT(
	--entrées
	clk50 : IN std_logic;
	dn : IN std_logic_vector(31 downto 0);
	--sorties
	Q : OUT std_logic);
END COMPONENT;

COMPONENT cpt_mli IS PORT(
	--entrées
	clk400k : in std_logic;
	Q : out std_logic_vector(7 downto 0));
END COMPONENT;

COMPONENT comp_Mli IS PORT(
	--entrées
	clk : in std_logic;
	cons_mli, val_mli : in std_logic_vector(7 downto 0);
	--sortie
	out_mli : out std_logic);
END COMPONENT;

END PACKAGE;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
ENTITY comp_mli IS PORT(
	--entrées
	clk : in std_logic;
	cons_mli, val_mli : in std_logic_vector(7 downto 0);
	--sortie
	out_mli : out std_logic);
END ENTITY;

ARCHITECTURE toto OF comp_Mli IS
BEGIN
	process(clk) begin
		if rising_edge(clk) then
			if val_mli > cons_mli then
				out_mli <= '0';
			else
				out_mli <= '1';
			end if;
		end if;
	end process;
END toto;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
ENTITY cpt_mli IS PORT(
	--entrées
	clk400k : in std_logic;
	Q : out std_logic_vector(7 downto 0));
END ENTITY;

ARCHITECTURE cpt OF cpt_mli IS
signal N : std_logic_vector(7 downto 0);

BEGIN
	process (clk400k) begin
		if rising_edge(clk400k) then
			if n < 199 then
				n <= n + 1;
			else
				n <= (OTHERS => '0');
			end if;
		end if;
	end process;
	Q <= N;
END cpt;




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