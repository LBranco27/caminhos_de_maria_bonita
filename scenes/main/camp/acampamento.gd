extends Node2D

var first_start = true

func _ready():
	if first_start:
		print_debug("Teste do baralho")
		print_debug("Quantidade no deck:", baralho.quantidade_deck())

		var carta = baralho.comprar_carta()
		print_debug("Carta comprada:", carta)

		print_debug("Deck depois:", baralho.quantidade_deck())
		print_debug("Mão:", baralho.get_mao())
