library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Descodificacao_ROM is
    Port ( 
           Opcode   : in  STD_LOGIC_VECTOR (4 downto 0);
           SEL_ALU  : out STD_LOGIC_VECTOR (3 downto 0);
           ESCR_P   : out STD_LOGIC;
           SEL_DATA : out STD_LOGIC_VECTOR (1 downto 0);
           ESCR_R   : out STD_LOGIC;
           WR       : out STD_LOGIC;
           SEL_PC   : out STD_LOGIC_VECTOR (2 downto 0);
           ESCR_F   : out STD_LOGIC;
           SEL_F    : out STD_LOGIC_VECTOR (2 downto 0)
    );
end Descodificacao_ROM;

architecture Behavioral of Descodificacao_ROM is
    
    -- Sinal interno que guarda a palavra de controlo de 16 bits
    signal controlo : std_logic_vector (15 downto 0);

begin

    process(Opcode)
    begin
        case Opcode is      
            --                                 |SEL_ALU|ESCR_p|SEL_DATA|ESCR_R|WR|SEL_PC|ESCR_F|SEL_F|
            -- Perifericos                     |       |      |        |      |  |      |      |     |
            when "00000" => controlo <= "0000" & '0' &  "01"  & '1' & '0' & "000" & '0' & "000"; -- LDP Ri
            when "00001" => controlo <= "0000" & '1' &  "00"  & '0' & '0' & "000" & '0' & "000"; -- STP RA
            
            -- Leitura e Escrita
            when "00010" => controlo <= "0000" & '0' &  "11"  & '1' & '0' & "000" & '0' & "000"; -- LD Ri, constante
            when "00011" => controlo <= "0000" & '0' &  "10"  & '1' & '0' & "000" & '0' & "000"; -- LD Ri, [constante]
            when "00100" => controlo <= "0000" & '0' &  "00"  & '0' & '1' & "000" & '0' & "000"; -- ST [constante], RA
            
            -- Lógica e Aritmética
            when "00101" => controlo <= "0000" & '0' &  "00"  & '1' & '0' & "000" & '0' & "000"; -- AND RA, RB
            when "00110" => controlo <= "0001" & '0' &  "00"  & '1' & '0' & "000" & '0' & "000"; -- OR RA, RB
            when "00111" => controlo <= "0010" & '0' &  "00"  & '1' & '0' & "000" & '0' & "000"; -- NAND RA, RB
            when "01000" => controlo <= "0011" & '0' &  "00"  & '1' & '0' & "000" & '0' & "000"; -- NOR RA, RB
            when "01001" => controlo <= "0100" & '0' &  "00"  & '1' & '0' & "000" & '0' & "000"; -- XOR RA, RB
            when "01010" => controlo <= "0101" & '0' &  "00"  & '1' & '0' & "000" & '0' & "000"; -- SHR RA
            when "01011" => controlo <= "0110" & '0' &  "00"  & '1' & '0' & "000" & '0' & "000"; -- SHL RA
            when "01100" => controlo <= "0111" & '0' &  "00"  & '1' & '0' & "000" & '0' & "000"; -- ADD RA, RB
            when "01101" => controlo <= "1000" & '0' &  "00"  & '1' & '0' & "000" & '0' & "000"; -- SUB RA, RB
            when "01110" => controlo <= "1001" & '0' &  "00"  & '0' & '0' & "000" & '1' & "000"; -- CMP RA, RB
            
            -- Saltos
            when "01111" => controlo <= "0000" & '0' &  "00"  & '0' & '0' & "011" & '0' & "000"; -- JZ RA, constante
            when "10000" => controlo <= "0000" & '0' &  "00"  & '0' & '0' & "100" & '0' & "000"; -- JN RA, constante
            when "10001" => controlo <= "0000" & '0' &  "00"  & '0' & '0' & "010" & '0' & "000"; -- JL constante
            when "10010" => controlo <= "0000" & '0' &  "00"  & '0' & '0' & "010" & '0' & "001"; -- JLE constante
            when "10011" => controlo <= "0000" & '0' &  "00"  & '0' & '0' & "010" & '0' & "010"; -- JE constante
            when "10100" => controlo <= "0000" & '0' &  "00"  & '0' & '0' & "010" & '0' & "011"; -- JGE constante
            when "10101" => controlo <= "0000" & '0' &  "00"  & '0' & '0' & "010" & '0' & "100"; -- JG constante
            when "10110" => controlo <= "0000" & '0' &  "00"  & '0' & '0' & "001" & '0' & "000"; -- JMP constante
            
            when others  => controlo <= "0000" & '0' &  "00"  & '0' & '0' & "000" & '0' & "000"; -- NOP
        end case;
    end process;    

    -- Atribuições concorrentes às portas de saída (Fora do processo)
    SEL_ALU  <= controlo (15 downto 12);
    ESCR_P   <= controlo (11);
    SEL_DATA <= controlo (10 downto 9);
    ESCR_R   <= controlo (8);
    WR       <= controlo (7);
    SEL_PC   <= controlo (6 downto 4);
    ESCR_F   <= controlo (3);
    SEL_F    <= controlo (2 downto 0);
             
end Behavioral; 