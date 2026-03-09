library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
    Port ( 
           DadosIN  : in  STD_LOGIC_VECTOR (7 downto 0);
           Endereco : in  STD_LOGIC_VECTOR (7 downto 0);
           WR       : in  STD_LOGIC;
           CLK      : in  STD_LOGIC;
           DadosOUT : out STD_LOGIC_VECTOR (7 downto 0)
         );
end RAM;

architecture Behavioral of RAM is

    type memoria is array (0 to 255) of std_logic_vector (7 downto 0);
    
    -- Inicialização da RAM toda a zeros para evitar o estado 'U' no simulador
    signal MemEndereco : memoria := (others => (others => '0'));

begin
    
    -- Lógica de Escrita Síncrona (Apenas na subida do CLK e se WR = '1')
    process(CLK)
    begin
        if rising_edge(CLK) then
            if WR = '1' then
                MemEndereco(to_integer(unsigned(Endereco))) <= DadosIN;
            end if;
        end if;    
    end process;

    -- Lógica de Leitura Assíncrona (Fora do processo)
    -- Quando WR = '0' lê a RAM, caso contrário coloca a zeros
    DadosOUT <= MemEndereco(to_integer(unsigned(Endereco))) when WR = '0' else (others => '0');

end Behavioral;