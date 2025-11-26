extends StaticBody3D

var isSitting = false
var canInteract = true
@onready var SitPosition = $SitPosition
@onready var raycast : RayCast3D = $"Player/FirstPerson/RayCast3D2" 
# Called when the node enters the scene tree for the first time.
func sentar():
	if canInteract:  # Verifica se é possível interagir (se o jogador está dentro da área de interação)
		if not isSitting:
			_sit()  # Se não está sentado, senta
		else:
			_release()  # Se já está sentado, levanta

func _set_interaction(state: bool):
	canInteract = state
	

func _sit():
		isSitting = true
		var player = get_tree().get_first_node_in_group("player")
		var animator = player.get_node("Sprite3D/RogueHooded/AnimationPlayer")
		player.global_position = SitPosition.global_position + SitPosition.global_basis.z * 0.4
	
		player.sit()
		player.look_at(player.global_position + global_basis.x)
		player.global_rotation = SitPosition.global_rotation
		
		# Alterar o RayCast para apontar para cima (de cima para baixo)
	# Altere a posição do RayCast para que fique um pouco acima do personagem
		var raycast = player.get_node("CollisionShape3D/RayCast3D2")  # Pegue o RayCast3D2
		var marker = $RayCastMarker
	# Configura a direção do RayCast para baixo, de cima para baixo
		raycast.global_position = marker.global_position  # Defina a posição inicial do RayCast
	
	# Alterando a direção do RayCast (para baixo)
		raycast.target_position = marker.global_position + Vector3(0, -2, 0)
func _release():
	var player = get_tree().get_first_node_in_group("player")
	isSitting = false
	
	player.stand_up()

	# empurra o player PRA FRENTE do banco, não pro lado
	player.global_translate(-SitPosition.global_basis.z * 1.2)
