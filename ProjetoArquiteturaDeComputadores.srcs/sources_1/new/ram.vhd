library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    Port ( DadosIN : in STD_LOGIC_VECTOR (7 downto 0);
           Endereco : in STD_LOGIC_VECTOR (7 downto 0);
           WR : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DadosOUT : out std_logic_vector (7 downto 0));
end RAM;

architecture Behavioral of RAM is

begin
    process(CLK,Endereco,WR)
    type memoria is array (0 to 255) of std_logic_vector (7 downto 0);
    variable MemEndereco:memoria;
    begin
    if WR = '0' then
        DadosOUT <= MemEndereco(to_integer(unsigned(Endereco)));
    else
        DadosOUT <= (others => 'X');
    end if;
    if rising_edge(CLK) and WR = '1' then
        MemEndereco(to_integer(unsigned(Endereco))) := DadosIN;
    end if;    
    end process;
end Behavioral;
