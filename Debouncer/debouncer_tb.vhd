-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end entity;

architecture arch of testbench is
	constant CLK_PERIOD : time := 1 ns;
    signal clk : std_logic := '1';
    signal btn : std_logic := '0';
    
begin
	debouncer_inst : entity work.debouncer
    	generic map (
        	g_cycles => 10
        )
        port map (
	   		i_clk => clk,
    	    i_switch => btn,
	        o_debounced => open
    	);      
    clk <= not clk after CLK_PERIOD / 2;
    btn <= '1' after 1 ns, '0' after 2 ns, '1' after 3 ns, '0' after 4 ns, '1' after 5 ns, '0' after 6 ns, '1' after 7 ns, '0' after 20 ns, '1' after 40 ns, '0' after 41 ns, '1' after 42 ns, '1' after 43 ns;
    exec_window : process is
    begin
    	report "STARTING TESTBENCH";
        wait for 70 ns;
        assert false report "ENDING TESTBENCH" severity failure;
    end process;
end architecture;