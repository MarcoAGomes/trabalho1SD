library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
    
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
            B : in STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
            alu_sel : in STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
            alu_res : out STD_LOGIC_VECTOR (7 downto 0) := (others =>'0'));
            --carry_out : out STD_LOGIC := '0');

end alu;


architecture Behavioral of alu is
    
    component four_bit_adder is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
                b : in STD_LOGIC_VECTOR (3 downto 0);
                cin : in STD_LOGIC;
                sum : out STD_LOGIC_VECTOR (3 downto 0);
                cout, V, sgn, zr: out std_logic);
    
    end component;

    component four_bit_mul is
        Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
                y : in STD_LOGIC_VECTOR (3 downto 0);
                p : out STD_LOGIC_VECTOR (7 downto 0);
                cout_mul : out std_logic);
        
        end component;

    -- signal alu_res : std_logic_vector (7 downto 0) := (others => '0');
    signal add_res: std_logic_vector (3 downto 0) := (others => '0');
    signal add_res_1: std_logic_vector (3 downto 0) := (others => '0');
	 signal change_signal: std_logic_vector (3 downto 0) := (others => '0');
	 signal sub_res: std_logic_vector (3 downto 0) := (others => '0');
    signal mul_temp: std_logic_vector (7 downto 0) := (others => '0');
    signal sqr_temp: std_logic_vector (7 downto 0) := (others => '0');
    
    
    signal add_cout: std_logic;
	 signal add_1_cout: std_logic;
	 signal change_signal_cout: std_logic;
    signal sub_cout: std_logic;
    signal mul_cout: std_logic;
    signal sqr_cout: std_logic;
    
	 signal add_ovf: std_logic; 
	 signal sub_ovf: std_logic;
	 signal add_1_ovf:std_logic;
	 signal change_signal_ovf: std_logic;
	 
	 signal add_sgn: std_logic;
	 signal add_1_sgn: std_logic;
	 signal change_signal_sgn: std_logic;
	 signal sub_sgn: std_logic;
	 
	 signal add_zero: std_logic;
	 signal add_1_zero: std_logic;
	 signal change_singal_zero: std_logic;
	 signal sub_zero: std_logic;
	 
	 signal not_B : std_logic_vector (3 downto 0);
	 signal not_A : std_logic_vector (3 downto 0);


begin
	
	 not_A <= not A;
    not_B <= not B;
    
	 add: four_bit_adder port map(A, B, '0', add_res, add_cout, add_ovf, add_sgn, add_zero);
	 
	 add_1: four_bit_adder port map(A, "0000", '1', add_res_1, add_1_cout, add_1_ovf, add_1_sgn, add_1_zero);
	 
	 cs: four_bit_adder port map(not_A, "0000", '1', change_signal, change_signal_cout, change_signal_ovf, change_signal_sgn,change_singal_zero);
    
	 sub: four_bit_adder port map(A, not_B, '1', sub_res, sub_cout, sub_ovf, sub_sgn,sub_zero);
    
	 mul: four_bit_mul port map(A, B, mul_temp, mul_cout);
    
	 sqr: four_bit_mul port map(A, A, sqr_temp, sqr_cout);
    
    process(A, B, alu_sel)
    
    begin

        case (alu_sel) is
        -- "0xx" for logic ops
        -- "1xx" for arithmetic ops
        
        when "000" => -- and
            alu_res (3 downto 0) <= A and B;
            alu_res (7 downto 4) <= "0000";

        when "001" => -- or
            alu_res (3 downto 0) <= A or B;
            alu_res (7 downto 4) <= "0000";

        when "010" => -- A+1
            alu_res (3 downto 0) <= add_res_1;
            alu_res (4) <= add_1_cout;
				alu_res(5) <= add_1_ovf;
				alu_res(6) <= add_1_sgn;
				alu_res(7) <= add_1_zero;

        when "011" => -- change signal
            alu_res (3 downto 0)<= change_signal;
            alu_res (4) <= change_signal_cout;
				alu_res(5) <= change_signal_ovf;
				alu_res(6) <= change_signal_sgn;
				alu_res(7) <= change_singal_zero;

        when "100" => -- addition
            alu_res (3 downto 0) <= add_res;
            alu_res (4) <= add_cout;
				alu_res(5) <= add_ovf;
				alu_res(6) <= add_sgn;
				alu_res(7) <= add_zero;

        when "101" => -- subtraction
            alu_res (3 downto 0) <= sub_res;
            alu_res (4) <= sub_cout;
				alu_res(5) <= sub_ovf;
				alu_res(6) <= sub_sgn;
				alu_res(7) <= sub_zero;


        when "110" => -- multiplication
            alu_res <= mul_temp;
            alu_res(6) <= mul_cout;
		

        when "111" => -- A * A
            alu_res <= sqr_temp;
            alu_res(6) <= sqr_cout;

        when others =>
            alu_res <= "00000000";
        
        end case;
    
    end process;

end Behavioral;
