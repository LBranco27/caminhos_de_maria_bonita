extends Camera2D

@export var center_offset_x := 0.0
@export var edge_offset_x := 160.0
@export var shift_speed := 480.0

@onready var player: Node2D = get_parent()
@onready var left_limit: Node2D = %Limite_0
@onready var right_limit: Node2D = %Limite_1

var base_y := 0.0

func _process(delta: float) -> void:
	var left_x := left_limit.global_position.x
	var right_x := right_limit.global_position.x
	if is_equal_approx(left_x, right_x):
		position = Vector2(center_offset_x, base_y)
		return

	var progress := clampf(inverse_lerp(left_x, right_x, player.global_position.x), 0.0, 1.0)
	var target_x := lerpf(center_offset_x + edge_offset_x, center_offset_x - edge_offset_x, progress)

	position.x = move_toward(position.x, target_x, shift_speed * delta)
	position.y = base_y
