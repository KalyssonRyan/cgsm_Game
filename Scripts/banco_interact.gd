extends StaticBody3D
var isSitting = false
var canInteract = true
@onready var SitPosition = $SitPosition
@onready var texto = $"../Label3D"
@onready var raycast : RayCast3D = $"Player/FirstPerson/RayCast3D2" 
# Called when the node enters the scene tree for the first time.
func _sit():
		isSitting = true
		var player = get_tree().get_first_node_in_group("player")
		var animator = player.get_node("Sprite3D/RogueHooded/AnimationPlayer")
		player.global_position = SitPosition.global_position
		player.sit()
		player.look_at(player.global_position + global_basis.x)
		player.global_rotation = SitPosition.global_rotation
		texto.hide()
func _release():
	var player = get_tree().get_first_node_in_group("player")
	isSitting = false
	
	player.stand_up()

	# empurra o player PRA FRENTE do banco, não pro lado
	player.global_translate(-SitPosition.global_basis.z * 1.2)


#func _input(event: InputEvent) -> void:
	#if not canInteract:
		#return
	#
	#if event.is_action_pressed("interaction"):
		#if not isSitting:
			#_sit()
		#else:
			#_release()
#func _on_area_3d_body_entered(body: Node3D) -> void:
	#print("entered:", body)
	#texto.show()
	#if body.is_in_group("player"):
		#_set_interaction(true)
		
#func _on_area_3d_body_exited(body: Node3D) -> void:
	#print("exited:", body)
#
	#if body.is_in_group("player"):
		#_set_interaction(false)

	
func _set_interaction(state: bool):
	canInteract = state
	if state:
		texto.show()
	else:
		texto.hide()
func sentar():
	if canInteract:  # Verifica se é possível interagir (se o jogador está dentro da área de interação)
		if not isSitting:
			_sit()  # Se não está sentado, senta
		else:
			_release()  # Se já está sentado, levanta
