library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_filter is
port (
    i_clk  : in  std_logic;
    i_rstb : in  std_logic;
    i_data : in  std_logic_vector(15 downto 0);
    o_data : out std_logic_vector(15 downto 0));
end FIR_filter;

architecture behavioural of FIR_filter is

type coefficient_type is array(0 to 8) of signed(15 downto 0);

signal coefficient : coefficient_type := (
    X"04F6",
    X"0AE4",
    X"1089",
    X"1496",
    X"160F",
    X"1496",
    X"1089",
    X"0AE4",
    X"04F6"
);

type delayed_signal_type is array(0 to 8) of signed(15 downto 0);
type product_type is array(0 to 8) of signed(31 downto 0);
type sum_0_type is array(0 to 4) of signed(32 downto 0);
type sum_1_type is array(0 to 2) of signed(33 downto 0);
type sum_2_type is array(0 to 1) of signed(34 downto 0);

signal delayed_signal : delayed_signal_type;
signal product : product_type;
signal sum_0 : sum_0_type;
signal sum_1 : sum_1_type;
signal sum_2 : sum_2_type;
signal sum_3 : signed(35 downto 0);

begin

process(i_clk)
begin
    if (rising_edge(i_clk)) then
        delayed_signal(0) <= signed(i_data);
        for i in 1 to 8 loop
            delayed_signal(i) <= delayed_signal(i-1);
        end loop;
    end if;
end process;

process(i_clk)
begin
    if (rising_edge(i_clk)) then
        for j in 0 to 8 loop
            product(j) <= delayed_signal(j) * coefficient(j);
        end loop;
    end if;
end process;

process(i_clk)
begin
    if (rising_edge(i_clk)) then
        sum_0(0) <= (product(0)(31) & product(0)) + (product(1)(31) & product(1));
        sum_0(1) <= (product(2)(31) & product(2)) + (product(3)(31) & product(3));
        sum_0(2) <= (product(4)(31) & product(4)) + (product(5)(31) & product(5));
        sum_0(3) <= (product(6)(31) & product(6)) + (product(7)(31) & product(7));
        sum_0(4) <= product(0)(31) & product(0);
    end if;
end process;

process(i_clk)
begin
    if (rising_edge(i_clk)) then
        sum_1(0) <= (sum_0(0)(32) & sum_0(0)) + (sum_0(1)(32) & sum_0(1));
        sum_1(1) <= (sum_0(2)(32) & sum_0(2)) + (sum_0(3)(32) & sum_0(3));
        sum_1(2) <= sum_0(4)(32) & sum_0(4);
    end if;
end process;

process(i_clk)
begin
    if (rising_edge(i_clk)) then
        sum_2(0) <= (sum_1(0)(33) & sum_1(0)) + (sum_1(1)(33) & sum_1(1));
        sum_2(1) <= sum_1(2)(33) & sum_1(2);
    end if;
end process;

process(i_clk)
begin
    if (rising_edge(i_clk)) then
        sum_3 <= (sum_2(0)(34) & sum_2(0)) + (sum_2(1)(34) & sum_2(1));
    end if;
end process;

o_data <= std_logic_vector(sum_3(35) & sum_3(28 downto 14));

end behavioural;