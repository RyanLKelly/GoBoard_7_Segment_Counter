library IEEE;
use IEEE.std_logic_1164.all;

entity seven_segment_driver is
    port (
        i_clk : in std_logic;
        i_value : in std_logic_vector(3 downto 0); -- Leftmost (bit 3) is MSB
        o_seg_A : out std_logic; -- Letters represent common 7SD labels as shown on Google images
		o_seg_B : out std_logic;
		o_seg_C : out std_logic;
		o_seg_D : out std_logic;
		o_seg_E : out std_logic;
		o_seg_F : out std_logic;
		o_seg_G : out std_logic
    );
end entity;

architecture arch of seven_segment_driver is
    signal r_seg_A : std_logic := '0';
	signal r_seg_B : std_logic := '0';
	signal r_seg_C : std_logic := '0';
	signal r_seg_D : std_logic := '0';
	signal r_seg_E : std_logic := '0';
	signal r_seg_F : std_logic := '0';
	signal r_seg_G : std_logic := '0';
begin
	o_seg_A <= not r_seg_A; -- 7SD segments illuminate when LOW (i.e., ACTIVE LOW, oddly)
	o_seg_B <= not r_seg_B;
	o_seg_C <= not r_seg_C;
	o_seg_D <= not r_seg_D;
	o_seg_E <= not r_seg_E;
	o_seg_F <= not r_seg_F;
	o_seg_G <= not r_seg_G;
	
    process(i_clk) is
    begin
        if rising_edge(i_clk) then
            case i_value is -- illuminate 0 through F as appropriate
				when "0000" =>
					r_seg_A <= '1';
					r_seg_B <= '1';
					r_seg_C <= '1';
					r_seg_D <= '1';
					r_seg_E <= '1';
					r_seg_F <= '1';
					r_seg_G <= '0';
				when "0001" =>
					r_seg_A <= '0';
					r_seg_B <= '1';
					r_seg_C <= '1';
					r_seg_D <= '0';
					r_seg_E <= '0';
					r_seg_F <= '0';
					r_seg_G <= '0';
				when "0010" =>
					r_seg_A <= '1';
					r_seg_B <= '1';
					r_seg_C <= '0';
					r_seg_D <= '1';
					r_seg_E <= '1';
					r_seg_F <= '0';
					r_seg_G <= '1';
				when "0011" =>
					r_seg_A <= '1';
					r_seg_B <= '1';
					r_seg_C <= '1';
					r_seg_D <= '1';
					r_seg_E <= '0';
					r_seg_F <= '0';
					r_seg_G <= '1';
				when "0100" =>
					r_seg_A <= '0';
					r_seg_B <= '1';
					r_seg_C <= '1';
					r_seg_D <= '0';
					r_seg_E <= '0';
					r_seg_F <= '1';
					r_seg_G <= '1';
				when "0101" =>
					r_seg_A <= '1';
					r_seg_B <= '0';
					r_seg_C <= '1';
					r_seg_D <= '1';
					r_seg_E <= '0';
					r_seg_F <= '1';
					r_seg_G <= '1';
				when "0110" =>
					r_seg_A <= '1';
					r_seg_B <= '0';
					r_seg_C <= '1';
					r_seg_D <= '1';
					r_seg_E <= '1';
					r_seg_F <= '1';
					r_seg_G <= '1';
				when "0111" =>
					r_seg_A <= '1';
					r_seg_B <= '1';
					r_seg_C <= '1';
					r_seg_D <= '0';
					r_seg_E <= '0';
					r_seg_F <= '0';
					r_seg_G <= '0';
				when "1000" =>
					r_seg_A <= '1';
					r_seg_B <= '1';
					r_seg_C <= '1';
					r_seg_D <= '1';
					r_seg_E <= '1';
					r_seg_F <= '1';
					r_seg_G <= '1';
				when "1001" =>
					r_seg_A <= '1';
					r_seg_B <= '1';
					r_seg_C <= '1';
					r_seg_D <= '0';
					r_seg_E <= '0';
					r_seg_F <= '1';
					r_seg_G <= '1';
				when "1010" => -- A
					r_seg_A <= '1';
					r_seg_B <= '1';
					r_seg_C <= '1';
					r_seg_D <= '0';
					r_seg_E <= '1';
					r_seg_F <= '1';
					r_seg_G <= '1';
				when "1011" => -- B
					r_seg_A <= '0';
					r_seg_B <= '0';
					r_seg_C <= '1';
					r_seg_D <= '1';
					r_seg_E <= '1';
					r_seg_F <= '1';
					r_seg_G <= '1';
				when "1100" => -- C
					r_seg_A <= '1';
					r_seg_B <= '0';
					r_seg_C <= '0';
					r_seg_D <= '1';
					r_seg_E <= '1';
					r_seg_F <= '1';
					r_seg_G <= '0';
				when "1101" => -- D
					r_seg_A <= '0';
					r_seg_B <= '1';
					r_seg_C <= '1';
					r_seg_D <= '1';
					r_seg_E <= '1';
					r_seg_F <= '0';
					r_seg_G <= '1';
				when "1110" => -- E
					r_seg_A <= '1';
					r_seg_B <= '0';
					r_seg_C <= '0';
					r_seg_D <= '1';
					r_seg_E <= '1';
					r_seg_F <= '1';
					r_seg_G <= '1';
				when "1111" => -- F
					r_seg_A <= '1';
					r_seg_B <= '0';
					r_seg_C <= '0';
					r_seg_D <= '0';
					r_seg_E <= '1';
					r_seg_F <= '1';
					r_seg_G <= '1';					
				when others =>
					r_seg_A <= '0';
					r_seg_B <= '0';
					r_seg_C <= '0';
					r_seg_D <= '0';
					r_seg_E <= '0';
					r_seg_F <= '0';
					r_seg_G <= '0';
			end case;
         end if;
    end process;
end architecture;