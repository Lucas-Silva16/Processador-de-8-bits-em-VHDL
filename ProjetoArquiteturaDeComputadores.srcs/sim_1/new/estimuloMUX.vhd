library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- A entidade do testbench é sempre vazia, pois não tem portas externas
entity tb_MUX_Reg is
end tb_MUX_Reg;

architecture Behavioral of tb_MUX_Reg is

    -- 1. Declaração do componente que vamos testar (seu MUX)
    component MUX_Reg
        Port ( 
            resultado  : in std_logic_vector (7 downto 0);
            Dados_IN   : in std_logic_vector (7 downto 0);
            Dados_Mem  : in std_logic_vector (7 downto 0);
            Constante  : in std_logic_vector (7 downto 0);
            SEL_Data   : in std_logic_vector (1 downto 0);
            Dados_Regs : out std_logic_vector (7 downto 0)
        );
    end component;

    -- 2. Declaração dos sinais internos do Testbench para ligar no componente
    -- Inicializamos as entradas com '0' por boas práticas
    signal tb_resultado  : std_logic_vector(7 downto 0) := (others => '0');
    signal tb_Dados_IN   : std_logic_vector(7 downto 0) := (others => '0');
    signal tb_Dados_Mem  : std_logic_vector(7 downto 0) := (others => '0');
    signal tb_Constante  : std_logic_vector(7 downto 0) := (others => '0');
    signal tb_SEL_Data   : std_logic_vector(1 downto 0) := "00";
    
    signal tb_Dados_Regs : std_logic_vector(7 downto 0);

begin

    -- 3. Instanciação da UUT (Unit Under Test - Unidade Sob Teste)
    -- Mapeamos os sinais do testbench para as portas do seu MUX
    UUT: MUX_Reg Port map (
        resultado  => tb_resultado,
        Dados_IN   => tb_Dados_IN,
        Dados_Mem  => tb_Dados_Mem,
        Constante  => tb_Constante,
        SEL_Data   => tb_SEL_Data,
        Dados_Regs => tb_Dados_Regs
    );

    -- 4. Processo que gera os estímulos de teste
    stim_proc: process
    begin
        -- Preparamos dados diferentes (em hexadecimal) para cada entrada do MUX
        -- Isso ajuda a ver facilmente qual entrada está passando para a saída
        tb_resultado <= x"AA"; -- Representa 10101010
        tb_Dados_IN  <= x"BB"; -- Representa 10111011
        tb_Dados_Mem <= x"CC"; -- Representa 11001100
        tb_Constante <= x"DD"; -- Representa 11011101
        
        wait for 20 ns; -- Aguarda 20 nanosegundos para estabilizar

        -- Teste 1: Seleciona "00"
        tb_SEL_Data <= "00"; 
        wait for 20 ns;      -- Saída 'tb_Dados_Regs' deve ser x"AA"
        
        -- Teste 2: Seleciona "01"
        tb_SEL_Data <= "01"; 
        wait for 20 ns;      -- Saída 'tb_Dados_Regs' deve ser x"BB"
        
        -- Teste 3: Seleciona "10"
        tb_SEL_Data <= "10"; 
        wait for 20 ns;      -- Saída 'tb_Dados_Regs' deve ser x"CC"
        
        -- Teste 4: Seleciona "11"
        tb_SEL_Data <= "11"; 
        wait for 20 ns;      -- Saída 'tb_Dados_Regs' deve ser x"DD"

        -- Fim da simulação (o wait vazio trava o processo aqui, evitando loop infinito)
        wait;
    end process;

end Behavioral;