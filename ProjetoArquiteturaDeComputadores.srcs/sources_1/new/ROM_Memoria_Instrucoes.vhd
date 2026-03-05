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
           Constante : out STD_LOGIC_VECTOR (7 downto 0));
end ROM_Memoria_Instrucoes;

architecture Behavioral of ROM_Memoria_Instrucoes is
    
    signal instrucao : std_logic_vector(13 downto 0);
begin
    with Endereco select
        instrucao <= 
            "00000000000000" when x"00", -- 0:  LDP RA
            "00100000000000" when x"01", -- 1:  ST [0], RA
            "00010100110010" when x"02", -- 2:  LD RB, 50
            "01110000000000" when x"03", -- 3:  CMP RA, RB
            "10100000010101" when x"04", -- 4:  JGE 21
            "00010100000000" when x"05", -- 5:  LD RB, 0
            "01110000000000" when x"06", -- 6:  CMP RA, RB
            "10001000001111" when x"07", -- 7:  JL 15 (Nota 1)
            "00010100000001" when x"08", -- 8:  LD RB, 1
            "01100000000000" when x"09", -- 9:  ADD RA, RB
            "00001000000000" when x"0A", -- 10: STP RA
            "00010100110010" when x"0B", -- 11: LD RB, 50
            "01110000000000" when x"0C", -- 12: CMP RA, RB
            "10001000001000" when x"0D", -- 13: JL 8
            "10110000100100" when x"0E", -- 14: JMP 36
            "00010111111111" when x"0F", -- 15: LD RB, -1 (Complemento para 2)
            "01001000000000" when x"10", -- 16: XOR RA, RB
            "00010100000001" when x"11", -- 17: LD RB, 1
            "01100000000000" when x"12", -- 18: ADD RA, RB
            "00001000000000" when x"13", -- 19: STP RA
            "10110000100100" when x"14", -- 20: JMP 36
            "00010000000000" when x"15", -- 21: LD RA, 0
            "00100000000010" when x"16", -- 22: ST [2], RA
            "00011000000000" when x"17", -- 23: LD RA, [0]
            "00100000000001" when x"18", -- 24: ST [1], RA
            "00010100000001" when x"19", -- 25: LD RB, 1
            "00101000000000" when x"1A", -- 26: AND RA, RB
            "00011100000010" when x"1B", -- 27: LD RB, [2]
            "01100000000000" when x"1C", -- 28: ADD RA, RB
            "00100000000010" when x"1D", -- 29: ST [2], RA
            "00011000000001" when x"1E", -- 30: LD RA, [1]
            "01010000000000" when x"1F", -- 31: SHR RA
            "01111000100010" when x"20", -- 32: JZ RA, 34 (Nota 2)
            "10110000011000" when x"21", -- 33: JMP 24
            "00011000000010" when x"22", -- 34: LD RA, [2]
            "00001000000000" when x"23", -- 35: STP RA
            "10110000100100" when x"24", -- 36: JMP 36
            "00000000000000" when others; -- Preenche o resto da memória com NOPs ou Zeros;

   
    opcode <= instrucao(13 downto 9); -- 5 bits
    --
    SEL_R <= instrucao (8); --1bit
    --
    constante <= instrucao (7 downto 0); --8 bits
    --total da os 14 bits
end Behavioral;
