library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    port (
        
		  xHA: in std_logic;
        yHA: in std_logic;
        sumHA: out std_logic;
        coutHA: out std_logic
    
	 );
end half_adder;

architecture Behavioral of half_adder is

begin
    
    sumHA <= xHA xor yHA;
    coutHA <= xHA and yHA;

end Behavioral;