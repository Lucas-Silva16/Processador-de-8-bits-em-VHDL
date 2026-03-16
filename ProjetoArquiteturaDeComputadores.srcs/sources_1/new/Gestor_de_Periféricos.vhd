library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Gestor_Perifericos is
    Port ( 
           CLK       : in  STD_LOGIC;
           ESCR_P    : in  STD_LOGIC;
           PIN       : in  STD_LOGIC_VECTOR (7 downto 0);
           Operando1 : in  STD_LOGIC_VECTOR (7 downto 0);
           Dados_IN  : out STD_LOGIC_VECTOR (7 downto 0);
           POUT      : out STD_LOGIC_VECTOR (7 downto 0)
         );
end Gestor_Perifericos;

architecture Behavioral of Gestor_Perifericos is
begin

    Dados_IN <= PIN when ESCR_P = '0' else (others => '0');

    process(CLK)
    begin
        if rising_edge(CLK) then
            if ESCR_P = '1' then
                POUT <= Operando1;
            end if;
        end if;
    end process;

end Behavioral;