library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder is
    
	 port (
        
		  a: in std_logic_vector (3 downto 0);
        b: in std_logic_vector (3 downto 0);
        cin: in std_logic;
        sum: out std_logic_vector(3 downto 0);
        cout, V, sgn, zr: out std_logic
    
	 );

	 end four_bit_adder;

architecture Behavioral of four_bit_adder is
    
    signal c: std_logic_vector(4 downto 0);
    SIGNAL FA : STD_LOGIC_VECTOR(3 downto 0);

	 
    component full_adder is
        
		  port (
            
				xFA: in std_logic;
            yFA: in std_logic;
            cinFA: in std_logic;
            sumFA: out std_logic;
            coutFA: out std_logic
        
		  );
    
	 end component;
    
begin
    
	 c(0) <= cin;
    
    FA0: full_adder port map (a(0), b(0), c(0), FA(0), c(1));

    FA1: full_adder port map (a(1), b(1), c(1), FA(1), c(2));
    
    FA2: full_adder port map (a(2), b(2), c(2), FA(2), c(3));
    
    FA3: full_adder port map (a(3), b(3), c(3), FA(3), c(4));
     
    V <= c(3) xor c(4);
    cout <= c(4);
	 sgn <= FA(3);
	 zr <= not(FA(0) and FA(1) and FA(2) and FA(3));
	 sum <= FA;
    
end Behavioral;