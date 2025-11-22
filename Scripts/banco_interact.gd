extends StaticBody3D
var isSitting = false
var canInteract = false
@onready var SitPosition = $SitPosition
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _sit():
		isSitting = true
		var player = get_tree().get_first_node_in_group("player")
		var animator = player.get_node("Sprite3D/RogueHooded/AnimationPlayer")
		player.global_position = SitPosition.global_position
		player.sit()
		player.look_at(player.global_position + global_basis.x)
		player.global_rotation = SitPosition.global_rotation
func _release():
	var player = get_tree().get_first_node_in_group("player")
	player.set_physics_process(true)
	
	player.global_position = global_position - global_basis.x

func interact():
	if not isSitting:	
		_sit()
	elif Input.is_action_just_pressed("jump"):
		_release()
	
