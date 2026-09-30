library ieee;
use ieee.std_logic_1164.all;

entity n_bit_counter_tb is
end n_bit_counter_tb;

architecture testbench of n_bit_counter_tb is

constant COUNTER_WIDTH : integer := 2;

component N_BIT_COUNTER
    generic (
        BIT_WIDTH : integer := COUNTER_WIDTH
    );
    port ( i_clk  : in std_logic;
           i_reset: in std_logic;
           o_counter : out std_logic_vector(BIT_WIDTH-1 downto 0)
    );
end component;

signal reset, clk: std_logic;
signal counter : std_logic_vector(COUNTER_WIDTH-1 downto 0);

begin

DUT : N_BIT_COUNTER 
    port map ( i_clk   => clk, 
               i_reset => reset, 
               o_counter => counter
            );

clock_process : process
begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
end process;


stim_proc: process
begin
    reset <= '1';
    wait for 40 ns;
        reset <= '0';
    wait;
end process;

end architecture;