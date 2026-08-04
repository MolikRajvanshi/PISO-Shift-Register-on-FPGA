library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_parallel_to_serial is
-- Testbench has no ports
end tb_parallel_to_serial;

architecture behavior of tb_parallel_to_serial is
    -- Component Declaration for the Unit Under Test (UUT)
    component parallel_to_serial_selector
    generic(
        WIDTH : integer := 8
    );
    port(
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        load        : in  STD_LOGIC;
        parallel_in : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        serial_out  : out STD_LOGIC;
        busy        : out STD_LOGIC
    );
    end component;

    -- Testbench Signals
    constant WIDTH : integer := 8;
    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '0';
    signal load        : STD_LOGIC := '0';
    signal parallel_in : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');
    signal serial_out  : STD_LOGIC;
    signal busy        : STD_LOGIC;

    -- Clock period definition (100 MHz = 10 ns)
    constant CLK_PERIOD      : time := 10 ns;
    -- slow_clk period: counter(25) toggles every 2^25 cycles
    -- Full period = 2^26 * 10 ns ~= 671.08 ms
    constant SLOW_CLK_PERIOD : time := 672 ms;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: parallel_to_serial_selector
    generic map (
        WIDTH => WIDTH
    )
    port map (
        clk         => clk,
        reset       => reset,
        load        => load,
        parallel_in => parallel_in,
        serial_out  => serial_out,
        busy        => busy
    );

    -- Clock generation process
    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- 1. Apply Active LOW Reset
        reset       <= '0';
        load        <= '0';
        parallel_in <= (others => '0');
        wait for 100 ns;

        -- Release Reset
        reset <= '1';
        wait for 100 ns;

        -- 2. Load first test pattern: 0xAB (10101011)
        parallel_in <= x"AB";
        load <= '1';
        wait for SLOW_CLK_PERIOD;
        load <= '0';

        -- Wait for shift register to finish transmitting
        wait until busy = '0';

        -- Buffer before next transmission
        wait for SLOW_CLK_PERIOD;

        -- 3. Load second test pattern: 0xCC (11001100)
        parallel_in <= x"CC";
        load <= '1';
        wait for SLOW_CLK_PERIOD;
        load <= '0';

        wait until busy = '0';

        -- End simulation
        wait;
    end process;

end behavior;
