const int pinoBuzzer = 9;
const int pinoLEDVermelho = 8; 
const int pinoLEDVerde = 7; 
const int fioVermelho = 2;
const int fioAzul = 3;
const int fioVerde = 4;

bool jogoAcabou = false;

void setup() {
  Serial.begin(9600);
  pinMode(pinoBuzzer, OUTPUT);
  pinMode(pinoLEDVermelho, OUTPUT); 
  pinMode(pinoLEDVerde, OUTPUT); 

  pinMode(fioVermelho, INPUT_PULLUP);
  pinMode(fioAzul, INPUT_PULLUP);
  pinMode(fioVerde, INPUT_PULLUP);

  digitalWrite(pinoLEDVermelho, HIGH); 
  digitalWrite(pinoLEDVerde, LOW);     
}

void loop() {
  if (!jogoAcabou) {
    if (digitalRead(fioVermelho) == HIGH) { Serial.println("FIO_VERMELHO_CORTADO"); delay(500); }
    else if (digitalRead(fioAzul) == HIGH) { Serial.println("FIO_AZUL_CORTADO"); delay(500); }
    else if (digitalRead(fioVerde) == HIGH) { Serial.println("FIO_VERDE_CORTADO"); delay(500); }
  }

  if (Serial.available() > 0) {
    char comando = Serial.read();
    
    if (comando == 'D') { // DERROTA
      jogoAcabou = true;
      digitalWrite(pinoLEDVermelho, HIGH); // Trava o vermelho aceso
      digitalWrite(pinoLEDVerde, LOW);     // Mantém o verde apagado
      tone(pinoBuzzer, 100);               // Som da morte
    } 
    else if (comando == 'V') { // VITÓRIA
      jogoAcabou = true;
      digitalWrite(pinoLEDVermelho, LOW);  // Apaga o perigo
      digitalWrite(pinoLEDVerde, HIGH);    // ACENDE A LUZ DE SALVAÇÃO!
      
      // Musiquinha de vitória
      tone(pinoBuzzer, 1000, 100); delay(150);
      tone(pinoBuzzer, 1500, 100); delay(150);
      tone(pinoBuzzer, 2000, 300); 
    }
  }
}