library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity four_bit_mul is

    Port ( x : in STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
            y : in STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
            p : out STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
            cout_mul : out std_logic);
            
end four_bit_mul;


architecture Behavioral of four_bit_mul is
    
	 component four_bit_adder is
    
	 Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
            b : in STD_LOGIC_VECTOR (3 downto 0);
            cin : in STD_LOGIC;
            sum : out STD_LOGIC_VECTOR (3 downto 0);
            cout, V, sgn, zr: out std_logic);
    
	 end component;
    
    signal L0, L1, L2: std_logic_vector (3 downto 0); -- "ands" do lado esquerdo dos somadores

    signal R0, R1, R2: std_logic_vector (3 downto 0); -- entradas do lado direito dos somadores

    signal p_temp: std_logic_vector (7 downto 0);


begin

    L0 <= (y(1) and x(3), y(1) and x(2), y(1) and x(1), y(1) and x(0));
    L1 <= (y(2) and x(3), y(2) and x(2), y(2) and x(1), y(2) and x(0));
    L2 <= (y(3) and x(3), y(3) and x(2), y(3) and x(1), y(3) and x(0));
    R0 <= ('0', y(0) and x(3), y(0) and x(2), y(0) and x(1)); -- parte direita do primeiro somador
    p_temp(0) <= y(0) and x(0); -- primeiro digito da multiplicacao (LSB)

    FBA0: four_bit_adder port map(
        a => L0,
        b => R0,
        cin => '0',
        cout => R1(3),
        sum(3) => R1(2),
        sum(2) => R1(1),
        sum(1) => R1(0),
        sum(0) => p_temp(1)
    );
    
    FBA1: four_bit_adder port map(
        a => L1,
        b => R1,
        cin => '0',
        cout => R2(3),
        sum(3) => R2(2),
        sum(2) => R2(1),
        sum(1) => R2(0),
        sum(0) => p_temp(2)
    );
    
    FBA2: four_bit_adder port map(
        a => L2,
        b => R2,
        cin => '0',
        cout => p_temp(7),
        sum(3) => p_temp(6),
        sum(2) => p_temp(5),
        sum(1) => p_temp(4),
        sum(0) => p_temp(3)
    );

    cout_mul <= p_temp(6);
    p(5) <= p_temp(5);
    p(4) <= p_temp(4);
    p(3) <= p_temp(3);
    p(2) <= p_temp(2);
    p(1) <= p_temp(1);
    p(0) <= p_temp(0);

end Behavioral;