library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.malib.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity microcontroleur is
    Port ( clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			--pos_bot,v_mot_g,v_mot_d : in STD_LOGIC_VECTOR (7 downto 0);
			rd_data : out std_logic_vector(7 downto 0);
			--cmlig,cmlid : inout  STD_LOGIC_VECTOR (7 downto 0);
			led : out  STD_LOGIC_VECTOR (7 downto 0);
			en_g,en_d,dir_g,dir_d : out std_logic;
			sensorAG, sensorBG, sensorAD, sensorBD : in std_logic
			);
end microcontroleur;

architecture microcontroleur_architecture of microcontroleur is
--Registres et PORTs de l'ATTiny861
constant OCR1A : std_logic_vector(5 downto 0) := "101101";
constant OCR1B : std_logic_vector(5 downto 0) := "101100";
constant PORTA : std_logic_vector(5 downto 0) := "011011";
constant DDRA : std_logic_vector(5 downto 0) := "011010";
constant PINA : std_logic_vector(5 downto 0) := "011001";
constant PORTB : std_logic_vector(5 downto 0) := "011000";
constant DDRB : std_logic_vector(5 downto 0) := "010111";
constant PINB : std_logic_vector(5 downto 0) := "010110"; --0x16
constant ADCH : std_logic_vector(5 downto 0) := "000101";
constant ADCL : std_logic_vector(5 downto 0) := "000100";
--Registres non présents dans l'ATTiny861
constant UDR : std_logic_vector(5 downto 0) := "000011";
constant UCSRA : std_logic_vector(5 downto 0) := "000010";
constant UCSRB : std_logic_vector(5 downto 0) := "000001";
	component mcu_core is
		Port (
			Clk	: in std_logic;
			Rst	: in std_logic; -- Reset core when Rst='1'
			En		: in std_logic; -- CPU stops when En='0', could be used to slow down cpu to save power
			-- PM
			PM_A		: out std_logic_vector(15 downto 0);
			PM_Drd	: in std_logic_vector(15 downto 0);
			-- DM
			DM_A		: out std_logic_vector(15 downto 0); -- 0x00 - xxxx
			DM_Areal	: out std_logic_vector(15 downto 0); -- 0x60 - xxxx (same as above + io-adr offset)
			DM_Drd	: in std_logic_vector(7 downto 0);
			DM_Dwr	: out std_logic_vector(7 downto 0);
			DM_rd		: out std_logic;
			DM_wr		: out std_logic;
			-- IO
			IO_A		: out std_logic_vector(5 downto 0); -- 0x00 - 0x3F
			IO_Drd	: in std_logic_vector(7 downto 0);
			IO_Dwr	: out std_logic_vector(7 downto 0);
			IO_rd		: out std_logic;
			IO_wr		: out std_logic;
			-- OTHER
		   OT_FeatErr	: out std_logic; -- Feature error! (Unhandled part of instruction)
		   OT_InstrErr	: out std_logic -- Instruction error! (Unknown instruction)
		);
	end component mcu_core;
	--PM
	component pm  is
		Port (
				Clk	: in std_logic;
				rst	: in std_logic; -- Reset when Rst='1'
				-- PM
				PM_A		: in std_logic_vector(15 downto 0);
				PM_Drd	: out std_logic_vector(15 downto 0)
		);
	end component pm;	

  component dm is
    Port ( clk : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (15 downto 0);
           dataread : out  STD_LOGIC_VECTOR (7 downto 0);
           datawrite : in  STD_LOGIC_VECTOR (7 downto 0);
           rd : in  STD_LOGIC;
           wr : in  STD_LOGIC);
  end component dm;
  
