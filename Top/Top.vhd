library IEEE;
use IEEE.std_logic_1164.all;

entity top is
	port (
		i_Clk : in std_logic; -- Main system clock
		i_Switch_1 : in std_logic;  -- Top left pushbutton
		o_Segment2_A : out std_logic; -- Right-hand seven segment display segments
		o_Segment2_B : out std_logic;
		o_Segment2_C : out std_logic;
		o_Segment2_D : out std_logic;
		o_Segment2_E : out std_logic;
		o_Segment2_F : out std_logic;
		o_Segment2_G : out std_logic;
		o_LED_1 : out std_logic;
		o_LED_2 : out std_logic;
		o_LED_3 : out std_logic;
		o_LED_4 : out std_logic
	);
end entity;

architecture arch of top is
	signal w_debounced : std_logic;  -- Stage 1:  Debounce the pushbutton
	signal w_inc_pulse : std_logic;  -- Stage 2:  Pulse on button release
	signal w_count_vector : std_logic_vector(3 downto 0); -- Stage 3:  On pulse, increment the counter
begin
	o_LED_1 <= '0';
	o_LED_2 <= '0';
	o_LED_3 <= '0';
	o_LED_4 <= '0';
	db_inst : entity work.debouncer port map ( -- Debounces switch input, only passing state change after stable
		i_clk => i_Clk,
		i_switch => i_Switch_1,
		o_debounced => w_debounced
	);
	brd_inst : entity work.btn_release_detect port map (  -- Sends a 1-tick pulse when pushbutton is released
		i_clk => i_Clk,
		i_btn => w_debounced,
		o_pulse => w_inc_pulse
	);
	counter_inst : entity work.counter_4_bit port map ( -- Increments counter upon "button released" pulse
		clk_pin => i_Clk,
		increment_pin => w_inc_pulse,
		count_pin => w_count_vector
	);
	ssd_inst : entity work.seven_segment_driver port map ( -- Link the physical 7SD pins to the module's 7SD driver
		i_clk => i_Clk,
		i_value => w_count_vector,
		o_seg_A => o_Segment2_A,
		o_seg_B => o_Segment2_B,
		o_seg_C => o_Segment2_C,
		o_seg_D => o_Segment2_D,
		o_seg_E => o_Segment2_E,
		o_seg_F => o_Segment2_F,
		o_seg_G => o_Segment2_G
	);
end architecture;