library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_Reg is
  Port ( 
    resultado : in std_logic_vector (7 downto 0);
    Dados_IN : in std_logic_vector (7 downto 0);
    Dados_Mem : in std_logic_vector (7 downto 0);
    Constante : in std_logic_vector (7 downto 0);
    SEL_Data : in std_logic_vector (1 downto 0);
    Dados_Regs : out std_logic_vector (7 downto 0)
    );  
end MUX_Reg;

architecture Behavioral of MUX_Reg is
begin
    process(SEL_Data, resultado, Dados_IN, Dados_Mem, Constante)
    begin 
        case SEL_Data is
            when "00" => Dados_Regs <= resultado;
            when "01" => Dados_Regs <= Dados_IN;
            when "10" => Dados_Regs <= Dados_Mem;
            when "11" => Dados_Regs <= Constante;
            when others => Dados_Regs <= (others => '0');
        end case;
    end process;
end Behavioral;
