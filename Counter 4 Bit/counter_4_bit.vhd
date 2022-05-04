library ieee;
use ieee.std_logic_1164.all;

entity counter_4_bit is
	port(
		clk_pin : in std_logic; -- Module is synchronized to the clock's rising edge
		increment_pin : in std_logic; 
		count_pin : out std_logic_vector(3 downto 0) -- Leftmost bit (bit 3) is MSB
	);
end entity;

architecture behavior of counter_4_bit is
	signal r_state : std_logic_vector(3 downto 0);  -- Leftmost bit (bit 3) is MSB
begin
	count_pin <= r_state;
	process(clk_pin) is
	begin
		-- Note:  The calling module I designed this to work with (Button Release Detector)
		-- sends the 'increment'
		-- signal only upon a button press RELEASE, hence preventing an undesired
		-- behavior whereby the counter would continue to increment every rising-edge
		-- clock pulse, if one were to continuously depress a push-button (assuming 
		-- the "button pressed" state indicated one's desire to increment the counter.
		if (rising_edge(clk_pin) and (increment_pin = '1')) then
			case r_state is
				-- Cycles from decimal 0 through 15 (then rolls back to 0)
				when "0000" => r_state <= "0001";
				when "0001" => r_state <= "0010";
				when "0010" => r_state <= "0011";
				when "0011" => r_state <= "0100";
				when "0100" => r_state <= "0101";
				when "0101" => r_state <= "0110";
				when "0110" => r_state <= "0111";
				when "0111" => r_state <= "1000";
				when "1000" => r_state <= "1001";
				when "1001" => r_state <= "1010";
				when "1010" => r_state <= "1011";
				when "1011" => r_state <= "1100";
				when "1100" => r_state <= "1101";
				when "1101" => r_state <= "1110";
				when "1110" => r_state <= "1111";
				when "1111" => r_state <= "0000";
				when others => r_state <= "0000";
			end case;
		end if;
	end process;
end architecture;