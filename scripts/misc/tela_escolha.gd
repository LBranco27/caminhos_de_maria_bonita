extends Control
signal escolha_feita

func show_choices(_card_id):
	show()

func _on_opcao_1_pressed():
	Baralho.escolha = 1
	escolha_feita.emit()
	visible = false

func _on_opcao_2_pressed() -> void:
	Baralho.escolha = 2
	escolha_feita.emit()
	visible = false
