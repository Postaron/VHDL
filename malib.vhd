library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

PACKAGE malib IS --package : paquet genre librarie
COMPONENT dds IS PORT(
	--entrées
	clk50 : in std_logic;
	dn : in std_logic_vector(31 downto 0);
	--sorties
	Q : OUT std_logic);
END COMPONENT;

COMPONENT cpt_mli IS PORT(
	--entrées
	clk400k : in std_logic;
	--sortie
	Q : out std_logic_vector(7 downto 0));
END COMPONENT;

COMPONENT comp_Mli IS PORT(
	--entrées
	clk : in std_logic;
	cons_mli, val_mli : in std_logic_vector(7 downto 0);
	--sortie
	out_mli : out std_logic);
END COMPONENT;

COMPONENT fsm_mesure IS PORT(
	--entrées
	clk, init, clk_mesure, pulse : in std_logic;
	save_m, clear_m, en_m : out std_logic);
END COMPONENT;

COMPONENT cpt_speed IS PORT(
	--entrées
	clk, en, clr, en_save : in std_logic;
	--sortie
	Q : out std_logic_vector(7 downto 0));
END COMPONENT;

END PACKAGE;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
ENTITY cpt_speed IS PORT(
	--entrées
	clk, en, clr, en_save : in std_logic;
	--sortie
	Q : out std_logic_vector(7 downto 0));
END ENTITY;

ARCHITECTURE cpt OF cpt_speed IS
signal n : std_logic_vector(7 downto 0);
BEGIN
	process(clk) begin
		if rising_edge(clk) then
			if(clr = '1') then
				n <= (OTHERS => '0');
			elsif en = '1' then
				if n < 255 then
					n <= n + 1;
				end if;
			end if;
		end if;
	end process;
	process(clk) begin
		if rising_edge(clk) then
			if en_save = '1' then
				Q <= n;
			end if;
		end if;
	end process;
END cpt;



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

ENTITY fsm_mesure IS PORT(
	--entrées
	clk, init, clk_mesure, pulse : in std_logic;
	save_m, clear_m, en_m : out std_logic);
END ENTITY;

ARCHITECTURE titi OF fsm_mesure IS
type state is (e0, e1, e2, e3, e4, e5);
signal etat : state;
BEGIN
	process(clk) begin
		if rising_edge(clk) then
			if init = '1' then
				etat <= e0;
			else
				case etat is
					when e0 => 	if clk_mesure = '0' then
										etat <= e1;
										save_m <= '0';
										clear_m <= '0';
										en_m <= '0';
									else
										etat <= e0;
										save_m <= '0';
										clear_m <= '1';
										en_m <= '0';
									end if;
					when e1 =>	if (clk_mesure = '0' AND pulse = '1') then
										etat <= e2;
										save_m <= '0';
										clear_m <= '0';
										en_m <= '0';
									elsif clk_mesure = '1' then
										etat <= e5;
										save_m <= '1';
										clear_m <= '0';
										en_m <= '0';
									else
										etat <= e1;
										save_m <= '0';
										clear_m <= '0';
										en_m <= '0';
									end if;
					when e2 =>	if (pulse = '0' AND clk_mesure = '0') then
										etat <= e3;
										save_m <= '0';
										clear_m <= '0';
										en_m <= '1';
									elsif clk_mesure = '1' then
										etat <= e5;
										save_m <= '1';
										clear_m <= '0';
										en_m <= '0';
									else
										etat <= e2;
										save_m <= '0';
										clear_m <= '0';
										en_m <= '0';
									end if;
					when e3 =>	etat <= e4;
									save_m <= '0';
									clear_m <= '0';
									en_m <= '0';
					when e4 =>	if clk_mesure = '1' then
										etat <= e5;
										save_m <= '1';
										clear_m <= '0';
										en_m <= '0';
									elsif clk_mesure = '0' then
										etat <= e1;
										save_m <= '0';
										clear_m <= '0';
										en_m <= '0';
									else
										etat <= e4;
										save_m <= '0';
										clear_m <= '0';
										en_m <= '0';
									end if;
					when e5 =>	etat <= e0;
									save_m <= '0';
									clear_m <= '1';
									en_m <= '0';
					when OTHERS => etat <= e0;
										save_m <= '0';
										clear_m <= '1';
										en_m <= '0';
				end case;
			end if;
		end if;
	end process;
end titi;
	

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

ARCHITECTURE dds_work OF dds is
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
END dds_work;