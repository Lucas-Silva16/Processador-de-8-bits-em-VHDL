----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2026 13:55:09
-- Design Name: 
-- Module Name: Descodificacao_ROM - Behavioral
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

entity Descodificacao_ROM is
    Port ( Opcode : in STD_LOGIC_VECTOR (4 downto 0);
           SEL_ALU : out STD_LOGIC_VECTOR (3 downto 0);
           ESCR_P : out STD_LOGIC;
           SEL_DATA : out STD_LOGIC_VECTOR (1 downto 0);
           ESCR_R : out STD_LOGIC;
           WR : out STD_LOGIC;
           SEL_PC : out STD_LOGIC_VECTOR (2 downto 0);
           ESCR_F : out STD_LOGIC;
           SEL_F : out STD_LOGIC_VECTOR (2 downto 0));
end Descodificacao_ROM;

architecture Behavioral of Descodificacao_ROM is
signal controlo : std_logic_vector (15 downto 0);

begin
    with opcode select
        controlo <=
                    --ALU     P    DATA    R    WR     PC      F    SEL_F       OPCODE
                    "0000" & "0" & "01" & "1" & "0" & "000" & "0" & "000" when "00000", -- LDP Ri
                    "0000" & "1" & "00" & "0" & "0" & "000" & "0" & "000" when "00001", -- STP RA
                    "0000" & "0" & "11" & "1" & "0" & "000" & "0" & "000" when "00010", -- LD Ri, constante
                    "0000" & "0" & "10" & "1" & "0" & "000" & "0" & "000" when "00011", -- LD Ri, [constante]
                    "0000" & "0" & "00" & "0" & "1" & "000" & "0" & "000" when "00100", -- ST [constante], RA
                    "0000" & "0" & "00" & "1" & "0" & "000" & "0" & "000" when "00101", -- AND RA, RB
                    "0001" & "0" & "00" & "1" & "0" & "000" & "0" & "000" when "00110", -- OR RA, RB
                    "0010" & "0" & "00" & "1" & "0" & "000" & "0" & "000" when "00111", -- NAND RA, RB
                    "0011" & "0" & "00" & "1" & "0" & "000" & "0" & "000" when "01000", -- NOR RA, RB
                    "0100" & "0" & "00" & "1" & "0" & "000" & "0" & "000" when "01001", -- XOR RA, RB
                    "0101" & "0" & "00" & "1" & "0" & "000" & "0" & "000" when "01010", -- SHR RA
                    "0110" & "0" & "00" & "1" & "0" & "000" & "0" & "000" when "01011", -- SHL RA
                    "0111" & "0" & "00" & "1" & "0" & "000" & "0" & "000" when "01100", -- ADD RA, RB
                    "1000" & "0" & "00" & "1" & "0" & "000" & "0" & "000" when "01101", -- SUB RA, RB
                    "1001" & "0" & "00" & "0" & "0" & "000" & "1" & "000" when "01110", -- CMP RA, RB
                    "0000" & "0" & "00" & "0" & "0" & "011" & "0" & "000" when "01111", -- JZ RA, constante
                    "0000" & "0" & "00" & "0" & "0" & "100" & "0" & "000" when "10000", -- JN RA, constante
                    "0000" & "0" & "00" & "0" & "0" & "010" & "0" & "000" when "10001", -- JL constante
                    "0000" & "0" & "00" & "0" & "0" & "010" & "0" & "001" when "10010", -- JLE constante
                    "0000" & "0" & "00" & "0" & "0" & "010" & "0" & "010" when "10011", -- JE constante
                    "0000" & "0" & "00" & "0" & "0" & "010" & "0" & "011" when "10100", -- JGE constante
                    "0000" & "0" & "00" & "0" & "0" & "010" & "0" & "100" when "10101", -- JG constante
                    "0000" & "0" & "00" & "0" & "0" & "001" & "0" & "000" when "10110", -- JMP constante
                    "0000" & "0" & "00" & "0" & "0" & "000" & "0" & "000" when others;  -- NOP
                    
SEL_ALU <= controlo(15 downto 12);
ESCR_P <= controlo (11);
SEL_DATA <= controlo (10 downto 9);
ESCR_R <= controlo (8);
WR <= controlo (7);
SEL_PC <= controlo (6 downto 4);
ESCR_F <= controlo (3);
SEL_F <= controlo (2 downto 0);
             
           
end Behavioral;
