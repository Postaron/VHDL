library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library unisim; 
use unisim.vcomponents.all;

entity pm is
	Port (
           clk    : in std_logic;
           Rst    : in std_logic;
           PM_A   : in std_logic_vector(15 downto 0);
           PM_Drd : out std_logic_vector(15 downto 0));
end pm;

architecture Arch of pm is
constant p0_00 : BIT_VECTOR := X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
begin
pe_0 : RAMB16_S4 ---------------------------------------------------------
    generic map(
        INIT_00 => p0_00, INIT_01 => p0_00, INIT_02 => p0_00, INIT_03 => p0_00,
        INIT_04 => p0_00, INIT_05 => p0_00, INIT_06 => p0_00, INIT_07 => p0_00,
        INIT_08 => p0_00, INIT_09 => p0_00, INIT_0A => p0_00, INIT_0B => p0_00,
        INIT_0C => p0_00, INIT_0D => p0_00, INIT_0E => p0_00, INIT_0F => p0_00,
        INIT_10 => p0_00, INIT_11 => p0_00, INIT_12 => p0_00, INIT_13 => p0_00,
        INIT_14 => p0_00, INIT_15 => p0_00, INIT_16 => p0_00, INIT_17 => p0_00,
        INIT_18 => p0_00, INIT_19 => p0_00, INIT_1A => p0_00, INIT_1B => p0_00,
        INIT_1C => p0_00, INIT_1D => p0_00, INIT_1E => p0_00, INIT_1F => p0_00,
        INIT_20 => p0_00, INIT_21 => p0_00, INIT_22 => p0_00, INIT_23 => p0_00,
        INIT_24 => p0_00, INIT_25 => p0_00, INIT_26 => p0_00, INIT_27 => p0_00,
        INIT_28 => p0_00, INIT_29 => p0_00, INIT_2A => p0_00, INIT_2B => p0_00,
        INIT_2C => p0_00, INIT_2D => p0_00, INIT_2E => p0_00, INIT_2F => p0_00,
        INIT_30 => p0_00, INIT_31 => p0_00, INIT_32 => p0_00, INIT_33 => p0_00,
        INIT_34 => p0_00, INIT_35 => p0_00, INIT_36 => p0_00, INIT_37 => p0_00,
        INIT_38 => p0_00, INIT_39 => p0_00, INIT_3A => p0_00, INIT_3B => p0_00,
        INIT_3C => p0_00, INIT_3D => p0_00, INIT_3E => p0_00, INIT_3F => p0_00)
    port map(ADDR => PM_A(11 downto 0),                   
             CLK  => CLK,                    
             DI   => "0000",                  
             EN   => '1',                 
             SSR  => '0',                      
             WE   => '0',                       
             DO   => PM_Drd(3 downto 0));
 
pe_1 : RAMB16_S4 ---------------------------------------------------------
    generic map(
        INIT_00 => p0_00, INIT_01 => p0_00, INIT_02 => p0_00, INIT_03 => p0_00,
        INIT_04 => p0_00, INIT_05 => p0_00, INIT_06 => p0_00, INIT_07 => p0_00,
        INIT_08 => p0_00, INIT_09 => p0_00, INIT_0A => p0_00, INIT_0B => p0_00,
        INIT_0C => p0_00, INIT_0D => p0_00, INIT_0E => p0_00, INIT_0F => p0_00,
        INIT_10 => p0_00, INIT_11 => p0_00, INIT_12 => p0_00, INIT_13 => p0_00,
        INIT_14 => p0_00, INIT_15 => p0_00, INIT_16 => p0_00, INIT_17 => p0_00,
        INIT_18 => p0_00, INIT_19 => p0_00, INIT_1A => p0_00, INIT_1B => p0_00,
        INIT_1C => p0_00, INIT_1D => p0_00, INIT_1E => p0_00, INIT_1F => p0_00,
        INIT_20 => p0_00, INIT_21 => p0_00, INIT_22 => p0_00, INIT_23 => p0_00,
        INIT_24 => p0_00, INIT_25 => p0_00, INIT_26 => p0_00, INIT_27 => p0_00,
        INIT_28 => p0_00, INIT_29 => p0_00, INIT_2A => p0_00, INIT_2B => p0_00,
        INIT_2C => p0_00, INIT_2D => p0_00, INIT_2E => p0_00, INIT_2F => p0_00,
        INIT_30 => p0_00, INIT_31 => p0_00, INIT_32 => p0_00, INIT_33 => p0_00,
        INIT_34 => p0_00, INIT_35 => p0_00, INIT_36 => p0_00, INIT_37 => p0_00,
        INIT_38 => p0_00, INIT_39 => p0_00, INIT_3A => p0_00, INIT_3B => p0_00,
        INIT_3C => p0_00, INIT_3D => p0_00, INIT_3E => p0_00, INIT_3F => p0_00)
    port map(ADDR => PM_A(11 downto 0),                   
             CLK  => CLK,                    
             DI   => "0000",                  
             EN   => '1',                 
             SSR  => '0',                      
             WE   => '0',                       
             DO   => PM_Drd(7 downto 4));

