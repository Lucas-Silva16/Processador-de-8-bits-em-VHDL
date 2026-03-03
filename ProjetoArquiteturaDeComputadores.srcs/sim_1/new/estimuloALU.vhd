library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ALU is
end tb_ALU;

architecture Behavioral of tb_ALU is

    component ALU
    Port ( Operando1 : in STD_LOGIC_VECTOR (7 downto 0);
           Operando2 : in STD_LOGIC_VECTOR (7 downto 0);
           SEL_ALU   : in STD_LOGIC_VECTOR (3 downto 0);
           Resultado : out STD_LOGIC_VECTOR (7 downto 0);
           E_FLAG    : out STD_LOGIC_VECTOR (4 downto 0));
    end component;

    signal Operando1 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal Operando2 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal SEL_ALU   : STD_LOGIC_VECTOR (3 downto 0) := "0000";

    signal Resultado : STD_LOGIC_VECTOR (7 downto 0);
    signal E_FLAG    : STD_LOGIC_VECTOR (4 downto 0);

begin

    uut: ALU Port map (
        Operando1 => Operando1,
        Operando2 => Operando2,
        SEL_ALU   => SEL_ALU,
        Resultado => Resultado,
        E_FLAG    => E_FLAG
    );

    stim_proc: process
    begin
        wait for 50 ns;

        Operando1 <= "00001010";
        Operando2 <= "00000101";
        SEL_ALU   <= "0000";
        wait for 20 ns;

        Operando1 <= "00010100";
        Operando2 <= "00001010";
        SEL_ALU   <= "0001";
        wait for 20 ns;

        Operando1 <= "11111111";
        Operando2 <= "00001111";
        SEL_ALU   <= "0010";
        wait for 20 ns;

        Operando1 <= "00000001";
        Operando2 <= "00000000";
        SEL_ALU   <= "0011";
        wait for 20 ns;

        Operando1 <= "00000101";
        Operando2 <= "00001010";
        SEL_ALU   <= "0100";
        wait for 20 ns;

        Operando1 <= "00001010";
        Operando2 <= "00001010";
        SEL_ALU   <= "0101";
        wait for 20 ns;

        Operando1 <= "00001111";
        Operando2 <= "00001010";
        SEL_ALU   <= "0110";
        wait for 20 ns;
        
        Operando1 <= "01001111";
        Operando2 <= "01001010";
        SEL_ALU   <= "0111";
        wait for 20 ns;

        Operando1 <= "01011111";
        Operando2 <= "01101000";
        SEL_ALU   <= "1000";
        wait for 20 ns;
        
        Operando1 <= "01000000";
        Operando2 <= "01101000";
        SEL_ALU   <= "1001";
        wait for 20 ns;
        wait;
    end process;

end Behavioral;