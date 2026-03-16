----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2026 12:59:34
-- Design Name: 
-- Module Name: ROM_Memoria_Instrucoes - Behavioral
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

entity ROM_Memoria_Instrucoes is
    Port ( Endereco : in STD_LOGIC_VECTOR (7 downto 0);
           opcode : out STD_LOGIC_VECTOR (4 downto 0);
           SEL_R : out STD_LOGIC;
           Constante : out STD_LOGIC_VECTOR (7 downto 0)
           );
end ROM_Memoria_Instrucoes;

architecture Behavioral of ROM_Memoria_Instrucoes is
    
    signal instrucao : std_logic_vector(13 downto 0);
begin
--processo que define a instrucao
    process(Endereco)
    begin
        case Endereco is
            when "00000000" => instrucao <= "00000000000000"; -- 0000: OP LDP Ri
            when "00000001" => instrucao <= "00100000000000"; -- 1:  ST [0], RA
            when "00000010" => instrucao <= "00010100110010"; -- 2:  LD RB, 50
            when "00000011" => instrucao <= "01110000000000"; -- 3:  CMP RA, RB
            when "00000100" => instrucao <= "10100000010101"; -- 4:  JGE 21
            when "00000101" => instrucao <= "00010100000000"; -- 5:  LD RB, 0
            when "00000110" => instrucao <= "01110000000000"; -- 6:  CMP RA, RB
            when "00000111" => instrucao <= "10001000001111"; -- 7:  JL 15 
            when "00001000" => instrucao <= "00010100000001"; -- 8:  LD RB, 1
            when "00001001" => instrucao <= "01100000000000"; -- 9:  ADD RA, RB
            when "00001010" => instrucao <= "00001000000000"; -- 10: STP RA
            when "00001011" => instrucao <= "00010100110010"; -- 11: LD RB, 50
            when "00001100" => instrucao <= "01110000000000"; -- 12: CMP RA, RB
            when "00001101" => instrucao <= "10001000001000"; -- 13: JL 8
            when "00001110" => instrucao <= "10110000100100"; -- 14: JMP 36
            when "00001111" => instrucao <= "00010111111111"; -- 15: LD RB, -1 
            when "00010000" => instrucao <= "01001000000000"; -- 16: XOR RA, RB
            when "00010001" => instrucao <= "00010100000001"; -- 17: LD RB, 1
            when "00010010" => instrucao <= "01100000000000"; -- 18: ADD RA, RB
            when "00010011" => instrucao <= "00001000000000"; -- 19: STP RA
            when "00010100" => instrucao <= "10110000100100"; -- 20: JMP 36
            when "00010101" => instrucao <= "00010000000000"; -- 21: LD RA, 0
            when "00010110" => instrucao <= "00100000000010"; -- 22: ST [2], RA
            when "00010111" => instrucao <= "00011000000000"; -- 23: LD RA, [0]
            when "00011000" => instrucao <= "00100000000001"; -- 24: ST [1], RA
            when "00011001" => instrucao <= "00010100000001"; -- 25: LD RB, 1
            when "00011010" => instrucao <= "00101000000000"; -- 26: AND RA, RB
            when "00011011" => instrucao <= "00011100000010"; -- 27: LD RB, [2]
            when "00011100" => instrucao <= "01100000000000"; -- 28: ADD RA, RB
            when "00011101" => instrucao <= "00100000000010"; -- 29: ST [2], RA
            when "00011110" => instrucao <= "00011000000001"; -- 30: LD RA, [1]
            when "00011111" => instrucao <= "01010000000000"; -- 31: SHR RA
            when "00100000" => instrucao <= "01111000100010"; -- 32: JZ RA, 34 
            when "00100001" => instrucao <= "10110000011000"; -- 33: JMP 24
            when "00100010" => instrucao <= "00011000000010"; -- 34: LD RA, [2]
            when "00100011" => instrucao <= "00001000000000"; -- 35: STP RA
            when "00100100" => instrucao <= "10110000100100"; -- 36: JMP 36
            when others => instrucao <= "XXXXXXXXXXXXXX"; -- mete o resto a zeros
        end case;
    end process;    
    opcode    <= instrucao(13 downto 9); -- 5 bits de Opcode
    SEL_R     <= instrucao(8);           -- 1 bit de Seleção de Registo
    Constante <= instrucao(7 downto 0);  -- 8 bits de Constante
end Behavioral;
