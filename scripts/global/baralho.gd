extends Node

var cartas_disponiveis: Array = []
var deck: Array = []
var mao: Array = []
var descarte: Array = []

var limite_mao: int = 5


func _ready() -> void:
	inicializar_cartas()
	inicializar_deck()
	embaralhar_deck()


func inicializar_cartas() -> void:
	cartas_disponiveis = [
		{
			"id": 1,
			"nome": "Ataque do Cangaço",
			"descricao": "Causa impacto ofensivo no turno.",
			"tipo": "ataque",
			"valor": 2
		},
		{
			"id": 2,
			"nome": "Reforçar Acampamento",
			"descricao": "Melhora a defesa do grupo.",
			"tipo": "defesa",
			"valor": 3
		},
		{
			"id": 3,
			"nome": "Ajuda do Povoado",
			"descricao": "Gera apoio e recursos.",
			"tipo": "suporte",
			"valor": 1
		},
		{
			"id": 4,
			"nome": "Emboscada",
			"descricao": "Ação surpresa contra inimigos.",
			"tipo": "ataque",
			"valor": 4
		},
		{
			"id": 5,
			"nome": "Descanso Estratégico",
			"descricao": "Recupera fôlego para o próximo turno.",
			"tipo": "suporte",
			"valor": 2
		}
	]


func inicializar_deck() -> void:
	deck.clear()
	mao.clear()
	descarte.clear()

	for carta in cartas_disponiveis:
		deck.append(carta.duplicate(true))


func embaralhar_deck() -> void:
	deck.shuffle()


func comprar_carta() -> Dictionary:
	if mao.size() >= limite_mao:
		print("A mão já está cheia.")
		return {}

	if deck.is_empty():
		recompor_deck()

	if deck.is_empty():
		print("Não há cartas para comprar.")
		return {}

	var carta_comprada = deck.pop_back()
	mao.append(carta_comprada)
	return carta_comprada


func comprar_varias(quantidade: int) -> Array:
	var cartas_compradas: Array = []

	for i in range(quantidade):
		var carta = comprar_carta()
		if not carta.is_empty():
			cartas_compradas.append(carta)

	return cartas_compradas


func descartar_carta(indice_mao: int) -> void:
	if indice_mao < 0 or indice_mao >= mao.size():
		print("Índice de carta inválido.")
		return

	var carta = mao[indice_mao]
	descarte.append(carta)
	mao.remove_at(indice_mao)


func adicionar_carta_ao_deck(carta: Dictionary) -> void:
	deck.append(carta.duplicate(true))


func remover_carta_do_deck_por_id(id_carta: int) -> bool:
	for i in range(deck.size()):
		if deck[i]["id"] == id_carta:
			deck.remove_at(i)
			return true

	return false


func recompor_deck() -> void:
	if descarte.is_empty():
		return

	deck = descarte.duplicate(true)
	descarte.clear()
	embaralhar_deck()


func resetar_baralho() -> void:
	mao.clear()
	descarte.clear()
	inicializar_deck()
	embaralhar_deck()


func get_deck() -> Array:
	return deck


func get_mao() -> Array:
	return mao


func get_descarte() -> Array:
	return descarte


func quantidade_deck() -> int:
	return deck.size()


func quantidade_mao() -> int:
	return mao.size()


func quantidade_descarte() -> int:
	return descarte.size()
