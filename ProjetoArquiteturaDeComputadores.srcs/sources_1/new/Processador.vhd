library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processador is
    Port ( 
           CLK       : in STD_LOGIC;
           RESET     : in STD_LOGIC;
           PIN       : in STD_LOGIC_VECTOR (7 downto 0);
           POUT      : out STD_LOGIC_VECTOR (7 downto 0);
           opcode    : in STD_LOGIC_VECTOR (4 downto 0);
           Constante : in STD_LOGIC_VECTOR (7 downto 0);
           SEL_R_in  : in STD_LOGIC; -- Vem da ROM (segundo a Secção 3 do enunciado)
           Dados_M   : in STD_LOGIC_VECTOR (7 downto 0); 
           WR        : out STD_LOGIC;                    
           Endereco  : out STD_LOGIC_VECTOR (7 downto 0);
           Dados_W   : out STD_LOGIC_VECTOR (7 downto 0) 
         );
end Processador;

architecture Behavioral of Processador is

    component ALU is
        Port ( Operando1 : in STD_LOGIC_VECTOR (7 downto 0);
               Operando2 : in STD_LOGIC_VECTOR (7 downto 0);
               SEL_ALU : in STD_LOGIC_VECTOR (3 downto 0);
               Resultado : out STD_LOGIC_VECTOR (7 downto 0);
               E_FLAG : out STD_LOGIC_VECTOR (4 downto 0)
               );
    end component;
        
    component Gestor_De_Perifericos is
        Port ( ESCR_P : in STD_LOGIC;
               PIN : in STD_LOGIC_VECTOR (7 downto 0);
               POUT : out STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC;
               Operando1 : in STD_LOGIC_VECTOR (7 downto 0);
               Dados_IN : out STD_LOGIC_VECTOR (7 downto 0)
               );
    end component;    
            
    component MUX_Reg is
        Port ( 
               resultado : in std_logic_vector (7 downto 0);
               Dados_IN : in std_logic_vector (7 downto 0);
               Dados_Mem : in std_logic_vector (7 downto 0);
               Constante : in std_logic_vector (7 downto 0);
               SEL_Data : in std_logic_vector (1 downto 0);
               Dados_Regs : out std_logic_vector (7 downto 0)
               );  
    end component;
        
    component ProgramCounter is
        Port ( Constante : in STD_LOGIC_VECTOR (7 downto 0);
               ESCR_PC : in STD_LOGIC;
               CLK : in STD_LOGIC;
               Reset : in STD_LOGIC;
               Endereco : out STD_LOGIC_VECTOR (7 downto 0)
               );
    end component;
    
    component REGISTO_FLAGS is
        Port ( CLK : in STD_LOGIC;
               E_FLAG : in STD_LOGIC_VECTOR (4 downto 0);
               ESCR_FLAG : in STD_LOGIC;
               SEL_FLAG : in STD_LOGIC_VECTOR (2 downto 0);
               S_FLAG : out STD_LOGIC);
    end component;
    
    component Registos_A_e_B is
        Port ( CLK : in STD_LOGIC;
               ESCR_R : in STD_LOGIC;
               Dados_R : in STD_LOGIC_VECTOR (7 downto 0);
               Sel_R : in STD_LOGIC;
               Operando1 : out STD_LOGIC_VECTOR (7 downto 0);
               Operando2 : out STD_LOGIC_VECTOR (7 downto 0)
               );
    end component;
    
    component Descodificacao_ROM is
        Port ( Opcode : in STD_LOGIC_VECTOR (4 downto 0);
               SEL_ALU : out STD_LOGIC_VECTOR (3 downto 0);
               ESCR_P : out STD_LOGIC;
               SEL_DATA : out STD_LOGIC_VECTOR (1 downto 0);
               ESCR_R : out STD_LOGIC;
               WR : out STD_LOGIC;
               SEL_PC : out STD_LOGIC_VECTOR (2 downto 0);
               ESCR_F : out STD_LOGIC;
               SEL_F : out STD_LOGIC_VECTOR (2 downto 0)
               );
    end component;
    
    component MUX_PC is
        Port ( 
           S_FLAG : in std_logic;
           Operando1 : in std_logic_vector (7 downto 0);
           SEL_PC : in std_logic_vector (2 downto 0);
           ESCR_PC : out std_logic    
         );   
    end component;
    
    signal Resultado : std_logic_vector(7 downto 0);
    signal Operando1 : std_logic_vector(7 downto 0);
    signal Operando2 : std_logic_vector(7 downto 0);    
    signal Dados_IN : std_logic_vector(7 downto 0);
    signal Dados_R : std_logic_vector(7 downto 0);
    signal E_FLAG : std_logic_vector(4 downto 0);
    signal S_FLAG : std_logic;
    signal ESCR_PC : std_logic;
    
    --fios Descodificador da rom
    
    signal SEL_PC : std_logic_vector(2 downto 0);
    signal SEL_FLAG : std_logic_vector(2 downto 0);
    signal ESCR_FLAG : std_logic;
    signal SEL_ALU : std_logic_vector (3 downto 0);
    signal ESCR_R : std_logic;
    signal SEL_Data : std_logic_vector(1 downto 0);
    signal ESCR_P : std_logic;

begin

inst_ALU : ALU
    port map(
            Operando1 =>Operando1 ,
            Operando2 =>Operando2,
            SEL_ALU =>SEL_ALU ,
            Resultado =>Resultado ,
            E_FLAG => E_FLAG
            );
inst_Gestor_De_Perifericos : Gestor_De_Perifericos
    port map ( ESCR_P =>ESCR_P,
               PIN =>PIN,
               POUT =>POUT,
               CLK =>CLK,
               Operando1 =>Operando1,
               Dados_IN =>Dados_IN
               );
inst_MUX_Reg : MUX_Reg
        port map ( 
               resultado =>resultado,
               Dados_IN  =>Dados_IN,
               Dados_Mem  =>Dados_M,
               Constante  =>Constante,
               SEL_Data  =>SEL_Data,
               Dados_Regs  =>Dados_R
               );
inst_PC : ProgramCounter 
        port map ( Constante =>Constante,
               ESCR_PC =>ESCR_PC,
               CLK =>CLK,
               Reset =>Reset,
               Endereco =>Endereco
               ); 
inst_RF : REGISTO_FLAGS 
        port map ( CLK  =>CLK,
               E_FLAG  =>E_FLAG,
               ESCR_FLAG  =>ESCR_FLAG,
               SEL_FLAG => SEL_FLAG,
               S_FLAG =>  S_FLAG
               );                       
inst_R_AB : Registos_A_e_B 
        port map ( CLK =>CLK,
               ESCR_R =>ESCR_R,
               Dados_R =>Dados_R,
               Sel_R =>SEL_R_in,
               Operando1 =>Operando1,
               Operando2 =>Operando2
               );    
inst_DROM : Descodificacao_ROM 
        port map ( Opcode  =>Opcode,
               SEL_ALU =>SEL_ALU,
               ESCR_P  =>ESCR_P,
               SEL_DATA  =>SEL_DATA,
               ESCR_R  =>ESCR_R,
               WR  =>WR,
               SEL_PC  =>SEL_PC,
               ESCR_F =>ESCR_FLAG,
               SEL_F  =>SEL_FLAG
               );

    
inst_MUXPC : MUX_PC 
        port map ( 
           S_FLAG   =>S_FLAG,
           Operando1   =>Operando1,
           SEL_PC   =>SEL_PC,
           ESCR_PC   =>ESCR_PC
         );
         
 Dados_W <= Operando1;       

end Behavioral;