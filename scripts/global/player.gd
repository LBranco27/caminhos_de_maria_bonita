extends CharacterBody2D
#Variavel para controlar a animação
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 390.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction > 0:
		anim.flip_h = false
		
	elif direction < 0:
		anim.flip_h = true

	move_and_slide()
