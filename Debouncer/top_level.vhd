library ieee;
use ieee.std_logic_1164.all;
use ieee.std_numeric.all;

entity top is
	port(
		i_Clk : in std_logic;
		i_Switch_1 : in std_logic;
		o_LED_1 : out std_logic
	);
end entity;

architecture behavior of top is
begin
	debouncer_inst : entity work.debouncer
	generic map (
		g_cycles => 65000
	)
	port map (
		i_clk => i_Clk,
		i_switch => i_Switch_1,
		o_debounced => o_LED_1
	);
end architecture;