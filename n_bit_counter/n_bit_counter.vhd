library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity N_BIT_COUNTER is
    generic (
        BIT_WIDTH : integer := 4
    );
    port ( i_clk   : in std_logic;
           i_reset : in std_logic;
           o_counter : out std_logic_vector(BIT_WIDTH-1 downto 0)
    );
end N_BIT_COUNTER;

architecture behavioral of N_BIT_COUNTER is

signal up_counter : unsigned(BIT_WIDTH-1 downto 0);

begin

process(i_clk)

begin

if(rising_edge(i_clk)) then
    if(i_reset = '1') then
        up_counter <= (others => '0');
    else
        up_counter <= (up_counter + 1);
    end if;
 end if;
end process;

o_counter <= std_logic_vector(up_counter);

end behavioral;