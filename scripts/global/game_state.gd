extends Node
var caminho = 0
var stats = {}
var flags = {}
var karma = 0
var turn = 0
var current_player

func next_turn():
	turn += 1
	if turn == 1: #resolve cards
		Baralho.resolve_hand_cards()
	if turn == 2: #show consequences
		SceneManager.show_consequences()
	if turn == 3:
		SceneManager.show_camp_change()
