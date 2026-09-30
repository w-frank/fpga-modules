library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity shift_register is
    generic (
        SHIFT_DEPTH : integer := 8
    );
    port(
        i_clk           : in  std_logic;
        i_reset         : in  std_logic;
        i_data_to_delay : in  std_logic;
        o_delayed_data  : out std_logic
    );
end shift_register;

architecture behavioral of shift_register is


-- VHDL Example of Shift Register for Delay:
signal r_shift : std_logic_vector(SHIFT_DEPTH-1 downto 0);

begin
 
process (i_clk)
begin
    if rising_edge(i_clk) then
        if (i_reset = '1') then
            r_shift <= (others => '0');
        else
            r_shift(SHIFT_DEPTH-1 downto 1) <= r_shift(SHIFT_DEPTH-2 downto 0); -- Shift Left
            r_shift(0) <= i_data_to_delay;
            -- Bit SHIFT_DEPTH-1 of r_shift has been delayed by SHIFT_DEPTH clock cycles
        end if;
    end if;
end process;

o_delayed_data <= r_shift(SHIFT_DEPTH-1);

end behavioral;