extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 390.0
const JUMP_VELOCITY = -400.0

var nearby_interactables: Array[Node2D] = []
var dialog_active := false


func _ready() -> void:
	if not Dialogic.timeline_started.is_connected(_on_dialogic_timeline_started):
		Dialogic.timeline_started.connect(_on_dialogic_timeline_started)
	if not Dialogic.timeline_ended.is_connected(_on_dialogic_timeline_ended):
		Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)

	GameState.current_player = self
	Baralho.current_player = self
	SceneManager.current_player = self


func _physics_process(delta: float) -> void:
	if dialog_active:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("interact"):
		_interact_with_nearest()

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction > 0:
		anim.flip_h = false
		
	elif direction < 0:
		anim.flip_h = true

	move_and_slide()


func register_interactable(interactable: Node2D) -> void:
	if interactable in nearby_interactables:
		return
	nearby_interactables.append(interactable)


func unregister_interactable(interactable: Node2D) -> void:
	nearby_interactables.erase(interactable)


func _interact_with_nearest() -> void:
	var interactable := _get_nearest_interactable()
	if interactable == null:
		return
	if interactable.has_method("interact"):
		interactable.interact(self)


func _get_nearest_interactable() -> Node2D:
	nearby_interactables = nearby_interactables.filter(func(node: Node2D) -> bool:
		return is_instance_valid(node)
	)

	var nearest: Node2D = null
	var nearest_distance := INF
	for interactable in nearby_interactables:
		var distance := global_position.distance_squared_to(interactable.global_position)
		if distance < nearest_distance:
			nearest = interactable
			nearest_distance = distance

	return nearest


func _on_dialogic_timeline_started() -> void:
	stop()


func _on_dialogic_timeline_ended() -> void:
	resume()


func stop():
	dialog_active = true
	velocity = Vector2.ZERO

func resume():
	dialog_active = false

#region card
func buy_card():
	%card_selection.initialize_selection()
	await %card_selection.card_chosen
	%hand.update_hand()

func invoke_choice(card_id):
	%choice.show_choices(card_id)
