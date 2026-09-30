library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity accumulator is
    generic (
        BIT_WIDTH : integer := 8
    );
    port(
        i_clk   : in std_logic;
        i_reset : in std_logic;
        i_Din   : in std_logic_vector(BIT_WIDTH-1 downto 0);
        o_Q     : out std_logic_vector(BIT_WIDTH-1 downto 0));
end accumulator;

architecture behavioral of accumulator is

signal tmp: std_logic_vector(BIT_WIDTH-1 downto 0);

begin

process (i_clk, i_reset)

begin
if rising_edge(i_clk) then
    if (i_reset = '1') then
        tmp <= (others => '0');
    else
        tmp <= tmp + i_Din;
    end if;
end if;

end process;

o_Q <= tmp;

end behavioral;