library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity parallel_to_serial_selector is
    generic(
        WIDTH : integer := 8
    );
    Port (
        clk         : in  STD_LOGIC;   -- 100 MHz
        reset       : in  STD_LOGIC;
        load        : in  STD_LOGIC;
        parallel_in : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        serial_out  : out STD_LOGIC;
        busy        : out STD_LOGIC
    );
end parallel_to_serial_selector;

architecture rtl of parallel_to_serial_selector is
    signal shift_reg : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    signal bit_count : INTEGER range 0 to WIDTH := 0;
    signal active    : STD_LOGIC := '0';
    -- Clock divider
    signal slow_clk  : STD_LOGIC := '0';
    signal counter   : unsigned(25 downto 0) := (others => '0');
    -- slightly faster for lab visibility
begin
    -- Clock Divider (100MHz -> ~1-2 Hz)
    process(clk)
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
            slow_clk <= counter(25);
        end if;
    end process;

    -- Main PISO Logic
    process(slow_clk, reset)
    begin
        -- ACTIVE LOW RESET
        if reset = '0' then
            shift_reg  <= (others => '0');
            bit_count  <= 0;
            serial_out <= '0';
            active     <= '0';
        elsif rising_edge(slow_clk) then
            if load = '1' and active = '0' then
                shift_reg <= parallel_in;
                bit_count <= WIDTH;
                active    <= '1';
            elsif active = '1' then
                serial_out <= shift_reg(WIDTH-1);
                shift_reg  <= shift_reg(WIDTH-2 downto 0) & '0';
                bit_count  <= bit_count - 1;
                if bit_count = 1 then
                    active <= '0';
                end if;
            end if;
        end if;
    end process;

    busy <= active;
end rtl;
