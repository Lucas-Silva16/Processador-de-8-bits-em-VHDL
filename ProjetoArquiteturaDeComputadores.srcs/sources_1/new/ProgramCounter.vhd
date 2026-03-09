library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProgramCounter is
    Port ( 
        Constante : in  STD_LOGIC_VECTOR (7 downto 0);
        ESCR_PC   : in  STD_LOGIC;
        CLK       : in  STD_LOGIC;
        Reset     : in  STD_LOGIC;
        Endereco  : out STD_LOGIC_VECTOR (7 downto 0)
    );
end ProgramCounter;

architecture Behavioral of ProgramCounter is

    signal contagem : unsigned(7 downto 0);

begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if Reset = '1' then
                contagem <= (others => '0');
            elsif ESCR_PC = '1' then
                contagem <= unsigned(Constante);
            else
                contagem <= contagem + 1;
            end if;
        end if;        
    end process;

    Endereco <= std_logic_vector(contagem);

end Behavioral;