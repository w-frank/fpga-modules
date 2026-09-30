library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registered_adder is
    generic (
        BIT_WIDTH : integer := 8
    );
    port (
        i_clk     : in  std_logic;
        i_reset   : in  std_logic; -- synchronous active-high reset
        i_a       : in  std_logic_vector(BIT_WIDTH-1 downto 0);
        i_b       : in  std_logic_vector(BIT_WIDTH-1 downto 0);
        o_sum_out : out std_logic_vector(BIT_WIDTH downto 0) -- additional bit to hold potential carry out
    );
end registered_adder;

architecture behavioral of registered_adder is
begin
    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                o_sum_out <= (others => '0');
            else
                -- Perform addition using unsigned conversion
                o_sum_out <= std_logic_vector(unsigned('0' & i_a) + unsigned('0' & i_b));
            end if;
        end if;
    end process;
end behavioral;