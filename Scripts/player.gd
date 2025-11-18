extends CharacterBody3D

var current_animation
var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var sensivity = 0.003
@onready var camera = $FirstPerson
var mouse = true
@onready var animator = get_node("Sprite3D/RogueHooded/AnimationPlayer")
func _ready() :
	$FirstPerson.current= true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _switch_view():
	if Input.is_action_just_pressed("f3"):
		if camera == $FirstPerson:
			camera = $Head
			$ThirdPerson.current = true
		else: 
			camera = $FirstPerson
			$FirstPerson.current = true
	if Input.is_action_just_pressed("f4"):
		if camera == $FirstPerson:
			camera = $Head
			$ThirdPersonFront.current = true
		else: 
			camera = $FirstPerson
			$FirstPerson.current = true
func _process(delta):
	_switch_view()
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("TAB"):
		if mouse == true:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			mouse= false
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			mouse = true
	if Input.is_action_just_pressed('Pose'):
			animator.play('Block')
func _unhandled_input(event) :
	

	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensivity)
		camera.rotate_x(-event.relative.y * sensivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(70))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animator.play('Jump_Idle')
		current_animation = 'Jump_Idle'  # Define que a animação atual é de pulo
	if Input.is_action_just_pressed("shift"):
		SPEED = 10.0
		animator.play('Running_A')
	if Input.is_action_just_released("shift"):
		SPEED = 5.0
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		animator.play('Walking_A')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)		
		animator.play('Idle')
	move_and_slide()
