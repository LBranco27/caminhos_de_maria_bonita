extends Control

@onready var popup = $DetalheCarta
@onready var popup_imagem = $DetalheCarta/Carta
@onready var popup_texto = $DetalheCarta/Descricao

var carta = 0
signal card_chosen

func initialize_selection():
	show()

func mostrar_pop_up(arte, descricao):
	popup_imagem.texture = arte
	popup_texto.text = descricao
	popup.visible = true

func _on_carta_1_pressed():
	carta = 1
	var imagem = load("res://assets/card/cartas_pro/cordel1.jpg")
	var texto = "[b]Procurar ervas medicinais:[/b]
Uma incursão mata adentro em busca de cura. No coração de um local inóspito, o que a terra oferece é a única farmácia disponível para o bando. Conhecer a flora é a diferença entre a vida e o fim da jornada."
	mostrar_pop_up(imagem, texto)

func _on_fechar_cartas_pressed():
	popup.visible = false

func _on_carta_2_pressed():
	carta = 2
	var imagem = load("res://assets/card/cartas_pro/cordel2.jpg")
	var texto = "[b]Cuidar das roupas e equipamentos:[/b]
O preparo é essencial para a sobrevivência. Organizar a carga e realizar reparos no couro e tecidos garante que nada falte na necessidade. Um equipamento bem cuidado deixa de ser um peso e se torna um trunfo na hora do combate."
	mostrar_pop_up(imagem, texto)

func _on_cancelar_pressed():
	popup.visible = false

func _on_carta_3_pressed():
	carta = 3
	var imagem = load("res://assets/card/cartas_pro/cordel3.jpg")
	var texto = "[b]Aconselhar Lampião:[/b]
Sussurros ao pé do ouvido que moldam o destino do bando. Entre um conselho e outro, Maria exerce sua influência sobre o Capitão, buscando tocar sua humanidade ou guiar sutilmente os passos por caminhos que só ela vislumbra."
	mostrar_pop_up(imagem, texto)

func _on_selecionar_pressed():
	Baralho.adicionar_carta(carta)
	if carta == 1:
		$HBoxContainer/Carta1.visible = false
	elif carta == 2:
		$HBoxContainer/Carta2.visible = false
		GameState.karma -= 1
	elif carta == 3:
		$HBoxContainer/Carta3.visible = false
		GameState.karma += 1
	popup.visible = false
	hide()
	card_chosen.emit()
	#if Baralho.deck.size() == 3:
		#SceneManager.change_scene("res://scenes/main/history/tela_consequencias.tscn")
