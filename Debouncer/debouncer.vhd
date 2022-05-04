library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity debouncer is
    generic (
		g_cycles : integer := 262143 -- parent module can dictate stable cycles; 262k ~= 10 ms @ 25 MHz
    );
    port (
        i_clk : in std_logic;
        i_switch : in std_logic;
        o_debounced : out std_logic -- output changes only after button state stabilizes
    );
end entity;

architecture arch of debouncer is
    signal r_debouncing : std_logic := '0'; -- currently in a debouncing state?
    signal r_count : integer range 0 to 262143 := 0; -- 0 to 2^18-1; i.e., 18-bit int
    signal r_prev : std_logic := '0'; -- registered button state
    signal r_output : std_logic := '0'; -- registered output, wired to output port
begin
    o_debounced <= r_output;
    process(i_clk) is
    begin
        if rising_edge(i_clk) then
            r_prev <= i_switch;  -- register feeds the module output port
            if (i_switch /= r_prev) then -- states disagree (bounce!)
                r_debouncing <= '1'; -- set debouncing state to true
                r_count <= 0; -- switch is bouncing still, so reset stability timer
            else
                if (r_debouncing = '1') then -- if already in debouncing state
                    if (r_count = g_cycles) then -- when timer indicates switch is stable...
                        r_output <= r_prev;  -- ... output the new value
                        r_debouncing <= '0'; -- ... and resest the debouncing state
                        r_count <= 0; -- ... and reset the timer
                    else
                        r_count <= r_count + 1; -- stability timer not elapsed yet, so increment
                    end if;
                end if;
            end if;
         end if;
    end process;
end architecture;