pe_2 : RAMB16_S4 ---------------------------------------------------------
    generic map(
        INIT_00 => p0_00, INIT_01 => p0_00, INIT_02 => p0_00, INIT_03 => p0_00,
        INIT_04 => p0_00, INIT_05 => p0_00, INIT_06 => p0_00, INIT_07 => p0_00,
        INIT_08 => p0_00, INIT_09 => p0_00, INIT_0A => p0_00, INIT_0B => p0_00,
        INIT_0C => p0_00, INIT_0D => p0_00, INIT_0E => p0_00, INIT_0F => p0_00,
        INIT_10 => p0_00, INIT_11 => p0_00, INIT_12 => p0_00, INIT_13 => p0_00,
        INIT_14 => p0_00, INIT_15 => p0_00, INIT_16 => p0_00, INIT_17 => p0_00,
        INIT_18 => p0_00, INIT_19 => p0_00, INIT_1A => p0_00, INIT_1B => p0_00,
        INIT_1C => p0_00, INIT_1D => p0_00, INIT_1E => p0_00, INIT_1F => p0_00,
        INIT_20 => p0_00, INIT_21 => p0_00, INIT_22 => p0_00, INIT_23 => p0_00,
        INIT_24 => p0_00, INIT_25 => p0_00, INIT_26 => p0_00, INIT_27 => p0_00,
        INIT_28 => p0_00, INIT_29 => p0_00, INIT_2A => p0_00, INIT_2B => p0_00,
        INIT_2C => p0_00, INIT_2D => p0_00, INIT_2E => p0_00, INIT_2F => p0_00,
        INIT_30 => p0_00, INIT_31 => p0_00, INIT_32 => p0_00, INIT_33 => p0_00,
        INIT_34 => p0_00, INIT_35 => p0_00, INIT_36 => p0_00, INIT_37 => p0_00,
        INIT_38 => p0_00, INIT_39 => p0_00, INIT_3A => p0_00, INIT_3B => p0_00,
        INIT_3C => p0_00, INIT_3D => p0_00, INIT_3E => p0_00, INIT_3F => p0_00)
    port map(ADDR => PM_A(11 downto 0),                   
             CLK  => CLK,                    
             DI   => "0000",                  
             EN   => '1',                 
             SSR  => '0',                      
             WE   => '0',                       
             DO   => PM_Drd(11 downto 8)); 

