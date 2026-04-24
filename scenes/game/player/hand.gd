extends Control

var hand_card = load("res://scenes/game/player/hand_card.tscn")

func update_hand():
	erase_hand()
	for card in Baralho.mao:
		var new_hand_card = hand_card.instantiate()
		new_hand_card.texture = load(card.image)
		new_hand_card.rotation = randf_range(-20, 20)
		%hand_hbox.add_child(new_hand_card)

func erase_hand():
	for card in %hand_hbox.get_children():
		card.queue_free()
