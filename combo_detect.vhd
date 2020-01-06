LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use work.my_package.all;


ENTITY combo_detect IS
PORT ( clk, Resetn, w : IN  STD_LOGIC ;
		z: OUT STD_LOGIC;
		display_sequence: buffer std_logic_vector(7 downto 0); 
		display_w: out std_logic
	  );
END combo_detect ;

ARCHITECTURE Behavior OF combo_detect IS

SIGNAL y_present, y_next : STD_LOGIC_VECTOR(3 DOWNTO 0);



CONSTANT A :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000" ;
CONSTANT B :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001" ;
CONSTANT C :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010" ;
CONSTANT D :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011" ;
CONSTANT E :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "0100" ;
CONSTANT F :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "0101" ;
CONSTANT G :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "0110" ;
CONSTANT H :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111" ;
CONSTANT I :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "1000" ;
CONSTANT J :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "1001" ;
CONSTANT K :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "1010" ;
CONSTANT R :  STD_LOGIC_VECTOR(3 DOWNTO 0) := "1011" ;


BEGIN


--int_clk: counter PORT MAP(Clock, internal_clk);
display: shift8 PORT MAP(clk, Resetn, w, display_sequence);

PROCESS ( w, y_present )
BEGIN

	CASE y_present IS

	WHEN R =>
	IF w = '0' THEN y_next <= H ;
	ELSE y_next <= A ;
	END IF ;

	WHEN A =>
	IF w = '0' THEN y_next <= B ;
	ELSE y_next <= E ;
	END IF ;

	WHEN B =>  IF w = '0' THEN 
	y_next <= C ;
	ELSE y_next <= A ;
	END IF ;

	WHEN C => IF w = '0' THEN 
	y_next <= I ;
	ELSE y_next <= D ;
	END IF ;

	WHEN D =>
	IF w = '0' THEN y_next <= B ;
	ELSE y_next <= K ;
	END IF ;

	WHEN E =>
	IF w = '0' THEN y_next <= B ;
	ELSE y_next <= F ;
	END IF ;

	WHEN F =>
	IF w = '0' THEN y_next <= B ;
	ELSE y_next <= G ;
	END IF ;

	WHEN G =>
	IF w = '0' THEN y_next <= B ;
	ELSE y_next <= G ;
	END IF ;

	WHEN H =>
	IF w = '0' THEN y_next <= I ;
	ELSE y_next <= A ;
	END IF ;

	WHEN I =>
	IF w = '0' THEN y_next <= I ;
	ELSE y_next <= J ;
	END IF ;

	WHEN J =>
	IF w = '0' THEN y_next <= B ;
	ELSE y_next <= K ;
	END IF ;

	WHEN K =>
	IF w = '0' THEN y_next <= B ;
	ELSE y_next <= F ;
	END IF ;

	WHEN OTHERS =>
	y_next <= R;


	END CASE ;
END PROCESS ;

PROCESS ( clk, Resetn )
BEGIN
	IF Resetn = '0' THEN
	y_present <= R ;
	ELSIF (clk'EVENT AND clk = '0') THEN 
	y_present <= y_next ;
	END IF ;
END PROCESS ;



with y_present select
z <= '1' WHEN D,
     '1' WHEN G,
     '1' WHEN K, 
     '0' WHEN OTHERS;


display_w <= w;

END Behavior ;