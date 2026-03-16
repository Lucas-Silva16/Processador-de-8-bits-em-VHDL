library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mobo is
    Port ( 
           CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           PIN   : in  STD_LOGIC_VECTOR (7 downto 0);
           POUT  : out STD_LOGIC_VECTOR (7 downto 0)
         );
end Mobo;

architecture Behavioral of Mobo is

    component Processador is
        Port(
            CLK       : in  STD_LOGIC;
            RESET     : in  STD_LOGIC;
            PIN       : in  STD_LOGIC_VECTOR (7 downto 0);
            POUT      : out STD_LOGIC_VECTOR (7 downto 0);
            opcode    : in  STD_LOGIC_VECTOR (4 downto 0);
            Constante : in  STD_LOGIC_VECTOR (7 downto 0);
            SEL_R_in  : in  STD_LOGIC;
            Dados_M   : in  STD_LOGIC_VECTOR (7 downto 0); 
            WR        : out STD_LOGIC;                    
            Endereco  : out STD_LOGIC_VECTOR (7 downto 0);
            Dados_W   : out STD_LOGIC_VECTOR (7 downto 0) 
        );
    end component;
    
    component RAM is
        Port ( 
            DadosIN  : in  STD_LOGIC_VECTOR (7 downto 0);
            Endereco : in  STD_LOGIC_VECTOR (7 downto 0);
            WR       : in  STD_LOGIC;
            CLK      : in  STD_LOGIC;
            DadosOUT : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    
    component ROM_Memoria_Instrucoes is
        Port ( 
            Endereco  : in  STD_LOGIC_VECTOR (7 downto 0);
            opcode    : out STD_LOGIC_VECTOR (4 downto 0);
            SEL_R     : out STD_LOGIC;
            Constante : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    
    -- Fios de ligação interna (sinais)
    signal s_Endereco  : std_logic_vector (7 downto 0);
    signal s_opcode    : std_logic_vector (4 downto 0);
    signal s_Constante : std_logic_vector (7 downto 0);
    signal s_SEL_R     : std_logic;
    
    signal s_WR        : std_logic;
    signal s_Dados_M   : std_logic_vector (7 downto 0);
    signal s_Dados_W   : std_logic_vector (7 downto 0);

begin

    Inst_Processador : Processador 
        port map (
            CLK       => CLK,       
            RESET     => RESET,    
            PIN       => PIN,       
            POUT      => POUT,      
            opcode    => s_opcode,   
            Constante => s_Constante, 
            SEL_R_in  => s_SEL_R, 
            Dados_M   => s_Dados_M,
            WR        => s_WR,         
            Endereco  => s_Endereco,
            Dados_W   => s_Dados_W  
        );

    Inst_RAM : RAM
        port map (
            DadosIN  => s_Dados_W,
            Endereco => s_Constante, 
            WR       => s_WR,
            CLK      => CLK,
            DadosOUT => s_Dados_M
        );
            
    Inst_ROM : ROM_Memoria_Instrucoes
        port map ( 
            Endereco  => s_Endereco, 
            opcode    => s_opcode,
            SEL_R     => s_SEL_R,
            Constante => s_Constante
        );

end Behavioral;