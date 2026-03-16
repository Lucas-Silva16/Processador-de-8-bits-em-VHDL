library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PerifericosSim is

end PerifericosSim;

architecture Behavioral of PerifericosSim is

    component Gestor_Perifericos
    Port ( 
        ESCR_P    : in  STD_LOGIC;
        PIN       : in  STD_LOGIC_VECTOR (7 downto 0);
        POUT      : out STD_LOGIC_VECTOR (7 downto 0);
        CLK       : in  STD_LOGIC;
        Operando1 : in  STD_LOGIC_VECTOR (7 downto 0);
        Dados_IN  : out STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;

    -- 2. Criar os sinais internos para ligar ao componente
    -- Entradas
    signal ESCR_P    : std_logic := '0';
    signal PIN       : std_logic_vector(7 downto 0) := (others => '0');
    signal CLK       : std_logic := '0';
    signal Operando1 : std_logic_vector(7 downto 0) := (others => '0');

    -- Saídas
    signal POUT     : std_logic_vector(7 downto 0);
    signal Dados_IN : std_logic_vector(7 downto 0);

    -- 3. Definir o período do relógio
    constant CLK_period : time := 10 ns;

begin

    uut: Gestor_Perifericos PORT MAP (
        ESCR_P    => ESCR_P,
        PIN       => PIN,
        POUT      => POUT,
        CLK       => CLK,
        Operando1 => Operando1,
        Dados_IN  => Dados_IN
    );

    -- 5. Processo que gera o sinal de relógio
    CLK_process :process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;

    -- 6. Processo de estímulos (onde enviamos os dados de teste)
    stim_proc: process
    begin
        -- Esperar um pouco no início
        wait for 20 ns;

        -- TESTE 1: Ler do exterior (ESCR_P = '0')
        -- O que metermos no PIN deve aparecer Imediatamente no Dados_IN
        ESCR_P <= '0';
        PIN <= x"AA";       -- x"AA" é o mesmo que "10101010"
        Operando1 <= x"BB"; -- Preparamos um valor no Operando1 (não deve ir para POUT ainda)
        wait for CLK_period * 2;

        -- TESTE 2: Escrever para o exterior (ESCR_P = '1')
        -- O Dados_IN deve ir a zeros. Na subida do relógio, o POUT recebe o Operando1 (BB)
        ESCR_P <= '1';
        wait for CLK_period * 2;

        -- TESTE 3: Mudar o Operando1 enquanto ESCR_P = '1'
        Operando1 <= x"CC"; 
        wait for CLK_period * 2; -- Esperamos pelo relógio para ver o POUT a atualizar para CC

        -- TESTE 4: Voltar a ler do exterior
        ESCR_P <= '0';
        PIN <= x"DD";
        wait for CLK_period * 2;

        -- Fim da simulação
        wait;
    end process;

end Behavioral;