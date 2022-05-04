-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity btn_release_detect_tb is
end entity;

architecture arch of btn_release_detect_tb is
	constant CLK_PERIOD : time := 1 ns;
    signal clk : std_logic := '1';
    signal btn : std_logic := '0';
    
begin
	brd_inst : entity work.btn_release_detect port map(
    	i_clk => clk,
        i_btn => btn,
        o_pulse => open
    );
    clk <= not clk after CLK_PERIOD / 2;
    btn <= '1' after 2 ns, '0' after 6 ns, '1' after 11 ns, '0' after 13 ns;
    exec_window : process is
    begin
    	report "STARTING TESTBENCH";
        wait for 20 ns;
        assert false report "ENDING TESTBENCH" severity failure;
    end process;
end architecture;