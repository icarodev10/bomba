import serial
import socket
import time

arduino = serial.Serial('COM3', 9600)

print("Aguardando Arduino armar a bomba...")
time.sleep(2)
arduino.reset_input_buffer()

# UDP pra MANDAR pro Godot (Lê a porta 4242)
rede = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# UDP pra OUVIR o Godot (Escuta a porta 4243)
rede.bind(("127.0.0.1", 4243))
rede.setblocking(0) 

print("💣 Ponte Bidirecional Ligada! Jogo Rodando...")

while True:
    try:
        # 1. Lê a bancada e manda pro Godot
        if arduino.in_waiting > 0:
            dados = arduino.readline()
            rede.sendto(dados, ("127.0.0.1", 4242))
            
        # 2. Ouve o Godot e repassa pro Arduino
        try:
            msg, _ = rede.recvfrom(1024)
            if msg == b"D":
                arduino.write(b"D") # Derrota
            elif msg == b"V":
                arduino.write(b"V") # Vitória
        except BlockingIOError:
            pass
            
    except ConnectionResetError:
        pass
    except Exception as e:
        print("Erro:", e)