library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processador is
    Port ( 
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
end Processador;

architecture Behavioral of Processador is

    component ALU is
        Port ( 
               Operando1 : in  STD_LOGIC_VECTOR (7 downto 0);
               Operando2 : in  STD_LOGIC_VECTOR (7 downto 0);
               SEL_ALU   : in  STD_LOGIC_VECTOR (3 downto 0);
               Resultado : out STD_LOGIC_VECTOR (7 downto 0);
               E_FLAG    : out STD_LOGIC_VECTOR (4 downto 0)
             );
    end component;
        
    component Gestor_Perifericos is
        Port ( 
               CLK       : in  STD_LOGIC;
               ESCR_P    : in  STD_LOGIC;
               PIN       : in  STD_LOGIC_VECTOR (7 downto 0);
               Operando1 : in  STD_LOGIC_VECTOR (7 downto 0);
               Dados_IN  : out STD_LOGIC_VECTOR (7 downto 0);
               POUT      : out STD_LOGIC_VECTOR (7 downto 0)
             );
    end component;    
            
    component MUX_Reg is
        Port ( 
               resultado  : in  std_logic_vector (7 downto 0);
               Dados_IN   : in  std_logic_vector (7 downto 0);
               Dados_Mem  : in  std_logic_vector (7 downto 0);
               Constante  : in  std_logic_vector (7 downto 0);
               SEL_Data   : in  std_logic_vector (1 downto 0);
               Dados_Regs : out std_logic_vector (7 downto 0)
             );  
    end component;
        
    component ProgramCounter is
        Port ( 
               Constante : in  STD_LOGIC_VECTOR (7 downto 0);
               ESCR_PC   : in  STD_LOGIC;
               CLK       : in  STD_LOGIC;
               Reset     : in  STD_LOGIC;
               Endereco  : out STD_LOGIC_VECTOR (7 downto 0)
             );
    end component;
    
    component REGISTO_FLAGS is
        Port ( 
               CLK    : in  STD_LOGIC;
               E_FLAG : in  STD_LOGIC_VECTOR (4 downto 0);
               ESCR_F : in  STD_LOGIC; 
               SEL_F  : in  STD_LOGIC_VECTOR (2 downto 0); 
               S_FLAG : out STD_LOGIC
             );
    end component;
    
    component Registos_A_e_B is
        Port ( 
               CLK       : in  STD_LOGIC;
               ESCR_R    : in  STD_LOGIC;
               Dados_R   : in  STD_LOGIC_VECTOR (7 downto 0);
               SEL_R     : in  STD_LOGIC;
               Operando1 : out STD_LOGIC_VECTOR (7 downto 0);
               Operando2 : out STD_LOGIC_VECTOR (7 downto 0)
             );
    end component;
    
    component Descodificacao_ROM is
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
    end component;
    
    component MUX_PC is
        Port ( 
               S_FLAG    : in  std_logic;
               Operando1 : in  std_logic_vector (7 downto 0);
               SEL_PC    : in  std_logic_vector (2 downto 0);
               ESCR_PC   : out std_logic  
             );   
    end component;
    
    -- Sinais Internos (Fios) - Usando prefixo s_ para evitar conflitos com as Portas
    signal s_Resultado : std_logic_vector(7 downto 0);
    signal s_Operando1 : std_logic_vector(7 downto 0);
    signal s_Operando2 : std_logic_vector(7 downto 0);    
    signal s_Dados_IN  : std_logic_vector(7 downto 0);
    signal s_Dados_R   : std_logic_vector(7 downto 0);
    signal s_E_FLAG    : std_logic_vector(4 downto 0);
    signal s_S_FLAG    : std_logic;
    signal s_ESCR_PC   : std_logic;
    
    -- Fios do Descodificador da ROM
    signal s_SEL_PC : std_logic_vector(2 downto 0);
    signal s_SEL_F  : std_logic_vector(2 downto 0);
    signal s_ESCR_F : std_logic;
    signal s_SEL_ALU: std_logic_vector (3 downto 0);
    signal s_ESCR_R : std_logic;
    signal s_SEL_Data: std_logic_vector(1 downto 0);
    signal s_ESCR_P : std_logic;

begin

    Inst_ALU : ALU
        port map(
                 Operando1 => s_Operando1,
                 Operando2 => s_Operando2,
                 SEL_ALU   => s_SEL_ALU,
                 Resultado => s_Resultado,
                 E_FLAG    => s_E_FLAG
                );
                
    Inst_Gestor_Perifericos : Gestor_Perifericos
        port map ( 
                   CLK       => CLK,
                   ESCR_P    => s_ESCR_P,
                   PIN       => PIN,
                   Operando1 => s_Operando1,
                   Dados_IN  => s_Dados_IN,
                   POUT      => POUT
                 );
                 
    Inst_MUX_Reg : MUX_Reg
        port map ( 
                   resultado  => s_Resultado,
                   Dados_IN   => s_Dados_IN,
                   Dados_Mem  => Dados_M,
                   Constante  => Constante,
                   SEL_Data   => s_SEL_Data,
                   Dados_Regs => s_Dados_R
                 );
                 
    Inst_PC : ProgramCounter 
        port map ( 
                   Constante => Constante,
                   ESCR_PC   => s_ESCR_PC,
                   CLK       => CLK,
                   Reset     => Reset,
                   Endereco  => Endereco
                 ); 
                 
    Inst_RF : REGISTO_FLAGS 
        port map ( 
                   CLK    => CLK,
                   E_FLAG => s_E_FLAG,
                   ESCR_F => s_ESCR_F,
                   SEL_F  => s_SEL_F,
                   S_FLAG => s_S_FLAG
                 );                        
                 
    Inst_R_AB : Registos_A_e_B 
        port map ( 
                   CLK       => CLK,
                   ESCR_R    => s_ESCR_R,
                   Dados_R   => s_Dados_R,
                   Sel_R     => SEL_R_in,
                   Operando1 => s_Operando1,
                   Operando2 => s_Operando2
                 );    
                 
    Inst_DROM : Descodificacao_ROM 
        port map ( 
                   Opcode   => opcode,
                   SEL_ALU  => s_SEL_ALU,
                   ESCR_P   => s_ESCR_P,
                   SEL_DATA => s_SEL_Data,
                   ESCR_R   => s_ESCR_R,
                   WR       => WR,       -- Liga diretamente à porta de saída
                   SEL_PC   => s_SEL_PC,
                   ESCR_F   => s_ESCR_F,
                   SEL_F    => s_SEL_F
                 );
    
    Inst_MUXPC : MUX_PC 
        port map ( 
                   S_FLAG    => s_S_FLAG,
                   Operando1 => s_Operando1,
                   SEL_PC    => s_SEL_PC,
                   ESCR_PC   => s_ESCR_PC
                 );
             
    -- Ligação final do dado a escrever na RAM
    Dados_W <= s_Operando1;        

end Behavioral;