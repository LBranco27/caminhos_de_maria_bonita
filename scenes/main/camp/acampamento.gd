extends Node2D

var first_start = true

func _ready():
	if first_start:
		print_debug("Teste do baralho")
		print_debug("Quantidade no deck:", Baralho.quantidade_deck())

		var carta = await %Player.buy_card()
		print_debug("Carta comprada:", carta)

		print_debug("Deck depois:", Baralho.quantidade_deck())
		print_debug("Mão:", Baralho.get_mao())
		SceneManager.current_camp = self

func apply_consequence(consequence):
	match consequence:
		-1:
			%Lampião.hide()
			%Carne.hide()
			%Cabana.hide()
			%Jesuino.show()
			%Corisco.show()
		0:
			%Corisco.show()
		1:
			%Jesuino.show()
			
