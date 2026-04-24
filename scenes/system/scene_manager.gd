extends CanvasLayer

@onready var rect: ColorRect = $ColorRect
@onready var anim: AnimationPlayer = $AnimationPlayer
var current_scene: Node

signal transition_finished

var current_player
var current_camp

func _ready() -> void:
	call_deferred("_sync_current_scene")

func _sync_current_scene() -> void:
	current_scene = get_tree().current_scene

func change_scene(new_scene_path: String) -> void:
	anim.play("fade_out")
	await anim.animation_finished
	
	if current_scene:
		current_scene.queue_free()

	var scene = load(new_scene_path).instantiate()
	get_tree().root.add_child(scene)
	get_tree().current_scene = scene
	current_scene = scene
	
	anim.play("fade_in")
	await anim.animation_finished
	emit_signal("transition_finished")

func show_resolving_cards():
	%Label.text = "Resolvendo cartas..."
	%Label.show()
	await timeout(3)
	%Label.hide()

func show_consequences():
	anim.play("fade_out")
	await anim.animation_finished
	%Label.text = "(Pequeno timeskip) consequência das cartas..."
	%Label.show()
	if GameState.karma == 1:
		Dialogic.start("ervas")
	if GameState.karma == 0:
		Dialogic.start("equipamentos")
	if GameState.karma == -1:
		Dialogic.start("aconselhar")
	await Dialogic.timeline_ended
	anim.play("fade_in")
	await anim.animation_finished
	current_player.resume()
	%Label.hide()

func show_camp_change():
	%Label.text = "Troca de caminho... o bando avança para um destino imprevisível... (Antes disso o jogador escolhe cartas novas para integrar o deck, abrindo e fechando portas de oportunidades de caminhos próximos diferentes) (nessa parte temos a chance de apresentar várias coisas como diálogos, imagens, cenas, etc.)..."
	current_player.stop()
	anim.play("fade_out")
	await anim.animation_finished
	%Label.show()
	
	current_camp.apply_consequence(GameState.karma)
	
	await get_tree().create_timer(30).timeout
	
	anim.play("fade_in")
	await anim.animation_finished
	current_player.resume()
	
	%Label.hide()

func timeout(time):
	current_player.stop()
	anim.play("fade_out")
	await anim.animation_finished
	
	await get_tree().create_timer(time).timeout
	
	anim.play("fade_in")
	await anim.animation_finished
	current_player.resume()
