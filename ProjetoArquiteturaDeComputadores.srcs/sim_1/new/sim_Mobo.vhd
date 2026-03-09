library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sim_Mobo is
--  Port ( );
end sim_Mobo;

architecture Behavioral of sim_Mobo is

    component Mobo
    Port ( 
           CLK   : in STD_LOGIC;
           RESET : in STD_LOGIC;
           PIN   : in STD_LOGIC_VECTOR (7 downto 0);
           POUT  : out STD_LOGIC_VECTOR (7 downto 0)
         );
    end component;

    signal s_CLK   : STD_LOGIC := '0';
    signal s_RESET : STD_LOGIC := '0';
    signal s_PIN   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_POUT  : STD_LOGIC_VECTOR (7 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: Mobo port map (
          CLK   => s_CLK,
          RESET => s_RESET,
          PIN   => s_PIN,
          POUT  => s_POUT
        );

    clk_process : process
    begin
        s_CLK <= '0';
        wait for clk_period/2;
        s_CLK <= '1';
        wait for clk_period/2;
    end process;

stim_proc: process
    begin
        -- Teste 1: Caminho Normal
        s_RESET <= '1'; wait for 200 ns; s_RESET <= '0';
        s_PIN <= "00000101"; -- Metemos o 5
        wait for 3000 ns;    -- Deixamos correr
        
        -- Teste 2: Caminho Negativo
        s_RESET <= '1'; wait for 200 ns; s_RESET <= '0';
        s_PIN <= "11110000"; -- Metemos o -16
        wait for 1000 ns;    -- Deixamos correr
        
        -- Teste 3: Caminho da RAM
        s_RESET <= '1'; wait for 200 ns; s_RESET <= '0';
        s_PIN <= "00111100"; -- Metemos o 60
        wait for 2000 ns;    -- Deixamos correr
        
        wait;
    end process;

end behavioral;