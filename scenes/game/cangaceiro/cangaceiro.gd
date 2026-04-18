extends CharacterBody2D

@export var dialogic_identifier = "default"
@export var interaction_timeline := ""

func interact(_player: Node2D) -> void:
	if interaction_timeline.is_empty():
		return
	Dialogic.start(interaction_timeline)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("register_interactable"):
		body.register_interactable(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("unregister_interactable"):
		body.unregister_interactable(self)
