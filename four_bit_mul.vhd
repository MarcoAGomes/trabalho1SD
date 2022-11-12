library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity four_bit_mul is
		PORT (X, Y: in STD_LOGIC_VECTOR(3 downto 0);
		 P: out STD_LOGIC_VECTOR(7 downto 0)
		 );
end four_bit_mul;

architecture Behavioral of four_bit_mul is
		
		COMPONENT half_adder IS
			PORT (xHA, yHA: in STD_LOGIC;
					sumHA, coutHA: out STD_LOGIC);
		END COMPONENT;
		
		COMPONENT full_adder IS
			PORT(xFA, yFA, cinFA: in STD_LOGIC;
				  sumFA, coutFA: out	STD_LOGIC);
		END COMPONENT;
		
		signal c2, c31, c32, c41, c42, c43, c51, c52, c53, c61, c62, c7: STD_LOGIC;
		signal sp2, sp31, sp32, sp41, sp42, sp51, sp52: STD_LOGIC;		--Soma parcial 
		signal temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15 : STD_LOGIC;
begin
	P(0) <= X(0) AND Y(0);
	temp1 <= (X(1) AND Y(0));
	temp2 <= (X(0) AND Y(1));
	temp3 <= (Y(0) AND X(2));
	temp4 <= (Y(1) AND X(1));
	temp5 <= (Y(2) AND X(0));
	temp6 <= (Y(0) AND X(3));
	temp7 <= (Y(1) AND X(2));
	temp8 <= (Y(2) AND X(1));
	temp9 <= (Y(3) AND X(0));
	temp10 <= (Y(1) AND X(3));
	temp11 <= (Y(2) AND X(2));
	temp12 <= (Y(3) AND X(1));
	temp13 <= (Y(2) AND X(3));
	temp14 <= (Y(3) AND X(2));
	temp15 <= (Y(3) AND X(3));

	h1: half_adder PORT MAP (temp1, temp2, P(1), c2);
	
	f21: full_adder PORT MAP (temp3, temp4, c2, sp2, c31);
	h2: half_adder PORT MAP (sp2, temp5, p(2), c32);
	
	f31: full_adder PORT MAP (c31, c32, temp6, sp31, c41);
	f32: full_adder PORT MAP (temp7, temp8, sp31, sp32, c42);
	h3:  half_adder PORT MAP (temp9, sp32, P(3), c43);
	
	f41: full_adder PORT MAP (c41, c42, c43, sp41, c51);
	f42: full_adder PORT MAP (temp10, temp11, sp41, sp42, c52);
	h4:  half_adder PORT MAP (temp12, sp42, P(4), c53);
	
	f51: full_adder PORT MAP (c51, c52, c53, sp51, c61);
	f52: full_adder PORT MAP (temp13, temp14, sp51 , P(5), c62);
	
	f61: full_adder PORT MAP (c61, c62, temp15, P(6), c7);
	
	P(7) <= c7;
end Behavioral;
