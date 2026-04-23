# 💣 Arduino IoT Bomb Defusal: Escape Room Simulator

Um simulador de desarme de bomba interativo que integra **Godot 4**, **Python** e **Arduino**. O desafio exige que o jogador analise um código lógico na tela e manipule cabos físicos em uma protoboard para evitar a "explosão".

## 🕹️ O Projeto
Este projeto leva a experiência de jogos estilo *Escape Room* para um novo nível, onde a interface do jogo (Godot) e o hardware (Arduino) estão em constante sincronia. O jogador tem um tempo limite para interpretar uma regra lógica gerada aleatoriamente e desconectar o jumper correto na vida real.

## 💻 Desafios Técnicos e Aprendizados
Este projeto consolidou conhecimentos avançados de integração de sistemas e lógica de programação:

* **Detecção de Estado com `INPUT_PULLUP`:** Uso de resistores internos do Arduino para detectar o "corte" (desconexão) de cabos jumpers sem a necessidade de componentes externos extras para cada fio.
* **Comunicação Bidirecional em Rede:** * **Hardware -> Software:** O Arduino detecta a abertura do circuito e envia o evento via Serial/Python para o Godot.
    * **Software -> Hardware:** O Godot processa a vitória ou derrota e envia um sinal de volta para acionar o feedback físico (LEDs e Buzzer).
* **Lógica de Jogo Aleatória:** Implementação de um sistema de "Manual de Desarme" no Godot, onde a resposta correta é calculada dinamicamente a cada partida com base em números seriais e condições matemáticas (Paridade e Intervalos).
* **Feedback de Interface e Som:** Gerenciamento de cronômetro regressivo e sinais sonoros sincronizados entre a engine e o buzzer.

## 🛠️ Tecnologias
* **Game Engine:** Godot 4.x (Interface 2D e Lógica de Jogo)
* **Middleware:** Python 3 (Ponte UDP/Serial bidirecional)
* **Hardware:** Arduino (C++ / Linguagem Wiring)

## 🔌 Hardware e Montagem
* **Arduino Uno**
* **Protoboard**
* **LEDs:** Vermelho (Status Armada/Derrota) e Verde (Status Desarmada/Vitória)
* **Buzzer:** Alarme sonoro e melodias de feedback
* **Fios da Bomba:** 3 Jumpers Macho-Macho coloridos (Vermelho, Azul e Verde)



## 📝 Regras do Manual (Exemplo)
O sistema gera um código na tela e o jogador deve seguir a lógica programada:
1. Se o código for **PAR**, corte o fio **Vermelho**.
2. Se o código for **ÍMPAR** e **maior que 50**, corte o fio **Azul**.
3. Caso contrário, corte o fio **Verde**.

## 🎮 Como Executar
1. **Arduino:** Carregue o código para monitoramento dos pinos 2, 3 e 4.
2. **Ponte Python:** Execute o script `ponte_bomba.py` para abrir os canais de comunicação.
3. **Godot:** Abra a cena da bomba e tente desarmar antes que o tempo acabe!

---
*Projeto desenvolvido para prática de lógica de sistemas e integração entre software de alto nível e eletrônica.*