library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REGISTO_FLAGS is
    Port ( 
        CLK    : in STD_LOGIC;
        E_FLAG : in STD_LOGIC_VECTOR (4 downto 0);
        ESCR_F : in STD_LOGIC;  -- Corrigido para bater certo com o Descodificador
        SEL_F  : in STD_LOGIC_VECTOR (2 downto 0); -- Corrigido para bater certo com o Descodificador
        S_FLAG : out STD_LOGIC
    );
end REGISTO_FLAGS;

architecture Behavioral of REGISTO_FLAGS is
    
    -- Inicialização a '0' para evitar estados 'U' na simulação
    signal registo_interno : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    
begin
    
    -- FUNÇÃO PARA GUARDAR A ENTRADA (Síncrono)
    process(CLK)
    begin
        if rising_edge(CLK) then
            if ESCR_F = '1' then
                registo_interno <= E_FLAG;
            end if;
        end if;    
    end process;
    
    -- FUNÇÃO PARA FAZER A LÓGICA DE LEITURA (Combinatório)
    process(SEL_F, registo_interno)
    begin
        case SEL_F is
            when "000" => S_FLAG <= registo_interno(0); -- (<)
            when "001" => S_FLAG <= registo_interno(1); -- (<=)
            when "010" => S_FLAG <= registo_interno(2); -- (=)
            when "011" => S_FLAG <= registo_interno(3); -- (>=)
            when "100" => S_FLAG <= registo_interno(4); -- (>)
            when others => S_FLAG <= '0';               -- Alterado para '0' para síntese limpa
        end case;
    end process;

end Behavioral;