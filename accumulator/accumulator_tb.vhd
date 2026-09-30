library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
  
entity accumulator_tb is
end accumulator_tb;
 
architecture testbench of accumulator_tb is

constant ACCUMULATOR_WIDTH : integer := 8;

-- Component Declaration for the Unit Under Test (UUT)
component accumulator is
    generic (
        BIT_WIDTH : integer := ACCUMULATOR_WIDTH
    );
    port(
        i_clk   : in std_logic;
        i_reset : in std_logic;
        i_Din   : in std_logic_vector(BIT_WIDTH-1 downto 0);
        o_Q     : out std_logic_vector(BIT_WIDTH-1  downto 0));
end component;

signal clk   : std_logic := '0';
signal reset : std_logic := '0';
signal Din   : std_logic_vector(ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');

signal Q : std_logic_vector(ACCUMULATOR_WIDTH-1 downto 0);
 
constant clk_period : time := 20 ns;
 
begin
 
 -- Instantiate the Unit Under Test (UUT)
DUT : accumulator 
    port map (
        i_clk => clk,
        i_reset => reset,
        i_Din => Din,
        o_Q => Q
    );
 
 -- Clock process definitions
clk_process :process
    begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;
 
-- Stimulus process
stim_proc: process
begin

    wait for 100 ns;
    reset <= '1';

    Din <= std_logic_vector(to_unsigned(2, ACCUMULATOR_WIDTH));

    wait for 100 ns;

    reset <= '0';

    wait;
end process;

end;