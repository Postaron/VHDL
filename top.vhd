library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

library work;
use work.malib.all;
ENTITY top IS PORT(
	--entrées
	clk50, boutonD, boutonG, sensorA, sensorB : in std_logic;
	interD_mli, interG_mli : in std_logic_vector(3 downto 0);
	--sorties
	en_g, en_d, dirg, dird, sortieSensorA, sortieSensorB : out std_logic);
END ENTITY;

ARCHITECTURE toto OF top IS
signal clk400k : std_logic;
signal out_cpt : std_logic_vector(7 downto 0);
BEGIN
	ic1 : dds PORT MAP (
	clk50 => clk50, dn => X"020C49BA", Q => clk400k);
	
	ic2 : cpt_mli PORT MAP (
	clk400k => clk400k, Q => out_cpt);
	
	ic3 : comp_mli PORT MAP (
	clk => clk400k, val_mli => out_cpt , cons_mli(3 downto 0) => "1111", cons_mli(7 downto 4) => interG_mli, out_mli => en_g);
	
	ic4 : comp_mli PORT MAP (
	clk => clk400k, val_mli => out_cpt, cons_mli(3 downto 0) => "1111", cons_mli(7 downto 4) => interD_mli, out_mli => en_d);
	
	process(clk50) begin
		if rising_edge(clk50) then
			if boutonG = '1' then
				dirg <= '1';
			else
				dirg <= '0';
			end if;
			if boutonD = '1' then
				dird <= '1';
			else
				dird <= '0';
			end if;
			
		end if;
	end process;
	sortieSensorA <= sensorA;
	sortieSensorB <= sensorB;
END toto;