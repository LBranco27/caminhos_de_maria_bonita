extends Control

func _on_start_pressed() -> void:
	SceneManager.change_scene("res://scenes/main/camp/acampamento.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
