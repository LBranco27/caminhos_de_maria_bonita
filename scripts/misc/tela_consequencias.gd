extends Control

var recursos = 0
var armamentos = 0
var influencia = 0
var consequencia = 0

func processar_carta() -> int:
	Baralho.escolha = 0
	for x in Baralho.deck:
		if x == 1:
			recursos += 10
		elif x == 2:
			armamentos += 10
		elif x == 3:
			var tela = $Tela_escolha
			tela.visible = true
			await tela.escolha_feita
			if Baralho.escolha == 1:
				influencia += 5
			elif Baralho.escolha == 2:
				influencia += 10
	if armamentos == 10 and recursos == 10 and influencia == 5:
		consequencia = 1
	elif armamentos == 10 and recursos == 10 and influencia == 10:
		consequencia = 2
	Baralho.deck.clear()
	return consequencia 

func _on_ready():
	var historia = await processar_carta()
	if historia == 1:
		$Panel.visible = true
		$Panel/Imagem.texture = load("res://assets/history/historia1.jpg")
		$Panel/Texto.text = "As ações de Maria bonita ajudaram a fortificar o bando, contribuindo para a hegemonia de Lampião no sertão"
	elif historia == 2:
		$Panel.visible = true
		$Panel/Imagem.texture = load("res://assets/history/historia3.jpg")
		$Panel/Texto.text = "As ações de Maria fizeram emegir o que havia de mais humano no Capitão"

#func _on_seguir_pressed():
	#SceneManager.change_scene(#prossegue para a próxima cena)
