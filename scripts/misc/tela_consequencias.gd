extends Control

func _on_ready():
	Baralho.processar_carta()
	var historia = Baralho.consequencia
	if historia == 1:
		$Panel.visble = true
		$Imagem.texture = "res://assets/history/historia1.jpg"
		$Texto.text = "As ações de Maria bonita ajudaram a fortificar o bando, contribuindo para a hegemonia de Lampião no sertão"
	elif historia == 2:
		$Panel.visible = true
		$Imagem.texture = "res://assets/history/historia3.jpg"
		$Texto.text = "As ações de Maria fizeram emegir o que havia de mais humano no Capitão"

func _on_seguir_pressed():
	SceneManager.change_scene(#prossegue para a próxima cena)