pe_3 : RAMB16_S4 ---------------------------------------------------------
    generic map(
        INIT_00 => p0_00, INIT_01 => p0_00, INIT_02 => p0_00, INIT_03 => p0_00,
        INIT_04 => p0_00, INIT_05 => p0_00, INIT_06 => p0_00, INIT_07 => p0_00,
        INIT_08 => p0_00, INIT_09 => p0_00, INIT_0A => p0_00, INIT_0B => p0_00,
        INIT_0C => p0_00, INIT_0D => p0_00, INIT_0E => p0_00, INIT_0F => p0_00,
        INIT_10 => p0_00, INIT_11 => p0_00, INIT_12 => p0_00, INIT_13 => p0_00,
        INIT_14 => p0_00, INIT_15 => p0_00, INIT_16 => p0_00, INIT_17 => p0_00,
        INIT_18 => p0_00, INIT_19 => p0_00, INIT_1A => p0_00, INIT_1B => p0_00,
        INIT_1C => p0_00, INIT_1D => p0_00, INIT_1E => p0_00, INIT_1F => p0_00,
        INIT_20 => p0_00, INIT_21 => p0_00, INIT_22 => p0_00, INIT_23 => p0_00,
        INIT_24 => p0_00, INIT_25 => p0_00, INIT_26 => p0_00, INIT_27 => p0_00,
        INIT_28 => p0_00, INIT_29 => p0_00, INIT_2A => p0_00, INIT_2B => p0_00,
        INIT_2C => p0_00, INIT_2D => p0_00, INIT_2E => p0_00, INIT_2F => p0_00,
        INIT_30 => p0_00, INIT_31 => p0_00, INIT_32 => p0_00, INIT_33 => p0_00,
        INIT_34 => p0_00, INIT_35 => p0_00, INIT_36 => p0_00, INIT_37 => p0_00,
        INIT_38 => p0_00, INIT_39 => p0_00, INIT_3A => p0_00, INIT_3B => p0_00,
        INIT_3C => p0_00, INIT_3D => p0_00, INIT_3E => p0_00, INIT_3F => p0_00)
    port map(ADDR => PM_A(11 downto 0),                   
             CLK  => CLK,                    
             DI   => "0000",                  
             EN   => '1',                 
             SSR  => '0',                      
             WE   => '0',                       
             DO   => PM_Drd(15 downto 12)); 
end architecture Arch;

--architecture Arch of pm is
--
--   type PM_mem_type is array(0 to 111) of std_logic_vector(15 downto 0);
--   signal PM_mem : PM_mem_type := (
---- begin of program words-----
--     x"C012", x"C017", x"C016", x"C015", x"C014", x"C013", x"C012", x"C011",
--     x"C010", x"C00F", x"C00E", x"C00D", x"C00C", x"C00B", x"C00A", x"C009",
--     x"C008", x"C007", x"C006", x"2411", x"BE1F", x"EDCF", x"BFCD", x"D02E",
--     x"C055", x"CFE6", x"93DF", x"93CF", x"D000", x"D000", x"B7CD", x"B7DE",
--     x"019B", x"01AC", x"8219", x"821A", x"821B", x"821C", x"8219", x"821A",
--     x"821B", x"821C", x"C00B", x"8189", x"819A", x"81AB", x"81BC", x"9601",
--     x"1DA1", x"1DB1", x"8389", x"839A", x"83AB", x"83BC", x"8189", x"819A",
--     x"81AB", x"81BC", x"1782", x"0793", x"07A4", x"07B5", x"F360", x"900F",
--     x"900F", x"900F", x"900F", x"91CF", x"91DF", x"9508", x"93DF", x"93CF",
--     x"D000", x"D000", x"B7CD", x"B7DE", x"B32B", x"BB2B", x"8219", x"821A",
--     x"821B", x"821C", x"8219", x"821A", x"821B", x"821C", x"C00B", x"8189",
--     x"819A", x"81AB", x"81BC", x"9601", x"1DA1", x"1DB1", x"8389", x"839A",
--     x"83AB", x"83BC", x"8189", x"819A", x"81AB", x"81BC", x"5A80", x"4896",
--     x"40A1", x"40B0", x"F360", x"0F22", x"F701", x"CFDE", x"94F8", x"CFFF");
---- end of program words -----
--
--begin
--
--   pmproc : process (clk)
--     variable a_int : natural;
--   begin
--     if (clk'event and clk='1') then
--        a_int := CONV_INTEGER(PM_A);
--        PM_Drd <= PM_mem(a_int);
--     end if;
--  end process pmproc;
--
--end architecture Arch;
