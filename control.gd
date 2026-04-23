extends Control

var udp_receber := PacketPeerUDP.new()
var udp_enviar := PacketPeerUDP.new() # O telefone pra ligar de volta pro Python

@onready var texto_tempo = $Label
@onready var texto_mensagem = $Mensagem

var tempo_restante = 60.0 
var jogo_ativo = true
var fio_correto = ""

func _ready():
	udp_receber.bind(4242)
	udp_enviar.set_dest_address("127.0.0.1", 4243) # Aponta pra porta nova do Python
	randomize()
	sortear_regra()

func _process(delta):
	if jogo_ativo and tempo_restante > 0:
		tempo_restante -= delta
		atualizar_relogio()
		
		if tempo_restante <= 0:
			explodir("TEMPO ESGOTADO! BOOM!")

	while udp_receber.get_available_packet_count() > 0:
		var pacote = udp_receber.get_packet().get_string_from_utf8().strip_edges()
		if pacote.length() > 0 and jogo_ativo:
			analisar_fio(pacote)

func atualizar_relogio():
	var minutos = int(tempo_restante) / 60
	var segundos = int(tempo_restante) % 60
	texto_tempo.text = "%02d:%02d" % [minutos, segundos]

func sortear_regra():
	# Gera um número de 1 a 100
	var numero_serial = randi() % 100 + 1
	
	# A Lógica do Jogo na Tela
	texto_mensagem.text = "Código: " + str(numero_serial) + "\nSe PAR = Vermelho | ÍMPAR > 50 = Azul | Resto = Verde"
	texto_mensagem.modulate = Color(1, 1, 1)
	
	# O Godot decide a resposta baseado na matemática
	if numero_serial % 2 == 0:
		fio_correto = "FIO_VERMELHO_CORTADO"
	elif numero_serial > 50:
		fio_correto = "FIO_AZUL_CORTADO"
	else:
		fio_correto = "FIO_VERDE_CORTADO"

func analisar_fio(fio_cortado: String):
	if fio_cortado == fio_correto:
		desarmar()
	else:
		explodir("FIO ERRADO! BOOM!")

func explodir(motivo):
	jogo_ativo = false
	texto_tempo.text = "00:00"
	texto_mensagem.text = motivo
	texto_mensagem.modulate = Color(1, 0, 0)
	udp_enviar.put_packet("D".to_ascii_buffer()) # Avisa o hardware: DERROTA

func desarmar():
	jogo_ativo = false
	texto_mensagem.text = "BOMBA DESARMADA! UFA!"
	texto_mensagem.modulate = Color(0, 1, 0)
	udp_enviar.put_packet("V".to_ascii_buffer()) # Avisa o hardware: VITÓRIA
