# 🚀 Processador de 8 bits em VHDL

![VHDL](https://img.shields.io/badge/Language-VHDL-orange)
![Tools](https://img.shields.io/badge/Tools-Vivado_ML_Edition-blue)
![Hardware](https://img.shields.io/badge/Hardware-Artix--7_NEXYS_A7-red)

## 📝 Introdução
Este projeto descreve o desenvolvimento e implementação de um **processador básico de 8 bits**, utilizando a linguagem de descrição de hardware **VHDL**. O trabalho foi realizado no âmbito da unidade curricular de **Arquitetura de Computadores** (Faculdade de Ciências Exatas e da Engenharia).

O projeto aborda desde a criação dos blocos lógicos fundamentais até à sua integração final e configuração física numa FPGA **Artix-7 (NEXYS A7/4 DDR)**, utilizando a ferramenta **Vivado ML Edition**.

---

## 🎯 Objetivos
* **Conceção:** Criar um processador capaz de executar um conjunto específico de instruções.
* **Modelação:** Desenhar módulos internos como ALU, Registos, PC e Descodificador.
* **Integração:** Desenvolver a estrutura *Top-Level* (Motherboard) interligando Processador, ROM (Instruções) e RAM (Dados).
* **Validação:** Testar a arquitetura através de simulações (*Testbench*) e mapeamento de periféricos físicos (PIN/POUT).

---

## ⚙️ Arquitetura do Sistema

### 1. O Processador (Core)
O núcleo do sistema é composto pelos seguintes módulos essenciais:
* **Unidade Aritmética e Lógica (ALU):** Processa operandos de 8 bits em complemento para dois. Executa operações aritméticas (soma, subtração), lógicas (AND, OR, XOR) e deslocamentos (SHR, SHL).
* **Registos:** Inclui dois registos de uso geral (A e B) e um registo de Flags para controlo de fluxos condicionais.
* **Flow Control:** O Contador de Programa (PC) gere os endereços da ROM, permitindo incrementos sequenciais ou saltos (`JMP`, `JZ`, `JL`).
* **Descodificador:** O "cérebro" que interpreta opcodes de 5 bits e ativa os sinais de controlo necessários.
* **Gestor de Periféricos:** Gere a comunicação de entrada (PIN) e saída (POUT).

### 2. Placa-Mãe (Integração Estrutural)
A nível superior, o processador é instanciado com:
* **ROM:** Memória de instruções com palavras de 14 bits.
* **RAM:** Memória de dados para persistência e variáveis temporárias.

---

## ✅ Resultados e Discussão
A validação foi feita através de três rotinas principais no Testbench:

| Rotina | Descrição | Resultado Esperado |
| :--- | :--- | :--- |
| **Aritmética e Ciclos** | Introdução de valor "5" e execução de somas sucessivas. | Saída (POUT) parou corretamente em 50 via saltos `JL`. |
| **Lógica e Negativos** | Teste com valor "-16" e operações `XOR`. | Validação de complemento para dois e cálculo de valor absoluto. |
| **Acesso a RAM e Shifts** | Contagem de bits "1" num valor (ex: 60 -> `00111100`). | Uso de `ST`/`LD` na RAM e `SHR`. Saída exata de 4. |

> **Nota:** As formas de onda da simulação confirmaram a integridade síncrona do relógio e da lógica de descodificação.

---

## 🛠️ Tecnologias Utilizadas
* **Linguagem:** VHDL
* **Ambiente de Desenvolvimento:** Xilinx Vivado ML Edition
* **Hardware:** FPGA Artix-7 (Nexys A7-100T ou A7-50T)

---

## 📂 Estrutura de Ficheiros
* `/src`: Ficheiros fonte VHDL.
* `/sim`: Testbenches e ficheiros de simulação.
* `/docs`: Documentação adicional e diagramas.

---

## 🎓 Conclusão
O projeto consolidou conceitos de hardware modular e hierárquico. A abstração de blocos permitiu focar no encaminhamento de dados, resultando num sistema 100% funcional, capaz de manipular memória RAM e operações aritméticas complexas dentro das restrições de uma FPGA.
