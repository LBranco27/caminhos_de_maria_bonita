extends Parallax2D

@export var descricao_objeto : String = "Uma fogueira quente, lembra as noites no sertão."
var player_perto : bool = false

func _input(event):
	if event.is_action_pressed("interact") and player_perto:
		exibir_dialogo()

func exibir_dialogo():
	$"../../Texto/MeuLabel/RichTextLabel".text = descricao_objeto
	$"../../Texto/MeuLabel/RichTextLabel".visible = true

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player_provisorio":
		player_perto = true
	pass # Replace with function body.

func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player_provisorio":
		player_perto = false
		$"../../Texto/MeuLabel/RichTextLabel".visible = false
	pass # Replace with function body.
