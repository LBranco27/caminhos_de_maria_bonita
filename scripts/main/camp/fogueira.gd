extends Parallax2D


func interact(_player: Node2D) -> void:
	GameState.next_turn()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("register_interactable"):
		body.register_interactable(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("unregister_interactable"):
		body.unregister_interactable(self)
