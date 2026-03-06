----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2026 15:19:30
-- Design Name: 
-- Module Name: Mux_PC - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_PC is
    Port ( 
           S_FLAG : in std_logic;
           Operando1 : in std_logic_vector (7 downto 0);
           SEL_PC : in std_logic_vector (2 downto 0);
           ESCR_PC : out std_logic    
         );   
end MUX_PC;

architecture Behavioral of MUX_PC is
begin
    process(SEL_PC,S_FLAG,Operando1)
    begin
        case SEL_PC is 
            when "000" => ESCR_PC <= '0';
            when "001" => ESCR_PC <= '1';
            when "010" => ESCR_PC <= S_FLAG;
            when "011" => ESCR_PC <= NOT(Operando1(0) or Operando1(1) or Operando1(2) or Operando1(3)
                                      or Operando1(4) or Operando1(5) or Operando1(6) or Operando1(7));
            when "100" => ESCR_PC <= Operando1(7);
            when others => ESCR_PC <= '0';
        end case;
    end process;
end Behavioral;
