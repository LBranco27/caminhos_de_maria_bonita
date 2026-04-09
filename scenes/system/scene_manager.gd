extends CanvasLayer

@onready var rect: ColorRect = $ColorRect
@onready var anim: AnimationPlayer = $AnimationPlayer
var current_scene

signal transition_finished

func change_scene(new_scene_path: String) -> void:
	anim.play("fade_out")
	await anim.animation_finished
	
	if current_scene:
		current_scene.queue_free()

	var scene = load(new_scene_path).instantiate()
	get_tree().root.add_child(scene)
	current_scene = scene
	
	anim.play("fade_in")
	await anim.animation_finished
	emit_signal("transition_finished")
