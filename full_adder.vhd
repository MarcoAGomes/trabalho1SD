library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    
	 port (
        
		  xFA: in std_logic;
        yFA: in std_logic;
        cinFA: in std_logic;
        sumFA: out std_logic;
        coutFA: out std_logic
    
	 );

	 end full_adder;

architecture Behavioral of full_adder is

    component half_adder is
        
		  port (
            
				xHA: in std_logic;
            yHA: in std_logic;
            sumHA: out std_logic;
            coutHA: out std_logic
        
		  );
    
	 end component;

signal s0,c0,c1: std_logic;

begin
    
    HA0: half_adder port map(xFA, yFA, s0, c0);
    HA1: half_adder port map(s0, cinFA, sumFA, c1);
    
    coutFA <= c0 or c1;
    
end Behavioral;