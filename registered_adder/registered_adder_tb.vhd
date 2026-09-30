library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity registered_adder_tb is
end registered_adder_tb;

architecture testbench of registered_adder_tb is

constant ADDER_WIDTH : integer := 8;

component registered_adder
    generic (
        BIT_WIDTH : integer := ADDER_WIDTH
    );
    port (
        i_clk     : in  std_logic;
        i_reset   : in  std_logic; -- synchronous active-high reset
        i_a       : in  std_logic_vector(BIT_WIDTH-1 downto 0);
        i_b       : in  std_logic_vector(BIT_WIDTH-1 downto 0);
        o_sum_out : out std_logic_vector(BIT_WIDTH downto 0) -- additional bit to hold potential carry out
    );
end component;

signal reset, clk : std_logic;
signal a, b : std_logic_vector(ADDER_WIDTH-1 downto 0); 
signal sum_out : std_logic_vector(ADDER_WIDTH downto 0);

-- Clock Period Constant (50 MHz = 20 ns period)
constant CLK_PERIOD : time := 20 ns;

begin

DUT : REGISTERED_ADDER 
    port map ( i_clk   => clk,
               i_reset => reset,
               i_a => a,
               i_b => b,
               o_sum_out => sum_out
    );

clock_process : process
begin
    clk <= '0';
    wait for CLK_PERIOD / 2;
    clk <= '1';
    wait for CLK_PERIOD / 2;
end process;


stim_proc: process
begin
    -- 1. Apply reset sequence
    reset <= '1';
    a <= (others => '0');
    b <= (others => '0');
    wait for CLK_PERIOD * 2;
    reset <= '0';
    wait for CLK_PERIOD * 2;

    -- 2. Test Case 1: Simple Addition (10 + 5)
    a <= std_logic_vector(to_unsigned(10, ADDER_WIDTH));
    b <= std_logic_vector(to_unsigned(5, ADDER_WIDTH));
    wait for CLK_PERIOD; -- Wait one cycle for the registered result
    
    -- 3. Test Case 2: Zero Addition (0 + 0)
    a <= std_logic_vector(to_unsigned(0, ADDER_WIDTH));
    b <= std_logic_vector(to_unsigned(0, ADDER_WIDTH));
    wait for CLK_PERIOD;

    -- 4. Test Case 3: Carry-Out Verification (255 + 1)
    -- Expected output: 256 (9-bit representation: "100000000")
    a <= std_logic_vector(to_unsigned(255, ADDER_WIDTH));
    b <= std_logic_vector(to_unsigned(1, ADDER_WIDTH));
    wait for CLK_PERIOD * 2;

    -- 5. Test Case 4: Maximum Value Addition (255 + 255)
    -- Expected output: 510 (9-bit representation: "111111110")
    a <= std_logic_vector(to_unsigned(255, ADDER_WIDTH));
    b <= std_logic_vector(to_unsigned(255, ADDER_WIDTH));
    wait for CLK_PERIOD * 2;

    -- Clear inputs and wait indefinitely
    a <= (others => '0');
    b <= (others => '0');
    wait;
end process;

end architecture;