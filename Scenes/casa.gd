extends Node3D

@onready var animacao_mago = $Mage/AnimacaoMago
@onready var animacao_barbaro = $boneco/Barbarian/AnimacaoBarbaro
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	animacao_mago.play('Sit_Chair_Idle')
	animacao_barbaro.play('Sit_Floor_Idle')
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
