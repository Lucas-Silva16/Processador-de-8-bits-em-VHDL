library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramCounter is
    Port ( Constante : in STD_LOGIC_VECTOR (7 downto 0);
           Salto : in STD_LOGIC;
           Clock : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Endereco : out STD_LOGIC_VECTOR (7 downto 0));
end ProgramCounter;

architecture Behavioral of ProgramCounter is
signal contagem : unsigned(7 downto 0);

begin
    process(Clock)
    begin
        if rising_edge(Clock) then
            if Reset = '1' then
            contagem <=( others => '0');
        elsif Salto = '1' then
            contagem <=unsigned(Constante);
        else
            contagem <= contagem + 1;
        end if;
        
     end if;        
end process;

Endereco <= std_logic_vector(contagem);


end Behavioral;