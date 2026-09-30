library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
  
entity shift_register_tb is
end shift_register_tb;
 
architecture testbench of shift_register_tb is

constant SHIFT_DEPTH : integer := 8;

-- Component Declaration for the Unit Under Test (UUT)
component shift_register is
    generic (
        SHIFT_DEPTH : integer := SHIFT_DEPTH
    );
    port(
        i_clk           : in  std_logic;
        i_reset         : in  std_logic;
        i_Data_to_Delay : in  std_logic;
        o_Delayed_Data  : out std_logic
    );
end component;

signal clk   : std_logic := '0';
signal reset : std_logic := '0';
signal data_to_delay : std_logic := '0';
signal delayed_data  : std_logic := '0';
 
constant clk_period : time := 20 ns;
 
begin
 
 -- Instantiate the Unit Under Test (UUT)
DUT : shift_register 
    port map (
        i_clk => clk,
        i_reset => reset,
        i_Data_to_Delay => data_to_delay,
        o_Delayed_Data => delayed_data
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
    wait until clk = '1';
    reset <= '1';

    wait for 100 ns;
    wait until clk = '1';
    reset <= '0';

    wait for 100 ns;
    wait until clk = '1';
    data_to_delay <= '1';

    wait for 100 ns;
    wait until clk = '1';
    data_to_delay <= '0';

    wait for 100 ns;
    wait until clk = '1';
    data_to_delay <= '1';

    wait for 100 ns;
    wait until clk = '1';
    data_to_delay <= '0';

    wait;
end process;

end;