component avrioport is
    Generic (BASE_ADDR	: integer := 16#19#);
    Port ( clk : in  STD_LOGIC;
	        rst : in STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (5 downto 0);
           ioread : out  STD_LOGIC_VECTOR (7 downto 0);
           iowrite : in  STD_LOGIC_VECTOR (7 downto 0);
           rd : in  STD_LOGIC;
           wr : in  STD_LOGIC;
			  inoutport : inout  STD_LOGIC_VECTOR (7 downto 0));
end component avrioport;

component iodrdmux is
    Generic (ADDR_A	: integer := 16#19#;
	          ADDR_B  : integer := 16#16#);
    Port ( io_A : in  STD_LOGIC_VECTOR (5 downto 0);
           io_DrdA : in  STD_LOGIC_VECTOR (7 downto 0);
           io_DrdB : in  STD_LOGIC_VECTOR (7 downto 0);
           io_Drd : out  STD_LOGIC_VECTOR (7 downto 0));
end component iodrdmux;

component mod_m_counter is
	generic (
		N : integer :=4;	-- number of bits
		M : integer :=10	-- mod-M
	);
	
	port (
		clk,reset : in std_logic;
		max_tick : out std_logic;
		q : out std_logic_vector ( N-1 downto 0)
	);
end component;

component uart_tx is
    Port (            data_in : in std_logic_vector(7 downto 0);
                 write_buffer : in std_logic;
                 reset_buffer : in std_logic;
                 en_16_x_baud : in std_logic;
                   serial_out : out std_logic;
                  buffer_full : out std_logic;
             buffer_half_full : out std_logic;
                          clk : in std_logic);
    end component;
	 
component uart_rx is
    Port (            serial_in : in std_logic;
                       data_out : out std_logic_vector(7 downto 0);
                    read_buffer : in std_logic;
                   reset_buffer : in std_logic;
                   en_16_x_baud : in std_logic;
            buffer_data_present : out std_logic;
                    buffer_full : out std_logic;
               buffer_half_full : out std_logic;
                            clk : in std_logic);
end component uart_rx;

	signal PM_A		: std_logic_vector(15 downto 0);
	signal PM_Drd	: std_logic_vector(15 downto 0);
	-- DM
	signal DM_A			: std_logic_vector(15 downto 0); -- 0x00 - xxxx
	signal DM_Areal	: std_logic_vector(15 downto 0); -- 0x60 - xxxx (same as above + io-adr offset)
	signal DM_Drd		: std_logic_vector(7 downto 0);
	signal DM_Dwr		: std_logic_vector(7 downto 0);
	signal DM_rd		: std_logic;
	signal DM_wr		: std_logic;
	-- IO
	signal IO_A		: std_logic_vector(5 downto 0); -- 0x00 - 0x3F
	signal IO_Drd	: std_logic_vector(7 downto 0);
	signal IO_Dwr	: std_logic_vector(7 downto 0);
	signal IO_rd	: std_logic;
	signal IO_wr	: std_logic;

	signal IO_DrdA	: std_logic_vector(7 downto 0);
	signal IO_DrdB	: std_logic_vector(7 downto 0);
--	signal clk : std_logic;

	signal s_en : std_logic;
	signal en_16_x_baud : std_logic;
	signal s_full : std_logic;
	signal s_UCSRB : std_logic_vector(7 downto 0);
	signal s_buffer_read : std_logic;
	signal s_in_udr : std_logic_vector(7 downto 0);
	signal s_rxc : std_logic;
	signal io_rd_d : std_logic;

	signal clk400k, clk8, save_mg, clear_mg, en_mg, save_md, clear_md, en_md : std_logic; --signal interne, anciennement i/o
	signal out_cpt, vd, vg,dir,cmlig,cmlid : std_logic_vector(7 downto 0); --signal interne, anciennement i/o
	
begin

	dir_d <= dir(0);
	dir_g <= dir(1);

	dds400 : dds port map (
	clk50 => clk, dn => X"020C49BA", Q => clk400k);

	cpt_pwm : cpt_mli PORT MAP ( --compteur de PWM
	clk400k => clk400k, Q => out_cpt);

	compG : comp_mli PORT MAP ( --comparateur PWM moteurG
	clk => clk400k, val_mli => out_cpt , cons_mli => cmlig, out_mli => en_g);
	
	compD : comp_mli PORT MAP ( --comparateur PWM moteurD
	clk => clk400k, val_mli => out_cpt, cons_mli => cmlid, out_mli => en_d);
	
	dds8 : dds PORT MAP ( --second dds de 8Hz
	clk50 => clk, dn => X"000002B0", Q => clk8); --valeur trouvée par le calcul

	ic6 : fsm_mesure PORT MAP (
	clk => clk, init => rst, clk_mesure => clk8, pulse => sensorAG,
	save_m => save_mg, clear_m => clear_mg, en_m => en_mg);
	
	ic7 : fsm_mesure PORT MAP ( --machine état pour mesure et validation mesure
	clk => clk, init => rst, clk_mesure => clk8, pulse => sensorAD,
	save_m => save_md, clear_m => clear_md, en_m => en_md);
	
	ic8 : cpt_speed PORT MAP (
	clk => clk, en => en_mg, clr => clear_mg, en_save => save_mg, Q => vg);
	
	ic9 : cpt_speed PORT MAP (
	clk => clk, en => en_md, clr => clear_md, en_save => save_md, Q => vd);
	
	core : mcu_core Port map (
		Clk	=> clk,
		Rst	=> Rst,
		En		=> '1',
		-- PM
		PM_A		=> PM_A,
		PM_Drd	=> PM_Drd,
		-- DM
		DM_A		=> DM_A,
		DM_Areal	=> DM_Areal,
		DM_Drd	=> DM_Drd,
		DM_Dwr	=> DM_Dwr,
		DM_rd		=> DM_rd,
		DM_wr		=> DM_wr,
		-- IO
		IO_A		=> IO_A,
		IO_Drd	=> IO_Drd,
		IO_Dwr	=> IO_Dwr,
		IO_rd		=> IO_rd,
		IO_wr		=> IO_wr,
		-- OTHER
		OT_FeatErr => open,
		OT_InstrErr	=> open
	);

	prgmem : pm port map (
			Clk	=> clk,
			Rst	=> Rst,
			-- PM
			PM_A		=> PM_A,
			PM_Drd	=> PM_Drd
	);
	
	datamem : dm port map (
           clk => clk,
           addr => DM_A,
           dataread  => DM_Drd,
           datawrite => DM_Dwr,
           rd => DM_rd, 
           wr =>	DM_wr
	);
	
	-- IO write process

    iowr: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (IO_wr = '1') then
                case IO_A is
		 -- addresses for tiny861 device (use io.h).
       --
                    when PORTA  => cmlig <= IO_Dwr; 			-- PORTA=X"1B" (0X3B)
                                   
		              when PORTB => cmlid <= IO_Dwr;	-- PORTB=X"18" (0X3B)
			           				                          
						  when UCSRB => dir <=IO_Dwr;			-- PORT UART =X" " ( 0x   )
                    
						  when others =>
                end case;
            end if;
        end if;
    end process;
	 
-- IO read process
--
    iord: process(vg,vd)
    begin
        -- addresses for tinyX6 device (use iom8.h).
        --
		  if IO_rd = '1' then
          case IO_A is
				when PINA => IO_Drd <= vg;  -- PINA=X"19" (0X39)
            when PINB => IO_Drd <= vd;  -- PINB=X"16" (0X36)
            --when UCSRA => IO_Drd <= pos_bot;
				--when UDR	=> IO_DRD <= s_in_UDR;
            when others => IO_Drd <= X"AA";
          end case;
		  end if;
    end process;
	 
	 -- pour acces a des données stables
	 -- envoi du signal io_rd a la logique
	 rd_data <= cmlig;

end microcontroleur_architecture;

