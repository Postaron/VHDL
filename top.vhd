library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

library work;
use work.malib.all;
ENTITY top IS PORT(
	--entrées physiques
	clk50, boutonD, boutonG, sensorAG, sensorBG, sensorAD, sensorBD, init : in std_logic;
	interD_mli : in std_logic_vector(3 downto 0);
	--sorties physiques
	en_g, en_d, dirg, dird, sortieSensorA, sortieSensorB : out std_logic;
	led : out std_logic_vector(7 downto 0));
END ENTITY;
 
ARCHITECTURE toto OF top IS
signal clk400k, clk8, save_mg, clear_mg, en_mg, save_md, clear_md, en_md : std_logic; --signal interne
signal out_cpt, vd, vg : std_logic_vector(7 downto 0); --signal interne
BEGIN
	ic1 : dds PORT MAP ( --premier dds de 400kHz
	clk50 => clk50, dn => X"020C49BA", Q => clk400k); --valeur trouvée par le calcul
	
	ic2 : cpt_mli PORT MAP ( --compteur de PWM
	clk400k => clk400k, Q => out_cpt);
	
	ic3 : comp_mli PORT MAP ( --comparateur PWM moteurG
	clk => clk400k, val_mli => out_cpt , cons_mli(3 downto 0) => "1111", cons_mli(7 downto 4) => interD_mli, out_mli => en_g);
	
	ic4 : comp_mli PORT MAP ( --comparateur PWM moteurD
	clk => clk400k, val_mli => out_cpt, cons_mli(3 downto 0) => "1111", cons_mli(7 downto 4) => interD_mli, out_mli => en_d);
	
	ic5 : dds PORT MAP ( --second dds de 8Hz
	clk50 => clk50, dn => X"000002B0", Q => clk8); --valeur trouvée par le calcul

	ic6 : fsm_mesure PORT MAP (
	clk => clk50, init => init, clk_mesure => clk8, pulse => sensorAG,
	save_m => save_mg, clear_m => clear_mg, en_m => en_mg);
	
	ic7 : fsm_mesure PORT MAP (
	clk => clk50, init => init, clk_mesure => clk8, pulse => sensorAD,
	save_m => save_md, clear_m => clear_md, en_m => en_md);
	
	ic8 : cpt_speed PORT MAP (
	clk => clk50, en => en_mg, clr => clear_mg, en_save => save_mg, Q => vg);
	
	ic9 : cpt_speed PORT MAP (
	clk => clk50, en => en_md, clr => clear_md, en_save => save_md, Q => vd);
	
	dirg <= '1';
	dird <= '0';
	sortieSensorA <= sensorAD; --on sort les valeurs des sensor
	sortieSensorB <= sensorBD; -- de façon combinatoire (en permanence)
	led <= vd;					  -- le compilo fait un simple fil de l'entrée vers la sortie
END toto;