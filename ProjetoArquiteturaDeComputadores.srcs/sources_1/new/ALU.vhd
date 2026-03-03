----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2026 18:43:00
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( Operando1 : in STD_LOGIC_VECTOR (7 downto 0);
           Operando2 : in STD_LOGIC_VECTOR (7 downto 0);
           SEL_ALU : in STD_LOGIC_VECTOR (3 downto 0);
           Resultado : out STD_LOGIC_VECTOR (7 downto 0);
           E_FLAG : out STD_LOGIC_VECTOR (4 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
    process(Operando1, Operando2, SEL_ALU)
    begin
    Resultado <= (others => '0');
    E_FLAG <= (others => '0');
         case SEL_ALU is
                when "0000" => Resultado <= (Operando1 and Operando2);
                when "0001" => Resultado <= (Operando1 or Operando2);
                when "0010" => Resultado <= (Operando1 nand Operando2);
                when "0011" => Resultado <= (Operando1 nor Operando2);
                when "0100" => Resultado <= (Operando1 xor Operando2);
                when "0101" => Resultado <= std_logic_vector(shift_right(unsigned(Operando1), 1));--bitshift para a direita
                when "0110" => Resultado <= std_logic_vector(shift_left(unsigned(Operando1), 1));--bitshift para a esquerda
                when "0111" => Resultado <= std_logic_vector(unsigned(Operando1)+unsigned(Operando2));
                when "1000" => Resultado <= std_logic_vector(unsigned(Operando1)-unsigned(Operando2)) ;
                when "1001" => if (Operando1 <  Operando2) then E_FLAG(0) <= '1'; end if;
                               if (Operando1 <= Operando2) then E_FLAG(1) <= '1'; end if;
                               if (Operando1 =  Operando2) then E_FLAG(2) <= '1'; end if;
                               if (Operando1 >= Operando2) then E_FLAG(3) <= '1'; end if;
                               if (Operando1 >  Operando2) then E_FLAG(4) <= '1'; end if;
                when others => Resultado <= (others => '0');
            end case;
    end process;
end Behavioral;
