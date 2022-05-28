library IEEE;
use IEEE.std_logic_1164.all;
entity MFR is
port (
	X0: in BIT;
	X1: in BIT;
	X2: in BIT;
	X3: in BIT;
	z0: in BIT;
	z1: in BIT;
	z2: in BIT;
	z3: in BIT;
	SI: in BIT;
	Y0: in BIT;
	Y1: in BIT;
	EN: in BIT;
	CLK: in BIT;
	CLR: in BIT;
	q0: buffer BIT;
	q1: buffer BIT;
	q2: buffer BIT;
	q3: buffer BIT
	);
end MFR;

architecture MFR_arch of MFR is
signal s1: integer range 0 to 6;
signal s2: integer range 0 to 8;
signal s3: integer range 0 to 14;

COMPONENT POZ1
port (
	D0: in BIT;
	D1: in BIT;
	D2: in BIT;
	D3: in BIT;
	F: out integer range 0 to  6
	);
end COMPONENT;

COMPONENT POZ2
	port (
	D0: in BIT;
	D1: in BIT;
	D2: in BIT;
	D3: in BIT;
	F: out integer range 0 to  8
);
end COMPONENT;

COMPONENT SM
port (
	A: in integer range 0 to  6;
	B: in integer range 0 to  8;
	S: out integer range 0 to  14
);
end COMPONENT;

COMPONENT RG
PORT (
	SI: in BIT;
	SMM: in integer range 0 to 14;
	D0: in BIT;
	D1: in BIT;
	D2: in BIT;
	D3: in BIT;
	Y0: in BIT;
	Y1: in BIT;
	EN: in BIT;
	X1: in BIT;
	Z1: in BIT;
	CLK: in BIT;
	CLR: in BIT;
	Q0: buffer BIT;
	Q1: buffer BIT;
	Q2: buffer BIT;
	Q3: buffer BIT
	);
end COMPONENT;

begin 
DD1: POZ1
PORT MAP (
	D0 => X0,
	D1 => X1,
	D2 => X2,
	D3 => X3,
	F => s1
	);

DD2: POZ2
PORT MAP (
	D0 => z0,
	D1 => z1,
	D2 => z2,
	D3 => z3,
	F => s2
	);

DD3: SM
PORT MAP (
	A => s1,
	B => s2,
	S => s3
	);

DD4: RG
PORT MAP (
	SI => SI,
	SMM => s3,
	D0 => Z0,
	D1 => Z1,
	D2 => Z2,
	D3 => Z3,
	Y0 => Y0,
	Y1 => Y1,
	X1 => X1,
	Z1 => Z1,
	EN => EN,
	CLK => CLK,
	CLR => CLR,
	Q0 => q0,
	Q1 => q1,
	Q2 => q2,
	Q3 => q3
	);
end MFR_arch;

library IEEE;
use IEEE.std_logic_1164.all;

entity POZ1 is
PORT (
	D0: in BIT;
	D1: in BIT;
	D2: in BIT;
	D3: in BIT;
	F: out integer range 0 to  6
	);
end POZ1;

architecture RTY_arch of POZ1 is
	begin
	process (D0,D1,D2,D3)
	variable D: BIT_VECTOR (3 downto 0);
		begin
		D:= D3 & D2 & D1 & D0;
		case D is 
			when "0000" => F <= 0;
			when "0001" => F <= 2;
			when "0010" => F <= 2;
			when "0011" => F <= 0;
			when "0100" => F <= 4;
			when "0101" => F <= 2;
			when "0110" => F <= 6;
			when "0111" => F <= 4;
			when "1000" => F <= 4;
			when "1001" => F <= 6;
			when "1010" => F <= 2;
			when "1011" => F <= 4;
			when "1100" => F <= 0;
			when "1101" => F <= 2;
			when "1110" => F <= 2;
			when "1111" => F <= 0;
		end case;
	end process;
end RTY_arch;

entity POZ2 is
PORT (
	D0: in BIT;
	D1: in BIT;
	D2: in BIT;
	D3: in BIT;
	F: out integer range 0 to 8
	);
end POZ2;

architecture RTY_arch of POZ2 is
	begin
	process (D0,D1,D2,D3)
	variable D: BIT_VECTOR (3 downto 0);
		begin
		D:= D3 & D2 & D1 & D0;
		case D is 
			when "0000" => F <= 0;
			when "0001" => F <= 2;
			when "0010" => F <= 2;
			when "0011" => F <= 4;
			when "0100" => F <= 2;
			when "0101" => F <= 2;
			when "0110" => F <= 4;
			when "0111" => F <= 6;
			when "1000" => F <= 2;
			when "1001" => F <= 2;
			when "1010" => F <= 2;
			when "1011" => F <= 2;
			when "1100" => F <= 4;
			when "1101" => F <= 4;
			when "1110" => F <= 6;
			when "1111" => F <= 8;
		end case;
	end process;
end RTY_arch;

library IEEE;
use IEEE.std_logic_1164.all;
entity SM is
PORT (
	A: in integer range 0 to 6;
	B: in integer range 0 to 8;
	S: out integer range 0 to 14		
	);
end SM;

architecture ADD_arch of SM is
begin
S <= A + B;
end ADD_arch;

library IEEE;
use IEEE.std_logic_1164.all;
entity RG is
PORT (
	SI: in BIT;
	SMM: in integer range 0 to 14;
	D0: in BIT;
	D1: in BIT;
	D2: in BIT;
	D3: in BIT;
	Y0: in BIT;
	Y1: in BIT;
	X1: in BIT;
	Z1: in BIT;
	EN: in BIT;
	CLK: in BIT;
	CLR: in BIT;
	Q0: buffer BIT;
	Q1: buffer BIT;
	Q2: buffer BIT;
	Q3: buffer BIT
	);
end RG;

architecture RG_arch of RG is
	begin
	process (CLK, CLR, EN)
	begin
		if CLR = '1' then
			Q0 <= '0';
			Q1 <= '0';
			Q2 <= '0';
			Q3 <= '0';
		elsif EN = '0' then null;
		elsif CLK'event and CLK = '1' then
			if Y0 = '0' and Y1 = '0' then
				Q0 <= D0;
				Q1 <= D1;
				Q2 <= D2;
				Q3 <= D3;
			elsif Y0 = '0' and Y1 = '1' then
				Q0 <= SI;
				Q1 <= Q0;
				Q2 <= Q1;
				Q3 <= Q2;
			elsif Y0 = '1' and Y1 = '0' then
				Q0 <= Q1;
				Q1 <= Q2;
				Q2 <= '0';
			elsif Y0 = '1' and Y1 = '1' then
				case SMM is
					when 0 => Q0 <= '0'; Q1 <= '0'; Q2 <= '0'; Q3 <= '0';
					when 2 => Q0 <= '0'; Q1 <= '1'; Q2 <= '0'; Q3 <= '0';
					when 4 => Q0 <= '0'; Q1 <= '0'; Q2 <= '1'; Q3 <= '0';
					when 6 => Q0 <= '0'; Q1 <= '1'; Q2 <= '1'; Q3 <= '0';
					when 8 => Q0 <= '0'; Q1 <= '0'; Q2 <= '0'; Q3 <= '1';
					when 10 => Q0 <= '0'; Q1 <= '1'; Q2 <= '0'; Q3 <= '1';
					when 12 => Q0 <= '0'; Q1 <= '0'; Q2 <= '1'; Q3 <= '1';
					when 14 => Q0 <= '0'; Q1 <= '1'; Q2 <= '1'; Q3 <= '1';
				end case;
			end if;
		end if;
	end process;
end RG_arch;
