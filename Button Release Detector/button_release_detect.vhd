library IEEE;
use IEEE.std_logic_1164.all;

entity btn_release_detect is
    port (
       i_clk : in std_logic;
       i_btn : in std_logic;
       o_pulse : out std_logic  -- generates a 1-clk-tick pulse upon button release
    );
end entity;

architecture behavior of btn_release_detect is
    signal r_pulse : std_logic := '0'; -- a one-cycle high pulse indicates pushbutton release
    signal r_prev : std_logic := '0'; -- registered button state
begin
    o_pulse <= r_pulse;
    process(i_clk) is
    begin
        if (rising_edge(i_clk)) then
            r_prev <= i_btn; -- register button state (updates AFTER this process concludes)
            if (r_prev = '1' and i_btn ='0') then -- was registered 'pressed' but is 'now' released
                r_pulse <= '1'; -- ...then send the one-cycle high pulse
            else
                r_pulse <= '0'; -- ...otherwise leave the signal low
            end if;
        end if;
    end process;                   
end architecture;
